Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C847B2F3137
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Jan 2021 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbhALM47 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Jan 2021 07:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388710AbhALM46 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:56:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 782D62311E;
        Tue, 12 Jan 2021 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610456145;
        bh=Ey9cdj9Qb3y4GEM57tNeEL9UWD6+5fS93Hq6+cABaTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArTF6Bx69XEN2EVvMGe1KA4TAHUDvqcBF1yG+EoYrXkxSXHSa1djj03KrcNYPyg68
         sGwjq99f7aeejpTJvmkiOa93SSYq/xhy9hxKrzAlLN3Zw2Np2glJ4VURWCWr2USV1v
         2epdqtj3Dr+494tw2lw2/RdiT2bKgaA9Lbx1QO4bIEaYrKH35Xr3YuVw/Hl3lLXCRr
         cAAzeWQXdVLXI7A/leTYj1UKHiz2qb3XtMj1u643hmS7iUKXbDK0kE/NhsZYFv0ghG
         ZFGSgROZH5ksshJK7d1yStNU2Uhebn1Yo7mRjlFHrbL8qa5acgmSE23pOZrxfTSCdE
         ij5XGo+UlvT/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/51] netfilter: ipset: fixes possible oops in mtype_resize
Date:   Tue, 12 Jan 2021 07:54:50 -0500
Message-Id: <20210112125534.70280-8-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125534.70280-1-sashal@kernel.org>
References: <20210112125534.70280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 2b33d6ffa9e38f344418976b06057e2fc2aa9e2a ]

currently mtype_resize() can cause oops

        t = ip_set_alloc(htable_size(htable_bits));
        if (!t) {
                ret = -ENOMEM;
                goto out;
        }
        t->hregion = ip_set_alloc(ahash_sizeof_regions(htable_bits));

Increased htable_bits can force htable_size() to return 0.
In own turn ip_set_alloc(0) returns not 0 but ZERO_SIZE_PTR,
so follwoing access to t->hregion should trigger an OOPS.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 521e970be4028..8d4a9e0fd723f 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -644,7 +644,7 @@ mtype_resize(struct ip_set *set, bool retried)
 	struct htype *h = set->data;
 	struct htable *t, *orig;
 	u8 htable_bits;
-	size_t dsize = set->dsize;
+	size_t hsize, dsize = set->dsize;
 #ifdef IP_SET_HASH_WITH_NETS
 	u8 flags;
 	struct mtype_elem *tmp;
@@ -668,14 +668,12 @@ mtype_resize(struct ip_set *set, bool retried)
 retry:
 	ret = 0;
 	htable_bits++;
-	if (!htable_bits) {
-		/* In case we have plenty of memory :-) */
-		pr_warn("Cannot increase the hashsize of set %s further\n",
-			set->name);
-		ret = -IPSET_ERR_HASH_FULL;
-		goto out;
-	}
-	t = ip_set_alloc(htable_size(htable_bits));
+	if (!htable_bits)
+		goto hbwarn;
+	hsize = htable_size(htable_bits);
+	if (!hsize)
+		goto hbwarn;
+	t = ip_set_alloc(hsize);
 	if (!t) {
 		ret = -ENOMEM;
 		goto out;
@@ -817,6 +815,12 @@ mtype_resize(struct ip_set *set, bool retried)
 	if (ret == -EAGAIN)
 		goto retry;
 	goto out;
+
+hbwarn:
+	/* In case we have plenty of memory :-) */
+	pr_warn("Cannot increase the hashsize of set %s further\n", set->name);
+	ret = -IPSET_ERR_HASH_FULL;
+	goto out;
 }
 
 /* Get the current number of elements and ext_size in the set  */
-- 
2.27.0

