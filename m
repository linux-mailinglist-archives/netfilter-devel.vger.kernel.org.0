Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3193DA74B
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jul 2021 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhG2PRH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Jul 2021 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhG2PRG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:17:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24015C061765
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Jul 2021 08:17:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h14so11679189lfv.7
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Jul 2021 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oz/02ML48+DN3KWaK8em4QBBmfeu6b4Rgvz7+TNevjI=;
        b=kze5sZifSV5YhAMChuDZ/5ObwtsemRmzIVepudZ5hsDRXYsEwGtF4JFBJQ+A4FXNTS
         XcuImPaJ9F359lyoMUAHw5zD67889p5dp+hitNa2a59V3PCrXuK5NR/7aIfcwJ7x68hL
         m5R9UuoT3VNmXi+lwRmVb1quS805rBVPGBGlrW+Mz86qT1b2W4q0+n5138rxib+IEKbA
         ktWMxFCiwIJYlnYM+uCi8E2ulWENacaCEer7lM7Zcz/KaOpAW0FBZxV0W6EtV/Znb8pH
         Q82DSzdcUg+h44rsoV+SiqUX3NWQ4NUpdN/zVbFzuYDIYqWppJS2kTZr2n0AtIzGJhsM
         tonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oz/02ML48+DN3KWaK8em4QBBmfeu6b4Rgvz7+TNevjI=;
        b=WkrdWvyKnhhk8adKYQzOIzOwVmLiNqulP8+3HIVOVFs/EDFNXLC/3MAsSYhVrAQK6g
         zQrksnQAmGUm93fUmxOK7JW8oseNUEnb7pc7tnOPGXQ5QOvPl0LnK7eLcTGDR22XkVsX
         hV7cmnmai7kHZgMEfwxQGJd2ZBjqd3E7SKdsFMWEXfWBIpOzbz+qwb+uljbErvKYK73R
         VKOBUnB419/GojXpH34JA/8Tl3Jjy1yClL5BqIGH8swkF7sme8vZBwyaaRwzrMXpntR6
         OFO4DtMTymZ0T8DoDrDu7xghCY4iMxb9Wk36RRQrZ+at/Wl6m/Y0o/IJ/OaQlm3CsVda
         Ii/A==
X-Gm-Message-State: AOAM533Ttiq0z3QGcr1toJnRhwrgc1HSO8n/tf4U7liasY4TSTZrGSlK
        3L4yWvA7qpk+tpJDD+n24TUzqGHHy/gt5yo/KuQ=
X-Google-Smtp-Source: ABdhPJz0LaILidxJd3t44i9z2d3rf1Ogu8dtCyT1o93QCb6pEJoE8bqvfn3mHU6CjvxJ+6chw98fohuevCXoVCG8II0=
X-Received: by 2002:a19:6f07:: with SMTP id k7mr4156367lfc.86.1627571821397;
 Thu, 29 Jul 2021 08:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210727153741.14406-1-pablo@netfilter.org> <20210727153741.14406-2-pablo@netfilter.org>
 <CAGnHSE=e-iYaz3KOMBq1JSVRd0HTL=TKQ_HHMadfyd2Nr8__yg@mail.gmail.com>
 <20210727210503.GA15429@salvia> <CAGnHSEn_oyCqrUoNgKZyE3sO--5RMqkGhepGobSjGKTz1-0=vQ@mail.gmail.com>
 <20210729070345.GB15962@salvia> <CAGnHSEkfh57NqD2LJYKBjOXT+6kgvya67nfv0ZtaNnwsNg3diQ@mail.gmail.com>
 <CAGnHSEnGV=uFkMLWMc8ZXJ_cQUmPFtBBoMNOAYmU+dhZkda=Yw@mail.gmail.com>
In-Reply-To: <CAGnHSEnGV=uFkMLWMc8ZXJ_cQUmPFtBBoMNOAYmU+dhZkda=Yw@mail.gmail.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Thu, 29 Jul 2021 23:16:50 +0800
Message-ID: <CAGnHSE=hrCJUh109-r3NipZxXj0=bWSVwrVZ68_hxWeMfx0z6w@mail.gmail.com>
Subject: Re: [PATCH nft 2/3] netlink_linearize: incorrect netlink bytecode
 with binary operation and flags
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I've written sort of a specification / the grammar of how things
should be. See if it helps you see my point and if you can find any
problem in it:

spec/grammar for comma-separated list

definition: string representation of *one or more* bits, separated by comma
example: syn fin,rst,ack
meaning (of the comma): bitwise or

When a list is matched against, the value of the list is compared
against. Therefore the following are equivalent:

tcp flags syn
tcp flags == syn

And these are equivalent:

