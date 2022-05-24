Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FD532AAE
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 May 2022 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiEXMuP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 May 2022 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiEXMuO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 May 2022 08:50:14 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A6F205F6
        for <netfilter-devel@vger.kernel.org>; Tue, 24 May 2022 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QWhO5PTXTN68i+PhXPpfTPqZWS3vs9N/hYfItmPb6Ds=; b=EeA+7isb8xV5z6BxZLMab9on10
        os1j6PMnqmt7FJTjqV/Dttg81HtFVOWKsozRE2HfgK9SE/FHGk6leAy6dxQVbGifRQV+guk6p0u+G
        5zwPwFVMZKBb1AtJ745JDK/qg+UvH8TAMWLWa5/wBc/EgJ2q5CCHWgqWq0yJoALkuPQowoe9tuskR
        3yVEBqeS25mY/EqzUe34DRlJHdi10BsFo3itjl6laumQYsqYp1LdWJjzy8iAPol2+LxTR11GE262N
        SAJaVhXWtV2A4JykscqD1JkT9O455OzupI5lhOoXTA9Bejyzg6W95hDTG5zft9yL1xwVS9KvWHnNl
        IhQivbMw==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1ntTzG-0007Zb-FL; Tue, 24 May 2022 14:50:10 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nf PATCH] netfilter: nft_limit: Clone packet limits' cost value
Date:   Tue, 24 May 2022 14:50:01 +0200
Message-Id: <20220524125001.25881-1-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When cloning a packet-based limit expression, copy the cost value as
well. Otherwise the new limit is not functional anymore.

Fixes: 3b9e2ea6c11bf ("netfilter: nft_limit: move stateful fields out of expression data")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nft_limit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index 04ea8b9bf2028..981addb2d0515 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -213,6 +213,8 @@ static int nft_limit_pkts_clone(struct nft_expr *dst, const struct nft_expr *src
 	struct nft_limit_priv_pkts *priv_dst = nft_expr_priv(dst);
 	struct nft_limit_priv_pkts *priv_src = nft_expr_priv(src);
 
+	priv_dst->cost = priv_src->cost;
+
 	return nft_limit_clone(&priv_dst->limit, &priv_src->limit);
 }
 
-- 
2.34.1

