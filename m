Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E330758CA2F
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Aug 2022 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiHHOJ0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Aug 2022 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiHHOJZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:09:25 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A388E0C2
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Aug 2022 07:09:24 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:09:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Duncan Roe <duncan_roe@optusnet.com.au>
Subject: Re: [PATCH libmnl v2 2/2] libmnl: add support for signed types
Message-ID: <YvEZEcLT5t1SBVcc@salvia>
References: <20220805210040.2827875-1-jacob.e.keller@intel.com>
 <20220805210040.2827875-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805210040.2827875-2-jacob.e.keller@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Fri, Aug 05, 2022 at 02:00:40PM -0700, Jacob Keller wrote:
> libmnl has get and put functions for unsigned integer types. It lacks
> support for the signed variations. On some level this is technically
> sufficient. A user could use the unsigned variations and then cast to a
> signed value at use. However, this makes resulting code in the application
> more difficult to follow. Introduce signed variations of the integer get
> and put functions.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  include/libmnl/libmnl.h |  16 ++++
>  src/attr.c              | 194 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 209 insertions(+), 1 deletion(-)
> 
[...]
> @@ -127,6 +139,10 @@ enum mnl_attr_data_type {
>  	MNL_TYPE_U16,
>  	MNL_TYPE_U32,
>  	MNL_TYPE_U64,
> +	MNL_TYPE_S8,
> +	MNL_TYPE_S16,
> +	MNL_TYPE_S32,
> +	MNL_TYPE_S64,

This breaks ABI, you have to add new types at the end of the
enumeration.

>  	MNL_TYPE_STRING,
>  	MNL_TYPE_FLAG,
>  	MNL_TYPE_MSECS,

Thanks.
