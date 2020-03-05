Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6067717A80C
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2020 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCEOsH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Mar 2020 09:48:07 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55994 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCEOsH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2JBao9qd4UAoLpzvEIpPux6GxNtA6sc6roRH4vbmBPk=; b=lf1zVBX/GsWdR8NHSkT3hl14eC
        EPuJKXlFijqYaNYzyXUYScJVLAxfcc8cKe1v7nPmBSGr69KP3JEuNDCdyA8aA6JzV2DwAj2TaEQoc
        PSvcuO2vvywvfY7vVcNqBnlQOeNkh1P5F/CKZAQNdtnnMZMp3tNqoiFE7xniGreWIBu7VrS86fS3R
        aaoUYul78eEqvwclZ9ALov37KD8eZzojkHsIm9z1mudHVhM+lg6Jg4C26//QZdKB60zxRef8tioVD
        Sg4VnUKERCKCOunfpGK+dgRCpoc33nMIJVkFR4udRH+LL8mRLDZxkXKRMFbKwhBwS87eQ6fczHGeb
        mgIFr7kQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j9rnB-0006kU-EW; Thu, 05 Mar 2020 14:48:05 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 1/4] main: include '-d' in help.
Date:   Thu,  5 Mar 2020 14:48:02 +0000
Message-Id: <20200305144805.143783-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200305144805.143783-1-jeremy@azazel.net>
References: <20200305144805.143783-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The short option for '--debug' was omitted from the help.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/main.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/src/main.c b/src/main.c
index 81f30951c90f..3e37d600e38b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -140,28 +140,28 @@ static void show_help(const char *name)
 "Usage: %s [ options ] [ cmds... ]\n"
 "\n"
 "Options:\n"
-"  -h, --help			Show this help\n"
-"  -v, --version			Show version information\n"
-"  -V				Show extended version information\n"
+"  -h, --help				Show this help\n"
+"  -v, --version				Show version information\n"
+"  -V					Show extended version information\n"
 "\n"
-"  -c, --check			Check commands validity without actually applying the changes.\n"
-"  -f, --file <filename>		Read input from <filename>\n"
-"  -i, --interactive		Read input from interactive CLI\n"
+"  -c, --check				Check commands validity without actually applying the changes.\n"
+"  -f, --file <filename>			Read input from <filename>\n"
+"  -i, --interactive			Read input from interactive CLI\n"
 "\n"
-"  -j, --json			Format output in JSON\n"
-"  -n, --numeric			Print fully numerical output.\n"
-"  -s, --stateless		Omit stateful information of ruleset.\n"
-"  -t, --terse			Omit contents of sets.\n"
-"  -u, --guid			Print UID/GID as defined in /etc/passwd and /etc/group.\n"
-"  -N				Translate IP addresses to names.\n"
-"  -S, --service			Translate ports to service names as described in /etc/services.\n"
-"  -p, --numeric-protocol	Print layer 4 protocols numerically.\n"
-"  -y, --numeric-priority	Print chain priority numerically.\n"
-"  -T, --numeric-time		Print time values numerically.\n"
-"  -a, --handle			Output rule handle.\n"
-"  -e, --echo			Echo what has been added, inserted or replaced.\n"
-"  -I, --includepath <directory>	Add <directory> to the paths searched for include files. Default is: %s\n"
-"  --debug <level [,level...]>	Specify debugging level (scanner, parser, eval, netlink, mnl, proto-ctx, segtree, all)\n"
+"  -j, --json				Format output in JSON\n"
+"  -n, --numeric				Print fully numerical output.\n"
+"  -s, --stateless			Omit stateful information of ruleset.\n"
+"  -t, --terse				Omit contents of sets.\n"
+"  -u, --guid				Print UID/GID as defined in /etc/passwd and /etc/group.\n"
+"  -N					Translate IP addresses to names.\n"
+"  -S, --service				Translate ports to service names as described in /etc/services.\n"
+"  -p, --numeric-protocol		Print layer 4 protocols numerically.\n"
+"  -y, --numeric-priority		Print chain priority numerically.\n"
+"  -T, --numeric-time			Print time values numerically.\n"
+"  -a, --handle				Output rule handle.\n"
+"  -e, --echo				Echo what has been added, inserted or replaced.\n"
+"  -I, --includepath <directory>		Add <directory> to the paths searched for include files. Default is: %s\n"
+"  -d, --debug <level [,level...]>	Specify debugging level (scanner, parser, eval, netlink, mnl, proto-ctx, segtree, all)\n"
 "\n",
 	name, DEFAULT_INCLUDE_PATH);
 }
-- 
2.25.1

