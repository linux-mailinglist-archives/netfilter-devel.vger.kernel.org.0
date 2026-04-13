Return-Path: <netfilter-devel+bounces-11840-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGwuFY+c3GkxUAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11840-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 09:34:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986E3E84E6
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 480883006F18
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD73939A3;
	Mon, 13 Apr 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="qQaMmMcp"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C866389111;
	Mon, 13 Apr 2026 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065675; cv=none; b=V0MCgo/tmj7FOXgDd8K8LwxpPw1FiN2+C72wtj64eYr6zHEVTuEjcrOrr5erNueHrE+qwunnXsY0Ab/BFYyYKnpbEIXBJYv/P+tNEx1zej7Z/y8fWMo5tzuQTecZ95u48QcZ5qmyvNNcD5wC6qLn8FzR/GWPISvO0slJhzgnYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065675; c=relaxed/simple;
	bh=V3WFhOJ14ldxim/GRHhxMiMs5RksmKIiGzmv36LwcGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iL6S//ELhSFqoUIihBvVnixsjAwK0UQjJXYRedEysWipI11KqtYzCXnCceeV2lGCbDjgDTqqEd1ey1+svzoxerP+zkwsRMAr92E//XHKJ+xTcy7vZy5lROXYw3/2b93g3X3e615mbpuFO6ScUNogXPmClXik0AEeBo2w+5WpZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=qQaMmMcp; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qQaMmMcpmhrOyLVt+UcXfuamFbGCHqy2bsfNiyFJ3axIZgV/OKtZbZ0dZOzWtKWNqVtbPCkU/9l0g
	 kbhMszL2hnbpar21iqRGufUkcZ/Oijrh7KhdCaJyGU3pkYW9+qrbo6LUCyYDwVGq94u2D2Mr5JNFf1
	 iFA2xTGBo62Qh2zc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-10-12088 (RichMail) with SMTP id 2f3869dc9bb6403-0141d;
	Mon, 13 Apr 2026 15:31:06 +0800 (CST)
X-RM-TRANSID:2f3869dc9bb6403-0141d
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	fw@strlen.de
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH 6.12.y] netfilter: conntrack: add missing netlink policy validations
Date: Mon, 13 Apr 2026 15:31:05 +0800
Message-Id: <20260413073105.2990210-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11840-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,netfilter.org,davemloft.net,google.com,kernel.org,redhat.com,trash.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-0.645];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 8986E3E84E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Florian Westphal <fw@strlen.de>

[ Upstream commit f900e1d77ee0ef87bfb5ab3fe60f0b3d8ad5ba05 ]

Hyunwoo Kim reports out-of-bounds access in sctp and ctnetlink.

These attributes are used by the kernel without any validation.
Extend the netlink policies accordingly.

Quoting the reporter:
  nlattr_to_sctp() assigns the user-supplied CTA_PROTOINFO_SCTP_STATE
  value directly to ct->proto.sctp.state without checking that it is
  within the valid range. [..]

  and: ... with exp->dir = 100, the access at
  ct->master->tuplehash[100] reads 5600 bytes past the start of a
  320-byte nf_conn object, causing a slab-out-of-bounds read confirmed by
  UBSAN.

Fixes: 076a0ca02644 ("netfilter: ctnetlink: add NAT support for expectations")
Fixes: a258860e01b8 ("netfilter: ctnetlink: add full support for SCTP to ctnetlink")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 net/netfilter/nf_conntrack_netlink.c    | 2 +-
 net/netfilter/nf_conntrack_proto_sctp.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 323e147fe282..f51cdfba68fb 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3460,7 +3460,7 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 
 #if IS_ENABLED(CONFIG_NF_NAT)
 static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
-	[CTA_EXPECT_NAT_DIR]	= { .type = NLA_U32 },
+	[CTA_EXPECT_NAT_DIR]	= NLA_POLICY_MAX(NLA_BE32, IP_CT_DIR_REPLY),
 	[CTA_EXPECT_NAT_TUPLE]	= { .type = NLA_NESTED },
 };
 #endif
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 4cc97f971264..fabb2c1ca00a 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -587,7 +587,8 @@ static int sctp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
 }
 
 static const struct nla_policy sctp_nla_policy[CTA_PROTOINFO_SCTP_MAX+1] = {
-	[CTA_PROTOINFO_SCTP_STATE]	    = { .type = NLA_U8 },
+	[CTA_PROTOINFO_SCTP_STATE]	    = NLA_POLICY_MAX(NLA_U8,
+							 SCTP_CONNTRACK_HEARTBEAT_SENT),
 	[CTA_PROTOINFO_SCTP_VTAG_ORIGINAL]  = { .type = NLA_U32 },
 	[CTA_PROTOINFO_SCTP_VTAG_REPLY]     = { .type = NLA_U32 },
 };
-- 
2.34.1



