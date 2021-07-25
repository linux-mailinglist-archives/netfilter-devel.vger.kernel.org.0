Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65673D4FF5
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Jul 2021 22:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGYUBL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Jul 2021 16:01:11 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:50665 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGYUBK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Jul 2021 16:01:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 93FA2CC02B9;
        Sun, 25 Jul 2021 22:41:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Sun, 25 Jul 2021 22:41:35 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 5D2D0CC02B6;
        Sun, 25 Jul 2021 22:41:35 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 525953412EC; Sun, 25 Jul 2021 22:41:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 4FD5A3412EB;
        Sun, 25 Jul 2021 22:41:35 +0200 (CEST)
Date:   Sun, 25 Jul 2021 22:41:35 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     Akshat Kakkar <akshat.1984@gmail.com>
cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: Nf_nat_h323 module not working with Panasonic VCs
In-Reply-To: <CAA5aLPirA-gNiYRCoQR6-2fP80ESvvXKu7f0bVPT80FFxua6=g@mail.gmail.com>
Message-ID: <17a7e7ed-f324-2a94-5f82-18c3850de6a@netfilter.org>
References: <CAA5aLPirA-gNiYRCoQR6-2fP80ESvvXKu7f0bVPT80FFxua6=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

On Sat, 24 Jul 2021, Akshat Kakkar wrote:

> I have 2 vc endpoints VC1 (Make:Panasonic, IP:10.1.1.11), 
> VC2(make:Polycom,IP: 10.1.1.12) and 1 MCU (172.16.1.100).
> 
> There is a Linux firewall between VCs and MCU.
> 
> There is one to one nat configured for these 2 VCs (10.1.1.11  <-->
> 172.16.1.110, 10.1.1.12  <--> 172.16.1.120)
> There is no natting for MCU IP as it is routable.
> 
> nf_nat_h323 and nf_conntrack_h323 module is enabled in the firewall.
> 
> When VC1 and VC2 initiate call to MCU, everything works fine. Video
> call is successful for both VC1 and VC2. h245 IP address for tcp in
> h225: CS connect packet is correctly replaced by the natted IP.
> 
> However, when there is a dial out from MCU to VCs (i.e. MCU initiate
> call to the natted IP (i.e. 172.16.1.110 and 172.16.1.120 of VCs),
> natting works fine but h245 IP address for tcp in h225:CS is replaced
> correctly only for VC2 and not for VC1. For VC1, it is still its
> actual IP (i.e. 10.1.1.12 and not 172.16.1.120).
> 
> Because of this, video call is successful only with VC2 and not with
> VC1, when initiated from MCU. I tried with another panasonic VC
> hardware, there was no change.
> 
> Further packet dump analysis showed that for VC1, there are 3 h225
> packets (setup, call proceeding and alert) before Connect message but
> for VC2 there are only 2 h225 packets (setup and alert) before connect
> message.
> 
> Is there a bug in nf_nat_h323 module or am I missing something?

It can be a bug/incompatibility with the H.323 implementation in the 
Panasonic device. However, first I'd make sure the MCU does not use 
hostname for VC1 instead of its IP address. Hostnames in the calls are not 
supported.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
