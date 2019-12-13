Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FF11DB61
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Dec 2019 01:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfLMA6W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Dec 2019 19:58:22 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:37682 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727766AbfLMA6W (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:58:22 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ifZHg-0008Pl-Dn; Fri, 13 Dec 2019 01:58:20 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: conntrack: remove two export symbols
Date:   Fri, 13 Dec 2019 01:58:15 +0100
Message-Id: <20191213005815.9244-1-fw@strlen.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c   | 1 -
 net/netfilter/nf_conntrack_extend.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 0af1898af2b8..983a9481e8f8 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2333,7 +2333,6 @@ int nf_conntrack_set_hashsize(const char *val, const struct kernel_param *kp)
 
 	return nf_conntrack_hash_resize(hashsize);
 }
-EXPORT_SYMBOL_GPL(nf_conntrack_set_hashsize);
 
 static __always_inline unsigned int total_extension_size(void)
 {
diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntrack_extend.c
index c24e5b64b00c..3dbe2329c3f1 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -37,7 +37,6 @@ void nf_ct_ext_destroy(struct nf_conn *ct)
 
 	kfree(ct->ext);
 }
-EXPORT_SYMBOL(nf_ct_ext_destroy);
 
 void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext_id id, gfp_t gfp)
 {
-- 
2.23.0

