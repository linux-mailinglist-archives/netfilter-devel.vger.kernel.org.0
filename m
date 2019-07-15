Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84D683A9
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jul 2019 08:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGOGqZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jul 2019 02:46:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfGOGqY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:46:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D37F3AF06;
        Mon, 15 Jul 2019 06:46:23 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 623B7E0148; Mon, 15 Jul 2019 08:46:23 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH conntrack-tools] conntrackd: use correct max unix path length
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Message-Id: <20190715064623.623B7E0148@unicorn.suse.cz>
Date:   Mon, 15 Jul 2019 08:46:23 +0200 (CEST)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When copying value of "Path" option for unix socket, target buffer size is
UNIX_MAX_PATH so that we must not copy more bytes than that. Also make sure
that the path is null terminated and bail out if user provided path is too
long rather than silently truncate it.

Fixes: ce06fb606906 ("conntrackd: use strncpy() to unix path")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 src/read_config_yy.y | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/read_config_yy.y b/src/read_config_yy.y
index ceba6fc0d242..4311cd6c9a2f 100644
--- a/src/read_config_yy.y
+++ b/src/read_config_yy.y
@@ -689,8 +689,13 @@ unix_options:
 
 unix_option : T_PATH T_PATH_VAL
 {
-	strncpy(conf.local.path, $2, PATH_MAX);
+	strncpy(conf.local.path, $2, UNIX_PATH_MAX);
 	free($2);
+	if (conf.local.path[UNIX_PATH_MAX - 1]) {
+		dlog(LOG_ERR, "UNIX Path is longer than %u characters",
+		     UNIX_PATH_MAX - 1);
+		exit(EXIT_FAILURE);
+	}
 };
 
 unix_option : T_BACKLOG T_NUMBER
-- 
2.22.0

