Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245D915466D
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Feb 2020 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBFOq1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Feb 2020 09:46:27 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:49184 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBFOq0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:46:26 -0500
Received: from localhost ([::1]:34042 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iziQD-00085m-L6; Thu, 06 Feb 2020 15:46:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] xtables-translate: Fix for interface name corner-cases
Date:   Thu,  6 Feb 2020 15:46:25 +0100
Message-Id: <20200206144625.27616-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There are two special situations xlate_ifname() didn't cover for:

* Interface name being '*': This went unchanged, creating a command nft
  wouldn't accept. Instead translate into '\*' which doesn't change
  semantics.

* Interface name being '+': Can't translate into nft wildcard character
  as nft doesn't accept asterisk-only interface names. Instead decide
  what to do based on 'invert' value: Skip match creation if false,
  match against an invalid interface name if true.

Also add a test to make sure future changes to this behaviour are
noticed.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/generic.txlate    | 12 ++++++++++++
 iptables/xtables-translate.c | 27 +++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/extensions/generic.txlate b/extensions/generic.txlate
index b38fbd1fe113b..aabe13b169718 100644
--- a/extensions/generic.txlate
+++ b/extensions/generic.txlate
@@ -18,3 +18,15 @@ nft add rule bridge filter FORWARD iifname != "iname" meta ibrname "ilogname" oi
 
 ebtables-translate -I INPUT -p ip -d 1:2:3:4:5:6/ff:ff:ff:ff:00:00
 nft insert rule bridge filter INPUT ether type 0x800 ether daddr 01:02:03:04:00:00 and ff:ff:ff:ff:00:00 == 01:02:03:04:00:00 counter
+
+# asterisk is not special in iptables and it is even a valid interface name
+iptables-translate -A FORWARD -i '*'
+nft add rule ip filter FORWARD iifname "\*" counter
+
+# skip for always matching interface names
+iptables-translate -A FORWARD -i '+'
+nft add rule ip filter FORWARD counter
+
+# match against invalid interface name to simulate never matching rule
+iptables-translate -A FORWARD ! -i '+'
+nft add rule ip filter FORWARD iifname "INVAL/D" counter
diff --git a/iptables/xtables-translate.c b/iptables/xtables-translate.c
index 77a186b905d73..d2a62f4d53ee8 100644
--- a/iptables/xtables-translate.c
+++ b/iptables/xtables-translate.c
@@ -33,15 +33,34 @@ void xlate_ifname(struct xt_xlate *xl, const char *nftmeta, const char *ifname,
 		  bool invert)
 {
 	int ifaclen = strlen(ifname);
-	char iface[IFNAMSIZ];
+	char iface[IFNAMSIZ + 1];
 
 	if (ifaclen < 1 || ifaclen >= IFNAMSIZ)
 		return;
 
 	strcpy(iface, ifname);
-	if (iface[ifaclen - 1] == '+')
-		iface[ifaclen - 1] = '*';
-
+	switch (iface[ifaclen - 1]) {
+	case '+':
+		if (ifaclen > 1) {
+			iface[ifaclen - 1] = '*';
+			break;
+		}
+		/* Nftables does not support wildcard only string. Workaround
+		 * is easy, given that this will match always or never
+		 * depending on 'invert' value. To match always, simply don't
+		 * generate an expression. To match never, use an invalid
+		 * interface name (kernel doesn't accept '/' in names) to match
+		 * against. */
+		if (!invert)
+			return;
+		strcpy(iface, "INVAL/D");
+		invert = false;
+		break;
+	case '*':
+		iface[ifaclen - 1] = '\\';
+		strcat(iface, "*");
+		break;
+	}
 	xt_xlate_add(xl, "%s %s\"%s\" ", nftmeta, invert ? "!= " : "", iface);
 }
 
-- 
2.24.1

