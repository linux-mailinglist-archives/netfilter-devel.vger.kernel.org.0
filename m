Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714AADB9DA
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 00:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438287AbfJQWtN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 18:49:13 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42630 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbfJQWtN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:49:13 -0400
Received: from localhost ([::1]:55720 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iLEa0-00045B-Jh; Fri, 18 Oct 2019 00:49:12 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 5/8] iptables-restore: Constify struct iptables_restore_cb
Date:   Fri, 18 Oct 2019 00:48:33 +0200
Message-Id: <20191017224836.8261-6-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017224836.8261-1-phil@nwl.cc>
References: <20191017224836.8261-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Just like with xtables-restore, these callbacks don't change at
run-time.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/iptables-restore.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/iptables/iptables-restore.c b/iptables/iptables-restore.c
index 3655b3e84637e..50d0708eff1f3 100644
--- a/iptables/iptables-restore.c
+++ b/iptables/iptables-restore.c
@@ -70,7 +70,7 @@ struct iptables_restore_cb {
 };
 
 static struct xtc_handle *
-create_handle(struct iptables_restore_cb *cb, const char *tablename)
+create_handle(const struct iptables_restore_cb *cb, const char *tablename)
 {
 	struct xtc_handle *handle;
 
@@ -90,7 +90,8 @@ create_handle(struct iptables_restore_cb *cb, const char *tablename)
 }
 
 static int
-ip46tables_restore_main(struct iptables_restore_cb *cb, int argc, char *argv[])
+ip46tables_restore_main(const struct iptables_restore_cb *cb,
+			int argc, char *argv[])
 {
 	struct xtc_handle *handle = NULL;
 	char buffer[10240];
@@ -360,7 +361,7 @@ ip46tables_restore_main(struct iptables_restore_cb *cb, int argc, char *argv[])
 
 
 #if defined ENABLE_IPV4
-struct iptables_restore_cb ipt_restore_cb = {
+static const struct iptables_restore_cb ipt_restore_cb = {
 	.ops		= &iptc_ops,
 	.for_each_chain	= for_each_chain4,
 	.flush_entries	= flush_entries4,
@@ -391,7 +392,7 @@ iptables_restore_main(int argc, char *argv[])
 #endif
 
 #if defined ENABLE_IPV6
-struct iptables_restore_cb ip6t_restore_cb = {
+static const struct iptables_restore_cb ip6t_restore_cb = {
 	.ops		= &ip6tc_ops,
 	.for_each_chain	= for_each_chain6,
 	.flush_entries	= flush_entries6,
-- 
2.23.0

