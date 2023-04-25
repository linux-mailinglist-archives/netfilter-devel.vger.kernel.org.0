Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94EF6EE452
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Apr 2023 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjDYOyi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Apr 2023 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjDYOyf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:54:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF4FE71
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Apr 2023 07:54:34 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] mnl: incomplete extended error reporting for singleton device in chain
Date:   Tue, 25 Apr 2023 16:54:31 +0200
Message-Id: <20230425145431.2870-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix error reporting when single device is specifies in chain:

 # nft add chain netdev filter ingress '{ devices = { x }; }'
 add chain netdev filter ingress { devices = { x }; }
                                               ^

Fixes: a66b5ad9540d ("src: allow for updating devices on existing netdev chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/mnl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mnl.c b/src/mnl.c
index 5dcfd9a04c4b..adc0bd3d61cf 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -790,6 +790,7 @@ static void mnl_nft_chain_devs_build(struct nlmsghdr *nlh, struct cmd *cmd)
 
 	dev_array = nft_dev_array(dev_expr, &num_devs);
 	if (num_devs == 1) {
+		cmd_add_loc(cmd, nlh->nlmsg_len, dev_array[0].location);
 		mnl_attr_put_strz(nlh, NFTA_HOOK_DEV, dev_array[0].ifname);
 	} else {
 		nest_dev = mnl_attr_nest_start(nlh, NFTA_HOOK_DEVS);
-- 
2.30.2

