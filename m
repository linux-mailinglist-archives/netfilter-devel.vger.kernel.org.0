Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48A7826E7
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Aug 2023 12:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjHUKSA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Aug 2023 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjHUKSA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:18:00 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D302DCF
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Aug 2023 03:17:58 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack] conntrack: unbreak -U command, use correct family
Date:   Mon, 21 Aug 2023 12:17:51 +0200
Message-Id: <20230821101751.4083-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Set the family from the conntrack object, otherwise, if -f is not specified
and the kernel bails out with:

 # conntrack -U -p tcp -m 1
 Operation failed: Not supported
 conntrack v1.4.7 (conntrack-tools): Operation failed: Not supported

Reported-by: Tony He <huangya90@gmail.com>
Fixes: b7a396b70015 ("conntrack: use libmnl for updating conntrack table")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/conntrack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index bf727391bcf6..69a8fde6b5ee 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -2184,14 +2184,16 @@ static int mnl_nfct_update_cb(const struct nlmsghdr *nlh, void *data)
 	if (nfct_cmp(tmp, ct, NFCT_CMP_ALL | NFCT_CMP_MASK))
 		goto destroy_ok;
 
-	res = nfct_mnl_request(modifier_sock, NFNL_SUBSYS_CTNETLINK, cmd->family,
+	res = nfct_mnl_request(modifier_sock, NFNL_SUBSYS_CTNETLINK,
+			       nfct_get_attr_u8(ct, ATTR_ORIG_L3PROTO),
 			       IPCTNL_MSG_CT_NEW, NLM_F_ACK, NULL, tmp, NULL);
 	if (res < 0) {
 		fprintf(stderr, "Operation failed: %s\n",
 			err2str(errno, CT_UPDATE));
 	}
 
-	res = nfct_mnl_request(modifier_sock, NFNL_SUBSYS_CTNETLINK, cmd->family,
+	res = nfct_mnl_request(modifier_sock, NFNL_SUBSYS_CTNETLINK,
+			       nfct_get_attr_u8(ct, ATTR_ORIG_L3PROTO),
 			       IPCTNL_MSG_CT_GET, NLM_F_ACK,
 			       mnl_nfct_print_cb, tmp, NULL);
 	if (res < 0) {
-- 
2.30.2

