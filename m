Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2450B798B0
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfG2Tg5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Jul 2019 15:36:57 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:56627 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387811AbfG2Tg4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:36:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 90602CC010E;
        Mon, 29 Jul 2019 21:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:user-agent:message-id:from
        :from:date:date:received:received:received; s=20151130; t=
        1564429011; x=1566243412; bh=8YdbWiEb4tfmH4XUZZ4tIdIHNlFaCMACRGi
        hpYfxBY8=; b=KaGnW8b+c+ZQQTiuKTuNsWEL2L6dgj2H4+pX0gkjs3u1A74emwy
        y+au4hZlJSkpgxajkk9q2xVZeWL7Bgz9FU6Rnp9+v/cvCMueSe3Awx+QUT0p+eYt
        UWspzbBWEUTSLHOwnCJ5Aim9EF6YCehYLA8L/7jl+wcVz2fLDN94kNak=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 29 Jul 2019 21:36:51 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 44A9BCC0110;
        Mon, 29 Jul 2019 21:36:51 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 1D57B21B3B; Mon, 29 Jul 2019 21:36:51 +0200 (CEST)
Date:   Mon, 29 Jul 2019 21:36:51 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: [ANNOUNCE] ipset 7.3 released
Message-ID: <alpine.DEB.2.20.1907292134050.26619@blackhole.kfki.hu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I'm happy to announce ipset 7.3 which brings a few fixes and corrections:

Userspace changes:
  - ipset: fix spelling error in libipset.3 manpage (Neutron Soutmun)
Kernel part changes:
  - Fix rename concurrency with listing, which can result broken
    list/save results.
  - ipset: Copy the right MAC address in bitmap:ip,mac and
    hash:ip,mac sets (Stefano Brivio)
  - ipset: Actually allow destination MAC address for hash:ip,mac
    sets too (Stefano Brivio)

You can download the source code of ipset from:
        http://ipset.netfilter.org
        ftp://ftp.netfilter.org/pub/ipset/
        git://git.netfilter.org/ipset.git

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics, Hungarian Academy of Sciences
          H-1525 Budapest 114, POB. 49, Hungary
