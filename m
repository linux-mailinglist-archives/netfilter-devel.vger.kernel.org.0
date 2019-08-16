Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E56905DE
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Aug 2019 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHPQcK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Aug 2019 12:32:10 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46626 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfHPQcJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:32:09 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hyf96-0003Ou-64; Fri, 16 Aug 2019 18:32:08 +0200
Date:   Fri, 16 Aug 2019 18:32:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, pablo@netfilter.org
Subject: Re: [PATCH v2] netfilter: nfacct: Fix alignment mismatch in
 xt_nfacct_match_info
Message-ID: <20190816163208.pjgnidt7kjsigssu@breakpoint.cc>
References: <7899070.tJGA48rBTd@rocinante.m.i2n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7899070.tJGA48rBTd@rocinante.m.i2n>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com> wrote:
> When running a 64-bit kernel with a 32-bit iptables binary, the size of
> the xt_nfacct_match_info struct diverges.
> 
>     kernel: sizeof(struct xt_nfacct_match_info) : 40
>     iptables: sizeof(struct xt_nfacct_match_info)) : 36
> 
> Trying to append nfacct related rules results in an unhelpful message.
> Although it is suggested to look for more information in dmesg, nothing
> can be found there.
> 
>     # iptables -A <chain> -m nfacct --nfacct-name <acct-object>
>     iptables: Invalid argument. Run `dmesg' for more information.
> 
> This patch fixes the memory misalignment by enforcing 8-byte alignment
> within the struct's first revision. This solution is often used in many
> other uapi netfilter headers.
> 
> Signed-off-by: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>

Thanks, this looks good.

Acked-by: Florian Westphal <fw@strlen.de>
