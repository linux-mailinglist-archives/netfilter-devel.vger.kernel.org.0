Return-Path: <netfilter-devel+bounces-11868-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJapEigg3mk1ngkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11868-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:08:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 450273F921F
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C383300D4F9
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE173D8135;
	Tue, 14 Apr 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WnoVS11w"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430963D8127
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164898; cv=none; b=F/lngS+Y8AbhganHPapRQaXI1DwyS1VMqyyueDb9YIJulDmRA4muGXmcwHfg6CRYRpEYJYlPXfRrgf7OsfoLQqr/ceGZmlaleMex7ojMjgIbSQVmR9g3LRJP8ZCiJPoxSSTkdBvgWTGzUFlGE4aG98rDURgP4LuWX03iPviBwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164898; c=relaxed/simple;
	bh=EcQJ7R5/vlUG+l9M4urrtglnmwq2y2eUq2o8l45QUME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HU38p+XyjTiekP6YRV4FIQU85v34y7taJV/rDxWqawE1I7sr2P2KTxezih+BqHowgOUksCOHTRHaMD/DwE73hUpRgqLGsyPdAdtAfHPNX0efnCzHyD6UxCLLz9WNxagbCSYAyxTybxfyc/dXfT7ZQIqrrObszieFoHk3cfMGzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WnoVS11w; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 219A86028D
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 13:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776164895;
	bh=XxZ2IVyQyR9Sy7Ez9hyROmVUWgU0CzbFuPnEqQ8JU9g=;
	h=From:To:Subject:Date:From;
	b=WnoVS11wvt5XjLcWxvt3o+wk5+6wuK4+FusA2VqKukKyqs3aakEyrCaHt8ZSn4Li4
	 wwXzS7ipYR1EDW5eKp4UaOBh+Jozw3nXHGkPPT2Q5YdTNUcYd58esqqheGnwA2Ajoh
	 dBtBD6DsXvJAdymnYlM7H+97jTkLjj/hnFwFxbQfmyZ5wrrUFjnnbGHOkOOaDe4AZi
	 dX6HRry3cmQ1ubeB+h16p1lQR0n5UO7vDB4ZX91bLah9Id3MP0VKzK10fEiYGjuhtE
	 Vqbsu9I5wfzwbVxQDLKBYrlAJkkxpjHRnDsYVpT/fBiCQT7R2uHgWsYdDpSyZoTTsV
	 IQdGr/wloa9jg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_osf: restrict it to ipv6
Date: Tue, 14 Apr 2026 13:08:11 +0200
Message-ID: <20260414110811.6178-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-11868-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid]
X-Rspamd-Queue-Id: 450273F921F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This expression only supports for ipv4, restrict it.

Fixes: b96af92d6eaf ("netfilter: nf_tables: implement Passive OS fingerprint module in nft_osf")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_osf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 1c0b493ef0a9..bdc2f6c90e2f 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -28,6 +28,11 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct nf_osf_data data;
 	struct tcphdr _tcph;
 
+	if (nft_pf(pkt) != NFPROTO_IPV4) {
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+
 	if (pkt->tprot != IPPROTO_TCP) {
 		regs->verdict.code = NFT_BREAK;
 		return;
@@ -114,7 +119,6 @@ static int nft_osf_validate(const struct nft_ctx *ctx,
 
 	switch (ctx->family) {
 	case NFPROTO_IPV4:
-	case NFPROTO_IPV6:
 	case NFPROTO_INET:
 		hooks = (1 << NF_INET_LOCAL_IN) |
 			(1 << NF_INET_PRE_ROUTING) |
-- 
2.47.3


