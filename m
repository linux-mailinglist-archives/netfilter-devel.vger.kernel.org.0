Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8061F5C435
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGAUQ4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 16:16:56 -0400
Received: from fnsib-smtp06.srv.cat ([46.16.61.61]:58831 "EHLO
        fnsib-smtp06.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfGAUQ4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:16:56 -0400
Received: from localhost.localdomain (unknown [47.62.206.189])
        by fnsib-smtp06.srv.cat (Postfix) with ESMTPSA id 3513DD9C5C
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 22:16:52 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH v4 4/4] nft: Update documentation
Date:   Mon,  1 Jul 2019 22:16:46 +0200
Message-Id: <20190701201646.7040-4-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701201646.7040-1-a@juaristi.eus>
References: <20190701201646.7040-1-a@juaristi.eus>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 doc/nft.txt                |  6 +++++-
 doc/primary-expression.txt | 27 +++++++++++++++++++++++++--
 src/main.c                 |  2 +-
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/doc/nft.txt b/doc/nft.txt
index 3f1074b..b7a8ee8 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -9,7 +9,7 @@ nft - Administration tool of the nftables framework for packet filtering and cla
 SYNOPSIS
 --------
 [verse]
-*nft* [ *-nNscaeSupyj* ] [ *-I* 'directory' ] [ *-f* 'filename' | *-i* | 'cmd' ...]
+*nft* [ *-nNscaeSupyjt* ] [ *-I* 'directory' ] [ *-f* 'filename' | *-i* | 'cmd' ...]
 *nft* *-h*
 *nft* *-v*
 
@@ -93,6 +93,10 @@ For a full summary of options, run *nft --help*.
 	Read input from an interactive readline CLI. You can use quit to exit, or use the EOF marker,
 	normally this is CTRL-D.
 
+*-t*::
+*--seconds*::
+	Show time, day and hour values in seconds.
+
 INPUT FILE FORMATS
 ------------------
 LEXICAL CONVENTIONS
diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
index 6eb9583..cef2afc 100644
--- a/doc/primary-expression.txt
+++ b/doc/primary-expression.txt
@@ -2,7 +2,7 @@ META EXPRESSIONS
 ~~~~~~~~~~~~~~~~
 [verse]
 *meta* {*length* | *nfproto* | *l4proto* | *protocol* | *priority*}
-[*meta*] {*mark* | *iif* | *iifname* | *iiftype* | *oif* | *oifname* | *oiftype* | *skuid* | *skgid* | *nftrace* | *rtclassid* | *ibrname* | *obrname* | *pkttype* | *cpu* | *iifgroup* | *oifgroup* | *cgroup* | *random* | *ipsec* | *iifkind* | *oifkind*}
+[*meta*] {*mark* | *iif* | *iifname* | *iiftype* | *oif* | *oifname* | *oiftype* | *skuid* | *skgid* | *nftrace* | *rtclassid* | *ibrname* | *obrname* | *pkttype* | *cpu* | *iifgroup* | *oifgroup* | *cgroup* | *random* | *ipsec* | *iifkind* | *oifkind* | *time* | *hour* | *day* }
 
 A meta expression refers to meta data associated with a packet.
 
@@ -115,7 +115,16 @@ boolean (1 bit)
 |iifkind|
 Input interface kind |
 |oifkind|
-Output interface kind
+Output interface kind|
+|time|
+Absolute time of packet reception|
+Integer (32 bit) or string
+|day|
+Day of week|
+Integer (8 bit) or string
+|hour|
+Hour of day|
+String
 |====================
 
 .Meta expression specific types
@@ -141,6 +150,20 @@ Packet type: *host* (addressed to local host), *broadcast* (to all),
 *multicast* (to group), *other* (addressed to another host).
 |ifkind|
 Interface kind (16 byte string). Does not have to exist.
+|time|
+Either an integer or a date in ISO format. For example: "2019-06-06 17:00".
+Hour and seconds are optional and can be omitted if desired. If omitted,
+midnight will be assumed.
+The following three would be equivalent: "2019-06-06", "2019-06-06 00:00"
+and "2019-06-06 00:00:00".
+When an integer is given, it is assumed to be a UNIX timestamp.
+|day|
+Either a day of week ("Monday", "Tuesday", etc.), or an integer between 0 and 6.
+Strings are matched case-insensitively, and a full match is not expected (e.g. "Mon" would match "Monday").
+When an integer is given, 0 is Sunday and 6 is Saturday.
+|hour|
+A string representing an hour in 24-hour format. Seconds can optionally be specified.
+For example, 17:00 and 17:00:00 would be equivalent.
 |=============================
 
 .Using meta expressions
diff --git a/src/main.c b/src/main.c
index dc8ad91..5bffa9a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -148,7 +148,7 @@ static void show_help(const char *name)
 "  -a, --handle			Output rule handle.\n"
 "  -e, --echo			Echo what has been added, inserted or replaced.\n"
 "  -I, --includepath <directory>	Add <directory> to the paths searched for include files. Default is: %s\n"
-"  -t, --seconds                Show hour values in seconds since midnight.\n"
+"  -t, --seconds                Show time, day and hour values in seconds.\n"
 "  --debug <level [,level...]>	Specify debugging level (scanner, parser, eval, netlink, mnl, proto-ctx, segtree, all)\n"
 "\n",
 	name, DEFAULT_INCLUDE_PATH);
-- 
2.17.1

