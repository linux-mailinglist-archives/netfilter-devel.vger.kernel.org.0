Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA102533BE
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Aug 2020 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHZPc1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Aug 2020 11:32:27 -0400
Received: from correo.us.es ([193.147.175.20]:56216 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgHZPcZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:32:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 88CBF1176B1
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Aug 2020 17:32:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7561BDA78C
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Aug 2020 17:32:22 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6B1F5DA78A; Wed, 26 Aug 2020 17:32:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9776BDA73F;
        Wed, 26 Aug 2020 17:32:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 26 Aug 2020 17:32:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7A4D5426CCB9;
        Wed, 26 Aug 2020 17:32:19 +0200 (CEST)
Date:   Wed, 26 Aug 2020 17:32:19 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: nfnetlink: Busy-loop in nfnetlink_rcv_msg()
Message-ID: <20200826153219.GA2640@salvia>
References: <20200823115536.16631-1-pablo@netfilter.org>
 <20200823120434.GA16617@salvia>
 <20200822184621.GH15804@breakpoint.cc>
 <20200824131104.GC23632@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824131104.GC23632@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Mon, Aug 24, 2020 at 03:11:04PM +0200, Phil Sutter wrote:
[...]
> On Sun, Aug 23, 2020 at 02:04:34PM +0200, Pablo Neira Ayuso wrote:
> > Hi Phil,
> > 
> > On Sat, Aug 22, 2020 at 01:06:15AM +0200, Phil Sutter wrote:
> > > Hi,
> > > 
> > > Starting firewalld with two active zones in an lxc container provokes a
> > > situation in which nfnetlink_rcv_msg() loops indefinitely, because
> > > nc->call_rcu() (nf_tables_getgen() in this case) returns -EAGAIN every
> > > time.
> > > 
> > > I identified netlink_attachskb() as the originator for the above error
> > > code. The conditional leading to it looks like this:
> > > 
> > > | if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
> > > |      test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
> > > |         [...]
> > > |         if (!*timeo) {
> > > 
> > > *timeo is zero, so this seems to be a non-blocking socket. Both
> > > NETLINK_S_CONGESTED bit is set and sk->sk_rmem_alloc exceeds
> > > sk->sk_rcvbuf.
> > > 
> > > From user space side, firewalld seems to simply call sendto() and the
> > > call never returns.
> > > 
> > > How to solve that? I tried to find other code which does the same, but I
> > > haven't found one that does any looping. Should nfnetlink_rcv_msg()
> > > maybe just return -EAGAIN to the caller if it comes from call_rcu
> > > backend?
> > 
> > It's a bug in the netlink frontend, which erroneously reports -EAGAIN
> > to the nfnetlink when the socket buffer is full, see:
> > 
> > https://patchwork.ozlabs.org/project/netfilter-devel/patch/20200823115536.16631-1-pablo@netfilter.org/
> 
> Obviously this avoids the lockup. As correctly assumed by Florian,
> firewalld startup fails instead. (The daemon keeps running, but an error
> message is printed indicating that initial ruleset setup failed.)

Thanks for confirming, I'll apply this patch to nf.git.

> [...]
> > > The value of sk_rcvbuf is 425984, BTW. sk_rmem_alloc is 426240. In user
> > > space, I see a call to setsockopt(SO_RCVBUF) with value 4194304. No idea
> > > if this is related and how.
> > 
> > Next problem is to track why socket buffer is getting full with
> > GET_GENID.
> > 
> > firewalld heavily uses NLM_F_ECHO, there I can see how it can easily
> > reach the default socket buffer size, but with GET_GENID I'm not sure
> > yet, probably the problem is elsewhere but it manifests in GET_GENID
> > because it's the first thing that is done when sending a batch (maybe
> > there are unread messages in the socket buffer, you might check
> > /proc/net/netlink to see if the socket buffer keeps growing as
> > firewalld moves on).
> 
> Yes, it happens only for echo mode. With your fix in place, I also see
> what firewalld is trying to do: The JSON input leading to the error is
> huge (~72k characters). I suspect that GET_GENID just happens to be the
> last straw. Or my debugging was faulty somehow and netlink_attachskb()
> really got called via a different code-path.
> 
> > Is this easy to reproduce? Or does this happens after some time of
> > firewalld execution?
> 
> The necessary lxd setup aside, it's pretty trivial: launch an instance
> of images:centos/8/amd64, install firewalld therein, add two zone files
> and start firewalld. It happens immediately, so two active zones already
> make firewalld generate enough rules to exceed the buffer space.
> 
> On Sun, Aug 23, 2020 at 01:55:36PM +0200, Pablo Neira Ayuso wrote:
> > Frontend callback reports EAGAIN to nfnetlink to retry a command, this
> > is used to signal that module autoloading is required. Unfortunately,
> > nlmsg_unicast() reports EAGAIN in case the receiver socket buffer gets
> > full, so it enters a busy-loop.
> > 
> > This patch updates nfnetlink_unicast() to turn EAGAIN into ENOBUFS and
> > to use nlmsg_unicast(). Remove the flags field in nfnetlink_unicast()
> > since this is always MSG_DONTWAIT in the existing code which is exactly
> > what nlmsg_unicast() passes to netlink_unicast() as parameter.
> > 
> > Fixes: 96518518cc41 ("netfilter: add nftables")
> > Reported-by: Phil Sutter <phil@nwl.cc>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> This indeed "fixes" the problem. Or rather, exposes the actual problem
> in echo-related code, namely the tendency to exhaust socket buffers.
> 
> So the problem we're facing is that while user space still waits for
> sendmsg() to complete, receive buffer fills up. Is it possible to buffer
> the data in kernel somewhere else so user space has a chance to call
> recvmsg()?

There several possibilities, just a few that can be explored:

* I made a quick patch to batch several netlink messages coming as
  reply to the NLM_F_ECHO request into one single skbuff. If you look
  at the _notify() functions in the kernel, this is currently taking
  one single skbuff for one message which adds a bit of overhead (the
  skbuff truesize is used for the socket buffer accounting). I'm
  measuring here on x86_64 that each command takes 768 bytes. With a
  quick patch I'm batching several reply netlink messages into one
  single skbuff, now each commands takes ~120 bytes (well, size
  depends on how many expressions you use actually). This means this
  can handle ~3550 commands vs. the existing ~555 commands (assuming
  very small sk_rmem_alloc 426240 as the one you're reporting).

  Even if this does not fix your problem (you refer to 72k chars, not
  sure how many commands this is), this is probably good to have
  anyway, this decreasing memory consumption by 85%. This will also
  make event reporting (monitor mode) more reliable through netlink
  (it's the same codepath).

  Note that userspace requires no changes to support batching mode:
  libmnl's mnl_cb_run() keeps iterating over the buffer that was
  received until all netlink messages are consumed.

  The quick patch is incomplete, I just want to prove the saving in
  terms of memory. I'll give it another spin and submit this for
  review.

* Probably recover the cookie idea: firewalld specifies a cookie
  that identifies the rule from userspace, so there is no need for
  NLM_F_ECHO. Eric mentioned he would like to delete rules by cookie,
  this should be possible by looking up for the handle from the
  cookie to delete rules. The cookie is stored in NFTA_RULE_USERDATA
  so this is only meaningful to userspace. No kernel changes are
  required (this is supported for a bit of time already).

  Note: The cookie could be duplicated. Since the cookie is allocated
  by userspace, it's up to userspace to ensure uniqueness. In case
  cookies are duplicated, if you delete a rule by cookie then

  Rule deletion by cookie requires dumping the whole ruleset though
  (slow). However, I think firewalld keeps a rule cache, so it uses
  the rule handle to delete the rule instead (no need to dump the
  cache then). Therefore, the cookie is only used to fetch the rule
  handle.

  With the rule cookie in place, firewalld can send the batch, then
  make a NLM_F_DUMP request after sending the batch to retrieve the
  handle from the cookie instead of using NLM_F_ECHO. The batch send +
  NLM_F_DUMP barely consumes 16KBytes per recvmsg() call. The send +
  dump is not atomic though.

  Because NLM_F_ECHO is only used to get back the rule handle, right?
