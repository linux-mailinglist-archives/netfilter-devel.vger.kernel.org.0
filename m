Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3751ED100
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2020 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgFCNiv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jun 2020 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgFCNiv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:38:51 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E6C08C5C0
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2020 06:38:50 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id B869158781302; Wed,  3 Jun 2020 15:38:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 89084587637A1;
        Wed,  3 Jun 2020 15:38:48 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH] build: resolve iptables-apply not getting installed
Date:   Wed,  3 Jun 2020 15:38:48 +0200
Message-Id: <20200603133848.13672-1-jengelh@inai.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ip6tables-apply gets installed but iptables-apply does not.
That is wrong.

» make install DESTDIR=$PWD/r
» find r -name "*app*"
r/usr/local/sbin/ip6tables-apply
r/usr/local/share/man/man8/iptables-apply.8
r/usr/local/share/man/man8/ip6tables-apply.8

Fixes: v1.8.5~87
Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---

 (for the iptables git repo)

 iptables/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/Makefile.am b/iptables/Makefile.am
index dc66b3cc..2024dbf5 100644
--- a/iptables/Makefile.am
+++ b/iptables/Makefile.am
@@ -56,7 +56,7 @@ man_MANS         = iptables.8 iptables-restore.8 iptables-save.8 \
                    ip6tables-save.8 iptables-extensions.8 \
                    iptables-apply.8 ip6tables-apply.8
 
-sbin_SCRIPT      = iptables-apply
+sbin_SCRIPTS     = iptables-apply
 
 if ENABLE_NFTABLES
 man_MANS	+= xtables-nft.8 xtables-translate.8 xtables-legacy.8 \
-- 
2.26.2

