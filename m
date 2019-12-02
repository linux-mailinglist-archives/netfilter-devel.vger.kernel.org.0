Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC810F2D0
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLBWYM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 17:24:12 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:54600 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBWYM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:24:12 -0500
Received: from localhost ([::1]:39458 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1ibu70-0000DY-9L; Mon, 02 Dec 2019 23:24:10 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 3/4] flowtable: Correctly check realloc() call
Date:   Mon,  2 Dec 2019 23:24:00 +0100
Message-Id: <20191202222401.867-4-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202222401.867-1-phil@nwl.cc>
References: <20191202222401.867-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If realloc() fails, it returns NULL but the original pointer is
untouchted and therefore still has to be freed. Unconditionally
overwriting the old pointer is therefore a bad idea, use a temporary
variable instead.

Fixes: 7f99639dd9217 ("flowtable: device array dynamic allocation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/flowtable.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/flowtable.c b/src/flowtable.c
index db319434b51c0..9ba3b6d9a3404 100644
--- a/src/flowtable.c
+++ b/src/flowtable.c
@@ -388,7 +388,7 @@ static int nftnl_flowtable_parse_hook_cb(const struct nlattr *attr, void *data)
 static int nftnl_flowtable_parse_devs(struct nlattr *nest,
 				      struct nftnl_flowtable *c)
 {
-	const char **dev_array;
+	const char **dev_array, **tmp;
 	int len = 0, size = 8;
 	struct nlattr *attr;
 
@@ -401,14 +401,13 @@ static int nftnl_flowtable_parse_devs(struct nlattr *nest,
 			goto err;
 		dev_array[len++] = strdup(mnl_attr_get_str(attr));
 		if (len >= size) {
-			dev_array = realloc(dev_array,
-					    size * 2 * sizeof(char *));
-			if (!dev_array)
+			tmp = realloc(dev_array, size * 2 * sizeof(char *));
+			if (!tmp)
 				goto err;
 
 			size *= 2;
-			memset(&dev_array[len], 0,
-			       (size - len) * sizeof(char *));
+			memset(&tmp[len], 0, (size - len) * sizeof(char *));
+			dev_array = tmp;
 		}
 	}
 
-- 
2.24.0

