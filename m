Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AAF4B0920
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Feb 2022 10:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiBJJGp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Feb 2022 04:06:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBJJGp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:06:45 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CAD71091
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Feb 2022 01:06:46 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5591A601BA;
        Thu, 10 Feb 2022 10:06:32 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ffmancera@riseup.net
Subject: [PATCH nf] netfilter: nft_synproxy: unregister hooks on init error path
Date:   Thu, 10 Feb 2022 10:06:42 +0100
Message-Id: <20220210090642.174185-1-pablo@netfilter.org>
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

Disable the IPv4 hooks if the IPv6 hooks fail to be registered.

Fixes: ad49d86e07a4 ("netfilter: nf_tables: Add synproxy support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_synproxy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index a0109fa1e92d..1133e06f3c40 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -191,8 +191,10 @@ static int nft_synproxy_do_init(const struct nft_ctx *ctx,
 		if (err)
 			goto nf_ct_failure;
 		err = nf_synproxy_ipv6_init(snet, ctx->net);
-		if (err)
+		if (err) {
+			nf_synproxy_ipv4_fini(snet, ctx->net);
 			goto nf_ct_failure;
+		}
 		break;
 	}
 
-- 
2.30.2

