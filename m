Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F09394222
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhE1LrJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 07:47:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52256 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhE1Lq6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 07:46:58 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 23279644F9
        for <netfilter-devel@vger.kernel.org>; Fri, 28 May 2021 13:44:20 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nfnetlink_cthelper: hit EBUSY on updates if size mismatches
Date:   Fri, 28 May 2021 13:45:16 +0200
Message-Id: <20210528114516.48266-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The private helper data size cannot be updated. However, updates that
contain NFCTH_PRIV_DATA_LEN might bogusly hit EBUSY even if the size is
the same.

Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_cthelper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index df58cd534ff5..5c622f55c9d6 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -380,10 +380,14 @@ static int
 nfnl_cthelper_update(const struct nlattr * const tb[],
 		     struct nf_conntrack_helper *helper)
 {
+	u32 size;
 	int ret;
 
-	if (tb[NFCTH_PRIV_DATA_LEN])
-		return -EBUSY;
+	if (tb[NFCTH_PRIV_DATA_LEN]) {
+		size = ntohl(nla_get_be32(tb[NFCTH_PRIV_DATA_LEN]));
+		if (size != helper->data_len)
+			return -EBUSY;
+	}
 
 	if (tb[NFCTH_POLICY]) {
 		ret = nfnl_cthelper_update_policy(helper, tb[NFCTH_POLICY]);
-- 
2.30.2