tcp flags fin,rst,ack
tcp flags == (fin | rst | ack)

The behavior of the matching / the meaning of a list *remains the
same* when a mask is applied, hence these are also equivalent:

tcp flags & syn syn
tcp flags & syn == syn

And so are these:

tcp flags & (fin | rst | ack) fin,rst,ack
tcp flags & (fin | rst | ack) == fin,rst,ack
tcp flags & (fin | rst | ack) == (fin | rst | ack)
tcp flags & (fin | rst | ack) (fin | rst | ack)

They can be represented in an alternative "value_in_list_form /
mask_in_list_form":

tcp flags syn / syn
tcp flags fin,rst,ack / fin,rst,ack

The behavior of the matching / the meaning of a list *remains the
same* when the operator is !=. So these are equivalent:

tcp flags != syn / syn
tcp flags & syn != syn

So are these:

tcp flags != fin,rst,ack / fin,rst,ack
tcp flags & (fin | rst | ack) != (fin | rst | ack)
tcp flags & (fin | rst | ack) != fin,rst,ack

Note that != is not the same as !. What the latter means is, the
specified list is used as the mask and the output will be compared
with 0. So these are equivalent:

tcp flags ! syn
tcp flags & syn == 0

So are these:

tcp flags ! fin,rst,ack
tcp flags & (fin | rst | ack) == 0

Note that ! cannot be used on / with a mask. Therefore:

tcp flags ! syn / syn
tcp flags syn / ! syn
tcp flags & ! syn syn
tcp flags & syn ! syn
...

tcp flags ! fin,rst,ack / fin,rst,ack
tcp flags fin,rst,ack / ! fin,rst,ack
tcp flags & ! (fin, rst, ack) fin,rst,ack
tcp flags & (fin, rst, ack) ! fin,rst,ack
...

are all invalid.

Also, there is no simplified / shortcut form for:

tcp flags & syn != 0
tcp flags & (fin | rst | ack) != 0

Although the first one is *inheritly* (i.e. by nature) equivalent to:

tcp flags & syn == syn
tcp flags & syn syn
tcp flags syn / syn

