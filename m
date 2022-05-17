Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648C529BE1
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 May 2022 10:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbiEQIL6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 May 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242677AbiEQILE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 May 2022 04:11:04 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDE2DCF
        for <netfilter-devel@vger.kernel.org>; Tue, 17 May 2022 01:10:57 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nqsIA-0008CW-Cz; Tue, 17 May 2022 10:10:54 +0200
Date:   Tue, 17 May 2022 10:10:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     vincent@systemli.org
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] treewide: use uint* instead of u_int*
Message-ID: <YoNYjq2yDr3jbnyv@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, vincent@systemli.org,
        netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
References: <9n33705n-4s4r-q4s1-q97-76n73p18s99r@vanv.qr>
 <20220516161641.15321-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516161641.15321-1-vincent@systemli.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 16, 2022 at 06:16:41PM +0200, vincent@systemli.org wrote:
[...]
> diff --git a/include/libipq/libipq.h b/include/libipq/libipq.h
> index 3cd13292..48c368f5 100644
> --- a/include/libipq/libipq.h
> +++ b/include/libipq/libipq.h
> @@ -48,19 +48,19 @@ typedef unsigned long ipq_id_t;
>  struct ipq_handle
>  {
>  	int fd;
> -	u_int8_t blocking;
> +	uint8_t blocking;
>  	struct sockaddr_nl local;
>  	struct sockaddr_nl peer;
>  };
>  
> -struct ipq_handle *ipq_create_handle(u_int32_t flags, u_int32_t protocol);
> +struct ipq_handle *ipq_create_handle(uint32_t flags, uint32_t protocol);

Might this break API compatibility? ABI won't change, but I suppose
users would have to include stdint.h prior to this header. Are we safe
if we change the include from sys/types.h to stdint.h in line 27 of that
file?

[...]
> diff --git a/include/linux/netfilter_arp/arpt_mangle.h b/include/linux/netfilter_arp/arpt_mangle.h
> index 250f5029..f83ad10a 100644
> --- a/include/linux/netfilter_arp/arpt_mangle.h
> +++ b/include/linux/netfilter_arp/arpt_mangle.h
> @@ -13,7 +13,7 @@ struct arpt_mangle
>  	union {
>  		struct in_addr tgt_ip;
>  	} u_t;
> -	u_int8_t flags;
> +	uint8_t flags;
>  	int target;
>  };

This is a kernel-header. The type was changed to __u8 in kernel repo, so
we should use that instead.

Thanks, Phil
