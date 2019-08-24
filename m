Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D19BEC7
	for <lists+netfilter-devel@lfdr.de>; Sat, 24 Aug 2019 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHXQ3o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 24 Aug 2019 12:29:44 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:50135 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfHXQ3o (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 24 Aug 2019 12:29:44 -0400
Received: from [47.60.33.188] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i1Yv2-0000oq-6j; Sat, 24 Aug 2019 18:29:42 +0200
Date:   Sat, 24 Aug 2019 18:29:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2 nf-next v2] netfilter: nf_tables: Introduce stateful
 object update operation
Message-ID: <20190824162934.sdlrz56out4tzlw7@salvia>
References: <20190822164827.1064-1-ffmancera@riseup.net>
 <20190823124142.dsmyr3mkwt3ppz3y@salvia>
 <20190823124250.75apok22fnbdhujd@salvia>
 <fc6fe6d4-1efa-6845-f0ee-4e1f1da61da5@riseup.net>
 <20d36122-4d8d-e73f-a5d9-af1642d3a887@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d36122-4d8d-e73f-a5d9-af1642d3a887@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 23, 2019 at 08:28:46PM +0200, Fernando Fernandez Mancera wrote:
> On 8/23/19 8:05 PM, Fernando Fernandez Mancera wrote:
> > 
> > 
> > On 8/23/19 2:42 PM, Pablo Neira Ayuso wrote:
> >> On Fri, Aug 23, 2019 at 02:41:42PM +0200, Pablo Neira Ayuso wrote:
> >>> On Thu, Aug 22, 2019 at 06:48:26PM +0200, Fernando Fernandez Mancera wrote:
> >>>> @@ -1405,10 +1409,16 @@ struct nft_trans_elem {
> >>>>  
> >>>>  struct nft_trans_obj {
> >>>>  	struct nft_object		*obj;
> >>>> +	struct nlattr			**tb;
> >>>
> >>> Instead of annotatint tb[] on the object, you can probably add here:
> >>>
> >>> union {
> >>>         struct quota {
> >>>                 uint64_t                consumed;
> >>>                 uint64_t                quota;
> >>>       } quota;
> >>> };
> >>>
> >>> So the initial update annotates the values in the transaction.
> >>>
> 
> If we follow that pattern then the indirection would need the
> nft_trans_phase enum, the quota struct and also the tb[] as parameters
> because in the preparation phase we always need the tb[] array.

Right, so this is my next idea :-)

For the update case, I'd suggest you use the existing 'obj' field in
the transaction object. The idea would be to allocate a new object via
nft_obj_init() from the update path. Hence, you can use the existing
expr->ops->init() interface to parse the attributes - I find the
existing parsing for ->update() a bit redundant.

Then, from the commit path, you use the new ->update() interface to
update the object accordingly taking this new object as input. I think
you cannot update u64 quota like you do in this patch. On 32-bit
arches, an assignment of u64 won't be atomic. So you have to use
atomic64_set() and atomic64_read() to make sure that packet path does
not observes an inconsistent state. BTW, once you have updated the
existing object, you can just release the object in the transaction
coming in this update. I think you will need a 'bool update' field on
the transaction object, so the commit path knows how to handle the
update.