On Thu, 29 Jul 2021 at 18:58, Tom Yan <tom.ty89@gmail.com> wrote:
>
> Allow me to add one more supplement to what I just wrote, as you/some
> might say something like "but allowing `ct state related,established`
> to work as expected is intuitive and neat".
>
> Consider this:
>
> # nft --debug=netlink add rule meh tcp_flags 'ct state == new,established'
> ip
>   [ ct load state => reg 1 ]
>   [ cmp eq reg 1 0x0000000a ]
>
> # nft list ruleset
> table ip meh {
>     chain tcp_flags {
>         ct state established | new
>     }
> }
>
> If `ct state new,established` is interpreted to be the same as `ct
> state == new,established`, at least we *will know* that we should use
> `ct state { new, established }` instead. But when it is not, we can
> only *suppose* it to be *practically* the same as it. (I'm quite sure
> many people think like, "nft is just not completed/smart enough yet to
> be able to omit the redundant curly braces"...)
>
> On Thu, 29 Jul 2021 at 18:41, Tom Yan <tom.ty89@gmail.com> wrote:
> >
> > I was quite overwhelmed by the whole thing, so I might not have made
> > my point clear.
> >
> > While I find e.g. `tcp flags fin,ack,rst` being not the same as `tcp
> > flags { fin, ack, rst }` confusing, in this case it is still
> > "reasonable", as we can say that in the former it is a
> > "comma-separated list" (hence no space), while in the latter it is a
> > set (hence the spaces).
> >
> > The real issue here is that a comma-separated list itself can have
> > totally different meanings. For example,
> >
> > 1. If (just) `fin,rst,ack`, it means "any of the bits set".
> > 2. If `== fin,rst,ack`, it means (fin | rst | ack)
> > 3. If `fin,rst,ack / fin,rst,ack`, it means (fin | rst | ack). *(For
> > both the value and the mask)*
> > 4. If `== fin,rst,ack / fin,rst,ack`, it means (fin | rst | ack).
> > *(For both the value and the mask)*
> >
> > So how could anyone have thought in the first case `fin,rst,ack` does
> > not have the same meaning as it does in the other cases? That's what I
> > would call "unreasonable". Also, if in any case e.g. (just) `syn` is
> > not considered a (single-value) "comma-separated list", it's
> > "unreasonable" as well.
> >
> > Or in other words, I don't find a behavior/shortcut like, "if a mask
> > is not specified explicitly, a mask that is equal to the value is
> > implied, yet not when we compare the value (e.g. ==)", sensible /
> > sensical. (Would anyone?)
> >
> > And you know what, comparing this with the `ct state` is unfair. The
> > fact that you did so sort of explains why we end up in this...mess.
> > (Not trying to say it's your fault but rather, how the issue could
> > have happened.)
> >
> > In the case of `ct state`, while we use the different bits for the
> > states, the states themselves are mutually exclusive (AFAIK, e.g. a
> > packet can't be new and established at the same time). People assume
> > e.g. `related,established` to be *practically* equivalent to `{
> > related, established }` not because they would think like, "generally
> > a comma-separated list should mean any of states", but either because
> > they know in advance a packet can only be of either, or, they assume
> > such similar syntax should mean the same thing. (The truth is, `ct
> > state related,established` is NOT *logically* the same as `ct state {
> > related, established }`; the former will be true for a packet if its
> > state can be / is related | established.)
> >
> > On Thu, 29 Jul 2021 at 15:03, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > >
> > > On Thu, Jul 29, 2021 at 09:48:21AM +0800, Tom Yan wrote:
> > > > I'm not sure it's just me or you that are missing something here.
> > > >
> > > > On Wed, 28 Jul 2021 at 05:05, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > >
> > > > > On Wed, Jul 28, 2021 at 02:36:18AM +0800, Tom Yan wrote:
> > > > > > Hmm, that means `tcp flags & (fin | syn | rst | ack) syn` is now
> > > > > > equivalent to 'tcp flags & (fin | syn | rst | ack) == syn'.
> > > > >
> > > > > Yes, those two are equivalent.
> > > > >
> > > > > > Does that mean `tcp flags syn` (was supposed to be and) is now
> > > > > > equivalent to `tcp flags == syn`
> > > > >
> > > > > tcp flag syn
> > > > >
> > > > > is a shortcut to match on the syn bit regarless other bit values, it's
> > > > > a property of the bitmask datatypes.
> > > >
> > > > Don't you think the syntax will be inconsistent then? As a user, it
> > > > looks pretty irrational to me: with a mask, just `syn` checks the
> > > > exact value of the flags (combined); without a mask, it checks and
> > > > checks only whether the specific bit is on.
> > > >
> > > > At least to me I would then expect `tcp flags syn` should be
> > > > equivalent / is a shortcut to `tcp flags & (fin | syn | rst | psh |
> > > > ack | urg | ecn | cwr) syn` hence `tcp flags & (fin | syn | rst | psh
> > > > | ack | urg | ecn | cwr) == syn` hence `tcp flags == syn`.
> > >
> > > As I said, think of a different use-case:
> > >
> > >         ct state new,established
> > >
> > > people are _not_ expecting to match on both flags to be set on (that
> > > will actually never happen).
> > >
> > > Should ct state and tcp flags use the same syntax (comma-separated
> > > values) but intepret things in a different way? I don't think so.
> > >
> > > You can use:
> > >
> > >         nft describe ct state
> > >
> > > to check for the real datatype behind this selector: it's a bitmask.
> > > For this datatype the implicit operation is not ==.
> > >
> > > > > tcp flags == syn
> > > > >
> > > > > is an exact match, it checks that the syn bit is set on.
> > > > >
> > > > > > instead of `tcp flags & syn == syn` / `tcp flags & syn != 0`?
> > > > >
> > > > > these two above are equivalent, I just sent a patch to fix the
> > > > > tcp flags & syn == syn case.
> > > > >
> > > > > > Suppose `tcp flags & syn != 0` should then be translated to `tcp flags
> > > > > > syn / syn` instead, please note that while nft translates `tcp flags &
> > > > > > syn == syn` to `tcp flags syn / syn`, it does not accept the
> > > > > > translation as input (when the mask is not a comma-separated list):
> > > > > >
> > > > > > # nft --debug=netlink add rule meh tcp_flags 'tcp flags syn / syn'
> > > > > > Error: syntax error, unexpected newline, expecting comma
> > > > > > add rule meh tcp_flags tcp flags syn / syn
> > > > > >                                           ^
> > > > >
> > > > > The most simple way to express this is: tcp flags == syn.
> > > >
> > > > That does not sound right to me at all. Doesn't `syn / syn` means
> > > > "with the mask (the second/"denominator" `syn`) applied on the flags,
> > > > we get the value (the first/"nominator" `syn`), which means `tcp flags
> > > > & syn == syn` instead of `tcp flags == syn` (which in turn means all
> > > > bits but syn are cleared).
> > >
> > > tcp flags syn / syn makes no sense, it's actually: tcp flags syn.
> > >
> > > The goal is to provide a compact syntax for most common operations, so
> > > users do not need to be mingling with explicit binary expressions
> > > (which is considered to be a "more advanced" operation).
