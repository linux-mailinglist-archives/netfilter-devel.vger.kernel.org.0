Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCC9AFD5
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Aug 2019 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391482AbfHWMnA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Aug 2019 08:43:00 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:49551 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391109AbfHWMnA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:43:00 -0400
Received: from [31.4.212.198] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i18u4-0007Ld-Oe; Fri, 23 Aug 2019 14:42:58 +0200
Date:   Fri, 23 Aug 2019 14:42:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2 nf-next v2] netfilter: nf_tables: Introduce stateful
 object update operation
Message-ID: <20190823124250.75apok22fnbdhujd@salvia>
References: <20190822164827.1064-1-ffmancera@riseup.net>
 <20190823124142.dsmyr3mkwt3ppz3y@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823124142.dsmyr3mkwt3ppz3y@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 23, 2019 at 02:41:42PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Aug 22, 2019 at 06:48:26PM +0200, Fernando Fernandez Mancera wrote:
> > @@ -1405,10 +1409,16 @@ struct nft_trans_elem {
> >  
> >  struct nft_trans_obj {
> >  	struct nft_object		*obj;
> > +	struct nlattr			**tb;
> 
> Instead of annotatint tb[] on the object, you can probably add here:
> 
> union {
>         struct quota {
>                 uint64_t                consumed;
>                 uint64_t                quota;
>       } quota;
> };
> 
> So the initial update annotates the values in the transaction.
> 
> I guess you will need two new indirections? Something like
> prepare_update() and update().

Or you have a single update() and pass enum nft_trans_phase as
parameter, so this only needs one single indirection.
