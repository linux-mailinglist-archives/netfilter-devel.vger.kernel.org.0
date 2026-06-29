Return-Path: <netfilter-devel+bounces-13514-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UP7nEG2GQmqL9AkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13514-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 16:51:25 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7CC6DC4C1
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 16:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=pNMj+rKg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13514-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13514-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D4B83157389
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07643F86E2;
	Mon, 29 Jun 2026 14:39:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55141C2FC
	for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2026 14:39:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743993; cv=none; b=XKTNq20P0LqjHqbIHZLRRP7Y5HZc6lJWAcv+KbdNOqKFnD0032sbIEqceM1GZe5bxX2UzFSnv4cL6loyXzEwgpisma/Xk09pfSb43hZob3nDXeYnoCabuhV+cztxl9ADQO8b4+JjaCyGEqHjXM5mw2+4UPq5zDk9V3iqClswpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743993; c=relaxed/simple;
	bh=NUmDaZ00QhuGvMTLZwdjiHbqSMznGifQBlGLzehnICw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtahiVJdoVEOFleDPPA4E93LtHFfFg/Apr7sbFuCbpzv4w/1+vIpHjHn6HA645aaNYbLfvT4V6Uk1/iA0H2MO6qiex7l+/oegAenHXtHJfeVNBJzcCLuZ45KKj1toOiquhVsIixw+D6qhfqTFfWNJivPXGrCAo0f6TZwguiHKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pNMj+rKg; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 3A7F96058A;
	Mon, 29 Jun 2026 16:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782743983;
	bh=vr4DsXt+MtD+ZT7+lNwvJ+vaUP3exopy5I417A06AGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNMj+rKg6NRJLrb97ok/qSYBerJAqoXwus96Yvyq+VDGg3nLanDgaZvtkTyIdQF/D
	 koGbp/Wf7ydTZG+Kv5+2oWp3WB13w5P4T7ctLRCo9p4UVoWUhQLCnb66OyJRseY/Pm
	 uqbv4t2Y/PLLobZLti25ODrkCyeFjptnaXJEzWVMu5gySA7MEiQuCdaVkWhe0CC01o
	 euPa+Sjo4Tx34HbWdlPkbVkdoQML+kzu6NC2/8VeoVUvOM2m64O2UthUYdjXpEPjYF
	 1smdnUiU8Y64Gq00GPpW3Z9NdGzHrKxOZAaiVvCloN97fDGCj0E6ljG4oMMmHO9LRb
	 4LpAwTN4QrpOw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: chzhengyang2023@lzu.edu.cn,
	lorenzo@kernel.org
Subject: [PATCH nf 2/3] netfilter: flowtable: IPIP tunnel hardware offload is not yet support
Date: Mon, 29 Jun 2026 16:39:35 +0200
Message-ID: <20260629143936.61239-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629143936.61239-1-pablo@netfilter.org>
References: <20260629143936.61239-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13514-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:chzhengyang2023@lzu.edu.cn,m:lorenzo@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C7CC6DC4C1

No driver supports for IPIP tunnels yet, give up early on setting up the
hardware offload for this scenario.

This patch adds a stub that can be enhanced to add more configuration
that are currently not supported. As of now, the offload work is
enqueued to the worker, then ignored if the hardware offload
configuration is not supported.

This can be updated later on to skip hardware offload work to be queued
in case hardware offload does not support it.

Fixes: d98103575dcd ("netfilter: flowtable: Add IP6IP6 rx sw acceleration")
Fixes: ab427db17885 ("netfilter: flowtable: Add IPIP rx sw acceleration")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_offload.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 002ec15d988b..3e87117e724b 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1101,12 +1101,23 @@ nf_flow_offload_work_alloc(struct nf_flowtable *flowtable,
 	return offload;
 }
 
+static bool nf_flow_offload_unsupported(struct flow_offload *flow)
+{
+	if (flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.tun_num ||
+	    flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.tun_num)
+		return true;
+
+	return false;
+}
 
 void nf_flow_offload_add(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow)
 {
 	struct flow_offload_work *offload;
 
+	if (nf_flow_offload_unsupported(flow))
+		return;
+
 	offload = nf_flow_offload_work_alloc(flowtable, flow, FLOW_CLS_REPLACE);
 	if (!offload)
 		return;
@@ -1119,6 +1130,9 @@ void nf_flow_offload_del(struct nf_flowtable *flowtable,
 {
 	struct flow_offload_work *offload;
 
+	if (nf_flow_offload_unsupported(flow))
+		return;
+
 	offload = nf_flow_offload_work_alloc(flowtable, flow, FLOW_CLS_DESTROY);
 	if (!offload)
 		return;
@@ -1133,6 +1147,9 @@ void nf_flow_offload_stats(struct nf_flowtable *flowtable,
 	struct flow_offload_work *offload;
 	__s32 delta;
 
+	if (nf_flow_offload_unsupported(flow))
+		return;
+
 	delta = nf_flow_timeout_delta(flow->timeout);
 	if ((delta >= (9 * flow_offload_get_timeout(flow)) / 10))
 		return;
-- 
2.47.3


