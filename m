Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E0DB9D6
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 00:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438257AbfJQWsw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 18:48:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42606 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbfJQWsw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:48:52 -0400
Received: from localhost ([::1]:55696 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iLEZe-00043g-Cu; Fri, 18 Oct 2019 00:48:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 6/8] xtables-restore: Drop pointless newargc reset
Date:   Fri, 18 Oct 2019 00:48:34 +0200
Message-Id: <20191017224836.8261-7-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017224836.8261-1-phil@nwl.cc>
References: <20191017224836.8261-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This was overlooked when merging argv-related code: newargc is
initialized at declaration and reset in free_argv() again.

Fixes: a2ed880a19d08 ("xshared: Consolidate argv construction routines")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-restore.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index df8844208c273..bb6ee78933f7a 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -232,9 +232,6 @@ void xtables_restore_parse(struct nft_handle *h,
 			char *bcnt = NULL;
 			char *parsestart = buffer;
 
-			/* reset the newargv */
-			newargc = 0;
-
 			add_argv(xt_params->program_name, 0);
 			add_argv("-t", 0);
 			add_argv(curtable->name, 0);
-- 
2.23.0

