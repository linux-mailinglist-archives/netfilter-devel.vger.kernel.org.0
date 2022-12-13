Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50364B670
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Dec 2022 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiLMNia (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Dec 2022 08:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiLMNi3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:38:29 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4122C
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Dec 2022 05:38:28 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1p55UH-00011h-UO; Tue, 13 Dec 2022 14:38:25 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] doc: add/update can be used with maps too
Date:   Tue, 13 Dec 2022 14:38:21 +0100
Message-Id: <20221213133821.2260-1-fw@strlen.de>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The man page implies that add/update are only supported with
sets, but this can be used with maps as well.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 doc/statements.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/statements.txt b/doc/statements.txt
index bda63bb3bc38..6758049b0513 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -716,6 +716,10 @@ will not grow indefinitely) either from the set definition or from the statement
 that adds or updates them. The set statement can be used to e.g. create dynamic
 blacklists.
 
+Dynamic updates are also supported with maps. In this case, the *add* or
+*update* rule needs to provide both the key and the data element (value),
+separated via ':'.
+
 [verse]
 {*add* | *update*} *@*'setname' *{* 'expression' [*timeout* 'timeout'] [*comment* 'string'] *}*
 
-- 
2.37.4

