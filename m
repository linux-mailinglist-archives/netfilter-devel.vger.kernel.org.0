Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0582324C1F0
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Aug 2020 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHTPRD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Aug 2020 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgHTPQ5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:16:57 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A89C061385
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Aug 2020 08:16:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1k8mJ9-0001uR-Es; Thu, 20 Aug 2020 17:16:51 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH libnftnl] libnftnl: export nftnl_set_elem_fprintf
Date:   Thu, 20 Aug 2020 17:16:45 +0200
Message-Id: <20200820151645.29418-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Was not exported so far due to a typo.  While at it, add const qualifier
to element structure.

Will be used to optionally dump set contents / elements from nft
frontend.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/libnftnl/set.h | 2 +-
 src/libnftnl.map       | 2 +-
 src/set_elem.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/libnftnl/set.h b/include/libnftnl/set.h
index 5138bb99b426..961ce5d7d71d 100644
--- a/include/libnftnl/set.h
+++ b/include/libnftnl/set.h
@@ -142,7 +142,7 @@ int nftnl_set_elem_parse(struct nftnl_set_elem *e, enum nftnl_parse_type type,
 int nftnl_set_elem_parse_file(struct nftnl_set_elem *e, enum nftnl_parse_type type,
 			    FILE *fp, struct nftnl_parse_err *err);
 int nftnl_set_elem_snprintf(char *buf, size_t size, const struct nftnl_set_elem *s, uint32_t type, uint32_t flags);
-int nftnl_set_elem_fprintf(FILE *fp, struct nftnl_set_elem *se, uint32_t type, uint32_t flags);
+int nftnl_set_elem_fprintf(FILE *fp, const struct nftnl_set_elem *se, uint32_t type, uint32_t flags);
 
 int nftnl_set_elem_foreach(struct nftnl_set *s, int (*cb)(struct nftnl_set_elem *e, void *data), void *data);
 
diff --git a/src/libnftnl.map b/src/libnftnl.map
index f62640f83e6b..6042479bf903 100644
--- a/src/libnftnl.map
+++ b/src/libnftnl.map
@@ -169,7 +169,7 @@ global:
   nftnl_set_elem_parse;
   nftnl_set_elem_parse_file;
   nftnl_set_elem_snprintf;
-  nftnl_set_elem_fprinf;
+  nftnl_set_elem_fprintf;
 
   nftnl_set_elems_nlmsg_build_payload;
   nftnl_set_elems_nlmsg_parse;
diff --git a/src/set_elem.c b/src/set_elem.c
index 44213228d827..e82684bc1c53 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -706,7 +706,7 @@ static int nftnl_set_elem_do_snprintf(char *buf, size_t size, const void *e,
 }
 
 EXPORT_SYMBOL(nftnl_set_elem_fprintf);
-int nftnl_set_elem_fprintf(FILE *fp, struct nftnl_set_elem *se, uint32_t type,
+int nftnl_set_elem_fprintf(FILE *fp, const struct nftnl_set_elem *se, uint32_t type,
 			 uint32_t flags)
 {
 	return nftnl_fprintf(fp, se, NFTNL_CMD_UNSPEC, type, flags,
-- 
2.26.2

