Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1461AADB5
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2020 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415520AbgDOQSf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Apr 2020 12:18:35 -0400
Received: from correo.us.es ([193.147.175.20]:57620 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415531AbgDOQSa (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:18:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C3D9611EB26
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2020 18:18:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AD2ABFF6F5
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2020 18:18:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9DB80FF6F2; Wed, 15 Apr 2020 18:18:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 414654E0C7;
        Wed, 15 Apr 2020 18:18:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 Apr 2020 18:18:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 18F3C42EF42A;
        Wed, 15 Apr 2020 18:18:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     champetier.etienne@gmail.com
Subject: [PATCH iptables] extensions: libxt_CT: add translation for NOTRACK
Date:   Wed, 15 Apr 2020 18:18:21 +0200
Message-Id: <20200415161821.119253-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1422
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 extensions/libxt_CT.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/extensions/libxt_CT.c b/extensions/libxt_CT.c
index 371b21766c56..64dae325996a 100644
--- a/extensions/libxt_CT.c
+++ b/extensions/libxt_CT.c
@@ -348,6 +348,20 @@ static void notrack_ct2_tg_init(struct xt_entry_target *target)
 	info->flags = XT_CT_NOTRACK | XT_CT_NOTRACK_ALIAS;
 }
 
+static int xlate_ct(struct xt_xlate *xl,
+		    const struct xt_xlate_tg_params *params)
+{
+	struct xt_ct_target_info_v1 *info =
+		(struct xt_ct_target_info_v1 *)params->target->data;
+
+	if (info->flags & XT_CT_NOTRACK)
+		xt_xlate_add(xl, "notrack");
+	else
+		return 0;
+
+	return 1;
+}
+
 static struct xtables_target ct_target_reg[] = {
 	{
 		.family		= NFPROTO_UNSPEC,
@@ -387,6 +401,7 @@ static struct xtables_target ct_target_reg[] = {
 		.alias		= ct_print_name_alias,
 		.x6_parse	= ct_parse_v1,
 		.x6_options	= ct_opts_v1,
+		.xlate		= xlate_ct,
 	},
 	{
 		.family        = NFPROTO_UNSPEC,
-- 
2.11.0

