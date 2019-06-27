Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387BB58A81
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2019 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0TAY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jun 2019 15:00:24 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49984 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbfF0TAY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:00:24 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgZd5-0005SN-SJ; Thu, 27 Jun 2019 21:00:19 +0200
Date:   Thu, 27 Jun 2019 21:00:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Ibrahim Ercan <ibrahim.ercan@labristeknoloji.com>,
        netfilter-devel@vger.kernel.org, fw@strlen.de,
        ibrahim.metu@gmail.com
Subject: Re: [PATCH v2] netfilter: synproxy: erroneous TCP mss option fixed.
Message-ID: <20190627190019.hrlowm5lxw7grmsk@breakpoint.cc>
References: <CAK6Qs9k_bdU9ZL4WRXBGYdtfnP_qhot0hzC=uMQG6C_pkz3+2w@mail.gmail.com>
 <1561441324-19193-1-git-send-email-ibrahim.ercan@labristeknoloji.com>
 <20190627185744.ynxyes7an6gd7hlg@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627185744.ynxyes7an6gd7hlg@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >  		opts.options &= info->options;
> > +		client_mssinfo = opts.mss;
> > +		opts.mss = info->mss;
> 
> No need for this new client_mssinfo variable, right? I mean, you can
> just set:
> 
>         opts.mss = info->mss;
> 
> and use it from synproxy_send_client_synack().

I thought that as well but we need both mss values,
the one configured in the target (info->mss) and the
ine received from the peer.

The former is what we announce to peer in the syn/ack
(as tcp option), the latter is what we need to encode
in the syncookie (to decode it on cookie ack).

