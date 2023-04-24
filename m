Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886826ED612
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Apr 2023 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjDXUXB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Apr 2023 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXUXA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:23:00 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B5315FCD
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Apr 2023 13:22:59 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] meta: skip protocol context update for nfproto with same table family
Date:   Mon, 24 Apr 2023 22:22:55 +0200
Message-Id: <20230424202255.13433-1-pablo@netfilter.org>
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

Inefficient bytecode crashes ruleset listing:

[ meta load nfproto => reg 1 ]
[ cmp eq reg 1 0x00000002 ] <-- this specifies NFPROTO_IPV4 but table family is IPv4!
[ payload load 4b @ network header + 12 => reg 1 ]
[ cmp gte reg 1 0x1000000a ]
[ cmp lte reg 1 0x1f00000a ]
[ masq ]

This IPv4 table obviously only see IPv4 traffic, but bytecode specifies
a redundant match on NFPROTO_IPV4.

After this patch, listing works:

 # nft list ruleset
 table ip crash {
        chain crash {
                type nat hook postrouting priority srcnat; policy accept;
                ip saddr 10.0.0.16-10.0.0.31 masquerade
        }
 }

Skip protocol context update in case that this information is redundant.

Fixes: https://bugzilla.netfilter.org/show_bug.cgi?id=1562
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/meta.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/meta.c b/src/meta.c
index dcf971a5dd62..3be270a4253c 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -773,6 +773,11 @@ static void meta_expr_pctx_update(struct proto_ctx *ctx,
 		break;
 	case NFT_META_NFPROTO:
 		protonum = mpz_get_uint8(right->value);
+		if (protonum == NFPROTO_IPV4 && h->desc == &proto_ip)
+			break;
+		else if (protonum == NFPROTO_IPV6 && h->desc == &proto_ip6)
+			break;
+
 		desc = proto_find_upper(h->desc, protonum);
 		if (desc == NULL) {
 			desc = &proto_unknown;
-- 
2.30.2

