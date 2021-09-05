Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32983401211
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhIEXWO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Sep 2021 19:22:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39762 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhIEXWN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Sep 2021 19:22:13 -0400
Received: by mail-il1-f197.google.com with SMTP id y8-20020a92c748000000b00224811cb945so3012745ilp.6
        for <netfilter-devel@vger.kernel.org>; Sun, 05 Sep 2021 16:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t6KGl5qGZOKwjA8wYNjhxOdRHpEUEUmyOHtgq+CbC7c=;
        b=Vy6SJ1IWhCsVuqdncyWRkY075WhI+4TuweTGlYsZDD9dQ6T+V2BqB9mQocpBJ60I7n
         MlgXAVZhcNXcZqdD35QuCn75nq4Utuss/aeb4OVlYKFq9jDPwCr/ciZxzfgBw1YtK2QC
         /pDpe0G2MLF2LB/toNTVDCmVuAtdtIWVuc+XagyLUT/nFzwj83DRbA2kMyQJUvFRrq+N
         354V44kwGs4RJ93KxCbJq4u+MVjnE0GUiFse0YV1LmdnKWHrVYTfczYLt+j0pCOC4427
         YPEwN85xnZPna8uYnSywHOli3Y2R28id00zPQHNU0h2JYYPV0yRtZyINZBEmx7Ou9dwf
         PIlg==
X-Gm-Message-State: AOAM533EIfY6uUdeUQWMIEI5d0LoFH6GwJULiZJY83rCAkD/GZYg3paN
        5ScBQ1md+EC1OI4Hc9dgfry/yL2D5xZWZ4QTa6pMUxpJUWPn
X-Google-Smtp-Source: ABdhPJwd3TYEWNuMTgpkZAvirmsn+/SrAn8Wwh9OqmKijRfViKorf/rzRe7Kmqs3U6G0U4D5VgDmmChYa9ZQ83uEoiOkJtAR2DKB
MIME-Version: 1.0
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr7782287iov.62.1630884069876;
 Sun, 05 Sep 2021 16:21:09 -0700 (PDT)
Date:   Sun, 05 Sep 2021 16:21:09 -0700
In-Reply-To: <000000000000ea2f2605cb1ff6f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7a8de05cb47c9b2@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ip_create
From:   syzbot <syzbot+3493b1873fb3ea827986@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com,
        coreteam@netfilter.org, davem@davemloft.net,
        eric.dumazet@gmail.com, fw@strlen.de, hch@lst.de,
        ira.weiny@intel.com, johan.hedberg@gmail.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, martin.petersen@oracle.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot has bisected this issue to:

commit e6e7471706dc42cbe0e01278540c0730138d43e5
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 27 05:56:34 2021 +0000

    bvec: add a bvec_kmap_local helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17468471300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c68471300000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c68471300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7860a0536ececf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=3493b1873fb3ea827986
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11602f35300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e8fbf5300000

Reported-by: syzbot+3493b1873fb3ea827986@syzkaller.appspotmail.com
Fixes: e6e7471706dc ("bvec: add a bvec_kmap_local helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
