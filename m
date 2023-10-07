Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8ED7BC6C5
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Oct 2023 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbjJGK3f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Oct 2023 06:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJGK3e (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:29:34 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 03:29:32 PDT
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B492
        for <netfilter-devel@vger.kernel.org>; Sat,  7 Oct 2023 03:29:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696674243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rPXmlx1ESs+dS6YD/9BfFLmuB90hUrMhRVQrlDgcFxo=;
        b=rQwpQ/o3/wo43UAIV2jM2gbs6AiRkfgePBhdei1ZexKfWs5D7Pg4t9JODHoKsFfPi9zz52
        Ibd7lVPXrP8NXymUpg0BXxha1Wht/HtwirHfkbagcpHbVKiuenJw+yjLQEQAtzj6TtnXKm
        2G9cQ+AOKikkHu2GpX6dcmI27D03NBY=
From:   George Guo <dongtai.guo@linux.dev>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Guo <guodongtai@kylinos.cn>
Subject: [PATCH] netfilter: remove inaccurate code comments from struct nft_table
Date:   Sat,  7 Oct 2023 18:25:28 +0800
Message-Id: <20231007102528.1544295-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: George Guo <guodongtai@kylinos.cn>

afinfo is no longer a member of struct nft_table, so remove the comment
for it.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index dd40c75011d2..acbb18c212e9 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1200,7 +1200,6 @@ static inline void nft_use_inc_restore(u32 *use)
  *	@use: number of chain references to this table
  *	@flags: table flag (see enum nft_table_flags)
  *	@genmask: generation mask
- *	@afinfo: address family info
  *	@name: name of the table
  *	@validate_state: internal, set when transaction adds jumps
  */
-- 
2.34.1

