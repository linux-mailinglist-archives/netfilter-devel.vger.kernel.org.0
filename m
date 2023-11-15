Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC17E9A4D
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKMKcZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 05:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjKMKcY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:32:24 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297ACB
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 02:32:20 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id EB35D58725FD8; Mon, 13 Nov 2023 11:32:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id DE28A58725FE7
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 11:32:14 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 4/7] man: stop putting non-terminals in italic
Date:   Mon, 13 Nov 2023 11:30:09 +0100
Message-ID: <20231113103156.57745-5-jengelh@inai.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113103156.57745-1-jengelh@inai.de>
References: <20231113103156.57745-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 iptables/iptables.8.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/iptables/iptables.8.in b/iptables/iptables.8.in
index ecaa5553..90417e89 100644
--- a/iptables/iptables.8.in
+++ b/iptables/iptables.8.in
@@ -49,11 +49,11 @@ iptables/ip6tables \(em administration tool for IPv4/IPv6 packet filtering and N
 .PP
 \fBiptables\fP [\fB\-t\fP \fItable\fP] \fB\-E\fP \fIold-chain-name new-chain-name\fP
 .PP
-rule-specification = [\fImatches...\fP] [\fItarget\fP]
+rule-specification := [matches...] [target]
 .PP
-match = \fB\-m\fP \fImatchname\fP [\fIper-match-options\fP]
+match := \fB\-m\fP \fImatchname\fP [per-match-options]
 .PP
-target = \fB\-j\fP \fItargetname\fP [\fIper\-target\-options\fP]
+target := \fB\-j\fP \fItargetname\fP [per-target-options]
 .SH DESCRIPTION
 \fBIptables\fP and \fBip6tables\fP are used to set up, maintain, and inspect the
 tables of IPv4 and IPv6 packet
-- 
2.42.1

