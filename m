Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C0398680
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Jun 2021 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhFBKbv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 06:31:51 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54017 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhFBKbt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:31:49 -0400
Received: by mail-io1-f70.google.com with SMTP id u15-20020a6b490f0000b0290447d9583f14so1156055iob.20
        for <netfilter-devel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/5Yxeay+76HnzJp/CqXkJ+ggXqViaQWyqCEQjK6m184=;
        b=KzEQotVj3SywezL1e74kKDomSwS2kjHSnzFYR/Y2UjDHM1eEJTZUQd9bV/qNS76XbN
         nkMb2f66AQssUnCo4HEF/ya1q9pBEKr2/h7b7xHGe4TUqDXWicTy2tQJ8tfGGsxgZNk/
         qDyNjwHwIHTZUmMAFGEDYxz/fUbUGoNn5DXUDvx1YFrse456X37JOIGa1c7ESYuT0uHx
         VK6lTHqgbLydqpLg3wsyO6znq/U2daVPpds7kHZkkvgVJM93QZxIkHXcCwAAi2/BbnwP
         JpCeuwJZxmjjCKmEUtrQlSX2zbkO3FBPp5jqFyk24rEfFOtGi5Iyq4R1GoYoCmLtd4t8
         eT2w==
X-Gm-Message-State: AOAM533FO+nkPQCSNhYPlEaGAOcIcSMhXV0E5qtONIoMgpaZ71o36aKz
        g7/IleyCRZuG2EDhdpD+pbBdL81ojWF1UT87Ia6lomTnxa2r
X-Google-Smtp-Source: ABdhPJx4g6XX+uFaQ6ef+gub/km+nZfMcKw0yEZ80kxD960AgE53q9Q4me2ar2pMKzoHdIlLr3xuAqcMTYpF4PDEjYk9rMPzqPr8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:: with SMTP id u12mr25215033ilv.221.1622629806914;
 Wed, 02 Jun 2021 03:30:06 -0700 (PDT)
Date:   Wed, 02 Jun 2021 03:30:06 -0700
In-Reply-To: <000000000000c98d7205ae300144@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e409f05c3c5f190@google.com>
Subject: Re: [syzbot] WARNING in idr_get_next
From:   syzbot <syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com>
To:     anmol.karan123@gmail.com, bjorn.andersson@linaro.org,
        coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org,
        ebiggers@google.com, ebiggers@kernel.org, eric.dumazet@gmail.com,
        fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        necip@google.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 43016d02cf6e46edfc4696452251d34bba0c0435
Author: Florian Westphal <fw@strlen.de>
Date:   Mon May 3 11:51:15 2021 +0000

    netfilter: arptables: use pernet ops struct during unregister

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11518847d00000
start commit:   4d41ead6 Merge tag 'block-5.9-2020-08-28' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=f7204dcf3df4bb4ce42c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a1352e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fdaf41900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: arptables: use pernet ops struct during unregister

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
