Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C067C8DF
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jul 2019 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfGaQjl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Jul 2019 12:39:41 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40916 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfGaQjl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:39:41 -0400
Received: from localhost ([::1]:54006 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hsrdb-0005jv-Pm; Wed, 31 Jul 2019 18:39:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 2/5] doc: Fix xtables-monitor man page
Date:   Wed, 31 Jul 2019 18:39:12 +0200
Message-Id: <20190731163915.22232-3-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731163915.22232-1-phil@nwl.cc>
References: <20190731163915.22232-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix some syntax errors, also document -4 and -6 long options.

Fixes: d26c538b9a549 ("xtables: add xtables-monitor")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-monitor.8.in | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/iptables/xtables-monitor.8.in b/iptables/xtables-monitor.8.in
index b647a79eb64ed..19eb729c51240 100644
--- a/iptables/xtables-monitor.8.in
+++ b/iptables/xtables-monitor.8.in
@@ -2,7 +2,7 @@
 .SH NAME
 xtables-monitor \(em show changes to rule set and trace-events
 .SH SYNOPSIS
-\fBxtables\-monitor\fP [\fB\-t\fP] [\fB\-e\fP] [\fB\-4\fP|\fB|\-6\fB]
+\fBxtables\-monitor\fP [\fB\-t\fP] [\fB\-e\fP] [\fB\-4\fP|\fB\-6\fP]
 .PP
 \
 .SH DESCRIPTION
@@ -14,8 +14,8 @@ for packets tagged using the TRACE target.
 will run until the user aborts execution, typically by using CTRL-C.
 .RE
 .SH OPTIONS
-\fB\-e\fP, \fB\-\-event\fP
 .TP
+\fB\-e\fP, \fB\-\-event\fP
 Watch for updates to the rule set.
 Updates include creation of new tables, chains and rules and
 the name of the program that caused the rule update.
@@ -24,10 +24,10 @@ the name of the program that caused the rule update.
 Watch for trace events generated by packets that have been tagged
 using the TRACE target.
 .TP
-\fB\-4\fP
+\fB\-4\fP, \fB--ipv4\fP
 Restrict output to IPv4.
 .TP
-\fB\-6\fP
+\fB\-6\fP, \fB--ipv6\fP
 Restrict output to IPv6.
 .SH EXAMPLE OUTPUT
 .TP
-- 
2.22.0

