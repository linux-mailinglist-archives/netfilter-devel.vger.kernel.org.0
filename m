Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACF58ABA
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2019 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0TJB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jun 2019 15:09:01 -0400
Received: from mail.us.es ([193.147.175.20]:52638 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfF0TJB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:09:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ED785C41AE
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Jun 2019 21:08:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D6CF9DA732
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Jun 2019 21:08:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C7AED1021A8; Thu, 27 Jun 2019 21:08:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AD55ADA704;
        Thu, 27 Jun 2019 21:08:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 27 Jun 2019 21:08:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8AB804265A31;
        Thu, 27 Jun 2019 21:08:57 +0200 (CEST)
Date:   Thu, 27 Jun 2019 21:08:57 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Ibrahim Ercan <ibrahim.ercan@labristeknoloji.com>,
        netfilter-devel@vger.kernel.org, ibrahim.metu@gmail.com
Subject: Re: [PATCH v2] netfilter: synproxy: erroneous TCP mss option fixed.
Message-ID: <20190627190857.f6lwop54735wo6dg@salvia>
References: <CAK6Qs9k_bdU9ZL4WRXBGYdtfnP_qhot0hzC=uMQG6C_pkz3+2w@mail.gmail.com>
 <1561441324-19193-1-git-send-email-ibrahim.ercan@labristeknoloji.com>
 <20190627185744.ynxyes7an6gd7hlg@salvia>
 <20190627190019.hrlowm5lxw7grmsk@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627190019.hrlowm5lxw7grmsk@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:00:19PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > >  		opts.options &= info->options;
> > > +		client_mssinfo = opts.mss;
> > > +		opts.mss = info->mss;
> > 
> > No need for this new client_mssinfo variable, right? I mean, you can
> > just set:
> > 
> >         opts.mss = info->mss;
> > 
> > and use it from synproxy_send_client_synack().
> 
> I thought that as well but we need both mss values,
> the one configured in the target (info->mss) and the
> ine received from the peer.
> 
> The former is what we announce to peer in the syn/ack
> (as tcp option), the latter is what we need to encode
> in the syncookie (to decode it on cookie ack).

I see, probably place client_mss field into the synproxy_options
structure?
