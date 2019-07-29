Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9B782DB
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 02:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfG2AiE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 28 Jul 2019 20:38:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55450 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfG2AiB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:38:01 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so65819527ioh.22
        for <netfilter-devel@vger.kernel.org>; Sun, 28 Jul 2019 17:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/bfC/9DYsjpqYrAz/GLNeevsKIsGM5ry8dJO/L9Ihk=;
        b=AykLSMNrRyGnu0WR+sRnAYCeC8nB8ywa4Uy/mCeTo+1OkBkW6HDRFe3aKRlix+KkjW
         bkPW8N0Z/9yZIb2kIYp8hHpLxhFPvxPDQsg/LK1i5MfOa00h1DMsgiZBpVEdQ6ofxHY4
         k4YUe//g5QfDyxqKHSluxsPlMRQ40Dv5b2lYSQAt4BQZ5XkLjz0XW59k7/pb5aVNdSG+
         sSPGlIV3v11QYZMCTyCAkaVBCYen50Ryco/cL3ooxJyDlcpDzz9BVQc9YJW+O/IQlJHS
         Ppu8WL50ZOwaLn+a24OC7OvM86lR/ivdTsVTxnLlWgxDCaQxIqlOIVdx2nDhfjLCIBdR
         pG+A==
X-Gm-Message-State: APjAAAXTy1GRUETF3cnzxvedyqMP5YdCEK9CE0wIOhaynZN2gdWs73Xv
        cSgs44BIDz5SunAG3SlGnWhzqbJJDgxTjBpHWo36kyGuzkFl
X-Google-Smtp-Source: APXvYqwVilF5qTRSsaLkhL6POlQdbplmHCUtbsaCjcw6sv9rHxSg5wY2IEL+f/ULWS/npxF51AhFcSpVnuGNfy6+mXTXpQgpNXm3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr81494815jap.17.1564360680847;
 Sun, 28 Jul 2019 17:38:00 -0700 (PDT)
Date:   Sun, 28 Jul 2019 17:38:00 -0700
In-Reply-To: <000000000000c75fb7058ba0c0e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aec4ec058ec71a3d@google.com>
Subject: Re: memory leak in bio_copy_user_iov
From:   syzbot <syzbot+03e5c8ebd22cc6c3a8cb@syzkaller.appspotmail.com>
To:     agk@redhat.com, axboe@kernel.dk, coreteam@netfilter.org,
        davem@davemloft.net, dm-devel@redhat.com, hdanton@sina.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        shli@kernel.org, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot has bisected this bug to:

commit 664820265d70a759dceca87b6eb200cd2b93cda8
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Thu Feb 18 20:44:39 2016 +0000

     dm: do not return target from dm_get_live_table_for_ioctl()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f4eb64600000
start commit:   0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100ceb64600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f4eb64600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
dashboard link: https://syzkaller.appspot.com/bug?extid=03e5c8ebd22cc6c3a8cb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13244221a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117b2432a00000

Reported-by: syzbot+03e5c8ebd22cc6c3a8cb@syzkaller.appspotmail.com
Fixes: 664820265d70 ("dm: do not return target from  
dm_get_live_table_for_ioctl()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
