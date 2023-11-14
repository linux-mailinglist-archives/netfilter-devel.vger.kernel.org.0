Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A107EB36D
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Nov 2023 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjKNPWi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Nov 2023 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjKNPWe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:22:34 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B6D113
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Nov 2023 07:22:31 -0800 (PST)
Received: from [78.30.43.141] (port=51024 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r2vFD-0075JD-1S; Tue, 14 Nov 2023 16:22:28 +0100
Date:   Tue, 14 Nov 2023 16:22:26 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] utils: Add example of setting socket
 buffer size
Message-ID: <ZVOQsqQg9P+ymB6e@calendula>
References: <20231110041604.11564-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110041604.11564-1-duncan_roe@optusnet.com.au>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 10, 2023 at 03:16:04PM +1100, Duncan Roe wrote:
> The libnetfilter_queue main HTML page mentions nfnl_rcvbufsiz() so the new
> libmnl-only libnetfilter_queue will have to support it.
> 
> The added call acts as a demo and a test case.
> 
> Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> ---
>  utils/nfqnl_test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/utils/nfqnl_test.c b/utils/nfqnl_test.c
> index 682f3d7..6d2305e 100644
> --- a/utils/nfqnl_test.c
> +++ b/utils/nfqnl_test.c
> @@ -91,6 +91,7 @@ int main(int argc, char **argv)
>  	int fd;
>  	int rv;
>  	uint32_t queue = 0;
> +	uint32_t ret;
>  	char buf[4096] __attribute__ ((aligned));
>  
>  	if (argc == 2) {
> @@ -107,6 +108,10 @@ int main(int argc, char **argv)
>  		fprintf(stderr, "error during nfq_open()\n");
>  		exit(1);
>  	}
> +	printf("setting socket buffer size to 2MB\n");
> +	ret = nfnl_rcvbufsiz(nfq_nfnlh(h), 1024 * 1024);

libnfnetlink is deprecated.

maybe call setsockopt and use nfq_fd() instead if you would like that
this shows in the example file.

> +	printf("Read buffer set to 0x%x bytes (%gMB)\n", ret,
> +	       ret / 1024.0 / 1024);
>  
>  	printf("unbinding existing nf_queue handler for AF_INET (if any)\n");
>  	if (nfq_unbind_pf(h, AF_INET) < 0) {
> -- 
> 2.35.8
> 
