Return-Path: <netfilter-devel+bounces-3063-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76693CC99
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jul 2024 04:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D06A1F2245C
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jul 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4B8BEF;
	Fri, 26 Jul 2024 02:00:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C481B28A
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jul 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721959212; cv=none; b=Yr04aB2QdsKr30ikK/4CZxjLUcrFpIqgOeMYkfh385HxRgvxG3B7CBJ4fNeNQDMAxCAjY9oyvCieEHcxuGbN6sEZmUNs48bS21qKnuBxceyjQK28NFNJFl4Dz4YfxKpJnK/kv0y8SHtCZxTXEWQt4p5BYGRfzq/zIXjsSXZ9dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721959212; c=relaxed/simple;
	bh=7YHC7r2FKjQlMttUh7T/hSOJ0esvhcE5SWkS8byQTJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrg4fIA9DZiKOXoj42+Cl/3JX8ea4cL2KQiL5ECjdNl1v/vcY/+g6nqeMihGhkix8p/I7Y5X8nimVJ9zTBzYabKAyiRq7twhJp9LbMdspSybv2vIg22qKqbDfFHEFWnKHm2wEU+Xk0HRPwmdWg4CHKwafNXKXeGFjdqV+WlOwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sXAFd-0004JS-G5; Fri, 26 Jul 2024 04:00:09 +0200
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 4/4] src: add egress support for 'list hooks'
Date: Fri, 26 Jul 2024 03:58:31 +0200
Message-ID: <20240726015837.14572-5-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240726015837.14572-1-fw@strlen.de>
References: <20240726015837.14572-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missing:  Also include the egress hooks when listing
the netdev family (or unspec).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/mnl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 9de3d34cfdbd..8703bcbf88c8 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -2551,11 +2551,12 @@ static int mnl_nft_dump_nf_arp(struct netlink_ctx *ctx, int family, int hook,
 static int mnl_nft_dump_nf_netdev(struct netlink_ctx *ctx, int family, int hook,
 				  const char *devname, struct list_head *hook_list)
 {
-	int err;
+	int err1, err2;
 
-	err = __mnl_nft_dump_nf_hooks(ctx, family, NFPROTO_NETDEV, NF_NETDEV_INGRESS, devname, hook_list);
+	err1 = __mnl_nft_dump_nf_hooks(ctx, family, NFPROTO_NETDEV, NF_NETDEV_INGRESS, devname, hook_list);
+	err2 = __mnl_nft_dump_nf_hooks(ctx, family, NFPROTO_NETDEV, NF_NETDEV_EGRESS, devname, hook_list);
 
-	return err;
+	return err1 ? err1 : err2;
 }
 
 static void release_hook_list(struct list_head *hook_list)
-- 
2.44.2


