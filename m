Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79F9178E2F
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2020 11:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgCDKON (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Mar 2020 05:14:13 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:57560 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387969AbgCDKON (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:14:13 -0500
Received: from localhost ([::1]:42418 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1j9R2a-0008K3-6o; Wed, 04 Mar 2020 11:14:12 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2] connlabel: Allow numeric labels even if connlabel.conf exists
Date:   Wed,  4 Mar 2020 11:14:03 +0100
Message-Id: <20200304101403.4849-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Existing code is a bit quirky: If no connlabel.conf was found, the local
function connlabel_value_parse() is called which tries to interpret
given label as a number. If the config exists though,
nfct_labelmap_get_bit() is called instead which doesn't care about
"undefined" connlabel names. So unless installed connlabel.conf contains
entries for all possible numeric labels, rules added by users may stop
working if a connlabel.conf is created.

Related man page snippet states: "Using a number always overrides
connlabel.conf", so try numeric parsing and fall back to nfct only if
that failed.

Fixes: 51340f7b6a110 ("extensions: libxt_connlabel: use libnetfilter_conntrack")
Fixes: 3a3bb480a738a ("extensions: connlabel: Fallback on missing connlabel.conf")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Prefer numeric parsing over labelmap.
---
 extensions/libxt_connlabel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/extensions/libxt_connlabel.c b/extensions/libxt_connlabel.c
index 5a01fe7237bd8..565b8c796b017 100644
--- a/extensions/libxt_connlabel.c
+++ b/extensions/libxt_connlabel.c
@@ -70,18 +70,15 @@ static int connlabel_value_parse(const char *in)
 static void connlabel_mt_parse(struct xt_option_call *cb)
 {
 	struct xt_connlabel_mtinfo *info = cb->data;
-	bool have_labelmap = !connlabel_open();
 	int tmp;
 
 	xtables_option_parse(cb);
 
 	switch (cb->entry->id) {
 	case O_LABEL:
-		if (have_labelmap)
+		tmp = connlabel_value_parse(cb->arg);
+		if (tmp < 0 && !connlabel_open())
 			tmp = nfct_labelmap_get_bit(map, cb->arg);
-		else
-			tmp = connlabel_value_parse(cb->arg);
-
 		if (tmp < 0)
 			xtables_error(PARAMETER_PROBLEM,
 				      "label '%s' not found or invalid value",
-- 
2.25.1

