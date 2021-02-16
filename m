Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE75131D293
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Feb 2021 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBPWZq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Feb 2021 17:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhBPWZp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:25:45 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B145C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Feb 2021 14:25:05 -0800 (PST)
Received: from localhost ([::1]:53292 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lC8mE-0004Sx-K7; Tue, 16 Feb 2021 23:25:02 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] include: Drop libipulog.h
Date:   Tue, 16 Feb 2021 23:24:53 +0100
Message-Id: <20210216222453.2519-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The file is not included anywhere, also it seems outdated compared to
the one in libnetfilter_log (which also holds the implementation).

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/libipulog/libipulog.h | 39 -----------------------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 include/libipulog/libipulog.h

diff --git a/include/libipulog/libipulog.h b/include/libipulog/libipulog.h
deleted file mode 100644
index 3f4cc2c7a3119..0000000000000
--- a/include/libipulog/libipulog.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#ifndef _LIBIPULOG_H
-#define _LIBIPULOG_H
-
-/* libipulog.h,v 1.3 2001/05/21 19:15:16 laforge Exp */
-
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/uio.h>
-#include <asm/types.h>
-#include <linux/netlink.h>
-#include <net/if.h>
-#include <linux/netfilter_ipv4/ipt_ULOG.h>
-
-/* FIXME: glibc sucks */
-#ifndef MSG_TRUNC 
-#define MSG_TRUNC	0x20
-#endif
-
-struct ipulog_handle;
-
-u_int32_t ipulog_group2gmask(u_int32_t group);
-
-struct ipulog_handle *ipulog_create_handle(u_int32_t gmask);
-
-void ipulog_destroy_handle(struct ipulog_handle *h);
-
-ssize_t ipulog_read(struct ipulog_handle *h,
-		    unsigned char *buf, size_t len, int timeout);
-
-ulog_packet_msg_t *ipulog_get_packet(struct ipulog_handle *h,
-				     const unsigned char *buf,
-				     size_t len);
-
-void ipulog_perror(const char *s);
-
-#endif /* _LIBULOG_H */
-- 
2.28.0

