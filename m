Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FFF29F21
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 May 2019 21:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfEXTba (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 May 2019 15:31:30 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:58622 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391669AbfEXTba (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 May 2019 15:31:30 -0400
Received: from [31.4.219.201] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <pablo@gnumonks.org>)
        id 1hUFuZ-0003KW-Kk; Fri, 24 May 2019 21:31:29 +0200
Date:   Fri, 24 May 2019 21:31:26 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v4 2/2] jump: Allow goto and jump to a variable using
 nft input files
Message-ID: <20190524193126.ukq2qs5w7ti6jicb@salvia>
References: <20190524130648.21520-1-ffmancera@riseup.net>
 <20190524130648.21520-2-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524130648.21520-2-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 24, 2019 at 03:06:50PM +0200, Fernando Fernandez Mancera wrote:
> This patch introduces the use of nft input files variables in 'jump' and 'goto'
> statements, e.g.
> 
> define dest = ber
> 
> add table ip foo
> add chain ip foo bar {type filter hook input priority 0;}
> add chain ip foo ber
> add rule ip foo ber counter
> add rule ip foo bar jump $dest
> 
> table ip foo {
>         chain bar {
>                 type filter hook input priority filter; policy accept;
>                 jump ber
>         }
> 
>         chain ber {
>                 counter packets 71 bytes 6664
>         }
> }

Also applied, thanks.
