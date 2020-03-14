Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76145185847
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2020 03:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCOCB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Mar 2020 22:01:57 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47962 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCOCB5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:01:57 -0400
Received: by mail-io1-f72.google.com with SMTP id w21so9420786iod.14
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Mar 2020 19:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=+QdPalM1/7ayitV9XmteLgnXaS2hu+LX/EwtXkNn8sI=;
        b=YDOsyJHYw5Z4O0CRCfsUX54KKUIGSeRKJWpCrt3LrKMHOTsbctMxVidwRUgcmKIsCY
         EarhY88oECjI2fzrxrEq2CBN7emVhpUQIEksHYdpzxVmOb75Wwx5U3Lbme8qf0t6c6TU
         BqNJg7eqLmBJrH2bNEsOENzEhggVSoDHpT2/1nCOS4Ebxgx9gsQGr8/oAx2M9Nirfnxg
         SjEz+omu7kbblFwJNY6TtjH/h2zKDeanFh0b3Of9bRD6Fjchr2CMnc2XiIfi+R/P/mp1
         HcXkVihlilI9SP5GPChZQfWcV5bHFY7sVDrjzQU8B5l4+x8pQHPXIWa8BBS7H+Hnhvd2
         lgEQ==
X-Gm-Message-State: ANhLgQ0fz9WV8rcCnFeOvzOxMbznMqm69WtAMrBN5eXLbn15MDYXAAXI
        7XJhistJoeO+7h+sEFxo4WdWC3nY20RhIFqELARAXofT+Cmr
X-Google-Smtp-Source: ADFU+vsvmmvzF0I4nMIQXyBWKmywCRss6IV6wvF4RwqOdkw0XwU5mtrUilZd8jdSs9quwxi/+KGtd7aYDnIYchTEyVeGinshxzTm
MIME-Version: 1.0
X-Received: by 2002:a92:aa87:: with SMTP id p7mr18089913ill.63.1584206402340;
 Sat, 14 Mar 2020 10:20:02 -0700 (PDT)
Date:   Sat, 14 Mar 2020 10:20:02 -0700
In-Reply-To: <000000000000cdbe79059ce82948@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dccd2405a0d3cb04@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_destroy
From:   syzbot <syzbot+a85062dec5d65617cc1c@syzkaller.appspotmail.com>
To:     a@unstable.cc, arvid.brodin@alten.se,
        b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org,
        davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de,
        jeremy@azazel.net, johannes.berg@intel.com,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik József <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10aef753e00000
start commit:   4703d911 Merge tag 'xarray-5.5' of git://git.infradead.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=a85062dec5d65617cc1c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1301ed85e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b7b79ee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
