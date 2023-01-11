Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2D666586
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Jan 2023 22:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAKVXD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Jan 2023 16:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjAKVXA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:23:00 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3039633C
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Jan 2023 13:22:58 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH net 2/3] netfilter: ipset: Fix overflow before widen in the bitmap_ip_create() function.
Date:   Wed, 11 Jan 2023 22:22:50 +0100
Message-Id: <20230111212251.193032-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111212251.193032-1-pablo@netfilter.org>
References: <20230111212251.193032-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

When first_ip is 0, last_ip is 0xFFFFFFFF, and netmask is 31, the value of
an arithmetic expression 2 << (netmask - mask_bits - 1) is subject
to overflow due to a failure casting operands to a larger data type
before performing the arithmetic.

Note that it's harmless since the value will be checked at the next step.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: b9fed748185a ("netfilter: ipset: Check and reject crazy /0 input parameters")
Signed-off-by: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipset/ip_set_bitmap_ip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_bitmap_ip.c b/net/netfilter/ipset/ip_set_bitmap_ip.c
index a8ce04a4bb72..e4fa00abde6a 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ip.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ip.c
@@ -308,8 +308,8 @@ bitmap_ip_create(struct net *net, struct ip_set *set, struct nlattr *tb[],
 			return -IPSET_ERR_BITMAP_RANGE;
 
 		pr_debug("mask_bits %u, netmask %u\n", mask_bits, netmask);
-		hosts = 2 << (32 - netmask - 1);
-		elements = 2 << (netmask - mask_bits - 1);
+		hosts = 2U << (32 - netmask - 1);
+		elements = 2UL << (netmask - mask_bits - 1);
 	}
 	if (elements > IPSET_BITMAP_MAX_RANGE + 1)
 		return -IPSET_ERR_BITMAP_RANGE_SIZE;
-- 
2.30.2

