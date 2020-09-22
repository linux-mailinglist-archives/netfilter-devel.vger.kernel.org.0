Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695DA274C51
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Sep 2020 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVWmU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Sep 2020 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWmT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:42:19 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82785C061755
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 15:42:19 -0700 (PDT)
Received: from localhost ([::1]:52084 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kKqzH-0007Vm-9M; Wed, 23 Sep 2020 00:42:15 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org,
        Serhey Popovych <serhe.popovych@gmail.com>
Subject: [iptables PATCH 1/3] libxtables: Make sure extensions register in revision order
Date:   Wed, 23 Sep 2020 00:53:39 +0200
Message-Id: <20200922225341.8976-2-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922225341.8976-1-phil@nwl.cc>
References: <20200922225341.8976-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Insert extensions into pending lists in ordered fashion: Group by
extension name (and, for matches, family) and order groups by descending
revision number.

This allows to simplify the later full registration considerably. Since
that involves kernel compatibility checks, the extra cycles here pay off
eventually.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 libxtables/xtables.c | 64 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/libxtables/xtables.c b/libxtables/xtables.c
index 8907ba2069be7..63d0ea5def2d5 100644
--- a/libxtables/xtables.c
+++ b/libxtables/xtables.c
@@ -948,8 +948,14 @@ static void xtables_check_options(const char *name, const struct option *opt)
 		}
 }
 
+static int xtables_match_prefer(const struct xtables_match *a,
+				const struct xtables_match *b);
+
 void xtables_register_match(struct xtables_match *me)
 {
+	struct xtables_match **pos;
+	bool seen_myself = false;
+
 	if (me->next) {
 		fprintf(stderr, "%s: match \"%s\" already registered\n",
 			xt_params->program_name, me->name);
@@ -1001,10 +1007,32 @@ void xtables_register_match(struct xtables_match *me)
 	if (me->extra_opts != NULL)
 		xtables_check_options(me->name, me->extra_opts);
 
+	/* order into linked list of matches pending full registration */
+	for (pos = &xtables_pending_matches; *pos; pos = &(*pos)->next) {
+		/* NOTE: No extension_cmp() here as we accept all families */
+		if (strcmp(me->name, (*pos)->name) ||
+		    me->family != (*pos)->family) {
+			if (seen_myself)
+				break;
+			continue;
+		}
+		seen_myself = true;
+		if (xtables_match_prefer(me, *pos) >= 0)
+			break;
+	}
+	if (!*pos)
+		pos = &xtables_pending_matches;
 
-	/* place on linked list of matches pending full registration */
-	me->next = xtables_pending_matches;
-	xtables_pending_matches = me;
+	me->next = *pos;
+	*pos = me;
+#ifdef DEBUG
+	printf("%s: inserted match %s (family %d, revision %d):\n",
+			__func__, me->name, me->family, me->revision);
+	for (pos = &xtables_pending_matches; *pos; pos = &(*pos)->next) {
+		printf("%s:\tmatch %s (family %d, revision %d)\n", __func__,
+		       (*pos)->name, (*pos)->family, (*pos)->revision);
+	}
+#endif
 }
 
 /**
@@ -1143,6 +1171,9 @@ void xtables_register_matches(struct xtables_match *match, unsigned int n)
 
 void xtables_register_target(struct xtables_target *me)
 {
+	struct xtables_target **pos;
+	bool seen_myself = false;
+
 	if (me->next) {
 		fprintf(stderr, "%s: target \"%s\" already registered\n",
 			xt_params->program_name, me->name);
@@ -1198,9 +1229,30 @@ void xtables_register_target(struct xtables_target *me)
 	if (me->family != afinfo->family && me->family != AF_UNSPEC)
 		return;
 
-	/* place on linked list of targets pending full registration */
-	me->next = xtables_pending_targets;
-	xtables_pending_targets = me;
+	/* order into linked list of targets pending full registration */
+	for (pos = &xtables_pending_targets; *pos; pos = &(*pos)->next) {
+		if (!extension_cmp(me->name, (*pos)->name, (*pos)->family)) {
+			if (seen_myself)
+				break;
+			continue;
+		}
+		seen_myself = true;
+		if (xtables_target_prefer(me, *pos) >= 0)
+			break;
+	}
+	if (!*pos)
+		pos = &xtables_pending_targets;
+
+	me->next = *pos;
+	*pos = me;
+#ifdef DEBUG
+	printf("%s: inserted target %s (family %d, revision %d):\n",
+			__func__, me->name, me->family, me->revision);
+	for (pos = &xtables_pending_targets; *pos; pos = &(*pos)->next) {
+		printf("%s:\ttarget %s (family %d, revision %d)\n", __func__,
+		       (*pos)->name, (*pos)->family, (*pos)->revision);
+	}
+#endif
 }
 
 static bool xtables_fully_register_pending_target(struct xtables_target *me)
-- 
2.28.0

