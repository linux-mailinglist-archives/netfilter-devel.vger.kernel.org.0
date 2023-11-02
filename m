Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6F7DF027
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 11:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbjKBK2v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbjKBK2u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:28:50 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94053128;
        Thu,  2 Nov 2023 03:28:48 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qyUwQ-0006r4-7q; Thu, 02 Nov 2023 11:28:46 +0100
Date:   Thu, 2 Nov 2023 11:28:46 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH v2] netfilter: nf_tables: prevent OOB access in
 nft_byteorder_eval
Message-ID: <20231102102846.GE6174@breakpoint.cc>
References: <20230705201232.GG3751@breakpoint.cc>
 <20230705210535.943194-1-cascardo@canonical.com>
 <d7e42ffd-aabf-46d7-b02a-a7337708a29a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e42ffd-aabf-46d7-b02a-a7337708a29a@moroto.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> wrote:
> This patch is correct, but shouldn't we fix the code for 64 bit writes
> as well?

Care to send a patch?

> net/netfilter/nft_byteorder.c
>     26  void nft_byteorder_eval(const struct nft_expr *expr,
>     27                          struct nft_regs *regs,
>     28                          const struct nft_pktinfo *pkt)
>     29  {
>     30          const struct nft_byteorder *priv = nft_expr_priv(expr);
>     31          u32 *src = &regs->data[priv->sreg];
>     32          u32 *dst = &regs->data[priv->dreg];
>     33          u16 *s16, *d16;
>     34          unsigned int i;
>     35  
>     36          s16 = (void *)src;
>     37          d16 = (void *)dst;
>     38  
>     39          switch (priv->size) {
>     40          case 8: {
>     41                  u64 src64;
>     42  
>     43                  switch (priv->op) {
>     44                  case NFT_BYTEORDER_NTOH:
>     45                          for (i = 0; i < priv->len / 8; i++) {
>     46                                  src64 = nft_reg_load64(&src[i]);
>     47                                  nft_reg_store64(&dst[i],
>     48                                                  be64_to_cpu((__force __be64)src64));
> 
> We're writing 8 bytes, then moving forward 4 bytes and writing 8 bytes
> again.  Each subsequent write over-writes 4 bytes from the previous
> write.

Yes.  I can't think if a case where we'd do two swaps back-to-back,
which is probably the reason noone noticed this so far.
