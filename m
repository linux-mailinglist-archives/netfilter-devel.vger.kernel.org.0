Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052F56B84D
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Jul 2022 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiGHLSc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Jul 2022 07:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiGHLS3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:18:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B29FB7DF
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Jul 2022 04:18:28 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     mikhail.sennikovskii@ionos.com
Subject: [PATCH conntrack-tools 1/3] conntrack: update manpage with new -A command
Date:   Fri,  8 Jul 2022 13:18:19 +0200
Message-Id: <20220708111821.37783-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Extend manpage to document the new -A/--add command.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 conntrack.8 | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/conntrack.8 b/conntrack.8
index 0db427b7b9ea..6fbb41fe81fc 100644
--- a/conntrack.8
+++ b/conntrack.8
@@ -14,6 +14,8 @@ conntrack \- command line interface for netfilter connection tracking
 .br
 .BR "conntrack -I [table] parameters"
 .br
+.BR "conntrack -A [table] parameters"
+.br
 .BR "conntrack -U [table] parameters"
 .br
 .BR "conntrack -E [table] [options]"
@@ -88,7 +90,10 @@ Search for and show a particular (matching) entry in the given table.
 Delete an entry from the given table.
 .TP
 .BI "-I, --create "
-Create a new entry from the given table.
+Create a new entry from the given table, it fails if it already exists.
+.TP
+.BI "-A, --add "
+Add a new entry from the given table.
 .TP
 .BI "-U, --update "
 Update an entry from the given table.
@@ -186,8 +191,8 @@ Use multiple \-l options to specify multiple labels that need to be set.
 .TP
 .BI "--label-add " "LABEL"
 Specify the conntrack label to add to the selected conntracks.
-This option is only available in conjunction with "\-I, \-\-create" or
-"\-U, \-\-update".
+This option is only available in conjunction with "\-I, \-\-create",
+"\-A, \-\-add" or "\-U, \-\-update".
 .TP
 .BI "--label-del " "[LABEL]"
 Specify the conntrack label to delete from the selected conntracks.
-- 
2.30.2

