Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9D10F2D2
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 23:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLBWYW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 17:24:22 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:54612 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBWYW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:24:22 -0500
Received: from localhost ([::1]:39470 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1ibu7A-0000EK-Ud; Mon, 02 Dec 2019 23:24:20 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 1/4] flowtable: Fix memleak in error path of nftnl_flowtable_parse_devs()
Date:   Mon,  2 Dec 2019 23:23:58 +0100
Message-Id: <20191202222401.867-2-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202222401.867-1-phil@nwl.cc>
References: <20191202222401.867-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In error case, allocated dev_array is not freed.

Fixes: 7f99639dd9217 ("flowtable: device array dynamic allocation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/flowtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/flowtable.c b/src/flowtable.c
index 324e80f7e6ad6..db319434b51c0 100644
--- a/src/flowtable.c
+++ b/src/flowtable.c
@@ -419,6 +419,7 @@ static int nftnl_flowtable_parse_devs(struct nlattr *nest,
 err:
 	while (len--)
 		xfree(dev_array[len]);
+	xfree(dev_array);
 	return -1;
 }
 
-- 
2.24.0

