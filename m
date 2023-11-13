Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105427E9A83
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjKMKoK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 05:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjKMKoI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:44:08 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CB10CC
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 02:44:05 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 84DB958725FCB; Mon, 13 Nov 2023 11:44:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 71DC558725FD6
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 11:44:02 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 6/7] man: fix one spello
Date:   Mon, 13 Nov 2023 11:43:11 +0100
Message-ID: <20231113104357.59087-7-jengelh@inai.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113104357.59087-1-jengelh@inai.de>
References: <20231113104357.59087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 ebtables-legacy.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebtables-legacy.8.in b/ebtables-legacy.8.in
index 13c95fe..51270d2 100644
--- a/ebtables-legacy.8.in
+++ b/ebtables-legacy.8.in
@@ -879,7 +879,7 @@ The log watcher writes descriptive data about a frame to the syslog.
 .TP
 .B "\-\-log"
 .br
-Log with the default loggin options: log-level=
+Log with the default logging options: log-level=
 .IR info ,
 log-prefix="", no ip logging, no arp logging.
 .TP
-- 
2.42.1

