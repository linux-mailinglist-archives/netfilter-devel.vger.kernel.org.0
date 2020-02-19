Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6996D163E37
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Feb 2020 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSHyE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Feb 2020 02:54:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45099 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSHyE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:54:04 -0500
Received: by mail-io1-f69.google.com with SMTP id t12so15643905iog.12
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 23:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=bhiLhZ0hGFmHCjOA0xxswOfkox27Yu7xmMOMfRdjKnY=;
        b=gsej8tAIoPetFlBFDbZ+TR2jLl69UXtYb1+tW3hFURdelxxwlt4vHShKDtmuDa8yYH
         mOKOMvJHHyqNMo45Ll/qcZkhs4KcMjnxOvdmwqhr8WiDOqT0I0XEPz6Wo9zn0JQglNdy
         sdR4iYQmn+Wi39biPAl6sH6I4QulCq7YfSaukgfr9jmXO4VP0rMME/lVkJPdewxNEvk7
         66Z8dzAu7uc3WjAPIQdjcLBm2Qx1oxCqOxmYB9kRnHy8cPO0qMO94rljhsJtSc6f0TvZ
         aM+JfRbWGAPIb+aeO4jgZmZ7g67aDfItey99VHCZHnORf8FLlx/5ukaRH5yJa0KIzCQn
         WRZQ==
X-Gm-Message-State: APjAAAUpKmIWl+1ESLX5sP+o661bFUdC+dgFyeKwBDFV9oFzWGxCRswt
        fMxj5OWzWQ3YPSpaJO/eEQbX0kOlD7DZjvu5NIWgpJrLw1WR
X-Google-Smtp-Source: APXvYqxGYY13aZOMM0BSOmDQMzSYZrf2qmPLxLF8eTHCcZFD8r1N2DfCNIuzDx8cL8jZ8cKMDsJUm0ShbBazBm0Pcb2Lzvn6MzqR
MIME-Version: 1.0
X-Received: by 2002:a02:2101:: with SMTP id e1mr19970446jaa.29.1582098843467;
 Tue, 18 Feb 2020 23:54:03 -0800 (PST)
Date:   Tue, 18 Feb 2020 23:54:03 -0800
In-Reply-To: <0000000000006d7b1e059c7db653@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000908c50059ee9173a@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_ext_cleanup
From:   syzbot <syzbot+b554d01b6c7870b17da2@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de,
        jeremy@azazel.net, johannes.berg@intel.com,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        nikolay@cumulusnetworks.com, pablo@netfilter.org,
        roopa@cumulusnetworks.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17079245e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=b554d01b6c7870b17da2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145948d6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16202cc9e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
