Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3F96601
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2019 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHTQOd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Aug 2019 12:14:33 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36114 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfHTQOd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:14:33 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i06mF-0006DN-NE; Tue, 20 Aug 2019 18:14:31 +0200
Date:   Tue, 20 Aug 2019 18:14:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Eric Jallot <ejallot@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] src: secmark: fix missing quotes in selctx
 strings output
Message-ID: <20190820161431.GU2588@breakpoint.cc>
References: <CAMV0XWGubiNxMu_HSgnXMCn75p92dMvLr9E+wBx3gx3gTE6GCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMV0XWGubiNxMu_HSgnXMCn75p92dMvLr9E+wBx3gx3gTE6GCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eric Jallot <ejallot@gmail.com> wrote:
> Colon is not allowed in strings and breaks nft -f.
> So move to quoted string in selctx output.
> 
> Before patch:
>  # nft list ruleset > rules.nft; cat rules.nft
>  table inet t {
>          secmark s {
>                  system_u:object_r:ssh_server_packet_t:s0
>          }
>  }
>  # nft flush ruleset
>  # nft -f rules.nft
>  rules.nft:3:11-11: Error: syntax error, unexpected colon
>                 system_u:object_r:ssh_server_packet_t:s0
>                         ^
> 
> After patch:
>  # nft list ruleset > rules.nft; cat rules.nft
>  table inet t {
>          secmark s {
>                  "system_u:object_r:ssh_server_packet_t:s0"
>          }
>  }
>  # nft flush ruleset
>  # nft -f rules.nft
> 
> Fixes: 3bc84e5c ("src: add support for setting secmark")
> Signed-off-by: Eric Jallot <ejallot@gmail.com>

Thanks for the patches.  Something has mangled them in transit,
replacing tabs with spaces and adding line breaks.

I've applied this change manually and pushed the result out,
can you please double-check the result is correct?

If not, please submit a relative fix.

Thanks!
