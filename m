Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79B312739
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Feb 2021 20:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGThF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Feb 2021 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGThE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:37:04 -0500
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24EC061756;
        Sun,  7 Feb 2021 11:36:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id 7249E3C8019C;
        Sun,  7 Feb 2021 20:36:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Sun,  7 Feb 2021 20:36:17 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp1.kfki.hu (Postfix) with ESMTP id 1A17D3C8019B;
        Sun,  7 Feb 2021 20:36:16 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id E4675340D5D; Sun,  7 Feb 2021 20:36:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id DF8E1340D5C;
        Sun,  7 Feb 2021 20:36:16 +0100 (CET)
Date:   Sun, 7 Feb 2021 20:36:16 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
X-X-Sender: kadlec@blackhole.kfki.hu
To:     Reindl Harald <h.reindl@thelounge.net>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net 1/4] netfilter: xt_recent: Fix attempt to update
 deleted entry
In-Reply-To: <a51d867a-3ca9-fd36-528a-353aa6c42f42@thelounge.net>
Message-ID: <alpine.DEB.2.23.453.2102072033520.16338@blackhole.kfki.hu>
References: <20210205001727.2125-1-pablo@netfilter.org> <20210205001727.2125-2-pablo@netfilter.org> <69957353-7fe0-9faa-4ddd-1ac44d5386a5@thelounge.net> <alpine.DEB.2.23.453.2102051448220.10405@blackhole.kfki.hu>
 <a51d867a-3ca9-fd36-528a-353aa6c42f42@thelounge.net>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 5 Feb 2021, Reindl Harald wrote:

> what makes me thinking about the ones without --reap - how is it 
> handeled in that case, i mean there must be some LRU logic present 
> anyways given that --reap is not enabled by default (otherwise that bug 
> would not have hitted me so long randomly)

Yes, checking the code I was wrong: when the recent table is full, the 
oldest entry is automatically removed to make space for the new one.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
