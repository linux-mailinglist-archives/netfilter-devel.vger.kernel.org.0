Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F157D514C
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjJXNT1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjJXNTY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:19:24 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F37110
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 06:19:21 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 4BD2358783FC7; Tue, 24 Oct 2023 15:19:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 946D758783FC8
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 15:19:19 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 5/6] man: grammar fixes to some manpages
Date:   Tue, 24 Oct 2023 15:19:18 +0200
Message-ID: <20231024131919.28665-5-jengelh@inai.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024131919.28665-1-jengelh@inai.de>
References: <20231024131919.28665-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

English generally uses open compounds rather than closed ones;
fix the excess hyphens in words. Fix a missing dash for the
portnr option as well.
---
 extensions/libxt_helper.man | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/extensions/libxt_helper.man b/extensions/libxt_helper.man
index 772b1350..fb8a206c 100644
--- a/extensions/libxt_helper.man
+++ b/extensions/libxt_helper.man
@@ -1,11 +1,11 @@
-This module matches packets related to a specific conntrack-helper.
+This module matches packets related to a specific conntrack helper.
 .TP
 [\fB!\fP] \fB\-\-helper\fP \fIstring\fP
-Matches packets related to the specified conntrack-helper.
+Matches packets related to the specified conntrack helper.
 .RS
 .PP
-string can be "ftp" for packets related to a ftp-session on default port.
-For other ports append \-portnr to the value, ie. "ftp\-2121".
+string can be "ftp" for packets related to an FTP session on default port.
+For other ports, append \-\-portnr to the value, ie. "ftp\-2121".
 .PP
-Same rules apply for other conntrack-helpers.
+Same rules apply for other conntrack helpers.
 .RE
-- 
2.42.0

