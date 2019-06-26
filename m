Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F05711D
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZS4y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 14:56:54 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42928 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbfFZS4y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:56:54 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgD6D-0004Rt-82; Wed, 26 Jun 2019 20:56:53 +0200
Date:   Wed, 26 Jun 2019 20:56:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2] selftests: netfilter: add nfqueue test case
Message-ID: <20190626185653.7xeno66crjigeyul@breakpoint.cc>
References: <20190626184234.3172-1-fw@strlen.de>
 <20190626185216.egekz5qpe2ggzj6j@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626185216.egekz5qpe2ggzj6j@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Wed, Jun 26, 2019 at 08:42:34PM +0200, Florian Westphal wrote:
> > diff --git a/tools/testing/selftests/netfilter/nf-queue.c b/tools/testing/selftests/netfilter/nf-queue.c
> > new file mode 100644
> > index 000000000000..897274bd6f4a
> > --- /dev/null
> > +++ b/tools/testing/selftests/netfilter/nf-queue.c
> 
> Oh well. Lots of copied and pasted code from the libraries.
> 
> We'll have to remind to take patches for the example in the library
> and the kernel.

Do you have an alternative proposal?
