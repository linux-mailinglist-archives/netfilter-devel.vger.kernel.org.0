Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19EA3057AC
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Jan 2021 11:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316801AbhAZXKd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Jan 2021 18:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393645AbhAZR4S (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:56:18 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A42C061573
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Jan 2021 09:55:13 -0800 (PST)
Received: from localhost ([::1]:44158 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1l4SYZ-0004pD-3K; Tue, 26 Jan 2021 18:55:11 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] erec: Sanitize erec location indesc
Date:   Tue, 26 Jan 2021 18:55:02 +0100
Message-Id: <20210126175502.9171-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

erec_print() unconditionally dereferences erec->locations->indesc, so
make sure it is valid when either creating an erec or adding a location.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/erec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/erec.c b/src/erec.c
index c550a596b38c8..5c3351a512464 100644
--- a/src/erec.c
+++ b/src/erec.c
@@ -38,7 +38,8 @@ void erec_add_location(struct error_record *erec, const struct location *loc)
 {
 	assert(erec->num_locations < EREC_LOCATIONS_MAX);
 	erec->locations[erec->num_locations] = *loc;
-	erec->locations[erec->num_locations].indesc = loc->indesc;
+	erec->locations[erec->num_locations].indesc = loc->indesc ?
+						    : &internal_indesc;
 	erec->num_locations++;
 }
 
-- 
2.28.0

