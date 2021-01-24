Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C533301B45
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 Jan 2021 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAXKqL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 24 Jan 2021 05:46:11 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:32870 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbhAXKqJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 24 Jan 2021 05:46:09 -0500
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7BADF25B7B1;
        Sun, 24 Jan 2021 21:45:26 +1100 (AEDT)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 88A0F44C4; Sun, 24 Jan 2021 11:45:24 +0100 (CET)
Date:   Sun, 24 Jan 2021 11:45:24 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     dpayne <darby.payne@gmail.com>, netfilter-devel@vger.kernel.org,
        lvs-devel@vger.kernel.org
Subject: Re: [PATCH v6] ipvs: add weighted random twos choice algorithm
Message-ID: <20210124104524.GG576@vergenet.net>
References: <c97fced3-b6b7-ba40-274c-7a5749bbe48a@ssi.bg>
 <20210106190242.1044489-1-darby.payne@gmail.com>
 <c13462ca-37ce-1112-f73c-40d3e612482@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13462ca-37ce-1112-f73c-40d3e612482@ssi.bg>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 06, 2021 at 09:25:47PM +0200, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Wed, 6 Jan 2021, dpayne wrote:
> 
> > Adds the random twos choice load-balancing algorithm. The algorithm will
> > pick two random servers based on weights. Then select the server with
> > the least amount of connections normalized by weight. The algorithm
> > avoids the "herd behavior" problem. The algorithm comes from a paper
> > by Michael Mitzenmacher available here
> > http://www.eecs.harvard.edu/~michaelm/NEWWORK/postscripts/twosurvey.pdf
> > 
> > Signed-off-by: dpayne <darby.payne@gmail.com>
> 
> 	Looks good to me for -next, thanks!
> 
> Acked-by: Julian Anastasov <ja@ssi.bg>

Sorry for the delay,

Acked-by: Simon Horman <horms@verge.net.au>
