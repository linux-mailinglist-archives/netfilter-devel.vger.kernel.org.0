Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF040115000
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfLFLrW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 06:47:22 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34888 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfLFLrW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:47:22 -0500
Received: from localhost ([::1]:47978 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1idC4u-0002k5-Hu; Fri, 06 Dec 2019 12:47:20 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 4/6] libxtables: Avoid buffer overrun in xtables_compatible_revision()
Date:   Fri,  6 Dec 2019 12:47:09 +0100
Message-Id: <20191206114711.6015-5-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206114711.6015-1-phil@nwl.cc>
References: <20191206114711.6015-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The function is exported and accepts arbitrary strings as input. Calling
strcpy() without length checks is not OK.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 libxtables/xtables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libxtables/xtables.c b/libxtables/xtables.c
index 895f6988eaf57..777c2b08e9896 100644
--- a/libxtables/xtables.c
+++ b/libxtables/xtables.c
@@ -856,7 +856,8 @@ int xtables_compatible_revision(const char *name, uint8_t revision, int opt)
 
 	xtables_load_ko(xtables_modprobe_program, true);
 
-	strcpy(rev.name, name);
+	strncpy(rev.name, name, XT_EXTENSION_MAXNAMELEN - 1);
+	rev.name[XT_EXTENSION_MAXNAMELEN - 1] = '\0';
 	rev.revision = revision;
 
 	max_rev = getsockopt(sockfd, afinfo->ipproto, opt, &rev, &s);
-- 
2.24.0

