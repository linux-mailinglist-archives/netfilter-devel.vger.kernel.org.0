Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785EC185CA3
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2020 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgCON2p (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Mar 2020 09:28:45 -0400
Received: from correo.us.es ([193.147.175.20]:60598 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgCON2o (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Mar 2020 09:28:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B944511EB28
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 14:28:16 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AA1F7DA38D
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 14:28:16 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9FA31DA3C3; Sun, 15 Mar 2020 14:28:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 456F1DA788;
        Sun, 15 Mar 2020 14:28:11 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 15 Mar 2020 14:28:11 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1F6D74251480;
        Sun, 15 Mar 2020 14:28:11 +0100 (CET)
Date:   Sun, 15 Mar 2020 14:28:36 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Graf <tgraf@suug.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH nf-next 3/3] netfilter: Introduce egress hook
Message-ID: <20200315132836.cj36ape6rpw33iqb@salvia>
References: <cover.1583927267.git.lukas@wunner.de>
 <14ab7e5af20124a34a50426fd570da7d3b0369ce.1583927267.git.lukas@wunner.de>
 <a57687ae-2da6-ca2a-1c84-e4332a5e4556@iogearbox.net>
 <20200313145526.ikovaalfuy7rnkdl@salvia>
 <1bd50836-33c4-da44-5771-654bfb0348cc@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd50836-33c4-da44-5771-654bfb0348cc@iogearbox.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello Daniel,

On Sat, Mar 14, 2020 at 01:12:02AM +0100, Daniel Borkmann wrote:
> On 3/13/20 3:55 PM, Pablo Neira Ayuso wrote:
[...]
> > We have plans to support for NAT64 and NAT46, this is the right spot
> > to do this mangling. There is already support for the tunneling
> 
> But why is existing local-out or post-routing hook _not_ sufficient for
> NAT64 given it being IP based?

Those hooks are not coming at the end of the IP processing. There is
very relevant IP code after those hooks that cannot be bypassed such
as fragmentation, tunneling and neighbour output. Such transformation
needs to happen after the IP processing, exactly from where Lukas is
proposing.

[...]
> > infrastructure in netfilter from ingress, this spot from egress will
> > allow us to perform the tunneling from here. There is also no way to
> > drop traffic generated by dhclient, this also allow for filtering such
> > locally generated traffic. And many more.
> 
> This is a known fact for ~17 years [0] or probably more by now and noone
> from netfilter folks cared to address it in all the years, so I presume
> it cannot be important enough, and these days it can be filtered through
> other means already. Tbh, it's a bit laughable that you bring this up as
> an argument ...
> 
>   [0] https://www.spinics.net/lists/netfilter/msg19488.html

Look: ip6tables, arptables and ebtables are a copy and paste from the
original iptables.

At that time, the only way one way to add support for ingress/egress
classification in netfilter: add "devtables", yet another copy and
past from iptables, that was a no-go.

This is not a problem anymore since there is a consolidated netfilter
framework to achieve ingress/egress classification.

> > Performance impact is negligible, Lukas already provided what you
> > asked for.
> 
> Sure, and the claimed result was "as said the fast-path gets faster, not
> slower" without any explanation or digging into details on why this might
> be, especially since it appears counter-intuitive as was stated by the
> author ... and later demonstrated w/ measurements that show the opposite.

I remember one of your collegues used this same argument against new
hooks back in 2015 [0], and the introduction of this hook was proven
to be negligible. This patchset introduces code that looks very much
the same.

I can make a list of recent updates to the output path, several of
them very are targeted to very specific usecases. You did not care at
all about performance impact of those at all, however, you care about
netfilter for some unknown reason.

In my opinion, your original feedback has been addressed, it's time to
move on.

Thank you.

[0] https://lwn.net/Articles/642414/
