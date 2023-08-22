Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE6783C78
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Aug 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjHVJGm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Aug 2023 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjHVJGm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:06:42 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E160ACE
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Aug 2023 02:06:40 -0700 (PDT)
Received: from [78.30.34.192] (port=43802 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qYNLQ-00HIR4-EM; Tue, 22 Aug 2023 11:06:39 +0200
Date:   Tue, 22 Aug 2023 11:06:35 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH 1/2] meta: don't assume time_t is 64 bit in
 date_type_print()
Message-ID: <ZOR6myDOceCfSQ0u@calendula>
References: <20230822081318.1370371-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822081318.1370371-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:13:09AM +0200, Thomas Haller wrote:
> diff --git a/src/meta.c b/src/meta.c
> index 822c2fd12b6f..0d4ae0261ff2 100644
> --- a/src/meta.c
> +++ b/src/meta.c
> @@ -385,20 +385,23 @@ const struct datatype ifname_type = {
>  
>  static void date_type_print(const struct expr *expr, struct output_ctx *octx)
>  {
> -	uint64_t tstamp = mpz_get_uint64(expr->value);
> +	uint64_t tstamp64 = mpz_get_uint64(expr->value);
> +	time_t tstamp;
>  	struct tm *tm, *cur_tm;
>  	char timestr[21];

For the record: I made this edit before applying:

	uint64_t tstamp64 = mpz_get_uint64(expr->value);
  	struct tm *tm, *cur_tm;
  	char timestr[21];
	time_t tstamp;

following reverse xmas tree layout, it is a comestic coding style
issue.

Not all the codebase follows this approach, but this is usually
preferred.

Thanks.
