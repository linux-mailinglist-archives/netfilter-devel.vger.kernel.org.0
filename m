Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B47C4F1D
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Oct 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjJKJfp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Oct 2023 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJKJfo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:35:44 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 342B594
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Oct 2023 02:35:42 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack] conntrack: label update requires a previous label in place
Date:   Wed, 11 Oct 2023 11:35:36 +0200
Message-Id: <20231011093536.129955-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

You have to set an initial label if you plan to update it later on.  If
conntrack comes with no initial label, then it is not possible to attach
it later because conntrack extensions are created by the time the new
entry is created.

Update manpage to document this behaviour.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1622
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 conntrack.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conntrack.8 b/conntrack.8
index 031eaa4e9fef..f3610b15d4a6 100644
--- a/conntrack.8
+++ b/conntrack.8
@@ -193,6 +193,9 @@ Use multiple \-l options to specify multiple labels that need to be set.
 Specify the conntrack label to add to the selected conntracks.
 This option is only available in conjunction with "\-I, \-\-create",
 "\-A, \-\-add" or "\-U, \-\-update".
+You must set a default label for conntracks initially if you plan to update it
+later, that is, "\-U, \-\-update" requires an initial label already. If you
+update a conntrack entry without an initial label, an error will be reported.
 .TP
 .BI "--label-del " "[LABEL]"
 Specify the conntrack label to delete from the selected conntracks.
-- 
2.30.2

