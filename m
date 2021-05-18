Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9063878F7
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 May 2021 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbhERMjm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 May 2021 08:39:42 -0400
Received: from mail.netfilter.org ([217.70.188.207]:42796 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbhERMjl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 May 2021 08:39:41 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id AA3A36415E
        for <netfilter-devel@vger.kernel.org>; Tue, 18 May 2021 14:37:28 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables,v2] datatype: skip cgroupv2 rootfs in listing
Date:   Tue, 18 May 2021 14:38:17 +0200
Message-Id: <20210518123817.64715-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

cgroupv2 path is expressed from the /sys/fs/cgroup, update listing
to skip the rootfs.

 # nft add rule x y socket cgroupv2 level 1 "user.slice" counter
 # nft list ruleset
 table ip x {
        chain y {
                type filter hook input priority filter; policy accept;
                socket cgroupv2 level 1 "user.slice" counter
        }
 }

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: update commit description.

 src/datatype.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/datatype.c b/src/datatype.c
index 743505de44b6..7267d60895d8 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1382,7 +1382,8 @@ static void cgroupv2_type_print(const struct expr *expr,
 
 	cgroup_path = cgroupv2_get_path(SYSFS_CGROUPSV2_PATH, id);
 	if (cgroup_path)
-		nft_print(octx, "\"%s\"", cgroup_path);
+		nft_print(octx, "\"%s\"",
+			  &cgroup_path[strlen(SYSFS_CGROUPSV2_PATH) + 1]);
 	else
 		nft_print(octx, "%" PRIu64, id);
 
-- 
2.30.2

