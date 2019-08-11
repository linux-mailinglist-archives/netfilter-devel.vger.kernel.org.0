Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDA89326
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Aug 2019 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKSmU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Aug 2019 14:42:20 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42914 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfHKSmU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:42:20 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hwsnJ-0004m2-IM; Sun, 11 Aug 2019 20:42:17 +0200
Date:   Sun, 11 Aug 2019 20:42:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Franta =?iso-8859-15?Q?Hanzl=EDk?= <franta@hanzlici.cz>
Subject: Re: [PATCH xtables-addons 2/2] xt_DHCPMAC: replaced
 skb_make_writable with skb_ensure_writable.
Message-ID: <20190811184217.yse5h3diubi7uvas@breakpoint.cc>
References: <20190811113826.5e594d8f@franta.hanzlici.cz>
 <20190811131617.10365-1-jeremy@azazel.net>
 <20190811131617.10365-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811131617.10365-2-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> skb_make_writable was removed from the kernel in 5.2 and its callers
> converted to use skb_ensure_writable.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
> ---
>  extensions/xt_DHCPMAC.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/extensions/xt_DHCPMAC.c b/extensions/xt_DHCPMAC.c
> index 47f9534f74c7..412f8984d326 100644
> --- a/extensions/xt_DHCPMAC.c
> +++ b/extensions/xt_DHCPMAC.c
> @@ -96,7 +96,7 @@ dhcpmac_tg(struct sk_buff *skb, const struct xt_action_param *par)
>  	struct udphdr udpbuf, *udph;
>  	unsigned int i;
>  
> -	if (!skb_make_writable(skb, 0))
> +	if (!skb_ensure_writable(skb, 0))
>  		return NF_DROP;

You need to drop the "!".  The "0" argument is suspicious as well, i
guess this needs to be "skb->len".
