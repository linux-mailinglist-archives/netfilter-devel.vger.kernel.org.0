Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476472B3BF1
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Nov 2020 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKPD6h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Nov 2020 22:58:37 -0500
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:35450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726532AbgKPD6h (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:58:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5630C1730858;
        Mon, 16 Nov 2020 03:58:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:4659:5007:9010:9025:9388:10004:10049:10400:10848:11232:11657:11658:11783:11914:12043:12048:12297:12555:12740:12895:13069:13311:13357:13439:13894:14094:14106:14181:14659:14721:14764:14849:21080:21451:21627:21691:21740:21781:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: scent45_491207927325
X-Filterd-Recvd-Size: 2428
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Nov 2020 03:58:34 +0000 (UTC)
Message-ID: <d03c87f9fcc4bb68c148cfad12cafef5f2385eef.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: rectify file patterns for NETFILTER
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 15 Nov 2020 19:58:33 -0800
In-Reply-To: <20201109091942.32280-1-lukas.bulwahn@gmail.com>
References: <20201109091942.32280-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, 2020-11-09 at 10:19 +0100, Lukas Bulwahn wrote:
> The two file patterns in the NETFILTER section:
> 
>   F:      include/linux/netfilter*
>   F:      include/uapi/linux/netfilter*
> 
> intended to match the directories:
> 
>   ./include{/uapi}/linux/netfilter_{arp,bridge,ipv4,ipv6}
> 
> A quick check with ./scripts/get_maintainer.pl --letters -f will show that
> they are not matched, though, because this pattern only matches files, but
> not directories.
> 
> Rectify the patterns to match the intended directories.
[]
diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -12139,10 +12139,10 @@ W:	http://www.nftables.org/
>  Q:	http://patchwork.ozlabs.org/project/netfilter-devel/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git
> -F:	include/linux/netfilter*
> +F:	include/linux/netfilter*/
>  F:	include/linux/netfilter/

This line could be deleted or perhaps moved up one line above

F:	include/linux/netfilter/
F:	include/linux/netfilter*/

(as the second line already matches the first line's files too)

>  F:	include/net/netfilter/
> -F:	include/uapi/linux/netfilter*
> +F:	include/uapi/linux/netfilter*/
>  F:	include/uapi/linux/netfilter/

same here.

>  F:	net/*/netfilter.c
>  F:	net/*/netfilter/


