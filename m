Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1930D2E0FFC
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Dec 2020 23:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLVWCV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Dec 2020 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgLVWCU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:02:20 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB20C0613D3
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Dec 2020 14:01:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so35375530lfc.11
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Dec 2020 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWeDwihFxTAhPlT/W6WCEEMXK+OSXU/rLqIMA122Kog=;
        b=GjeV9Ro1lac75aJ1KhE1sLyHOPZXVUp/KPe4acgRmCwKMsU9DeFCk+XqwMBKtfrRVH
         FaezK4cxCAXlid5LxjkWJT0btYkMqhexFp2DXti9Vq/0oH/3FpIXcfV9VGJLdEjS/1XP
         BAPUt7f+o5dbn1daNL+Qkzu9xrbRHZq9ha5ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWeDwihFxTAhPlT/W6WCEEMXK+OSXU/rLqIMA122Kog=;
        b=ALyf39pm22xy+QQ0nSvjiOX55s/+8WozgQg8y9KtgqRSb4uPVuwYrUVYTRdGTH0x/r
         eksWR3BTVSCeJYhwbeW9mzqW/V1O/qN4mEA3Q3U84g4Rg62ewmczT3itmgkF7MwSg57S
         p8IKLF2dTkPE2jlH1dN5ei5l8P+hhPjOzhQ05+Mb0W3dGvL06SGpeKDixTVukVuBfvcL
         lwIFoQ6Xg2459cSUa3T3cXN8QUu5OpwdhydQ0Ojg7IWm7/aMO1Td4/ajyyyHqlE0dNwL
         oshUXAjgpEjw930doAmKbrUigpAstLytDRThWHyptQA9+hFJxrZFcY+imtx+ruc0GOYC
         TA+Q==
X-Gm-Message-State: AOAM532V9Vq8vr4P3Bp8Y7478jCyoTf4CCf20r5RhQgiTKFC/sBGs8qs
        c6PeQAAKyMvGAxYLgYTyLi0FTD1pIY7QGw==
X-Google-Smtp-Source: ABdhPJxZbvZ9DZ/2gzXyOfUUATFnSalykAQqfjpxs8wB78ak99kUR3e1ALIZWnyxJUgVMcl/DPisAA==
X-Received: by 2002:a2e:a403:: with SMTP id p3mr10330770ljn.174.1608674498505;
        Tue, 22 Dec 2020 14:01:38 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a4sm3074653ljp.14.2020.12.22.14.01.38
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 14:01:38 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id h22so25935251lfu.2
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Dec 2020 14:01:38 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr10182715ljy.61.1608674497556;
 Tue, 22 Dec 2020 14:01:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000fcbe0705b70e9bd9@google.com>
In-Reply-To: <000000000000fcbe0705b70e9bd9@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Dec 2020 14:01:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com>
Message-ID: <CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com>
Subject: Re: kernel BUG at lib/string.c:LINE! (6)
To:     syzbot <syzbot+e86f7c428c8c50db65b4@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jakub Jelinek <jakub@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Dec 22, 2020 at 6:44 AM syzbot
<syzbot+e86f7c428c8c50db65b4@syzkaller.appspotmail.com> wrote:
>
> The issue was bisected to:
>
> commit 2f78788b55ba ("ilog2: improve ilog2 for constant arguments")

That looks unlikely, although possibly some constant folding
improvement might make the fortify code notice something with it.

> detected buffer overflow in strlen
> ------------[ cut here ]------------
> kernel BUG at lib/string.c:1149!
> Call Trace:
>  strlen include/linux/string.h:325 [inline]
>  strlcpy include/linux/string.h:348 [inline]
>  xt_rateest_tg_checkentry+0x2a5/0x6b0 net/netfilter/xt_RATEEST.c:143

Honestly, this just looks like the traditional bug in "strlcpy()".

That BSD function is complete garbage, exactly because it doesn't
limit the source length. People tend to _think_ it does ("what's that
size_t argument for?") but strlcpy() only limits the *destination*
size, and the source is always read fully.

So it's a completely useless function if you can't implicitly trust
the source string - but that is almost always why people think they
should use it!

Nobody should use it. I really would like to remove it, and let
everybody know how incredibly broken sh*t that function is.

Can we please have everybody stop using strlcpy(). But in this
particular case, it's that xt_rateest_tg_checkentry() in
net/netfilter/xt_RATEEST.c

That said, this may be a real FORTIFY report if that info->name is
*supposed* to be trustworthy? The xt_RATETEST code does use
"info->name" a few lines earlier when it does

        est = __xt_rateest_lookup(xn, info->name);

or maybe the bisection is right, and this points to some problem with
__builtin_clzll?

                 Linus
