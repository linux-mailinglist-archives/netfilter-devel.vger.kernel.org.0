Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9564F4020B7
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhIFUgB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 16:36:01 -0400
Received: from mail.netfilter.org ([217.70.188.207]:40338 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhIFUgA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 16:36:00 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 486506001B
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Sep 2021 22:33:50 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] doc: nfnetlink_log allows one single process through unicast
Date:   Mon,  6 Sep 2021 22:34:50 +0200
Message-Id: <20210906203450.30891-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nfnetlink_log uses netlink unicast to send logs to one single process in
userspace.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/statements.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/statements.txt b/doc/statements.txt
index 646311d19831..d402da7061a1 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -93,11 +93,11 @@ packets, such as header fields, via the kernel log (where it can be read with
 dmesg(1) or read in the syslog).
 
 In the second form of invocation (if 'nflog_group' is specified), the Linux
-kernel will pass the packet to nfnetlink_log which will multicast the packet
-through a netlink socket to the specified multicast group. One or more userspace
-processes may subscribe to the group to receive the packets, see man(8) ulogd
-for the Netfilter userspace log daemon and libnetfilter_log documentation for
-details in case you would like to develop a custom program to digest your logs.
+kernel will pass the packet to nfnetlink_log which will send the log through a
+netlink socket to the specified group. One userspace process may subscribe to
+the group to receive the logs, see man(8) ulogd for the Netfilter userspace log
+daemon and libnetfilter_log documentation for details in case you would like to
+develop a custom program to digest your logs.
 
 In the third form of invocation (if level audit is specified), the Linux
 kernel writes a message into the audit buffer suitably formatted for reading
-- 
2.20.1

