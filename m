Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55C223E59E
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Aug 2020 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHGByf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Aug 2020 21:54:35 -0400
Received: from [216.151.45.106] ([216.151.45.106]:61352 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgHGByd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:54:33 -0400
Received: by localhost (Postfix, from userid 1000)
        id 4D516D97D; Fri,  7 Aug 2020 01:16:11 +1000 (AEST)
From:   Michael Zhou <mzhou@cse.unsw.edu.au>
To:     netfilter-devel@vger.kernel.org
Cc:     Michael Zhou <mzhou@cse.unsw.edu.au>
Subject: [PATCH v2] net/ipv6/netfilter/ip6t_NPT: rewrite addresses in ICMPv6 original packet
Date:   Fri,  7 Aug 2020 01:15:25 +1000
Message-Id: <20200806151524.12112-1-mzhou@cse.unsw.edu.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Detect and rewrite a prefix embedded in an ICMPv6 original packet that was
rewritten by a corresponding DNPT/SNPT rule so it will be recognised by
the host that sent the original packet.

Example

Rules in effect on the 1:2:3:4::/64 + 5:6:7:8::/64 side router:
* SNPT src-pfx 1:2:3:4::/64 dst-pfx 5:6:7:8::/64
* DNPT src-pfx 5:6:7:8::/64 dst-pfx 1:2:3:4::/64

No rules on the 9:a:b:c::/64 side.

1. 1:2:3:4::1 sends UDP packet to 9:a:b:c::1
2. Router applies SNPT changing src to 5:6:7:8::ffef::1
3. 9:a:b:c::1 receives packet with (src 5:6:7:8::ffef::1 dst 9:a:b:c::1)
	and replies with ICMPv6 port unreachable to 5:6:7:8::ffef::1,
	including original packet (src 5:6:7:8::ffef::1 dst 9:a:b:c::1)
4. Router forwards ICMPv6 packet with (src 9:a:b:c::1 dst 5:6:7:8::ffef::1)
	including original packet (src 5:6:7:8::ffef::1 dst 9:a:b:c::1)
	and applies DNPT changing dst to 1:2:3:4::1
5. 1:2:3:4::1 receives ICMPv6 packet with (src 9:a:b:c::1 dst 1:2:3:4::1)
	including original packet (src 5:6:7:8::ffef::1 dst 9:a:b:c::1).
	It doesn't recognise the original packet as the src doesn't
	match anything it originally sent

With this change, at step 4, DNPT will also rewrite the original packet
src to 1:2:3:4::1, so at step 5, 1:2:3:4::1 will recognise the ICMPv6
error and provide feedback to the application properly.

Conversely, SNPT will help when ICMPv6 errors are sent from the
translated network.

1. 9:a:b:c::1 sends UDP packet to 5:6:7:8::ffef::1
2. Router applies DNPT changing dst to 1:2:3:4::1
3. 1:2:3:4::1 receives packet with (src 9:a:b:c::1 dst 1:2:3:4::1)
	and replies with ICMPv6 port unreachable to 9:a:b:c::1
	including original packet (src 9:a:b:c::1 dst 1:2:3:4::1)
4. Router forwards ICMPv6 packet with (src 1:2:3:4::1 dst 9:a:b:c::1)
	including original packet (src 9:a:b:c::1 dst 1:2:3:4::1)
	and applies SNPT changing src to 5:6:7:8::ffef::1
5. 9:a:b:c::1 receives ICMPv6 packet with
	(src 5:6:7:8::ffef::1 dst 9:a:b:c::1) including
	original packet (src 9:a:b:c::1 dst 1:2:3:4::1).
	It doesn't recognise the original packet as the dst doesn't
	match anything it already sent

The change to SNPT means the ICMPv6 original packet dst will be
rewritten to 5:6:7:8::ffef::1 in step 4, allowing the error to be
properly recognised in step 5.

Signed-off-by: Michael Zhou <mzhou@cse.unsw.edu.au>
---
 net/ipv6/netfilter/ip6t_NPT.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/ipv6/netfilter/ip6t_NPT.c b/net/ipv6/netfilter/ip6t_NPT.c
index 9ee077bf4f49..787c74aa85e3 100644
--- a/net/ipv6/netfilter/ip6t_NPT.c
+++ b/net/ipv6/netfilter/ip6t_NPT.c
@@ -77,16 +77,43 @@ static bool ip6t_npt_map_pfx(const struct ip6t_npt_tginfo *npt,
 	return true;
 }
 
+static struct ipv6hdr *icmpv6_bounced_ipv6hdr(struct sk_buff *skb,
+					      struct ipv6hdr *_bounced_hdr)
+{
+	if (ipv6_hdr(skb)->nexthdr != IPPROTO_ICMPV6)
+		return NULL;
+
+	if (!icmpv6_is_err(icmp6_hdr(skb)->icmp6_type))
+		return NULL;
+
+	return skb_header_pointer(skb,
+				  skb_transport_offset(skb) + sizeof(struct icmp6hdr),
+				  sizeof(struct ipv6hdr),
+				  _bounced_hdr);
+}
+
 static unsigned int
 ip6t_snpt_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ip6t_npt_tginfo *npt = par->targinfo;
+	struct ipv6hdr _bounced_hdr;
+	struct ipv6hdr *bounced_hdr;
+	struct in6_addr bounced_pfx;
 
 	if (!ip6t_npt_map_pfx(npt, &ipv6_hdr(skb)->saddr)) {
 		icmpv6_send(skb, ICMPV6_PARAMPROB, ICMPV6_HDR_FIELD,
 			    offsetof(struct ipv6hdr, saddr));
 		return NF_DROP;
 	}
+
+	/* rewrite dst addr of bounced packet which was sent to dst range */
+	bounced_hdr = icmpv6_bounced_ipv6hdr(skb, &_bounced_hdr);
+	if (bounced_hdr) {
+		ipv6_addr_prefix(&bounced_pfx, &bounced_hdr->daddr, npt->src_pfx_len);
+		if (ipv6_addr_cmp(&bounced_pfx, &npt->src_pfx.in6) == 0)
+			ip6t_npt_map_pfx(npt, &bounced_hdr->daddr);
+	}
+
 	return XT_CONTINUE;
 }
 
@@ -94,12 +121,24 @@ static unsigned int
 ip6t_dnpt_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ip6t_npt_tginfo *npt = par->targinfo;
+	struct ipv6hdr _bounced_hdr;
+	struct ipv6hdr *bounced_hdr;
+	struct in6_addr bounced_pfx;
 
 	if (!ip6t_npt_map_pfx(npt, &ipv6_hdr(skb)->daddr)) {
 		icmpv6_send(skb, ICMPV6_PARAMPROB, ICMPV6_HDR_FIELD,
 			    offsetof(struct ipv6hdr, daddr));
 		return NF_DROP;
 	}
+
+	/* rewrite src addr of bounced packet which was sent from dst range */
+	bounced_hdr = icmpv6_bounced_ipv6hdr(skb, &_bounced_hdr);
+	if (bounced_hdr) {
+		ipv6_addr_prefix(&bounced_pfx, &bounced_hdr->saddr, npt->src_pfx_len);
+		if (ipv6_addr_cmp(&bounced_pfx, &npt->src_pfx.in6) == 0)
+			ip6t_npt_map_pfx(npt, &bounced_hdr->saddr);
+	}
+
 	return XT_CONTINUE;
 }
 
-- 
2.25.1

