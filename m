Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE97113AB38
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2020 14:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgANNjw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jan 2020 08:39:52 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50592 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgANNjw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:39:52 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1irMQB-0005m9-AZ; Tue, 14 Jan 2020 14:39:51 +0100
Date:   Tue, 14 Jan 2020 14:39:51 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] xfrm: spi is big endian
Message-ID: <20200114133951.GO795@breakpoint.cc>
References: <20200114124015.31064-1-fw@strlen.de>
 <20200114132701.ybocb7vhgwd2yepx@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114132701.ybocb7vhgwd2yepx@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Jan 14, 2020 at 01:40:15PM +0100, Florian Westphal wrote:
> > the kernel stores spi in a __be32, so fix up the byteorder annotation
> > accordingly.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Please, update tests/py too, I guess that will spew a warning after
> this update?

Yup, pushed with amended test case, thanks for the reminder.
