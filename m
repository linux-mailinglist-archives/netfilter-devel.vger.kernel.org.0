Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74D5AFEEB
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Sep 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIGI00 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Sep 2022 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGI00 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:26:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07D7495AEF
        for <netfilter-devel@vger.kernel.org>; Wed,  7 Sep 2022 01:26:23 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nfnetlink_osf: fix possible bogus match in nf_osf_find()
Date:   Wed,  7 Sep 2022 10:26:18 +0200
Message-Id: <20220907082618.1193201-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_osf_find() incorrectly returns true on mismatch, this leads to
copying uninitialized memory area in nft_osf which can be used to leak
stale kernel stack data to userspace.

Fixes: 22c7652cdaa8 ("netfilter: nft_osf: Add version option support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_osf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 0fa2e2030427..ee6840bd5933 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -269,6 +269,7 @@ bool nf_osf_find(const struct sk_buff *skb,
 	struct nf_osf_hdr_ctx ctx;
 	const struct tcphdr *tcp;
 	struct tcphdr _tcph;
+	bool found = false;
 
 	memset(&ctx, 0, sizeof(ctx));
 
@@ -283,10 +284,11 @@ bool nf_osf_find(const struct sk_buff *skb,
 
 		data->genre = f->genre;
 		data->version = f->version;
+		found = true;
 		break;
 	}
 
-	return true;
+	return found;
 }
 EXPORT_SYMBOL_GPL(nf_osf_find);
 
-- 
2.30.2

