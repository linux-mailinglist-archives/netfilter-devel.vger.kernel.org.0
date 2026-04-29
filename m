Return-Path: <netfilter-devel+bounces-12296-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOn/FTcV8mljnwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12296-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 16:27:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E883C495B36
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9399630128C1
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EA32B9B6;
	Wed, 29 Apr 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx3STMW7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD081922F5;
	Wed, 29 Apr 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472677; cv=none; b=rqRgyB2oQ9yTZRF0WZnlr3jVJr0cNptgIemlKC00X2dItm201hY+H6kMaxcqp9wokw6f0t1vcMzSHxTT8Kp5N57YPZAsANlptm/5glrRs02FU6sB+StBTBIGZHNS0BAo14zMaATRn9CCMUIBwQcdwkvdfbnHkWB52A3aHY4bPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472677; c=relaxed/simple;
	bh=H3g4OX8A13YSN1s3iVOllHQBhUlNDzTOhla9m9vQ+3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oImG/9sYMCd/e+X4U0Rs9TBYQ2toZVpl+VS2dAG6xyEIgC/vifVxcxRmm/+4igsE9Zgf7DmEKAe5WmlvSp1G7olQQEwT6+xeoLiw8EjzQMfnenqVmSJu0CzOU3RyzNjk1u1+UbM6Eoj0Cruc/2XHbTitrvj/fVPxgPuS3ybVk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx3STMW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE315C19425;
	Wed, 29 Apr 2026 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472677;
	bh=H3g4OX8A13YSN1s3iVOllHQBhUlNDzTOhla9m9vQ+3o=;
	h=From:Date:Subject:To:Cc:From;
	b=hx3STMW7U4Q8kOOtOytA7jMOa6uDH5ystakdlPJ8CcErJhllOfMXMfgxTSTCQYI6D
	 K27HXFU8dC5NvFr6g11Abt593FDBK3FoVBDTE/uzjKhzj+E3ObVfVQzpI734eRHkaK
	 dfudEuKxyaz93qnghFMRYXMNs/j6qLGvR1e3bhxDtoRDEYLEKWbUyVEx8O6vY1oBZh
	 CsZV+/H8nHe/WUXRu+gtclYIUCLLgPwTQUovMy2gAnlosn+sUi3QvpVcwId/JMOAQs
	 wiEwKRvZhcqdwbrS0yWqBShmrR5ex2WlqpnNK3sEouoSc8Td6LTUAubM8Ve4DI+Te4
	 XIm68GfAmDsrA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 29 Apr 2026 16:24:16 +0200
Subject: [PATCH nf-next] netfilter: flowtable_offload: propagate CT mark to
 hardware offload path
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-nft-flowtable-priority-v1-1-d4d7574bcf43@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQqDMBBFryKz7pQk1kC76j2KC60THSqJTIJVJ
 Hdv8AJdPh7//QMiCVOER3WA0MqRgy+gLxW8p86PhDwUBqOMVTej0LuEbg7f1PUz4SIchNOOlsj
 dlRlM03RQxouQ4+0Mv8A79LQlaIuYOKYg+3m46lP/a68aNVqratf3TtfWPj8knuZrkBHanPMPS
 wxQy8YAAAA=
X-Change-ID: 20260420-nft-flowtable-priority-6eef902d255a
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: E883C495B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12296-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

When a user-space process sets the Connection Tracking (CT) mark on a
flow via nft_ct or xt_CONNMARK, that mark should be visible to the
hardware offload path when the flow is accelerated through the flowtable
infrastructure.
Extend the flowtable offload attribute set to include the ct mark field
when it has been explicitly set on the conntrack entry. This info can be
used to fill QoS hw rules for the offloaded traffic.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_offload.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 002ec15d988b..d5fe35b1a647 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -679,6 +679,22 @@ static int flow_offload_decap_tunnel(const struct flow_offload *flow,
 	return 0;
 }
 
+static void nf_flow_rule_ct_meta_mark(const struct flow_offload *flow,
+				      struct nf_flow_rule *flow_rule)
+{
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_MARK)
+	u32 mark = flow->ct ? READ_ONCE(flow->ct->mark) : 0;
+
+	if (mark) {
+		struct flow_action_entry *entry;
+
+		entry = flow_action_entry_next(flow_rule);
+		entry->id = FLOW_ACTION_CT_METADATA;
+		entry->ct_metadata.mark = mark;
+	}
+#endif /* IS_ENABLED(CONFIG_NF_CONNTRACK_MARK) */
+}
+
 static int
 nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 			  enum flow_offload_tuple_dir dir,
@@ -747,6 +763,8 @@ int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
 		return -1;
 
+	nf_flow_rule_ct_meta_mark(flow, flow_rule);
+
 	if (test_bit(NF_FLOW_SNAT, &flow->flags)) {
 		if (flow_offload_ipv4_snat(net, flow, dir, flow_rule) < 0 ||
 		    flow_offload_port_snat(net, flow, dir, flow_rule) < 0)
@@ -776,6 +794,8 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
 		return -1;
 
+	nf_flow_rule_ct_meta_mark(flow, flow_rule);
+
 	if (test_bit(NF_FLOW_SNAT, &flow->flags)) {
 		if (flow_offload_ipv6_snat(net, flow, dir, flow_rule) < 0 ||
 		    flow_offload_port_snat(net, flow, dir, flow_rule) < 0)

---
base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
change-id: 20260420-nft-flowtable-priority-6eef902d255a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


