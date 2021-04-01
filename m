Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81A6351DBB
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Apr 2021 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhDASbs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 14:31:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:40410 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234984AbhDASVn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=ZICGHgbe0yvapa1EaB1+YEHGNpN5YILQgHqtq1MlvN0=; b=MSENqHvk5+UI
        4yPS740rtaxxhKb9THYbiJue0uQwvQRAOADHsFlsba5i5IfHVIi+hWKXa68KTO1Yh32TXJ/jCRQmf
        bE0Y8fffxcK5sPqyn0DgiQfHhQkmXhb3Jsu3dketa1rhtJ/U2wX2dwaq7Zvgf/nlD9Sc2rujc6vwT
        wTjRY=;
Received: from [10.94.6.52] (helo=dhcp-172-16-24-175.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1lRwnc-000EBL-JO; Thu, 01 Apr 2021 15:51:48 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org, fw@strlen.de
Subject: [iptables PATCH v5 PATCH 2/2] extensions: libxt_conntrack: print xlate status as set
Date:   Thu,  1 Apr 2021 15:51:44 +0300
Message-Id: <20210401125144.30306-2-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210401125144.30306-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20210401125144.30306-1-alexander.mikhalitsyn@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

At the moment, status_xlate_print function prints statusmask as comma-separated
sequence of enabled statusmask flags. But if we have inverted conntrack ctstatus
condition then we have to use more complex expression (if more than one flag enabled)
because nft not supports syntax like "ct status != expected,assured".

Examples:
! --ctstatus CONFIRMED,ASSURED
should be translated as
ct status & (assured|confirmed) == 0

! --ctstatus CONFIRMED
can be translated as
ct status & confirmed == 0

See also netfilter/xt_conntrack.c (conntrack_mt() function as a reference).

Reproducer:
$ iptables -A INPUT -d 127.0.0.1/32 -p tcp -m conntrack ! --ctstatus expected,assured -j DROP
$ nft list ruleset
...
meta l4proto tcp ip daddr 127.0.0.1 ct status != expected,assured counter packets 0 bytes 0 drop
...

it will fail if we try to load this rule:
$ nft -f nft_test
../nft_test:6:97-97: Error: syntax error, unexpected comma, expecting newline or semicolon

Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
---
 extensions/libxt_conntrack.c      | 30 +++++++++++++++++++++---------
 extensions/libxt_conntrack.txlate |  8 +++++++-
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/extensions/libxt_conntrack.c b/extensions/libxt_conntrack.c
index 91f9e4a..7f7b45e 100644
--- a/extensions/libxt_conntrack.c
+++ b/extensions/libxt_conntrack.c
@@ -1200,26 +1200,39 @@ static int state_xlate(struct xt_xlate *xl,
 	return 1;
 }
 
-static void status_xlate_print(struct xt_xlate *xl, unsigned int statusmask)
+static void status_xlate_print(struct xt_xlate *xl, unsigned int statusmask, int inverted)
 {
 	const char *sep = "";
+	int one_flag_set;
+
+	one_flag_set = !(statusmask & (statusmask - 1));
+
+	if (inverted && !one_flag_set)
+		xt_xlate_add(xl, "& (");
+	else if (inverted)
+		xt_xlate_add(xl, "& ");
 
 	if (statusmask & IPS_EXPECTED) {
 		xt_xlate_add(xl, "%s%s", sep, "expected");
-		sep = ",";
+		sep = inverted && !one_flag_set ? "|" : ",";
 	}
 	if (statusmask & IPS_SEEN_REPLY) {
 		xt_xlate_add(xl, "%s%s", sep, "seen-reply");
-		sep = ",";
+		sep = inverted && !one_flag_set ? "|" : ",";
 	}
 	if (statusmask & IPS_ASSURED) {
 		xt_xlate_add(xl, "%s%s", sep, "assured");
-		sep = ",";
+		sep = inverted && !one_flag_set ? "|" : ",";
 	}
 	if (statusmask & IPS_CONFIRMED) {
 		xt_xlate_add(xl, "%s%s", sep, "confirmed");
-		sep = ",";
+		sep = inverted && !one_flag_set ? "|" : ",";
 	}
+
+	if (inverted && !one_flag_set)
+		xt_xlate_add(xl, ") == 0");
+	else if (inverted)
+		xt_xlate_add(xl, " == 0");
 }
 
 static void addr_xlate_print(struct xt_xlate *xl,
@@ -1277,10 +1290,9 @@ static int _conntrack3_mt_xlate(struct xt_xlate *xl,
 	}
 
 	if (sinfo->match_flags & XT_CONNTRACK_STATUS) {
-		xt_xlate_add(xl, "%sct status %s", space,
-			     sinfo->invert_flags & XT_CONNTRACK_STATUS ?
-			     "!= " : "");
-		status_xlate_print(xl, sinfo->status_mask);
+		xt_xlate_add(xl, "%sct status ", space);
+		status_xlate_print(xl, sinfo->status_mask,
+				   sinfo->invert_flags & XT_CONNTRACK_STATUS);
 		space = " ";
 	}
 
diff --git a/extensions/libxt_conntrack.txlate b/extensions/libxt_conntrack.txlate
index 5ab85b1..8cc7c50 100644
--- a/extensions/libxt_conntrack.txlate
+++ b/extensions/libxt_conntrack.txlate
@@ -35,7 +35,13 @@ iptables-translate -t filter -A INPUT -m conntrack --ctstatus EXPECTED -j ACCEPT
 nft add rule ip filter INPUT ct status expected counter accept
 
 iptables-translate -t filter -A INPUT -m conntrack ! --ctstatus CONFIRMED -j ACCEPT
-nft add rule ip filter INPUT ct status != confirmed counter accept
+nft add rule ip filter INPUT ct status & confirmed == 0 counter accept
+
+iptables-translate -t filter -A INPUT -m conntrack ! --ctstatus CONFIRMED,ASSURED -j ACCEPT
+nft add rule ip filter INPUT ct status & (assured|confirmed) == 0 counter accept
+
+iptables-translate -t filter -A INPUT -m conntrack --ctstatus CONFIRMED,ASSURED -j ACCEPT
+nft add rule ip filter INPUT ct status assured,confirmed counter accept
 
 iptables-translate -t filter -A INPUT -m conntrack --ctexpire 3 -j ACCEPT
 nft add rule ip filter INPUT ct expiration 3 counter accept
-- 
1.8.3.1

