Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80B3DDF04
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Aug 2021 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHBSUY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Aug 2021 14:20:24 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:35557 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSUY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:20:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 76CC9CC00FF;
        Mon,  2 Aug 2021 20:20:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon,  2 Aug 2021 20:20:09 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 3962FCC00F5;
        Mon,  2 Aug 2021 20:20:09 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 2E6273412ED; Mon,  2 Aug 2021 20:20:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 29C173412EC;
        Mon,  2 Aug 2021 20:20:09 +0200 (CEST)
Date:   Mon, 2 Aug 2021 20:20:09 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     Akshat Kakkar <akshat.1984@gmail.com>
cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: Nf_nat_h323 module not working with Panasonic VCs
In-Reply-To: <CAA5aLPjqFgeDkOjXed=XOHksDZNmQw9EPSkx3pwASKFQ6oioiw@mail.gmail.com>
Message-ID: <3556be79-66a2-9b12-7b7f-658a618690a8@netfilter.org>
References: <CAA5aLPirA-gNiYRCoQR6-2fP80ESvvXKu7f0bVPT80FFxua6=g@mail.gmail.com> <17a7e7ed-f324-2a94-5f82-18c3850de6a@netfilter.org> <CAA5aLPgQj8wEbawg8u=UqJedTPWCdK5WiizwCpNxMp7Vg=-JgA@mail.gmail.com> <e38ddbe-a47-efb1-e56f-457f5e426b18@netfilter.org>
 <CAA5aLPgowRWm7JZm02LCGeOPz4E_dO+8FCCag+8aO4HDeLUQFQ@mail.gmail.com> <CAA5aLPjqFgeDkOjXed=XOHksDZNmQw9EPSkx3pwASKFQ6oioiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Akshat,

On Mon, 2 Aug 2021, Akshat Kakkar wrote:

> > For the VC which is working (i.e. VC2, IP:172.16.1.120) following are
> > the generated debug log:

That can't be the full debug log, lines are missing/left out. What is the 
kernel version? Isn't there any output from the command

$ grep 'pr_debug("nf_ct_q931' net/netfilter/nf_conntrack_h323_main.c

> > [Jul27 17:29] nf_nat_q931: expect H.245 172.16.1.100:0->172.16.1.120:5516
> > [  +0.249944] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5506
> > [  +0.000021] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5507
> > [  +0.003265] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5508
> > [  +0.000011] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5509
> > [  +0.007606] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5506
> > [  +0.000012] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5507
> > [  +0.000010] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5506
> > [  +0.000004] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5507
> > [  +0.004337] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5508
> > [  +0.000010] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5509
> > [  +0.000007] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5508
> > [  +0.000007] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5509
> > [  +0.006028] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5510
> > [  +0.000011] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5511
> > [  +0.001171] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5510
> > [  +0.000008] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5511
> > [  +0.000006] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5510
> > [  +0.000003] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5511
> > [  +0.003261] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5512
> > [  +0.000011] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5513
> > [  +0.000006] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5512
> > [  +0.000003] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5513
> > [  +0.007889] nf_nat_h323: expect RTP 172.16.1.100:0->172.16.1.120:5512
> > [  +0.000012] nf_nat_h323: expect RTCP 172.16.1.100:0->172.16.1.120:5513
> >
> > However, for the panasonic VC1 i.e. the VC which is having issue,
> > there are no debug log generated. absolutely nothing.

Best regards,
Jozsef

> > On Mon, Jul 26, 2021 at 1:13 PM Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> > >
> > > On Mon, 26 Jul 2021, Akshat Kakkar wrote:
> > >
> > > > MCU is using IP only to dial to VC1 and not hostname.
> > > >
> > > > I went through packet capture and find everything in line with the
> > > > standard. Just that it is sending "CS : Call Proceeding" packet which
> > > > is an optional packet but it is part of standard.
> > > > I can share pcap file if needed.
> > >
> > > Could you enable dynamic debugging in the kernel and enable it for the
> > > nf_conntrack_h323 module? Then please repeate the testing with the
> > > working and not working VCs and send the generated kernel debug log
> > > messages.
> > >
> > > Best regards,
> > > Jozsef
> > > > On Mon, Jul 26, 2021 at 2:11 AM Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Sat, 24 Jul 2021, Akshat Kakkar wrote:
> > > > >
> > > > > > I have 2 vc endpoints VC1 (Make:Panasonic, IP:10.1.1.11),
> > > > > > VC2(make:Polycom,IP: 10.1.1.12) and 1 MCU (172.16.1.100).
> > > > > >
> > > > > > There is a Linux firewall between VCs and MCU.
> > > > > >
> > > > > > There is one to one nat configured for these 2 VCs (10.1.1.11  <-->
> > > > > > 172.16.1.110, 10.1.1.12  <--> 172.16.1.120)
> > > > > > There is no natting for MCU IP as it is routable.
> > > > > >
> > > > > > nf_nat_h323 and nf_conntrack_h323 module is enabled in the firewall.
> > > > > >
> > > > > > When VC1 and VC2 initiate call to MCU, everything works fine. Video
> > > > > > call is successful for both VC1 and VC2. h245 IP address for tcp in
> > > > > > h225: CS connect packet is correctly replaced by the natted IP.
> > > > > >
> > > > > > However, when there is a dial out from MCU to VCs (i.e. MCU initiate
> > > > > > call to the natted IP (i.e. 172.16.1.110 and 172.16.1.120 of VCs),
> > > > > > natting works fine but h245 IP address for tcp in h225:CS is replaced
> > > > > > correctly only for VC2 and not for VC1. For VC1, it is still its
> > > > > > actual IP (i.e. 10.1.1.12 and not 172.16.1.120).
> > > > > >
> > > > > > Because of this, video call is successful only with VC2 and not with
> > > > > > VC1, when initiated from MCU. I tried with another panasonic VC
> > > > > > hardware, there was no change.
> > > > > >
> > > > > > Further packet dump analysis showed that for VC1, there are 3 h225
> > > > > > packets (setup, call proceeding and alert) before Connect message but
> > > > > > for VC2 there are only 2 h225 packets (setup and alert) before connect
> > > > > > message.
> > > > > >
> > > > > > Is there a bug in nf_nat_h323 module or am I missing something?
> > > > >
> > > > > It can be a bug/incompatibility with the H.323 implementation in the
> > > > > Panasonic device. However, first I'd make sure the MCU does not use
> > > > > hostname for VC1 instead of its IP address. Hostnames in the calls are not
> > > > > supported.
> > > > >
> > > > > Best regards,
> > > > > Jozsef
> > > > > -
> > > > > E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> > > > > PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
> > > > > Address : Wigner Research Centre for Physics
> > > > >           H-1525 Budapest 114, POB. 49, Hungary
> > > >
> > >
> > > -
> > > E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> > > PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
> > > Address : Wigner Research Centre for Physics
> > >           H-1525 Budapest 114, POB. 49, Hungary
> 

-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
