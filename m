Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECF6F008
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGTQbN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 12:31:13 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40916 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfGTQbN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:31:13 -0400
Received: from localhost ([::1]:54006 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hosGN-0005Tz-VQ; Sat, 20 Jul 2019 18:31:12 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 01/12] ebtables: Fix error message for invalid parameters
Date:   Sat, 20 Jul 2019 18:30:15 +0200
Message-Id: <20190720163026.15410-2-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720163026.15410-1-phil@nwl.cc>
References: <20190720163026.15410-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With empty ruleset, ebtables-nft would report the wrong argv:

| % sudo ./install/sbin/ebtables-nft -vnL
| ebtables v1.8.3 (nf_tables): Unknown argument: './install/sbin/ebtables-nft'
| Try `ebtables -h' or 'ebtables --help' for more information.

After a (successful) call to 'ebtables-nft -L', this would even
segfault:

| % sudo ./install/sbin/ebtables-nft -vnL
| zsh: segmentation fault  sudo ./install/sbin/ebtables-nft -vnL

Fixes: acde6be32036f ("ebtables-translate: Fix segfault while parsing extension options")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-eb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index 171f41b0f616e..b8d89ad974a42 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -1180,7 +1180,7 @@ print_zero:
 			if (ebt_command_default(&cs))
 				xtables_error(PARAMETER_PROBLEM,
 					      "Unknown argument: '%s'",
-					      argv[optind - 1]);
+					      argv[optind]);
 
 			if (command != 'A' && command != 'I' &&
 			    command != 'D' && command != 'C')
-- 
2.22.0

