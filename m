Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25EA30328B
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Jan 2021 04:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbhAYJrO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Jan 2021 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbhAYJq0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:46:26 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFDC061797
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Jan 2021 01:35:40 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l23so6720048qtq.13
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Jan 2021 01:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6jCwIJstX1wZgb0EPoSQk8h054Be3opSl0qtm83Ox0=;
        b=BxupoS51tg1ooQ4CZqTzxm87f0+6VMrCIqfhHyZ32g3ila8nohM1yTaE4xtv3GBXml
         NSMW8CPeVRG1CKoPHsaq7ojInKH1w5glVfKSPI+8GaTAcbkILcP+e3jkltXY15vvRdOn
         tnrJePGlQEezxdlDDXVmgzkxBkpdTHroQIXJP6SDHZO9gRh/KVfEapyIWfoeYrTFit1D
         iM9J7yC60x34Yw7/TB8KA41SI0m9qnZ00hnoIjBywoETqrWqjpHb5qZOFeLc8DUNhtnA
         DXzYTvH4FHgbkLwDxYxa/f6WaB5vrUQRLrjmiRM63nM+JpOpVulpPqF6Yg+oGkx4hgzr
         ucRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6jCwIJstX1wZgb0EPoSQk8h054Be3opSl0qtm83Ox0=;
        b=fG4Dy3YjP8WHbsurcu7K+oJ6ltWhKauGLnCnlX1LDRkdo7+LQyPnRk50WYc2nAhZZS
         YyK7YQk3p91XE4n74d+scpBnMRwK447ESx40UsECKnhT/F/Ok2887cSnfcnztCO0VA6F
         uzs+kkUwj5Ygz9oPMu4bK7ifa/3D5Dw+TOp/HpYfmHeBM5vIszJdnLPgtx7gvFiMUFqp
         Uq+fkejpGbQ2isKi3/bvLtYLVloyD/KxGe6MIUzaqNPrUPlXDFWPmr7472uXcJL6wXLi
         e99NFftSTLxqu+SX3vPaOpcRYoA2n3oMoxc8uiwWRyNzfMFfoL+MQbQdmjzAMZGIeqg2
         XA9A==
X-Gm-Message-State: AOAM533oRwr4VDY9ucd9qMgYfTyOL8hiCj0ppfUY53DcIecGLqyPw+Qs
        aAX42/07nmT7zuS73Ol8yeAyiIIaTT9sD2WpFNAK5A==
X-Google-Smtp-Source: ABdhPJz7Hq5jJ1Zd4FMLaGFJFeb7Wi/gXQqRhHLh8T53KlQwPZM8j5FOfVPb4odNELSnoHsrBvDsQXkJfNnezb8gI5Q=
X-Received: by 2002:ac8:7551:: with SMTP id b17mr93603qtr.43.1611567339141;
 Mon, 25 Jan 2021 01:35:39 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a358f905ae6b5dc6@google.com> <000000000000dd897e05b9806982@google.com>
In-Reply-To: <000000000000dd897e05b9806982@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jan 2021 10:35:27 +0100
Message-ID: <CACT4Y+ZC=_Nr1QdE48MLZe1YxhtB4FyR4LwUg-uvD4-ktwE0Rg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in dump_schedule
To:     syzbot <syzbot+621fd33c0b53d15ee8de@syzkaller.appspotmail.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        anmol.karan123@gmail.com, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        leandro.maciel.dorileo@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        subashab@codeaurora.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vedang.patel@intel.com, Cong Wang <xiyou.wangcong@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:21 PM syzbot
<syzbot+621fd33c0b53d15ee8de@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit cc00bcaa589914096edef7fb87ca5cee4a166b5c
> Author: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
> Date:   Wed Nov 25 18:27:22 2020 +0000
>
>     netfilter: x_tables: Switch synchronization to RCU
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10879d68d00000
> start commit:   59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
> dashboard link: https://syzkaller.appspot.com/bug?extid=621fd33c0b53d15ee8de
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152c3af9900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12213b71900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: netfilter: x_tables: Switch synchronization to RCU
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: netfilter: x_tables: Switch synchronization to RCU
