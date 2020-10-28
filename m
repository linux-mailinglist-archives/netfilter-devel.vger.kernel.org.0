Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4F29D28D
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Oct 2020 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJ1VdT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Oct 2020 17:33:19 -0400
Received: from correo.us.es ([193.147.175.20]:45720 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgJ1VdO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 188F31761A1
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Oct 2020 15:23:56 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 08CEDDA722
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Oct 2020 15:23:56 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F2726DA704; Wed, 28 Oct 2020 15:23:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BDDBBDA722
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Oct 2020 15:23:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 28 Oct 2020 15:23:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id A9D3F42EFB80
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Oct 2020 15:23:53 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack] conntrack: allow to filter event by family
Date:   Wed, 28 Oct 2020 15:23:50 +0100
Message-Id: <20201028142350.3423-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch allows you to filter event through -f, e.g.

 conntrack -E -f ipv4

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/conntrack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index db35b070dadb..66f513b84a2c 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -393,7 +393,7 @@ static char commands_v_options[NUMBER_OF_CMD][NUMBER_OF_OPT] =
 /*CT_DELETE*/ {2,2,2,2,2,2,2,0,0,0,0,2,2,0,2,2,2,2,2,2,0,0,0,2,2,0,0,2,2},
 /*CT_GET*/    {3,3,3,3,1,0,0,0,0,0,0,0,0,0,0,2,0,0,0,2,0,0,0,0,2,0,0,0,0},
 /*CT_FLUSH*/  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
-/*CT_EVENT*/  {2,2,2,2,2,0,0,0,2,0,0,2,2,0,2,0,0,2,2,2,2,2,2,2,2,0,0,2,2},
+/*CT_EVENT*/  {2,2,2,2,2,0,0,0,2,0,0,2,2,0,2,0,2,2,2,2,2,2,2,2,2,0,0,2,2},
 /*VERSION*/   {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
 /*HELP*/      {0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
 /*EXP_LIST*/  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,2,0,0,0,0,0,0,0,0,0},
@@ -1425,6 +1425,7 @@ exp_event_sighandler(int s)
 
 static int event_cb(const struct nlmsghdr *nlh, void *data)
 {
+	struct nfgenmsg *nfh = mnl_nlmsg_get_payload(nlh);
 	unsigned int op_type = NFCT_O_DEFAULT;
 	struct nf_conntrack *obj = data;
 	enum nf_conntrack_msg_type type;
@@ -1456,7 +1457,9 @@ static int event_cb(const struct nlmsghdr *nlh, void *data)
 	if (nfct_nlmsg_parse(nlh, ct) < 0)
 		goto out;
 
-	if (nfct_filter(obj, ct))
+	if ((filter_family != AF_UNSPEC &&
+	     filter_family != nfh->nfgen_family) ||
+	    nfct_filter(obj, ct))
 		goto out;
 
 	if (output_mask & _O_XML) {
-- 
2.20.1

