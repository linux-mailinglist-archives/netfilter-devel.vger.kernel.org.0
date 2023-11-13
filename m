Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED6F7E9A82
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 11:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjKMKoJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 05:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKMKoJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:44:09 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C15510CE
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 02:44:06 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 9252E58725FD6; Mon, 13 Nov 2023 11:44:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 7F04458725FEA
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 11:44:02 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 7/7] ebtables: better error message when -j is missing
Date:   Mon, 13 Nov 2023 11:43:12 +0100
Message-ID: <20231113104357.59087-8-jengelh@inai.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113104357.59087-1-jengelh@inai.de>
References: <20231113104357.59087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

	~# ebtables -t broute -A BROUTING -i xyz0 --mark-set 0
	Unknown argument: don't forget the -t option.

But I have -t already!

`t->name` is the target name, not a table name (there is no built-in table
"standard"), so we need to show -j, not -t.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 ebtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebtables.c b/ebtables.c
index c1f5c2b..d0d206b 100644
--- a/ebtables.c
+++ b/ebtables.c
@@ -1086,7 +1086,7 @@ big_iface_length:
 				ebt_print_error2("Unknown argument: '%s'", argv[optind - 1], (char)optopt, (char)c);
 			else if (w == NULL) {
 				if (!strcmp(t->name, "standard"))
-					ebt_print_error2("Unknown argument: don't forget the -t option");
+					ebt_print_error2("Unknown argument: don't forget the -j option");
 				else
 					ebt_print_error2("Target-specific option does not correspond with specified target");
 			}
-- 
2.42.1

