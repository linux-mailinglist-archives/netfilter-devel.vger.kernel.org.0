Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773158D573
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNN4u (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 09:56:50 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34174 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfHNN4u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:56:50 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hxtlf-00034t-KL; Wed, 14 Aug 2019 15:56:47 +0200
Date:   Wed, 14 Aug 2019 15:56:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Ander Juaristi <a@juaristi.eus>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3] netfilter: nft_dynset: support for element deletion
Message-ID: <20190814135647.2hyfy6boqg5k5x7e@breakpoint.cc>
References: <20190813065849.4745-1-a@juaristi.eus>
 <20190814081747.j3gg57copo2zpinm@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814081747.j3gg57copo2zpinm@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Aug 13, 2019 at 08:58:49AM +0200, Ander Juaristi wrote:
> > This patch implements the delete operation from the ruleset.
> > 
> > It implements a new delete() function in nft_set_rhash. It is simpler
> > to use than the already existing remove(), because it only takes the set
> > and the key as arguments, whereas remove() expects a full
> > nft_set_elem structure.
> 
> Userspace patches for this? Thanks.

Yes, please also add at least one test case -- thanks.

As a reminder, this needs a small patch to libnftnl to avoid
  [ dynset unknown reg_key 1 set y timeout 0ms ]
