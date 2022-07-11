Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757CF56FFBE
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Jul 2022 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGKLMN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Jul 2022 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGKLL4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:11:56 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7185632D85
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Jul 2022 03:21:14 -0700 (PDT)
Date:   Mon, 11 Jul 2022 12:21:10 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Yuxuan Luo <luoyuxuan.carl@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de,
        marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        Yuxuan Luo <yuluo@redhat.com>
Subject: Re: [PATCH] xt_sctp: support a couple of new chunk types
Message-ID: <Ysv5lm/hE5/ANlSj@salvia>
References: <20220629200545.75362-1-yuluo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220629200545.75362-1-yuluo@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:05:45PM -0400, Yuxuan Luo wrote:
> There are new chunks added in Linux SCTP not being traced by iptables.
> 
> This patch introduces the following chunks for tracing:
> I_DATA, I_FORWARD_TSN (RFC8260), RE_CONFIG(RFC6525) and PAD(RFC4820)
> 
> Signed-off-by: Yuxuan Luo <luoyuxuan.carl@gmail.com>
> ---
>  extensions/libxt_sctp.c   | 4 ++++
>  extensions/libxt_sctp.man | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/extensions/libxt_sctp.c b/extensions/libxt_sctp.c
> index a4c5415f..3fb6cf1a 100644
> --- a/extensions/libxt_sctp.c
> +++ b/extensions/libxt_sctp.c
> @@ -112,9 +112,13 @@ static const struct sctp_chunk_names sctp_chunk_names[]
>      { .name = "ECN_ECNE",	.chunk_type = 12,  .valid_flags = "--------", .nftname = "ecne" },
>      { .name = "ECN_CWR",	.chunk_type = 13,  .valid_flags = "--------", .nftname = "cwr" },
>      { .name = "SHUTDOWN_COMPLETE", .chunk_type = 14,  .valid_flags = "-------T", .nftname = "shutdown-complete" },
> +    { .name = "I_DATA",		.chunk_type = 64,   .valid_flags = "----IUBE", .nftname = "i-data"},
> +    { .name = "RE_CONFIG",	.chunk_type = 130,  .valid_flags = "--------", .nftname = "re-config"},
> +    { .name = "PAD",		.chunk_type = 132,  .valid_flags = "--------", .nftname = "pad"},
>      { .name = "ASCONF",		.chunk_type = 193,  .valid_flags = "--------", .nftname = "asconf" },
>      { .name = "ASCONF_ACK",	.chunk_type = 128,  .valid_flags = "--------", .nftname = "asconf-ack" },
>      { .name = "FORWARD_TSN",	.chunk_type = 192,  .valid_flags = "--------", .nftname = "forward-tsn" },
> +    { .name = "I_FORWARD_TSN",	.chunk_type = 194,  .valid_flags = "--------", .nftname = "i-forward-tsn" },
>  };

Could you also update extensions/libxt_sctp.t including this new
options?

Thanks.
