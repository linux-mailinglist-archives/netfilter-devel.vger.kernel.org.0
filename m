Return-Path: <netfilter-devel+bounces-11011-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJkeMXvKqmlWXAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11011-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Mar 2026 13:37:15 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710E220C22
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Mar 2026 13:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C2883060CF1
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Mar 2026 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54700221726;
	Fri,  6 Mar 2026 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="nYKzw85M"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16318EFD1
	for <netfilter-devel@vger.kernel.org>; Fri,  6 Mar 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800616; cv=none; b=FAgHrYcNaWuUuVCPWKniWG88HUlvMqu3eF21sqrh6Ue3ImG3qygm7Pi0iCCk29P0ng1wUFKn1rfW82PAVXggifYuJp+CEj/nCSWGqessXZAOp+KsKrxv67UQ79yWSfkYEXmrhzfyMeyjsZH6HVJvftHEl6h/CAiaX+EB8RJUSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800616; c=relaxed/simple;
	bh=24vfKEUYJRoc4YICfJfjZKLhwTqw7RPEzURvZTes84Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGY0dg9Qacn8Pzli6SFfvd/4mHb7zlj+/v+MInGDo0nUG1px79WXWaa6QaTYYfrCtBu1+q5u/7sCWJCEt+p0bx7J3pvazXlaMUa+WsEu5FR5db9sBpeRxg/IdSya3aB4u40S1oGanLUBljQ8CR0QN4eIdBkikZkI8jLROOhqHAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=nYKzw85M; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E545560542;
	Fri,  6 Mar 2026 13:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772800613;
	bh=4qOVoi1w1+MDTVVWUMCfUDDd9VtXjJbKQXzVNfFMqSo=;
	h=From:To:Cc:Subject:Date:From;
	b=nYKzw85MSshOxE8p1yb44Ox0JBixGLFPEA9KBO3f6dbZL7Wgt6cAB9+s4ViAVgAvI
	 Aug+icid5h4eNb4AOatJrl38jehP+N+gxSdcv/Ujbm/kAl14DC6cxOiXQST+kTwRGP
	 jYiVJPrCVvk0DHPb7cgGvuD3qZglXSHYSYLEe+if79y1H0ktZDVutpNk54Zf3LhjIo
	 iWEET3pEa0n6dRNiOw/8IjzTr4x2Azx71g+h6q1V1+X/IB1DF1uuoYx3JifHTRlPug
	 RlnDO1cjE006fEhEvPaPmnTb3Jj6YoSrk9g57A3au7hg7Fj8OBv6kKGKdLusrBR06a
	 AtJP7XIH1Jgmw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf] netfilter: nft_set_rbtree: allocate same array size on updates
Date: Fri,  6 Mar 2026 13:36:48 +0100
Message-ID: <20260306123649.2878676-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5710E220C22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11011-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Action: no action

The array resize function increments the size of the array in
NFT_ARRAY_EXTRA_SIZE slots for each update, this is unnecesarily
increasing the array size.

Use the current maximum number of intervals in the live array instead.

Reported-by: Chris Arges <carges@cloudflare.com>
Fixes: 7e43e0a1141d ("netfilter: nft_set_rbtree: translate rbtree to array for binary search")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_rbtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 853ff30a208c..cffeb6f5c532 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -646,7 +646,7 @@ static int nft_array_may_resize(const struct nft_set *set)
 	struct nft_array *array;
 
 	if (!priv->array_next) {
-		array = nft_array_alloc(nelems + NFT_ARRAY_EXTRA_SIZE);
+		array = nft_array_alloc(priv->array->max_intervals);
 		if (!array)
 			return -ENOMEM;
 
-- 
2.47.3


