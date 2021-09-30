Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA341DBE9
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Sep 2021 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351773AbhI3OHC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Sep 2021 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351633AbhI3OG6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:06:58 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5754C06176A
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Sep 2021 07:05:15 -0700 (PDT)
Received: from localhost ([::1]:51708 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mVwgU-0007R7-Aj; Thu, 30 Sep 2021 16:05:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 06/17] xtables-standalone: Drop version number from init errors
Date:   Thu, 30 Sep 2021 16:04:08 +0200
Message-Id: <20210930140419.6170-7-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930140419.6170-1-phil@nwl.cc>
References: <20210930140419.6170-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Aside from the rather unconventional formatting, if those initialization
functions fail we've either released a completely broken iptables or
the wrong libraries are chosen by the loader. In both cases, the version
number is not really interesting.

While being at it, fix indenting of the first exit() call.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-standalone.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/iptables/xtables-standalone.c b/iptables/xtables-standalone.c
index f4d40cda6ae43..54c70c5429766 100644
--- a/iptables/xtables-standalone.c
+++ b/iptables/xtables-standalone.c
@@ -49,10 +49,8 @@ xtables_main(int family, const char *progname, int argc, char *argv[])
 	xtables_globals.program_name = progname;
 	ret = xtables_init_all(&xtables_globals, family);
 	if (ret < 0) {
-		fprintf(stderr, "%s/%s Failed to initialize xtables\n",
-				xtables_globals.program_name,
-				xtables_globals.program_version);
-				exit(1);
+		fprintf(stderr, "%s: Failed to initialize xtables\n", progname);
+		exit(1);
 	}
 #if defined(ALL_INCLUSIVE) || defined(NO_SHARED_LIBS)
 	init_extensions();
@@ -61,10 +59,8 @@ xtables_main(int family, const char *progname, int argc, char *argv[])
 #endif
 
 	if (nft_init(&h, family) < 0) {
-		fprintf(stderr, "%s/%s Failed to initialize nft: %s\n",
-				xtables_globals.program_name,
-				xtables_globals.program_version,
-				strerror(errno));
+		fprintf(stderr, "%s: Failed to initialize nft: %s\n",
+			xtables_globals.program_name, strerror(errno));
 		exit(EXIT_FAILURE);
 	}
 
-- 
2.33.0

