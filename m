Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383B03E513A
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Aug 2021 04:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhHJC7d (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Aug 2021 22:59:33 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50020 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhHJC7d (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:59:33 -0400
Received: by mail-il1-f198.google.com with SMTP id z5-20020a92cd050000b029022368ee85c8so1978246iln.16
        for <netfilter-devel@vger.kernel.org>; Mon, 09 Aug 2021 19:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zSDHB+ayhUP7TZd1PkK8NdiovuFeNlca3xDJ9hzYst8=;
        b=iYpWltMQBBCC8JpDc7uYEiscHNMLzErp8f0K1L6EyEKJIWWD7HRF0zMyfqrTuDKYBt
         VMGEFNK8Z8TuPHzcVnx4XOhC4pYQxctK+/3lgZ5coy0EiSs+heZAmmvpe8PB+OiAhOES
         Rj5XZGdo9hX4hcCz00GKiyTS9aYYhCmqov0+QYhWE5OH9TaynYmgE4D0MtTDXOCpmNO3
         HyJpqBGFwBevSNU8F2yg80JUqDHixA7LIzc3qDWvmGHQJEJmMWErSRgnmFgHFh7Mmrfj
         lzlyLk76wQxgoMdojOB7arkbkKl++AOCzpW1GmJxD5BMtwQXSEh9lkCYQwtNI0z594UF
         83Qw==
X-Gm-Message-State: AOAM530QTgHwVzsArIfEYRFF0moF+ahww412+M9R+6cbFJaORIqOTIq5
        9d1+clVcYZjfJ9EYDmiTk43wRuAmozZtf0RzwenMswy+PxpL
X-Google-Smtp-Source: ABdhPJyoTs63fvUgB/PD0YFzIx5H5r0vIF78rjKjUU7N6tcNhKKLeo3uHMOY2kdPn1GwjV88Drz92txjVgxJ4E6WMBtVLETc9sqe
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:: with SMTP id h9mr12236ila.46.1628564351925;
 Mon, 09 Aug 2021 19:59:11 -0700 (PDT)
Date:   Mon, 09 Aug 2021 19:59:11 -0700
In-Reply-To: <cdb5f0c9-1ad9-dd9d-b24d-e127928ada98@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0cbde05c92baf05@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in nft_ct_tmpl_put_pcpu
From:   syzbot <syzbot+649e339fa6658ee623d3@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+649e339fa6658ee623d3@syzkaller.appspotmail.com

Tested on:

commit:         9a73fa37 Merge branch 'for-5.14-fixes' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
dashboard link: https://syzkaller.appspot.com/bug?extid=649e339fa6658ee623d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153511fa300000

Note: testing is done by a robot and is best-effort only.
