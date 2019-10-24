Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B6E381A
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503483AbfJXQhs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 12:37:48 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:58930 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503426AbfJXQhs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:37:48 -0400
Received: from localhost ([::1]:43788 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iNg7P-0005Dx-7f; Thu, 24 Oct 2019 18:37:47 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 7/7] tests: shell: Add ipt-restore/0007-flush-noflush_0
Date:   Thu, 24 Oct 2019 18:37:12 +0200
Message-Id: <20191024163712.22405-8-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024163712.22405-1-phil@nwl.cc>
References: <20191024163712.22405-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Simple test to make sure iptables-restore does not touch tables it is
not supposed to.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../ipt-restore/0007-flush-noflush_0          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0007-flush-noflush_0

diff --git a/iptables/tests/shell/testcases/ipt-restore/0007-flush-noflush_0 b/iptables/tests/shell/testcases/ipt-restore/0007-flush-noflush_0
new file mode 100755
index 0000000000000..029db2235b9a4
--- /dev/null
+++ b/iptables/tests/shell/testcases/ipt-restore/0007-flush-noflush_0
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+# Make sure iptables-restore without --noflush does not flush tables other than
+# those contained in the dump it's reading from
+
+set -e
+
+$XT_MULTI iptables-restore <<EOF
+*nat
+-A POSTROUTING -j ACCEPT
+COMMIT
+EOF
+
+EXPECT="*nat
+:PREROUTING ACCEPT [0:0]
+:INPUT ACCEPT [0:0]
+:OUTPUT ACCEPT [0:0]
+:POSTROUTING ACCEPT [0:0]
+-A POSTROUTING -j ACCEPT
+COMMIT"
+diff -u -Z <(echo -e "$EXPECT" | sort) <($XT_MULTI iptables-save | grep -v '^#' | sort)
+
+$XT_MULTI iptables-restore <<EOF
+*filter
+-A FORWARD -j ACCEPT
+COMMIT
+EOF
+
+EXPECT="*filter
+:INPUT ACCEPT [0:0]
+:FORWARD ACCEPT [0:0]
+:OUTPUT ACCEPT [0:0]
+-A FORWARD -j ACCEPT
+COMMIT
+*nat
+:PREROUTING ACCEPT [0:0]
+:INPUT ACCEPT [0:0]
+:OUTPUT ACCEPT [0:0]
+:POSTROUTING ACCEPT [0:0]
+-A POSTROUTING -j ACCEPT
+COMMIT"
+diff -u -Z <(echo -e "$EXPECT" | sort) <($XT_MULTI iptables-save | grep -v '^#' | sort)
-- 
2.23.0

