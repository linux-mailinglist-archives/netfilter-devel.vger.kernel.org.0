Return-Path: <netfilter-devel+bounces-13018-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yiXRACt3IGpz3wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13018-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 20:49:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871163AA28
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 20:49:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=bzTGkZpu;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13018-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13018-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C583307FBC4
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2B3E171F;
	Wed,  3 Jun 2026 18:47:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F803F5BFC
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 18:47:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512450; cv=none; b=j5kIpYtPMtOS4jbFrexGMm/FBWnyShFRllgmD7FMdERcHGKKWI6orbCm7CpC5M8xG2mYVSx4vzLC4Q5sCEP4+f35RpvcnqiXiSPzxDnu2AkonCGjmFKbqYts5nLiGN9oqQGG66I4flReur3Kh591A/OxivBlPEOdpwD5fQdF+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512450; c=relaxed/simple;
	bh=6cr2q8OpM6+FROqXE8lz6XGT70Mk77oD36S++E5toXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbv4sleOxnnmSfzIX/ZuHu3q+nz4WLmMqepsP6DGA7l1Pl7UZT0G3rajKQ8LsL2Wf51Bev4oyc2yU0GYUxOo4riuKFutFVKEQ73HdO0dWPmfkDBcYuNhnLkaaqixeoQOi4CyuAWecMWEUGX5rbV3sm+s92pWC0LoG/A89kWQUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=bzTGkZpu; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YHXz3MTDnfYArYH3MVinUNs7u/cKWz2COE4ViPGBHJg=; b=bzTGkZpu3j6OLkhNzLkmdmzR6N
	Rm6sZ4BGvCwFJQfSM9DRjVnL5w7iH7KCVL5bJh45RKXWyp2WijpMQaV9WXRZH1p0+wUDpSOiVjYSA
	slUlsirve/zASWbWtTaIdLB7yX8hTo2IW4zq/oGZoSpSvZz9I4EoBq+lCC9w4o/y+JEKpACgzrTBe
	jYXra5crcLg9gc7CQNUhbVzsbLgPGU7e0rSi2Sp0zPAiVpHartjrsbIoMTsGz6lAcHLiegjrMlHe6
	Li674Z6liKQnL7dpUxGrzvItnPPDS0UpkzNLuNx/8EadLu/PGK25D56c2ytTkOsgY19s4EogxTkBL
	6Kq3RvWA==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wUqca-000000002WU-463Q;
	Wed, 03 Jun 2026 20:47:21 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: [nft PATCH] intervals: Fix for inconsistent union field use
Date: Wed,  3 Jun 2026 20:47:15 +0200
Message-ID: <20260603184715.1366533-1-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13018-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nwl.cc:mid,nwl.cc:from_mime,nwl.cc:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8871163AA28

Reported by a static code analyzer: key->value belongs to a different
struct in the embedded anonymous union than key->range.* which is
accessed elsewhere in that function.

It is correct in that the function asserts key->etype to be
EXPR_RANGE_VALUE, so key->value is not necessarily valid (it just
happens to match key->range.low's offset.

Fixes: 91dc281a82ea6 ("src: rework singleton interval transformation to reduce memory consumption")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/intervals.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/intervals.c b/src/intervals.c
index c9e278b2a895a..d6af7cbc144ec 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -832,7 +832,8 @@ int setelem_to_interval(const struct set *set, struct expr *elem,
 
 	if (adjacent)
 		return 0;
-	else if (!mpz_cmp_ui(key->value, 0) && elem->key->flags & EXPR_F_INTERVAL_END) {
+	else if (!mpz_cmp_ui(key->range.low, 0) &&
+		 elem->key->flags & EXPR_F_INTERVAL_END) {
 		low->key->flags |= EXPR_F_INTERVAL_END;
 		return 0;
 	} else if (mpz_scan0(key->range.high, 0) == set->key->len) {
-- 
2.54.0


