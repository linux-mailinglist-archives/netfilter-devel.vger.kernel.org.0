Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8806C813
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 05:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbfGRDj4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 23:39:56 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33914 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389174AbfGRDjz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:39:55 -0400
Received: from localhost ([::1]:47004 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hnxGs-0008RL-Tx; Thu, 18 Jul 2019 05:39:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/3] meta: Reject zero ifindex values
Date:   Thu, 18 Jul 2019 05:39:38 +0200
Message-Id: <20190718033940.12820-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/meta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/meta.c b/src/meta.c
index 1e8964eb48c4d..b12340991f35a 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -155,7 +155,7 @@ static struct error_record *ifindex_type_parse(const struct expr *sym,
 		errno = 0;
 		res = strtol(sym->identifier, &end, 10);
 
-		if (res < 0 || res > INT_MAX || *end || errno)
+		if (res <= 0 || res > INT_MAX || *end || errno)
 			return error(&sym->location, "Interface does not exist");
 
 		ifindex = (int)res;
-- 
2.22.0

