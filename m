Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD886D5365
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Apr 2023 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjDCVWL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Apr 2023 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCVWK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:22:10 -0400
X-Greylist: delayed 469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 14:22:07 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F93AB3
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Apr 2023 14:22:07 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Pr3YJ5vblz9swl;
        Mon,  3 Apr 2023 23:14:12 +0200 (CEST)
From:   Markus Boehme <markubo@amazon.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Markus Boehme <markubo@amazon.com>,
        Jonathan Caicedo <jonathan@jcaicedo.com>
Subject: [PATCH iptables] ip6tables: Fix checking existence of rule
Date:   Mon,  3 Apr 2023 23:13:47 +0200
Message-Id: <20230403211347.501448-1-markubo@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yam3nzkw3seka1pzktu3u35aqxuz6mgc
X-MBO-RS-ID: 3c481a4c85c224ede96
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_ADSP_ALL,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pass the proper entry size when creating a match mask for checking the
existence of a rule. Failing to do so causes wrong results.

Reported-by: Jonathan Caicedo <jonathan@jcaicedo.com>
Fixes: eb2546a846776 ("xshared: Share make_delete_mask() between ip{,6}tables")
Signed-off-by: Markus Boehme <markubo@amazon.com>
---
 iptables/ip6tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/ip6tables.c b/iptables/ip6tables.c
index 345af451..9afc32c1 100644
--- a/iptables/ip6tables.c
+++ b/iptables/ip6tables.c
@@ -331,7 +331,7 @@ check_entry(const xt_chainlabel chain, struct ip6t_entry *fw,
 	int ret = 1;
 	unsigned char *mask;
 
-	mask = make_delete_mask(matches, target, sizeof(fw));
+	mask = make_delete_mask(matches, target, sizeof(*fw));
 	for (i = 0; i < nsaddrs; i++) {
 		fw->ipv6.src = saddrs[i];
 		fw->ipv6.smsk = smasks[i];
-- 
2.25.1

