Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A03B1EAD
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jun 2021 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWQbG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Jun 2021 12:31:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55058 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhFWQbF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:31:05 -0400
Received: by mail-io1-f71.google.com with SMTP id s14-20020a5eaa0e0000b02904abce57cb24so2262056ioe.21
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Jun 2021 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=U3PZEl0Cdz5lWpgoZ3LcxBmCftsorG7+dKagwjSphas=;
        b=YeQlTZ11q0/4DJtqxyPMpTisyeZ7sJ1jKzCV1qU716gVe847UBURY2g34SfE0ejHFV
         IS7SQHK+SGmajJypLKnZQBZy9e0EpbQgFJQMkipGW5tO6IisrNaTYYom8XKJAUUrYXPn
         t/yxG/RLRsEU4pSA/eRee2Dd2md26UeEyro1P6V0ehD0unzh+oXYynJRguyQtC/KfZGo
         WuGtJIINkPTdcgeHNGoqBIGyoLkwH1XLQiGfYxlY7tJsKvtT4GatG6HYrev5XG+e4Uk5
         QxuPGAr4E3Vvu/SdSGevycqnEJA3Sg0/HPYMrkeMtFrJ97+MjrKzFownnHJwTrysxGqI
         ghTA==
X-Gm-Message-State: AOAM53067Uf9k7cSDOchfD2gIsUJqhxX6xu0QpOY6mTcKJZFpXH83R1i
        jzmP7cDBLklmRXVFW8qLBtqZXUpu3yI+LMAVPoDmE0rFPsxQ
X-Google-Smtp-Source: ABdhPJxWibJjI3zl8BX97kjoK8MD9g1qOHd22umTb2oqfAL1duULt7iEPmx3R7h0vjlzdlOJ5d2bXHVdheJ/jqPGdiGn+EFMmyQK
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2206:: with SMTP id n6mr339969ion.54.1624465725884;
 Wed, 23 Jun 2021 09:28:45 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:28:45 -0700
In-Reply-To: <20210623192837.13792eae@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a8f9c05c571668c@google.com>
Subject: Re: [syzbot] WARNING: zero-size vmalloc in corrupted
From:   syzbot <syzbot+c2f6f09fe907a838effb@syzkaller.appspotmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     akpm@linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, dsahern@kernel.org, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

> On Wed, 23 Jun 2021 19:19:28 +0300
> Pavel Skripkin <paskripkin@gmail.com> wrote:
>
>> On Wed, 23 Jun 2021 02:15:23 -0700
>> syzbot <syzbot+c2f6f09fe907a838effb@syzkaller.appspotmail.com> wrote:
>> 
>> > Hello,
>> > 
>> > syzbot found the following issue on:
>> > 
>> > HEAD commit:    13311e74 Linux 5.13-rc7
>> > git tree:       upstream
>> > console output:
>> > https://syzkaller.appspot.com/x/log.txt?x=15d01e58300000 kernel
>> > config:  https://syzkaller.appspot.com/x/.config?x=42ecca11b759d96c
>> > dashboard link:
>> > https://syzkaller.appspot.com/bug?extid=c2f6f09fe907a838effb syz
>> > repro:
>> > https://syzkaller.appspot.com/x/repro.syz?x=14bb89e8300000 C
>> > reproducer:
>> > https://syzkaller.appspot.com/x/repro.c?x=17cc51b8300000
>> > 
>> > The issue was bisected to:
>> > 
>> > commit f9006acc8dfe59e25aa75729728ac57a8d84fc32
>> > Author: Florian Westphal <fw@strlen.de>
>> > Date:   Wed Apr 21 07:51:08 2021 +0000
>> > 
>> >     netfilter: arp_tables: pass table pointer via nf_hook_ops
>> > 
>> > bisection log:
>> > https://syzkaller.appspot.com/x/bisect.txt?x=13b88400300000 final
>> > oops:
>> > https://syzkaller.appspot.com/x/report.txt?x=10788400300000 console
>> > output: https://syzkaller.appspot.com/x/log.txt?x=17b88400300000
>> > 
>> 
>> This one is similar to previous zero-size vmalloc, I guess :)
>> 
>> #syz test
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> master
>> 
>> 
>
> Hah, I didn't notice that this one is already fixed by me. But the
> patch is in the media tree, it's not upstreamed yet:  
>
> https://git.linuxtv.org/media_tree.git/commit/?id=c680ed46e418e9c785d76cf44eb33bfd1e8cf3f6
>
> So, 
>
> #syz dup: WARNING: zero-size vmalloc in dvb_dmx_init

Can't dup bug to a bug in different reporting (upstream->internal).Please dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.

>
> With regards,
> Pavel Skripkin
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20210623192837.13792eae%40gmail.com.
