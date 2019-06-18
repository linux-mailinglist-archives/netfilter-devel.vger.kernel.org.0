Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE8E4A206
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jun 2019 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFRNXw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jun 2019 09:23:52 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:52542 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfFRNXw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:23:52 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hdE5W-0000SM-NP; Tue, 18 Jun 2019 15:23:50 +0200
Date:   Tue, 18 Jun 2019 15:23:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Mojtaba <mespio@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: working with libnetfilter_queue and linbetfilter_contrack
Message-ID: <20190618132350.phtpv2vhteplfj32@breakpoint.cc>
References: <CABVi_Eyws89e+y_4tGJNybGRdL4AarHG6GkNB0d0MGgLABuv3w@mail.gmail.com>
 <20190618095021.doh6pc7gzah3bnra@breakpoint.cc>
 <CABVi_EyyV6jmB8SxuiUKpHzL9NwMLUA1TPk3X=SOq58BFdG9vA@mail.gmail.com>
 <20190618105613.qgfov6jmnov2ba3e@breakpoint.cc>
 <CABVi_ExMpOnaau6sroSXd=Zzc4=F6t0Hv5iCm16q0jxqp5Tjkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVi_ExMpOnaau6sroSXd=Zzc4=F6t0Hv5iCm16q0jxqp5Tjkg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mojtaba <mespio@gmail.com> wrote:
> Thanks Florian so much.
> According the last paragraf of email i get the best way is i should use
> libnetfilter_conntrack to insert a new conntrack entry in my userspace that
> is called from raw PREROUTING table as NQUEUE callback queue.
> Is it right underestanding?

Yes, but since you did not exactly say what you're trying to do
there might be better ways (ipvs, nft maps, etc).

Nfqueue is slow.
