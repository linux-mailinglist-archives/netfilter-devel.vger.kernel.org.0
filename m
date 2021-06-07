Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E639DF38
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Jun 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGOvv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Jun 2021 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGOvv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:51:51 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACBC061787
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Jun 2021 07:50:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lqGZi-0002U1-IE; Mon, 07 Jun 2021 16:49:58 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v2 3/3] doc: add LISTING section
Date:   Mon,  7 Jun 2021 16:49:45 +0200
Message-Id: <20210607144945.16649-3-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607144945.16649-1-fw@strlen.de>
References: <20210607144945.16649-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

mention various 'nft list' options, such as secmarks, flow tables, and
so on.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 No changes.
 doc/nft.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/nft.txt b/doc/nft.txt
index 011095babe80..46e8dc5366c2 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -683,6 +683,16 @@ and subtraction can be used to set relative priority, e.g. filter + 5 equals to
 *delete*:: Delete the specified flowtable.
 *list*:: List all flowtables.
 
+LISTING
+-------
+[verse]
+*list { secmarks | synproxys | flow tables | meters | hooks }* ['family']
+*list { secmarks | synproxys | flow tables | meters | hooks } table* ['family'] 'table'
+*list ct { timeout | expectation | helper | helpers } table* ['family'] 'table'
+
+Inspect configured objects.
+*list hooks* shows the full hook pipeline, including those registered by
+kernel modules, such as nf_conntrack.
 
 STATEFUL OBJECTS
 ----------------
@@ -691,6 +701,7 @@ STATEFUL OBJECTS
 *delete* 'type' ['family'] 'table' *handle* 'handle'
 *list counters* ['family']
 *list quotas* ['family']
+*list limits* ['family']
 
 Stateful objects are attached to tables and are identified by a unique name.
 They group stateful information from rules, to reference them in rules the
-- 
2.31.1

