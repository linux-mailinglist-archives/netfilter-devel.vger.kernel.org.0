Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DC6E4C0
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 13:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSLKM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 07:10:12 -0400
Received: from kadath.azazel.net ([81.187.231.250]:52162 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfGSLKM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qOPFAIuBK3b+lsEwNQ4U8sEvGEkxBPaVsnbSdc6mceQ=; b=QaFPTIqy8LA4pkwsyNl6WdKG+9
        cgIoy7S7TyteJWlocMTsuVLZmzh/ETkJOHdKUzTHYVITPU/l0LazqnDnDQk88WoyIVMyXk/eBsDkE
        uQwVIG0TLEusT6tpfSLRA9B8lSL+RCUcyLyYBgrOM/LjQtU9rV3LZ9Xu6B2XcOWqF77TpMe6L+B3a
        11UzFIjHu6/acV0HmVzFam+LypUm6Co61+OCV6aWZAxTSIJ0ZZEfQj70I3qWZXsrya2MPdVIONdx/
        cOrrKxfVNWsXGYhLPl1pV4cOQR6ejfG3Im4EfxQ83uJF7tGexytIhBQdb2n7Iw1qA7+adaXqVy0vo
        VsnTIjQA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1hoQmB-00070n-1x; Fri, 19 Jul 2019 12:10:11 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nft v2 2/2] rule: removed duplicate member initializer.
Date:   Fri, 19 Jul 2019 12:10:10 +0100
Message-Id: <20190719111010.14421-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719111010.14421-1-jeremy@azazel.net>
References: <20190719103205.GM1628@orbyte.nwl.cc>
 <20190719111010.14421-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Initialization of a netlink_ctx included two initializers for .nft.
Removed one of them.

Fixes: 2dc07bcd7eaa ("src: pass struct nft_ctx through struct netlink_ctx")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/rule.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/rule.c b/src/rule.c
index b957b4571249..0ebe91e79a03 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -240,7 +240,6 @@ int cache_update(struct nft_ctx *nft, unsigned int flags, struct list_head *msgs
 		.list		= LIST_HEAD_INIT(ctx.list),
 		.nft		= nft,
 		.msgs		= msgs,
-		.nft		= nft,
 	};
 	struct nft_cache *cache = &nft->cache;
 	uint32_t genid, genid_stop;
-- 
2.20.1

