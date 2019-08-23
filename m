Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9841B9AFA4
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Aug 2019 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbfHWMgY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Aug 2019 08:36:24 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:34937 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389160AbfHWMgY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:36:24 -0400
Received: from [31.4.212.198] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i18ng-0006pj-Ei; Fri, 23 Aug 2019 14:36:22 +0200
Date:   Fri, 23 Aug 2019 14:36:14 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v4] meta: add ibrpvid and ibrvproto support
Message-ID: <20190823123614.qnusroitogrjg74m@salvia>
References: <1566382238-5286-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566382238-5286-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.5 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:10:38PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This allows you to match the bridge pvid and vlan protocol, for
> instance:
> 
> nft add rule bridge firewall zones meta ibrvproto 0x8100
> nft add rule bridge firewall zones meta ibrpvid 100
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  src/meta.c                     |  6 ++++++
>  tests/py/bridge/meta.t         |  2 ++
>  tests/py/bridge/meta.t.json    | 26 ++++++++++++++++++++++++++
>  tests/py/bridge/meta.t.payload |  9 +++++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/src/meta.c b/src/meta.c
> index 5901c99..d45d757 100644
> --- a/src/meta.c
> +++ b/src/meta.c
> @@ -442,6 +442,12 @@ const struct meta_template meta_templates[] = {
>  	[NFT_META_OIFKIND]	= META_TEMPLATE("oifkind",   &ifname_type,
>  						IFNAMSIZ * BITS_PER_BYTE,
>  						BYTEORDER_HOST_ENDIAN),
> +	[NFT_META_BRI_IIFPVID]	= META_TEMPLATE("ibrpvid",   &integer_type,

Just notices another nitpick: I think if you use etheraddr_type
instead of integer_type here, you would get a nicer output.
