Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D641CD645
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2020 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKKR5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 May 2020 06:17:57 -0400
Received: from correo.us.es ([193.147.175.20]:52474 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgEKKR4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 May 2020 06:17:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BAC4C4FFE1A
        for <netfilter-devel@vger.kernel.org>; Mon, 11 May 2020 12:17:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ABD92DA736
        for <netfilter-devel@vger.kernel.org>; Mon, 11 May 2020 12:17:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A14E21158F7; Mon, 11 May 2020 12:17:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 974E91158E8;
        Mon, 11 May 2020 12:17:52 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 11 May 2020 12:17:52 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 6A64042EF42A;
        Mon, 11 May 2020 12:17:52 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ozsh@mellanox.com, roid@mellanox.com, saeedm@mellanox.com
Subject: [PATCH nf] netfilter: flowtable: set NF_FLOW_TEARDOWN flag on entry expiration
Date:   Mon, 11 May 2020 12:17:42 +0200
Message-Id: <20200511101742.20748-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the flow timer expires, the gc sets on the NF_FLOW_TEARDOWN flag.
Otherwise, the flowtable software path might race to refresh the
timeout, leaving the state machine in inconsistent state.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Reported-by: Paul Blakey <paulb@mellanox.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 4344e572b7f9..42da6e337276 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -284,7 +284,7 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
 
 	if (nf_flow_has_expired(flow))
 		flow_offload_fixup_ct(flow->ct);
-	else if (test_bit(NF_FLOW_TEARDOWN, &flow->flags))
+	else
 		flow_offload_fixup_ct_timeout(flow->ct);
 
 	flow_offload_free(flow);
@@ -361,8 +361,10 @@ static void nf_flow_offload_gc_step(struct flow_offload *flow, void *data)
 {
 	struct nf_flowtable *flow_table = data;
 
-	if (nf_flow_has_expired(flow) || nf_ct_is_dying(flow->ct) ||
-	    test_bit(NF_FLOW_TEARDOWN, &flow->flags)) {
+	if (nf_flow_has_expired(flow) || nf_ct_is_dying(flow->ct))
+		set_bit(NF_FLOW_TEARDOWN, &flow->flags);
+
+	if (test_bit(NF_FLOW_TEARDOWN, &flow->flags)) {
 		if (test_bit(NF_FLOW_HW, &flow->flags)) {
 			if (!test_bit(NF_FLOW_HW_DYING, &flow->flags))
 				nf_flow_offload_del(flow_table, flow);
-- 
2.20.1

