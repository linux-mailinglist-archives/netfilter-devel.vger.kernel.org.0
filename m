Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D52AD198
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Nov 2020 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJIsP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Nov 2020 03:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgKJIsP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604998093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arjHCPlBEDuR8rSzREf+BlIUonpkRpzcvVzFwoXgIGM=;
        b=QdSo2Jb8X1icu6712UOX8WNXR81m8mhqzgVt1qFoLMUas2V6LPsabKUGHp5ga4NLlcsiF8
        E8SC1LCuIkEaNfyj6Zfk5/ZWMelgIdu1jxlQGw41EZFsEKExzN1aWAQ1EZ6oS/1B1hOjn/
        DduZ1F+Cu9Lv/0uMkvKn4rZh4Oi4X0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-NA6N2vbkNRKaf8LbsCAfNQ-1; Tue, 10 Nov 2020 03:48:11 -0500
X-MC-Unique: NA6N2vbkNRKaf8LbsCAfNQ-1
Received: by mail-wm1-f70.google.com with SMTP id 8so443805wmg.6
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Nov 2020 00:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arjHCPlBEDuR8rSzREf+BlIUonpkRpzcvVzFwoXgIGM=;
        b=YsGy4UFGN3227AcfuUcgpdGLPTgRlPZbP/gIcyoPGXvScNcxEj2cTWQ4pvSS5YccAa
         xQuxt4o273e0IwA8r+SSQtXthViAlLsEOc9BhwORD5PoBDYLZnPoAE/XW5EJDzAOtJKW
         G4gQk1jRwLUpqIWolqSFEyiRJS+oASJFKUHTVgZp/RuNNmHhNLHz7iDekqTuMzj9MBrx
         nUyTRuUXp1JDhCfqVqKcx1o8wkxkLz+lPXhBGK9ERew4q5umHKnGtFZPyXPZA4t7bgVM
         mceJLDBsxpjBl65frUH195SDT7eiyTiR1JNaKw6mSXlrCi0acX7hDly2/URp3ftJl0V+
         KZjQ==
X-Gm-Message-State: AOAM530hLste0SAz7bLgBrfthx597VXgLf9KC+CWfZixAuS1u2zJatkk
        9gyJqRF6eHxItnUJq6sdIFww/SLHHnAEd1UJsTINNvq1t5L57aZrlDmy2FBSPbo1CZ5QfMQDDGk
        INpZ91AOYRe6LJKi0nq2c+BfJBQraWQCv0uKendbdLlbD
X-Received: by 2002:a05:600c:2cb4:: with SMTP id h20mr3462037wmc.119.1604998090413;
        Tue, 10 Nov 2020 00:48:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMSyb8OkNRE3T1JGs1r3ka/msK6DDLRuyEE0GNqP0f8/5qr1Y9l2p7meE6KzUHF99t5Ov1mNtYgeCXVEf/6M0=
X-Received: by 2002:a05:600c:2cb4:: with SMTP id h20mr3462022wmc.119.1604998090204;
 Tue, 10 Nov 2020 00:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20201109072930.14048-1-nusiddiq@redhat.com> <20201109213557.GE23619@breakpoint.cc>
In-Reply-To: <20201109213557.GE23619@breakpoint.cc>
From:   Numan Siddique <nusiddiq@redhat.com>
Date:   Tue, 10 Nov 2020 14:17:58 +0530
Message-ID: <CAH=CPzqTy3yxgBEJ9cVpp3pmGN9u4OsL9GrA+1w6rVum7B8zJw@mail.gmail.com>
Subject: Re: [net-next] netfiler: conntrack: Add the option to set ct tcp flag
 - BE_LIBERAL per-ct basis.
To:     Florian Westphal <fw@strlen.de>
Cc:     ovs dev <dev@openvswitch.org>, netdev <netdev@vger.kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:06 AM Florian Westphal <fw@strlen.de> wrote:
>
> nusiddiq@redhat.com <nusiddiq@redhat.com> wrote:
> > From: Numan Siddique <nusiddiq@redhat.com>
> >
> > Before calling nf_conntrack_in(), caller can set this flag in the
> > connection template for a tcp packet and any errors in the
> > tcp_in_window() will be ignored.
> >
> > A helper function - nf_ct_set_tcp_be_liberal(nf_conn) is added which
> > sets this flag for both the directions of the nf_conn.
> >
> > openvswitch makes use of this feature so that any out of window tcp
> > packets are not marked invalid. Prior to this there was no easy way
> > to distinguish if conntracked packet is marked invalid because of
> > tcp_in_window() check error or because it doesn't belong to an
> > existing connection.
> >
> > An earlier attempt (see the link) tried to solve this problem for
> > openvswitch in a different way. Florian Westphal instead suggested
> > to be liberal in openvswitch for tcp packets.
> >
> > Link: https://patchwork.ozlabs.org/project/netdev/patch/20201006083355.121018-1-nusiddiq@redhat.com/
> >
> > Suggested-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Numan Siddique <nusiddiq@redhat.com>
> > ---
> >  include/net/netfilter/nf_conntrack_l4proto.h |  6 ++++++
> >  net/netfilter/nf_conntrack_core.c            | 13 +++++++++++--
> >  net/openvswitch/conntrack.c                  |  1 +
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/netfilter/nf_conntrack_l4proto.h b/include/net/netfilter/nf_conntrack_l4proto.h
> > index 88186b95b3c2..572ae8d2a622 100644
> > --- a/include/net/netfilter/nf_conntrack_l4proto.h
> > +++ b/include/net/netfilter/nf_conntrack_l4proto.h
> > @@ -203,6 +203,12 @@ static inline struct nf_icmp_net *nf_icmpv6_pernet(struct net *net)
> >  {
> >       return &net->ct.nf_ct_proto.icmpv6;
> >  }
> > +
> > +static inline void nf_ct_set_tcp_be_liberal(struct nf_conn *ct)
> > +{
> > +     ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
> > +     ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_NF_CT_PROTO_DCCP
> > diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> > index 234b7cab37c3..8290c5b04e88 100644
> > --- a/net/netfilter/nf_conntrack_core.c
> > +++ b/net/netfilter/nf_conntrack_core.c
> > @@ -1748,10 +1748,18 @@ static int nf_conntrack_handle_packet(struct nf_conn *ct,
> >                                     struct sk_buff *skb,
> >                                     unsigned int dataoff,
> >                                     enum ip_conntrack_info ctinfo,
> > -                                   const struct nf_hook_state *state)
> > +                                   const struct nf_hook_state *state,
> > +                                   union nf_conntrack_proto *tmpl_proto)
>
> I would prefer if we could avoid adding yet another function argument.
>
> AFAICS its enough to call the new nf_ct_set_tcp_be_liberal() helper
> before nf_conntrack_confirm() in ovs_ct_commit(), e.g.:

Thanks for the comments. I actually tried this approach first, but it
doesn't seem to work.
I noticed that for the committed connections, the ct tcp flag -
IP_CT_TCP_FLAG_BE_LIBERAL is
not set when nf_conntrack_in() calls resolve_normal_ct().

Would you expect that the tcp ct flags should have been preserved once
the connection is committed ?

Thanks
Numan

>
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -1235,10 +1235,13 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
>         if (!nf_ct_is_confirmed(ct)) {
>                 err = ovs_ct_init_labels(ct, key, &info->labels.value,
>                                          &info->labels.mask);
>                 if (err)
>                         return err;
> +
> +               if (nf_ct_protonum(ct) == IPPROTO_TCP)
> +                       nf_ct_set_tcp_be_liberal(ct);
>

