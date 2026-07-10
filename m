Return-Path: <netfilter-devel+bounces-13817-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 72Q9FP+gUGqJ2gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13817-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 09:36:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 467A8738176
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 09:36:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="hlgi5uF/";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13817-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13817-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AF1730091C1
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB73C37B4;
	Fri, 10 Jul 2026 07:36:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09783C8C49
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 07:36:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668984; cv=none; b=RuFsxTrXLKPE9dRGuxbs2luAb/k9tIyCbaastn5UZHcMqTFE8fqvtlVlK4x2K4mmx3yXbfQ4gTElEkuYZCOJZJsJJVvx6hRfNDS1M5sE4J+AuZkfqy1JET0i9M5TyftAxbrEPT4byl7FkwZd/AX/XZCaVUmfEeiYBOlwNorK+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668984; c=relaxed/simple;
	bh=yXPsKhsYSioNjINT93BtxyK9j6TxYtzPzDUJHjH0Grc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUaTMA0a1ADFGfquSK1NnxF+4GaP26PVSNcrgxKowdM+NK0LFBamvXWm6ezW2nb0yj8gwEYTQN/hrPKFTUL5L1aAcRX0lhL2UH3Q5tiYQlj346CVWrRHuvCatqsAsB4P4nCmqNEnFzZSC/7XUCI24MoDj12/PIfg6MpGwJ2m2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=hlgi5uF/; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 36CC160581;
	Fri, 10 Jul 2026 09:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783668977;
	bh=wvMjTWtsCStdG3MZTL2/OWZTfNE/USm0QwX1vkeyvDg=;
	h=From:To:Cc:Subject:Date:From;
	b=hlgi5uF/bO42tkstnBrMLpDY7vSD8BCtw4BeCYm+qc8ryaewTNK339cN9Z6rrMuMV
	 QAMbP5oXX/PzhXDrlIj89+BYNW/TUgIKaICZUfBj0X6kR7bW0VP/pNgGgMjuiZZhLy
	 AggrtItiXv3wtExhGBMgDt0YXsZ7gsVbnxbzsW/Qs95iwjqYI8uO2BhYxudTGZgMkP
	 /AYqZnPNkbF2CwFPKmXbbEKnR6p2u1BlIR+IlrV3IcJKW1bZcLxu/W8yS4u3haHpRL
	 2ZCbSU8KqRw5BxCufD3qKer94F6gYfoeafxkNWv8wNxWGesSsJBOfuMdM3TL4Qztpy
	 OQsquVWEFJ9OQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: anzaki@gmail.com
Subject: [PATCH nf-next] netfilter: flowtable: tear down flow entries with stale dst from GC
Date: Fri, 10 Jul 2026 09:36:10 +0200
Message-ID: <20260710073610.1352167-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13817-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:anzaki@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 467A8738176

In case of route updates, tear down flow entries with stale dst to give
them a chance to obtain a fresh route.

This is specifically useful for hardware offloaded entries, where the
flowtable software dataplane sees no packet, where the existing check
for stale dst entries does not help.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 99c5b9d671a0..61ab27de79fa 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -561,6 +561,14 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	nf_ct_put(ct);
 }
 
+static bool nf_flow_check_dst(struct flow_offload *flow,
+			      enum flow_offload_tuple_dir dir)
+{
+	struct flow_offload_tuple *tuple = &flow->tuplehash[dir].tuple;
+
+	return tuple->dst_cache && dst_check(tuple->dst_cache, tuple->dst_cookie);
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
@@ -568,6 +576,8 @@ static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
+	    nf_flow_check_dst(flow, FLOW_OFFLOAD_DIR_ORIGINAL) ||
+	    nf_flow_check_dst(flow, FLOW_OFFLOAD_DIR_REPLY) ||
 	    nf_flow_custom_gc(flow_table, flow)) {
 		flow_offload_teardown(flow);
 		teardown = true;
-- 
2.47.3


