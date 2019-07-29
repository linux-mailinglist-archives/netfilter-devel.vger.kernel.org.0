Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E27CD789A6
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfG2KdU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Jul 2019 06:33:20 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33782 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbfG2KdU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:33:20 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hs2xx-0002Vs-EJ; Mon, 29 Jul 2019 12:33:18 +0200
Date:   Mon, 29 Jul 2019 12:33:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nfacct: Fix alignment mismatch in
 xt_nfacct_match_info
Message-ID: <20190729103317.ujlx4larhtzeijp3@breakpoint.cc>
References: <2781693.KLf3iWz6jR@rocinante.m.i2n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2781693.KLf3iWz6jR@rocinante.m.i2n>
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
> within the struct. This solution is often used in many other uapi
> netfilter headers.

Yes, but this breaks the 32bit abi.

Its best to add a 'v1' match revision to fix this.
