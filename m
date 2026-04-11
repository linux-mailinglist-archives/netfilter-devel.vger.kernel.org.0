Return-Path: <netfilter-devel+bounces-11825-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJUkB9C52mkw5wgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11825-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 23:14:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E663E1B8A
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C8B9300A61E
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7112FFDE3;
	Sat, 11 Apr 2026 21:13:23 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C554248880
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Apr 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775942003; cv=none; b=T4r6KY7nTZRl6x3gQFnLG42aRVP8MdPiYUfksGHfGmSOVruxkBvl2SnAVpcFHFbthQpz85GpswOILEnHv/s8wf0ehRiS6t15QRU9ABM1zZsvUT2rz2QduVK6gxNNwen9dbN3SpiReRCM+zwuSWTLIfJWl+kgtOlRZ8SNXNLbOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775942003; c=relaxed/simple;
	bh=YY9wQ/wmEerCIGpGyAyPo+RV8dgCsMqlPJ6sTDFtMBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knAx/Y0iUfE1Ab3t8VpAWVgzOAl8MrxVTVnkwOkAqMwW8qIjbWdAv5TLrVztw84OYgbIpbFf0LXRXvV0WFIHiILlmyYI58aGsp+Z0toE9FEEIQWNT3Mmxa8d49WCUCzgVU/BzUCPyl0t4WEOVoNVIp/hzGVCvNAld4S4JpNJ8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6BADE60344; Sat, 11 Apr 2026 23:13:20 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH nf-next v2] netfilter: nft_set_rbtree: remove dead conditional
Date: Sat, 11 Apr 2026 23:13:08 +0200
Message-ID: <20260411211313.1597912-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[strlen.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-11825-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: 85E663E1B8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net/netfilter/nft_set_rbtree.c:399 __nft_rbtree_insert()
        warn: 'removed_end' is not an error pointer

Since commit : 087388278e0f ("netfilter: nf_tables: nft_set_rbtree: fix
spurious insertion failure") __nft_rbtree_insert() can no longer fail
and this condition is always false.  Remove it.

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/adjSaolTji0mPgqx@stanley.mountain/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: re-target to nf-next & fix commit message.
 There is no bug, the condition is never true anymore.

 net/netfilter/nft_set_rbtree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 737c339decd0..3407109d6a5c 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -396,9 +396,6 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			const struct nft_rbtree_elem *removed_end;
 
 			removed_end = nft_rbtree_gc_elem(set, priv, rbe);
-			if (IS_ERR(removed_end))
-				return PTR_ERR(removed_end);
-
 			if (removed_end == rbe_le || removed_end == rbe_ge)
 				return -EAGAIN;
 
-- 
2.53.0


