Return-Path: <netfilter-devel+bounces-13543-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBR4GEGRQ2oPcQoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13543-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 11:49:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C86E272B
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 11:49:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=S2ALs7nS;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13543-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13543-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D412306169F
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A6391E77;
	Tue, 30 Jun 2026 09:41:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96471261B91
	for <netfilter-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:41:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812466; cv=none; b=Ayo3meveXW98Q8KgEqh8xvPSZrvn6DtuzA6irgOo5r1NRGkd7TibzuaYnpAIJ5uGj6APAQg+8U1bHz+CtZXpvJ3tAjDsr9R/GWLCinMSM+W17Tjhxk4aOHFZi9J3IpbB09s5oYLWy2WBR6LoWzXkvqgIa1MmpQ3zwiTuC2k/oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812466; c=relaxed/simple;
	bh=iVoocAzpvo34TiRX3wR8/aDVuWaMZrBb/es2zsFQdnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0U6TXZq/ygP7vn6G4bBEGjLAqM8JwMPUfTKVQUg5kJYZUHt2cSO7YntBWDP4l0wSghWo9EsozmnqShFV6La+tnCW9Gl1BfyMfYjplVnhDzzpYgoV7jN8HmIukp/iHl1s2IdpfoFN8jg0kk8rZ2uUy2bxN5pmFaa+mn6vni0dmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=S2ALs7nS; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 9641360592;
	Tue, 30 Jun 2026 11:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782812461;
	bh=C8Iw89ggCGlS39rsy76NdE6Ig6vegwZ5BLlC++ToRV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2ALs7nSZmlUFyJ1dCfBV2ztmaf32m3L07gChJV1FstnT/Vm08ccsXpmQ4qGn6Ut1
	 QwDfestU/AN99N9/+anG9blJyble+6RPLosJcji5vC1PDHPMGjU9IPX7CdpbjO+nnQ
	 lskVU+Ab1JwsNNoIYr7dCkSxRrTr5rSSI8P/ONK5GbZvV9yCZ+LAKREJvSRZ9yLkQf
	 TNBOI2Zm/B2ye+s42Gah46oi+GEFgGFGnOEyTHN3pJSu7nKyVNHyJa+Oqi/deykntf
	 vUTVBhAcFzO5sTp1Wh4xcPpvMN7RKAMf7y6bittl8ku5NGPfvHh62UhwXSPb0ye0XK
	 AZibfRvY1YnDg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: lorenzo@kernel.org,
	chzhengyang2023@lzu.edu.cn
Subject: [PATCH nf,v2 2/3] netfilter: flowtable: IPIP tunnel hardware offload is not yet support
Date: Tue, 30 Jun 2026 11:40:55 +0200
Message-ID: <20260630094056.97038-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630094056.97038-1-pablo@netfilter.org>
References: <20260630094056.97038-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13543-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:lorenzo@kernel.org,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B29C86E272B

No driver supports for IPIP tunnels yet, give up early on setting up the
hardware offload for this scenario.

This patch adds a stub that can be enhanced to add more configuration
that are currently not supported. As of now, the offload work is
enqueued to the worker, then ignored if the hardware offload
configuration is not supported.

Check the NF_FLOW_HW flag to know if this entry was already tried once
to be offloaded so this is not retried on refresh when unsupported. Move
NF_FLOW_HW flag check to nf_flow_offload_add(). If this NF_FLOW_HW flag
is unset the _del and _stats variants are never called.

This can be updated later on to skip hardware offload work to be queued
in case hardware offload does not support it.

Fixes: d98103575dcd ("netfilter: flowtable: Add IP6IP6 rx sw acceleration")
Fixes: ab427db17885 ("netfilter: flowtable: Add IPIP rx sw acceleration")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - set NF_FLOW_HW flag from nf_flow_offload_add(), after checking if it is supported.
    - call nf_flow_offload_refresh() only if NF_FLOW_HW is set on.

 include/net/netfilter/nf_flow_table.h |  2 ++
 net/netfilter/nf_flow_table_core.c    |  7 +++----
 net/netfilter/nf_flow_table_offload.c | 22 ++++++++++++++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 7b23b245a5a8..dc5c9b48e65a 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -357,6 +357,8 @@ static inline int nf_flow_register_bpf(void)
 
 void nf_flow_offload_add(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow);
+void nf_flow_offload_refresh(struct nf_flowtable *flowtable,
+			     struct flow_offload *flow);
 void nf_flow_offload_del(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow);
 void nf_flow_offload_stats(struct nf_flowtable *flowtable,
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 99c5b9d671a0..d06ce0848b68 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -345,10 +345,8 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 
 	nf_ct_refresh(flow->ct, NF_CT_DAY);
 
-	if (nf_flowtable_hw_offload(flow_table)) {
-		__set_bit(NF_FLOW_HW, &flow->flags);
+	if (nf_flowtable_hw_offload(flow_table))
 		nf_flow_offload_add(flow_table, flow);
-	}
 
 	return 0;
 }
@@ -369,7 +367,8 @@ void flow_offload_refresh(struct nf_flowtable *flow_table,
 	    test_bit(NF_FLOW_CLOSING, &flow->flags))
 		return;
 
-	nf_flow_offload_add(flow_table, flow);
+	if (test_bit(NF_FLOW_HW, &flow->flags))
+		nf_flow_offload_refresh(flow_table, flow);
 }
 EXPORT_SYMBOL_GPL(flow_offload_refresh);
 
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 002ec15d988b..d26874f1b15f 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1101,9 +1101,17 @@ nf_flow_offload_work_alloc(struct nf_flowtable *flowtable,
 	return offload;
 }
 
+static bool nf_flow_offload_unsupported(struct flow_offload *flow)
+{
+	if (flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.tun_num ||
+	    flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.tun_num)
+		return true;
 
-void nf_flow_offload_add(struct nf_flowtable *flowtable,
-			 struct flow_offload *flow)
+	return false;
+}
+
+void nf_flow_offload_refresh(struct nf_flowtable *flowtable,
+			     struct flow_offload *flow)
 {
 	struct flow_offload_work *offload;
 
@@ -1114,6 +1122,16 @@ void nf_flow_offload_add(struct nf_flowtable *flowtable,
 	flow_offload_queue_work(offload);
 }
 
+void nf_flow_offload_add(struct nf_flowtable *flowtable,
+			 struct flow_offload *flow)
+{
+	if (nf_flow_offload_unsupported(flow))
+		return;
+
+	__set_bit(NF_FLOW_HW, &flow->flags);
+	nf_flow_offload_refresh(flowtable, flow);
+}
+
 void nf_flow_offload_del(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow)
 {
-- 
2.47.3


