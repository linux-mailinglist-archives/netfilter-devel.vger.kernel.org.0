Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD655246A6
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 May 2022 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350752AbiELHQ3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 May 2022 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350861AbiELHQ2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 May 2022 03:16:28 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D8F369C0;
        Thu, 12 May 2022 00:16:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba17so5152227edb.5;
        Thu, 12 May 2022 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1XETfrWvgpDK6xvPqjYv9ph4oVJcRFnO6XHZ6bvIog=;
        b=k0bltUDkLQwIX8L12eIhCxHgg32+k8KxhAOGtblJOOq2W1wolhxlhMDQNWu63Fj3Ez
         nHvEnceXeaPxvSa6DDTmEeurVbMiENrRps85RrpmnOULv2UGAbV7ZPS/tnjAMqmbj8FO
         0mTyxMFk9DIs5pVyd70820mlw6os1YT/vFrDVwCkniG2hkJ1X5dw7xS2sl8srdMOumYQ
         hO+/gZI0b1mLBCf7eyCqIWvB30u9jUV94/N2rY+mKHHmjlLCzSVMkZ1/rpWucezwlila
         1OWoooaATajmucRphfoLUbdPaOreXFBsph++a5sqR4aIF/lQ8UkCg1TTn0jrPBqr37/o
         xSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1XETfrWvgpDK6xvPqjYv9ph4oVJcRFnO6XHZ6bvIog=;
        b=7LPTtHI9XB68gQWr46M1yYplEPgxyc8AXgTVIHOh2F+JQtpjXdnTS/0onjpzYMI+sm
         A/B2ChjC0y3Rni5mlHxKQYqXY5JRX0ZhOX6mJcGsHMxhdcy35KUUSybl/cPF6alEada2
         zOovdd6JABN2GvQodfobiLJEChvxbSeOwKuKY5DmF+7rP6+wjvunb5rSZRNwe+5J0olG
         wzB4/qb7S3Y4xXAXbFpVBY84PpeqQ528WsnD3yx/oRQADtBfSVY05VeDlC2u7yiWrkjU
         e3ixp34rTNl/hyiRzfNmakE+oiogEydr3k+7UyPbETFpPNhqEp416SmruBXoYMoM3c2M
         qkRw==
X-Gm-Message-State: AOAM533Mcfd9spKV7sIvn6BA89pKVbbHO8droNom8y2o4Rj7KLJFbmLC
        QRFduQR4Q+Y4vjxHwRc0ocPpQfMXT42tcANiOTS2/Nv5Mfrf5A==
X-Google-Smtp-Source: ABdhPJwO9qh++KU/aQdVtD5XEDmaET+9KGnIleSzf3MMwailYVjG+Prsw/4NNQPKwHt6nJ5z3eESYmUTRdRdMNPbEhU=
X-Received: by 2002:a05:6402:3586:b0:427:b16e:a191 with SMTP id
 y6-20020a056402358600b00427b16ea191mr33769508edc.137.1652339785296; Thu, 12
 May 2022 00:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220510074301.480941-1-imagedong@tencent.com> <8983fedf-5095-59a4-b4b3-83f1864be055@ssi.bg>
In-Reply-To: <8983fedf-5095-59a4-b4b3-83f1864be055@ssi.bg>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 12 May 2022 15:16:13 +0800
Message-ID: <CADxym3aREm=ZPucm=C6ZRnPbQJMvCxkcnKge2EAcy-Rs0CTtfg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: ipvs: randomize starting destination of
 RR/WRR scheduler
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Hao Peng <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 11, 2022 at 5:51 AM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,
>
> On Tue, 10 May 2022, menglong8.dong@gmail.com wrote:
>
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > For now, the start of the RR/WRR scheduler is in order of added
> > destinations, it will result in imbalance if the director is local
> > to the clients and the number of connection is small.
> >
> > For example, we have client1, client2, ..., client100 and real service
> > service1, service2, ..., service10. All clients have local director with
> > the same ipvs config, and each of them will create 2 long TCP connect to
> > the virtual service. Therefore, all the clients will connect to service1
> > and service2, leaving others free, which will make service1 and service2
> > overloaded.
>
>         More time I spend on this topic, I'm less
> convinced that it is worth the effort. Randomness can come
> from another place: client address/port. Schedulers
> like MH and SH probably can help for such case.
> RR is so simple scheduler that I doubt it is used in
> practice. People prefer WLC, WRR and recently MH which
> has many features:
>
> - lockless
> - supports server weights
> - safer on dest adding/removal or weight changes
> - fallback, optional
> - suitable for sloppy TCP/SCTP mode to avoid the
> SYNC mechanism in active-active setups
>

