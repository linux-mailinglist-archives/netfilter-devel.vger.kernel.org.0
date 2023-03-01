Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA166A6B57
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Mar 2023 12:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCALFH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Mar 2023 06:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCALFG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:05:06 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC3751516A
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Mar 2023 03:05:04 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft 1/2] cache: fetch more objects when resetting rule
Date:   Wed,  1 Mar 2023 12:05:00 +0100
Message-Id: <20230301110501.79700-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the ruleset contains a reference to object, listing fails. The
existing test for the new reset command displays the following error:

 # ./run-tests.sh testcases/rule_management/0011reset_0
 I: using nft command: ./../../src/nft

 W: [FAILED]     testcases/rule_management/0011reset_0: got 2
 loading ruleset
 resetting specific rule
 netlink: Error: Unknown set 's' in dynset statement

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/cache.c b/src/cache.c
index 38bc219abc57..95adee7f8ac1 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -268,6 +268,7 @@ static unsigned int evaluate_cache_reset(struct cmd *cmd, unsigned int flags,
 {
 	switch (cmd->obj) {
 	case CMD_OBJ_RULES:
+	case CMD_OBJ_RULE:
 		if (filter) {
 			if (cmd->handle.table.name) {
 				filter->list.family = cmd->handle.family;
-- 
2.30.2

