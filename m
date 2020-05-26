Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5C1BE6D0
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2020 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD2TAZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Apr 2020 15:00:25 -0400
Received: from correo.us.es ([193.147.175.20]:56548 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2TAZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:00:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 814734A7066
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2020 21:00:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6F0C8BAABA
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2020 21:00:23 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 64783BAAB5; Wed, 29 Apr 2020 21:00:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4612F20661
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2020 21:00:21 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 29 Apr 2020 21:00:21 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 27E4142EF9E0
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2020 21:00:21 +0200 (CEST)
Date:   Wed, 29 Apr 2020 21:00:20 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue 0/3] pktbuff API updates
Message-ID: <20200429190020.GA16096@salvia>
References: <20200426132356.8346-1-pablo@netfilter.org>
 <20200427110614.GA15436@dimstar.local.net>
 <20200427170656.GA22296@salvia>
 <20200428043302.GB15436@dimstar.local.net>
 <20200428103407.GA1160@salvia>
 <20200428211452.GF15436@dimstar.local.net>
 <20200428225520.GA30421@salvia>
 <20200429132840.GA3833@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429132840.GA3833@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:28:40PM +1000, Duncan Roe wrote:
> On Wed, Apr 29, 2020 at 12:55:20AM +0200, Pablo Neira Ayuso wrote:
> > On Wed, Apr 29, 2020 at 07:14:52AM +1000, Duncan Roe wrote:
> > > On Tue, Apr 28, 2020 at 12:34:07PM +0200, Pablo Neira Ayuso wrote:
> > [...]
> > > > pktb_alloc2() still has a memcpy which is not needed by people that do
> > > > not need to mangle the packet.
> > >
> > > No it does not. Please look again. There is only a memcpy if the caller
> > > specifies extra > 0, in which case she clearly intends to mangle it (perhaps
> > > depending on its contents).
> >
> > Right, it only happens if extra is specified.
> >
> > +       if (extra) {
> > +               pkt_data = buf;
> > +               memcpy(pkt_data, data, len);
> > +               memset((uint8_t *)pkt_data + len, 0, extra);
> > +       } else {
> > +               pkt_data = data;
> > +       }
> >
> > So buf is only used if extra is specified?
> 
> Yes, that's right.

OK. Then, the user must pass the buf only if extra is set on.

> > > Yes it's more complex. No problem with the buffer - the user gave that to
> > > pktb_alloc2().
> >
> > I'm just hesitating about the new pktb_alloc2() approach because it
> > has many parameters, it's just looks a bit complicated to me (this
> > function takes 8 parameters).
> 
> It has the original 4 from pktb_alloc() plus 2 {buffer, size} pairs. It could
> have been just one pair, with packet data appended to metadata as in
> pktb_alloc() but I thought it would be really awkward to document how to
> dimension it.

I'm starting to think this function is hard to document, too many
parameters.

> I think we should not be usurping the data pointer of mnl_cb_run().
> I can see people wanting to use it to pass a pointer to e.g. some
> kind of database that callbacks need to access. There's no
> performance gain to recycling the buffer: the CB doesn't need to
> call pktb_head_size() on every invocation, that can be done once by
> main() e.g.
> 
>  static size_t sizeof_head;
>  ...
>  int main(int argc, char *argv[])
>  {
>  ...
>          sizeof_head = pktb_head_size(); /* Avoid multiple calls in CB */
>  ...
>  static int queue_cb(const struct nlmsghdr *nlh, void *data)
>  {
>          char head[sizeof_head];

You might also declare the pre-allocated pkt_buff as a global if you
don't want to use the data pointer in mnl_cb_run().

static struct pkt_buff *pkt;

int main(int argc, char *argv[])
{
        ...
        pkt = pktb_head_alloc();
        ...
}

Then, use it from queue_cb().

Alternatively, you can also define a wrapper structure that you can
pass to mnl_cb_run(), e.g.

struct my_data {
        struct pkt_buff *pktb;
        void            *something_ese;
};

> > My understanding is that requirements are:
> >
> > * Users that do not want to mangle the packet, they use the buffer
> >   that was passed to recvmsg().
> > * Users that want to mangle the packet, they use the _mangle()
> >   function that might reallocate the data buffer (the one you would
> >   like to have). However, if this data buffer reallocation happens,
> >   then pkt_buff should annotate that this pkt_buff object needs to
> >   release this data buffer from pktb_free() otherwise.
> 
> No, there is nothing to release. We told pktb_alloc2() where the buffer was,
> it's on the stack (usually).

Then, I'm not sure I understand yet what extension you would like to
make to _mangle(), please, clarify.

> > > Problem is that if mangler moves the packet, then any packet pointer the caller
> > > had is invalid (points to the un-mangled copy). This applies at all levels, e.g.
> > > nfq_udp_get_payload(). There is no way for the mangler functions to address
> > > this: it just has to be highlighted in the documentation.
> >
> > That's fine, this is exactly how the kernel works: if the function
> > might reallocate the data area, then you have to refetch pointers
> > after this. If you teach _mangle() to do reallocations, then
> > documenting this is fine.
> >
> > However, those reallocation need pktb_free() to release that new data
> > buffer, right?
> 
> No way. There is no malloc() nor free() anywhere. The data buffer is
> (recommended to be) on the stack; for running under gdb it may be preferred to
> us a static buffer which has to be dimensioned hugely.

If the user pre-allocates the heap or place it in the stack is
irrelevant, the save for the user is the memcpy() if it's only
inspecting the packet (no mangling) and the out-of-line pkt_buff
allocation / or place in the stack.

If pktb_build_data() takes the extra parameter, I think the
showstopper you mentioned is gone. Otherwise, please tell me what you
cannot achieve with my patchset.

Thanks.
