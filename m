Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A497D514A
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjJXNT0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJXNTY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:19:24 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C76E9
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 06:19:21 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 3D58A58783FC6; Tue, 24 Oct 2023 15:19:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 8738D58783FC7
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 15:19:19 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 4/6] man: consistent casing of "IPv[46]"
Date:   Tue, 24 Oct 2023 15:19:17 +0200
Message-ID: <20231024131919.28665-4-jengelh@inai.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024131919.28665-1-jengelh@inai.de>
References: <20231024131919.28665-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

---
 extensions/libipt_ULOG.man     | 2 +-
 extensions/libxt_connlimit.man | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/extensions/libipt_ULOG.man b/extensions/libipt_ULOG.man
index c91f7764..453a5600 100644
--- a/extensions/libipt_ULOG.man
+++ b/extensions/libipt_ULOG.man
@@ -1,4 +1,4 @@
-This is the deprecated ipv4-only predecessor of the NFLOG target.
+This is the deprecated IPv4-only predecessor of the NFLOG target.
 It provides userspace logging of matching packets.  When this
 target is set for a rule, the Linux kernel will multicast this packet
 through a
diff --git a/extensions/libxt_connlimit.man b/extensions/libxt_connlimit.man
index 2292e9cc..980bf6c5 100644
--- a/extensions/libxt_connlimit.man
+++ b/extensions/libxt_connlimit.man
@@ -33,7 +33,7 @@ iptables \-p tcp \-\-syn \-\-dport 80 \-m connlimit \-\-connlimit\-above 16
 \-\-connlimit\-mask 24 \-j REJECT
 .TP
 # limit the number of parallel HTTP requests to 16 for the link local network
-(ipv6)
+(IPv6)
 ip6tables \-p tcp \-\-syn \-\-dport 80 \-s fe80::/64 \-m connlimit \-\-connlimit\-above
 16 \-\-connlimit\-mask 64 \-j REJECT
 .TP
-- 
2.42.0

