Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134DA3DE73B
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Aug 2021 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhHCHa5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Aug 2021 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhHCHa4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:30:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4BDC06175F
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Aug 2021 00:30:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p5so24186454wro.7
        for <netfilter-devel@vger.kernel.org>; Tue, 03 Aug 2021 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZtKPo2wlrgg1Bfe2HGwljwrvNxCU+oU5Ns3mlpz+O4=;
        b=TNZp7m7slNFVX/fPfAFpq9P3dKKz9ZgFwy0D+FLdXSs50O46iW37AH0iucunUjdm5H
         fRhQPZab6gl5rcNDKJMVaI2dPhthxXVDtehgp9hJQkCHPH+POPIaDbrnPfWiasD2Z7IB
         WOB5rHjOqF+dtzvkVlz11Oa68L6VBnar7hPKi0SItW9e1gcmcZ7uFyH1l4Sl14ob2igR
         MhZdfOmrAxUTXV5jI8ULOfu9GIH1+4QCJzL2C5zYecpZ1VGD0ga28Il2GZqa51HkQqlH
         bEVnSRnIJyB+HePGG8rCToPqKRALlS34uiL6VDwZrC0nYouf6SXO8IhVpy4t9Kas9OUU
         IT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZtKPo2wlrgg1Bfe2HGwljwrvNxCU+oU5Ns3mlpz+O4=;
        b=IbNNm1GuBKm2Q3yr7FNZ8n/rlF8bAZhNul4LjZcotTsJxKXt+36cAkuX6BnxCNnsgM
         EP7292Tmpbz8kO1LTgJdQEen3tZ3tn3WbmJjGqc+SqPL7GRCz07uaUtACGrGQe5QM9zX
         GaL8wbdLdYW3BOxuZr7RX31k5D8BVU9KjSwMkuFwvN+GysQ0IsmmDfRNcD29VcsKSdLH
         6XyinDQqp/oC/VIkFhcHW3bxhV9ihn+QK2rKGFoeJSOPJD+8n+SqTBSSQIUPv56q/Pis
         fCiBqkdEA7kK4mRi+1hOo/yiakzKcBpyCFPsDntWPtAJrVyLX2OMc7XJfkLEzjYkmOel
         TlJQ==
X-Gm-Message-State: AOAM5329k3bs+G635jqD7tca9ghdY3JJOw/Wx1FalNUe04OUqJ7OdeeP
        6mp0tf4Z17e0rkpwqkM/7oMfTaVx3tI+cMQC1d4=
X-Google-Smtp-Source: ABdhPJx9NJp0Gfo8Zv20AXZ7Hk/iQAY+qYvMxW07mPuZFozalQwQgAeoyNJ9ZkZ3RQ7yHITD8mNDpLGBL7tFfoZD2cc=
X-Received: by 2002:adf:a409:: with SMTP id d9mr21570545wra.237.1627975844506;
 Tue, 03 Aug 2021 00:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAA5aLPirA-gNiYRCoQR6-2fP80ESvvXKu7f0bVPT80FFxua6=g@mail.gmail.com>
 <17a7e7ed-f324-2a94-5f82-18c3850de6a@netfilter.org> <CAA5aLPgQj8wEbawg8u=UqJedTPWCdK5WiizwCpNxMp7Vg=-JgA@mail.gmail.com>
 <e38ddbe-a47-efb1-e56f-457f5e426b18@netfilter.org> <CAA5aLPgowRWm7JZm02LCGeOPz4E_dO+8FCCag+8aO4HDeLUQFQ@mail.gmail.com>
 <CAA5aLPjqFgeDkOjXed=XOHksDZNmQw9EPSkx3pwASKFQ6oioiw@mail.gmail.com>
 <3556be79-66a2-9b12-7b7f-658a618690a8@netfilter.org> <CAA5aLPiO3CQxRwzhEU3tzG5xuLfqgnHN=7evixin68vEf2kH4w@mail.gmail.com>