Yeah, WLC and MH are excellent schedulers. As for SH, my
fellows' feedback says that it doesn't work well. In fact, it's their
fault, they just forget to enable port hash and just use the
default ip hash. With my direction, this case is solved by sh.

Now, I'm not sure if this feature is necessary. Maybe someone
needs it? Such as someone, who need RR/WRR and a random
start......

Anyway, I have made a V3 according to your advice. I can
send it with any positive reply :/


Thanks for your direction
Menglong Dong

> > Fix this by randomizing the starting destination when
> > IP_VS_SVC_F_SCHED_RR_RANDOM/IP_VS_SVC_F_SCHED_WRR_RANDOM is set.
> >
> > I start the randomizing from svc->destinations, as we choose the starting
> > destination from all of the destinations, so it makes no different to
> > start from svc->sched_data or svc->destinations. If we start from
> > svc->sched_data, we have to avoid the 'head' node of the list being the
> > next node of svc->sched_data, to make the choose totally random.
>
>         Yes, first dest has two times more chance if we do
> not account the head.
>
> > Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> > Reviewed-by: Hao Peng <flyingpeng@tencent.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v2:
> > - randomizing the starting of WRR scheduler too
> > - Replace '|' with '&' in ip_vs_rr_random_start(Julian Anastasov)
> > - Replace get_random_u32() with prandom_u32_max() (Julian Anastasov)
> > ---
> >  include/uapi/linux/ip_vs.h     |  3 +++
> >  net/netfilter/ipvs/ip_vs_rr.c  | 25 ++++++++++++++++++++++++-
> >  net/netfilter/ipvs/ip_vs_wrr.c | 20 ++++++++++++++++++++
> >  3 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
> > index 4102ddcb4e14..9543906dae7d 100644
> > --- a/include/uapi/linux/ip_vs.h
> > +++ b/include/uapi/linux/ip_vs.h
> > @@ -28,6 +28,9 @@
> >  #define IP_VS_SVC_F_SCHED_SH_FALLBACK        IP_VS_SVC_F_SCHED1 /* SH fallback */
> >  #define IP_VS_SVC_F_SCHED_SH_PORT    IP_VS_SVC_F_SCHED2 /* SH use port */
> >
> > +#define IP_VS_SVC_F_SCHED_WRR_RANDOM IP_VS_SVC_F_SCHED1 /* random start */
> > +#define IP_VS_SVC_F_SCHED_RR_RANDOM  IP_VS_SVC_F_SCHED1 /* random start */
> > +
> >  /*
> >   *      Destination Server Flags
> >   */
> > diff --git a/net/netfilter/ipvs/ip_vs_rr.c b/net/netfilter/ipvs/ip_vs_rr.c
> > index 38495c6f6c7c..d53bfaf7aadf 100644
> > --- a/net/netfilter/ipvs/ip_vs_rr.c
> > +++ b/net/netfilter/ipvs/ip_vs_rr.c
> > @@ -22,13 +22,36 @@
> >
> >  #include <net/ip_vs.h>
> >
> > +static void ip_vs_rr_random_start(struct ip_vs_service *svc)
> > +{
> > +     struct list_head *cur;
> > +     u32 start;
> > +
> > +     if (!(svc->flags & IP_VS_SVC_F_SCHED_RR_RANDOM) ||
> > +         svc->num_dests <= 1)
> > +             return;
> > +
> > +     start = prandom_u32_max(svc->num_dests);
> > +     spin_lock_bh(&svc->sched_lock);
> > +     cur = &svc->destinations;
> > +     while (start--)
> > +             cur = cur->next;
> > +     svc->sched_data = cur;
> > +     spin_unlock_bh(&svc->sched_lock);
> > +}
> >
> >  static int ip_vs_rr_init_svc(struct ip_vs_service *svc)
> >  {
> >       svc->sched_data = &svc->destinations;
> > +     ip_vs_rr_random_start(svc);
> >       return 0;
> >  }
> >
> > +static int ip_vs_rr_add_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest)
> > +{
> > +     ip_vs_rr_random_start(svc);
> > +     return 0;
> > +}
> >
> >  static int ip_vs_rr_del_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest)
> >  {
> > @@ -104,7 +127,7 @@ static struct ip_vs_scheduler ip_vs_rr_scheduler = {
> >       .module =               THIS_MODULE,
> >       .n_list =               LIST_HEAD_INIT(ip_vs_rr_scheduler.n_list),
> >       .init_service =         ip_vs_rr_init_svc,
> > -     .add_dest =             NULL,
> > +     .add_dest =             ip_vs_rr_add_dest,
> >       .del_dest =             ip_vs_rr_del_dest,
> >       .schedule =             ip_vs_rr_schedule,
> >  };
> > diff --git a/net/netfilter/ipvs/ip_vs_wrr.c b/net/netfilter/ipvs/ip_vs_wrr.c
> > index 1bc7a0789d85..ed6230976379 100644
> > --- a/net/netfilter/ipvs/ip_vs_wrr.c
> > +++ b/net/netfilter/ipvs/ip_vs_wrr.c
> > @@ -102,6 +102,24 @@ static int ip_vs_wrr_max_weight(struct ip_vs_service *svc)
> >       return weight;
> >  }
> >
> > +static void ip_vs_wrr_random_start(struct ip_vs_service *svc)
> > +{
> > +     struct ip_vs_wrr_mark *mark = svc->sched_data;
> > +     struct list_head *cur;
> > +     u32 start;
> > +
> > +     if (!(svc->flags & IP_VS_SVC_F_SCHED_WRR_RANDOM) ||
> > +         svc->num_dests <= 1)
> > +             return;
> > +
> > +     start = prandom_u32_max(svc->num_dests);
> > +     spin_lock_bh(&svc->sched_lock);
> > +     cur = &svc->destinations;
> > +     while (start--)
> > +             cur = cur->next;
> > +     mark->cl = list_entry(cur, struct ip_vs_dest, n_list);
>
>         The problem with WRR is that mark->cl and mark->cw
> work together, we can not change just cl.
>
> > +     spin_unlock_bh(&svc->sched_lock);
> > +}
> >
> >  static int ip_vs_wrr_init_svc(struct ip_vs_service *svc)
> >  {
> > @@ -119,6 +137,7 @@ static int ip_vs_wrr_init_svc(struct ip_vs_service *svc)
> >       mark->mw = ip_vs_wrr_max_weight(svc) - (mark->di - 1);
> >       mark->cw = mark->mw;
> >       svc->sched_data = mark;
> > +     ip_vs_wrr_random_start(svc);
> >
> >       return 0;
> >  }
> > @@ -149,6 +168,7 @@ static int ip_vs_wrr_dest_changed(struct ip_vs_service *svc,
> >       else if (mark->di > 1)
> >               mark->cw = (mark->cw / mark->di) * mark->di + 1;
> >       spin_unlock_bh(&svc->sched_lock);
> > +     ip_vs_wrr_random_start(svc);
>
>         This will be called even on upd_dest (while processing
> packets), so the region under lock should be short and cl/cw
> state should not be damaged.
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>
>
