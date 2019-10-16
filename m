Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253DADA1E6
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 01:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfJPXDz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 19:03:55 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40214 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbfJPXDy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:03:54 -0400
Received: from localhost ([::1]:53304 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKsKf-0005fb-AT; Thu, 17 Oct 2019 01:03:53 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 4/4] rule: Fix for single line ct timeout printing
Date:   Thu, 17 Oct 2019 01:03:22 +0200
Message-Id: <20191016230322.24432-5-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016230322.24432-1-phil@nwl.cc>
References: <20191016230322.24432-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Commit 43ae7a48ae3de ("rule: do not print semicolon in ct timeout")
removed an extra semicolon at end of line, but thereby broke single line
output. The correct fix is to use opts->stmt_separator which holds
either newline or semicolon chars depending on output mode.

Fixes: 43ae7a48ae3de ("rule: do not print semicolon in ct timeout")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rule.c b/src/rule.c
index 2d35bae44c9e5..3c7c8d63f8cdf 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1869,7 +1869,7 @@ static void obj_print_data(const struct obj *obj,
 		nft_print(octx, "%s", opts->nl);
 		nft_print(octx, "%s%sprotocol ", opts->tab, opts->tab);
 		print_proto_name_proto(obj->ct_timeout.l4proto, octx);
-		nft_print(octx, "%s", opts->nl);
+		nft_print(octx, "%s", opts->stmt_separator);
 		nft_print(octx, "%s%sl3proto %s%s",
 			  opts->tab, opts->tab,
 			  family2str(obj->ct_timeout.l3proto),
-- 
2.23.0