In-Reply-To: <CAA5aLPiO3CQxRwzhEU3tzG5xuLfqgnHN=7evixin68vEf2kH4w@mail.gmail.com>
From:   Akshat Kakkar <akshat.1984@gmail.com>
Date:   Tue, 3 Aug 2021 13:00:32 +0530
Message-ID: <CAA5aLPh=JiE7M53aSb+dmSZztKhh0HNfVp=8vak=f1nDVEhj5A@mail.gmail.com>
Subject: Re: Nf_nat_h323 module not working with Panasonic VCs
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I feel the bug can be in this section :

/* If the calling party is on the same side of the forward-to party,
 * we don't need to track the second call
 */
static int callforward_do_filter(struct net *net,
const union nf_inet_addr *src,
const union nf_inet_addr *dst,
u_int8_t family)



... where it is wrongly assumed that the calling party is on the same
side of the forward-to party. In case of natting (like a virtual-ip)
and dial-out, the initial call will look to be on the same side but it
is after natting that forward-to party is known. In my case, the
initial call is from 172.16.1.100 to 172.16.1.120 which looks to be on
the same side. But after natting, it changes to 10.1.1.12 which is on
the other side i.e. it becomes a call from 172.16.1.100 to 10.1.1.12.

It's just a wild guess.

On Tue, Aug 3, 2021 at 12:03 PM Akshat Kakkar <akshat.1984@gmail.com> wrote:
>
> My kernel is 4.4.82. It may be demotivating, I know.
>
> However, the logs shared by me, though very less, still shows clearly
> that for Panasonic VC packets the module isn't treating this as a q931
> packet (or cs:connect of h.225) and hence not processed.
>
> As far as output of the command is concerned, there is no .c file with
> that name.
>
> when I try to find files having 323 in the name in /usr/src path using
> following command
>
>         find . -name *323*
>
> Following is the output:
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/linux/netfilter/nf_conntrack_h323.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/linux/netfilter/nf_conntrack_h323_types.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/linux/netfilter/nf_conntrack_h323_asn1.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/linux/i2c/lm8323.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/config/rtc/drv/ds3234.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/config/rtc/drv/ds3232.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/config/nf/conntrack/h323.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/config/nf/nat/h323.h
> ./kernels/4.4.82-1.el7.elrepo.x86_64/include/config/cm3232.h
>
>
> On Mon, Aug 2, 2021 at 11:50 PM Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> >
> > Hi Akshat,
> >
> > On Mon, 2 Aug 2021, Akshat Kakkar wrote:
> >
> > > > For the VC which is working (i.e. VC2, IP:172.16.1.120) following are
> > > > the generated debug log:
> >
> > That can't be the full debug log, lines are missing/left out. What is the
> > kernel version? Isn't there any output from the command
> >
> > $ grep 'pr_debug("nf_ct_q931' net/netfilter/nf_conntrack_h323_main.c
> >
> > > > [Jul27 17:29] nf_nat_q931: expect H.245 172.16.1.100:0->172.16.1.120:5516
> > > > [  +0.249944] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5506
> > > > [  +0.000021] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5507
> > > > [  +0.003265] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5508
> > > > [  +0.000011] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5509
> > > > [  +0.007606] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5506
> > > > [  +0.000012] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5507
> > > > [  +0.000010] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5506
> > > > [  +0.000004] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5507
> > > > [  +0.004337] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5508
> > > > [  +0.000010] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5509
> > > > [  +0.000007] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5508
> > > > [  +0.000007] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5509
> > > > [  +0.006028] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5510
> > > > [  +0.000011] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5511
> > > > [  +0.001171] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5510
> > > > [  +0.000008] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5511
> > > > [  +0.000006] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5510
> > > > [  +0.000003] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5511
> > > > [  +0.003261] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5512
> > > > [  +0.000011] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5513
> > > > [  +0.000006] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5512
> > > > [  +0.000003] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5513
> > > > [  +0.007889] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5512
> > > > [  +0.000012] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5513
> > > >
> > > > However, for the panasonic VC1 i.e. the VC which is having issue,
> > > > there are no debug log generated. absolutely nothing.
> >
> > Best regards,
> > Jozsef
> >
> > > > On Mon, Jul 26, 2021 at 1:13 PM Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> > > > >
> > > > > On Mon, 26 Jul 2021, Akshat Kakkar wrote:
> > > > >
> > > > > > MCU is using IP only to dial to VC1 and not hostname.
> > > > > >
> > > > > > I went through packet capture and find everything in line with the
> > > > > > standard. Just that it is sending "CS : Call Proceeding" packet which
> > > > > > is an optional packet but it is part of standard.
> > > > > > I can share pcap file if needed.
> > > > >
> > > > > Could you enable dynamic debugging in the kernel and enable it for the
> > > > > nf_conntrack_h323 module? Then please repeate the testing with the
> > > > > working and not working VCs and send the generated kernel debug log
> > > > > messages.
> > > > >
> > > > > Best regards,
> > > > > Jozsef
> > > > > > On Mon, Jul 26, 2021 at 2:11 AM Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > On Sat, 24 Jul 2021, Akshat Kakkar wrote:
> > > > > > >
> > > > > > > > I have 2 vc endpoints VC1 (Make:Panasonic, IP:10.1.1.11),
> > > > > > > > VC2(make:Polycom,IP: 10.1.1.12) and 1 MCU (172.16.1.100).
> > > > > > > >
> > > > > > > > There is a Linux firewall between VCs and MCU.
> > > > > > > >
> > > > > > > > There is one to one nat configured for these 2 VCs (10.1.1.11  <-->
> > > > > > > > 172.16.1.110, 10.1.1.12  <--> 172.16.1.120)
> > > > > > > > There is no natting for MCU IP as it is routable.
> > > > > > > >
> > > > > > > > nf_nat_h323 and nf_conntrack_h323 module is enabled in the firewall.
> > > > > > > >
> > > > > > > > When VC1 and VC2 initiate call to MCU, everything works fine. Video
> > > > > > > > call is successful for both VC1 and VC2. h245 IP address for tcp in
> > > > > > > > h225: CS connect packet is correctly replaced by the natted IP.
> > > > > > > >
> > > > > > > > However, when there is a dial out from MCU to VCs (i.e. MCU initiate
> > > > > > > > call to the natted IP (i.e. 172.16.1.110 and 172.16.1.120 of VCs),
> > > > > > > > natting works fine but h245 IP address for tcp in h225:CS is replaced
> > > > > > > > correctly only for VC2 and not for VC1. For VC1, it is still its
> > > > > > > > actual IP (i.e. 10.1.1.12 and not 172.16.1.120).
> > > > > > > >
> > > > > > > > Because of this, video call is successful only with VC2 and not with
> > > > > > > > VC1, when initiated from MCU. I tried with another panasonic VC
> > > > > > > > hardware, there was no change.
> > > > > > > >
> > > > > > > > Further packet dump analysis showed that for VC1, there are 3 h225
> > > > > > > > packets (setup, call proceeding and alert) before Connect message but
> > > > > > > > for VC2 there are only 2 h225 packets (setup and alert) before connect
> > > > > > > > message.
> > > > > > > >
> > > > > > > > Is there a bug in nf_nat_h323 module or am I missing something?
> > > > > > >
> > > > > > > It can be a bug/incompatibility with the H.323 implementation in the
> > > > > > > Panasonic device. However, first I'd make sure the MCU does not use
> > > > > > > hostname for VC1 instead of its IP address. Hostnames in the calls are not
> > > > > > > supported.
> > > > > > >
> > > > > > > Best regards,
> > > > > > > Jozsef
> > > > > > > -
> > > > > > > E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> > > > > > > PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
> > > > > > > Address : Wigner Research Centre for Physics
> > > > > > >           H-1525 Budapest 114, POB. 49, Hungary
> > > > > >
> > > > >
> > > > > -
> > > > > E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> > > > > PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
> > > > > Address : Wigner Research Centre for Physics
> > > > >           H-1525 Budapest 114, POB. 49, Hungary
> > >
> >
> > -
> > E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> > PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
> > Address : Wigner Research Centre for Physics
> >           H-1525 Budapest 114, POB. 49, Hungary
