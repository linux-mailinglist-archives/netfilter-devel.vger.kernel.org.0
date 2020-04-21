Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79C1B2635
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUMfk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMfk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:35:40 -0400
X-Greylist: delayed 596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Apr 2020 05:35:40 PDT
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F7C061A10
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2020 05:35:40 -0700 (PDT)
Received: from localhost ([::1]:47350 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jQs7n-0000ax-8k; Tue, 21 Apr 2020 14:35:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] xshared: Drop pointless assignment in add_param_to_argv()
Date:   Tue, 21 Apr 2020 14:35:30 +0200
Message-Id: <20200421123530.31231-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This must be a leftover from a previous cleanup.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xshared.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/iptables/xshared.c b/iptables/xshared.c
index 16c58914e59a5..c1d1371a6d54a 100644
--- a/iptables/xshared.c
+++ b/iptables/xshared.c
@@ -495,7 +495,6 @@ void add_param_to_argv(struct argv_store *store, char *parsestart, int line)
 				continue;
 			} else if (*curchar == '"') {
 				quote_open = 0;
-				*curchar = '"';
 			} else {
 				add_param(&param, curchar);
 				continue;
-- 
2.25.1

