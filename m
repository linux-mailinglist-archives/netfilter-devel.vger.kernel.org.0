Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5810DE57
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Nov 2019 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfK3RCV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Nov 2019 12:02:21 -0500
Received: from kadath.azazel.net ([81.187.231.250]:52156 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3RCV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Nov 2019 12:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7f0ELXwjzHTS/0m5kCDxt1lzGsPXizWkpXYvIa9PfS8=; b=hso/WDSKAMVBBAteA+h1KQsm/d
        DooE92WqcimOTo+EZK+znSECBn2hdbahT22ebRxildaL4NPV57hiUWzfowpEzlcdrqszwQSIdmQlt
        YNGzqOOVIubHxfRB3FYPHMvgO061JDkImVAlYwXYKcTbI6EdnxEQblpIdbfHWVHmMy3un0DMxbdnm
        p/oqHIXvKKrgurS0zjPGrM1N/YWNMotpUbHhQzkPn0CgCeqDlW+znKAJ5H5CjxKn5oC3S5y8MK322
        SwT1aHBukwJJiu+qOkXB7Mb7ZiWo9VywQk5kIwccM1eAAGgvCIA+q39CfKrQklJungfD/Pmd2UqRV
        DgYU9n0w==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1ib68S-0001qd-1R; Sat, 30 Nov 2019 17:02:20 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        "Thomas B . Clark" <kernel@clark.bz>
Subject: [PATCH xtables-addons 1/3] configure: Fix max. supported kernel version.
Date:   Sat, 30 Nov 2019 17:02:16 +0000
Message-Id: <20191130170219.368867-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130170219.368867-1-jeremy@azazel.net>
References: <3971b408-51e6-d90e-f291-7a43e46e84c1@ferree-clark.org>
 <20191130170219.368867-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The maximum supported version is reported as 5.3.  Bump to 5.4.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index eccb09bf44b4..103cf07d6f9a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,7 +57,7 @@ if test -n "$kbuilddir"; then
 		echo "WARNING: Version detection did not succeed. Continue at own luck.";
 	else
 		echo "$kmajor.$kminor.$kmicro.$kstable in $kbuilddir";
-		if test "$kmajor" -gt 5 -o "$kmajor" -eq 5 -a "$kminor" -gt 3; then
+		if test "$kmajor" -gt 5 -o "$kmajor" -eq 5 -a "$kminor" -gt 4; then
 			echo "WARNING: That kernel version is not officially supported yet. Continue at own luck.";
 		elif test "$kmajor" -eq 5 -a "$kminor" -ge 0; then
 			:
-- 
2.24.0

