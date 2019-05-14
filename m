Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8681C901
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 May 2019 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfENMuX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 May 2019 08:50:23 -0400
Received: from mail.us.es ([193.147.175.20]:44574 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENMuW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 May 2019 08:50:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 14BDD303D00
        for <netfilter-devel@vger.kernel.org>; Tue, 14 May 2019 14:50:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 04035DA706
        for <netfilter-devel@vger.kernel.org>; Tue, 14 May 2019 14:50:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EDE5ADA705; Tue, 14 May 2019 14:50:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A6411DA70B
        for <netfilter-devel@vger.kernel.org>; Tue, 14 May 2019 14:50:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 14 May 2019 14:50:18 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 86FF04265A31
        for <netfilter-devel@vger.kernel.org>; Tue, 14 May 2019 14:50:18 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables] man: refer to iptables-translate and ip6tables
Date:   Tue, 14 May 2019 14:50:15 +0200
Message-Id: <20190514125015.3936-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of xtables-translate. Remove old reference to xtables-compat.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/xtables-translate.8 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/iptables/xtables-translate.8 b/iptables/xtables-translate.8
index c40f9f0297b5..3dc72760e863 100644
--- a/iptables/xtables-translate.8
+++ b/iptables/xtables-translate.8
@@ -22,11 +22,12 @@
 .\" <http://www.gnu.org/licenses/>.
 .\" %%%LICENSE_END
 .\"
-.TH XTABLES-TRANSLATE 8 "Mar 16, 2018"
+.TH IPTABLES-TRANSLATE 8 "May 14, 2019"
 
 .SH NAME
-xtables-translate \- translation tools to migrate from iptables to nftables
-
+iptables-translate \(em translation tool to migrate from iptables to nftables
+.P
+ip6tables-translate \(em translation tool to migrate from ip6tables to nftables
 .SH DESCRIPTION
 There is a set of tools to help the system administrator translate a given
 ruleset from \fBiptables(8)\fP and \fBip6tables(8)\fP to \fBnftables(8)\fP.
@@ -123,7 +124,7 @@ To get up-to-date information about this, please head to
 \fBhttps://wiki.nftables.org/\fP.
 
 .SH SEE ALSO
-\fBnft(8)\fP, \fBxtables-compat(8)\fP
+\fBnft(8)\fP, \fBiptables(8)\fP
 
 .SH AUTHORS
 The nftables framework is written by the Netfilter project
-- 
2.11.0

