Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F919165861
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Feb 2020 08:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgBTH21 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Feb 2020 02:28:27 -0500
Received: from mx60.baidu.com ([61.135.168.60]:37158 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbgBTH21 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:28:27 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 02:28:25 EST
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id 9BA8011C0034
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Feb 2020 15:20:18 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH][nf-next] netfilter: cleanup unused macro
Date:   Thu, 20 Feb 2020 15:20:18 +0800
Message-Id: <1582183218-17489-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

TEMPLATE_NULLS_VAL is not used after commit 0838aa7fcfcd
("netfilter: fix netns dependencies with conntrack templates")

PFX is not used after commit 8bee4bad03c5b ("netfilter: xt
extensions: use pr_<level>")

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/netfilter/nf_conntrack_core.c | 1 -
 net/netfilter/xt_SECMARK.c        | 2 --
 2 files changed, 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d1305423640f..1f91351432cc 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2497,7 +2497,6 @@ void nf_conntrack_init_end(void)
  */
 #define UNCONFIRMED_NULLS_VAL	((1<<30)+0)
 #define DYING_NULLS_VAL		((1<<30)+1)
-#define TEMPLATE_NULLS_VAL	((1<<30)+2)
 
 int nf_conntrack_init_net(struct net *net)
 {
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2317721f3ecb..75625d13e976 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -21,8 +21,6 @@ MODULE_DESCRIPTION("Xtables: packet security mark modification");
 MODULE_ALIAS("ipt_SECMARK");
 MODULE_ALIAS("ip6t_SECMARK");
 
-#define PFX "SECMARK: "
-
 static u8 mode;
 
 static unsigned int
-- 
2.16.2

