Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DAF71F27B
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Jun 2023 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFAS6i (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Jun 2023 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAS6i (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:58:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3712186
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Jun 2023 11:58:36 -0700 (PDT)
Date:   Thu, 1 Jun 2023 20:58:31 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     tongxiaoge1001@126.com
Cc:     netfilter-devel@vger.kernel.org, shixuantong1@huawei.com
Subject: Re: [PATCH] fix typo
Message-ID: <ZHjqV4Nj5/ALy9fN@calendula>
References: <20230601154945.65460-1-tongxiaoge1001@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601154945.65460-1-tongxiaoge1001@126.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

May I add your Signed-off-by: tag to your patch?

Thanks

On Thu, Jun 01, 2023 at 11:49:45PM +0800, tongxiaoge1001@126.com wrote:
> From: shixuantong <tongxiaoge1001@126.com>
> 
> ---
>  tests/nft-table-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/nft-table-test.c b/tests/nft-table-test.c
> index 1b2f280..53cf3d1 100644
> --- a/tests/nft-table-test.c
> +++ b/tests/nft-table-test.c
> @@ -34,7 +34,7 @@ static void cmp_nftnl_table(struct nftnl_table *a, struct nftnl_table *b)
>  		print_err("table flags mismatches");
>  	if (nftnl_table_get_u32(a, NFTNL_TABLE_FAMILY) !=
>  	    nftnl_table_get_u32(b, NFTNL_TABLE_FAMILY))
> -		print_err("tabke family mismatches");
> +		print_err("table family mismatches");
>  }
>  
>  int main(int argc, char *argv[])
> -- 
> 2.33.0
> 
