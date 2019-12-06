Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C25115001
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 12:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfLFLr1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 06:47:27 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34894 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfLFLr1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:47:27 -0500
Received: from localhost ([::1]:47984 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1idC4z-0002kY-Ra; Fri, 06 Dec 2019 12:47:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 6/6] extensions: among: Check call to fstat()
Date:   Fri,  6 Dec 2019 12:47:11 +0100
Message-Id: <20191206114711.6015-7-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206114711.6015-1-phil@nwl.cc>
References: <20191206114711.6015-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If this fails, a bogus length value may be passed to mmap().

Fixes: 26753888720d8 ("nft: bridge: Rudimental among extension support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libebt_among.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/extensions/libebt_among.c b/extensions/libebt_among.c
index 2e87db3bc06fa..715d559f432c2 100644
--- a/extensions/libebt_among.c
+++ b/extensions/libebt_among.c
@@ -6,6 +6,7 @@
  * August, 2003
  */
 
+#include <errno.h>
 #include <ctype.h>
 #include <fcntl.h>
 #include <getopt.h>
@@ -137,7 +138,10 @@ static int bramong_parse(int c, char **argv, int invert,
 		if ((fd = open(optarg, O_RDONLY)) == -1)
 			xtables_error(PARAMETER_PROBLEM,
 				      "Couldn't open file '%s'", optarg);
-		fstat(fd, &stats);
+		if (fstat(fd, &stats) < 0)
+			xtables_error(PARAMETER_PROBLEM,
+				      "fstat(%s) failed: '%s'",
+				      optarg, strerror(errno));
 		flen = stats.st_size;
 		/* use mmap because the file will probably be big */
 		optarg = mmap(0, flen, PROT_READ | PROT_WRITE,
-- 
2.24.0

