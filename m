Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D8EB48C
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfJaQSo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 12:18:44 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42106 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfJaQSo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:18:44 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iQD9m-0001HG-El; Thu, 31 Oct 2019 17:18:42 +0100
Date:   Thu, 31 Oct 2019 17:18:42 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nf-next 1/2] netfilter: nft_payload: simplify vlan header
 handling
Message-ID: <20191031161842.GK876@breakpoint.cc>
References: <20191031145122.3741-1-pablo@netfilter.org>
 <20191031145122.3741-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031145122.3741-2-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> If the offset is within the ethernet + vlan header size boundary, then
> rebuild the ethernet + vlan header and use it to copy the bytes to the
> register. Otherwise, subtract the vlan header size from the offset and
> fall back to use skb_copy_bits().
> 
> There is one corner case though: If the offset plus the length of the
> payload instruction goes over the ethernet + vlan header boundary, then,
> fetch as many bytes as possible from the rebuilt ethernet + vlan header
> and fall back to copy the remaining bytes through skb_copy_bits().

This looks simpler indeed.

Acked-by: Florian Westphal <fw@strlen.de>
