Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C482133E90
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jan 2020 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgAHJwi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Jan 2020 04:52:38 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:47140 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgAHJwi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:52:38 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ip80w-0002MM-IA; Wed, 08 Jan 2020 10:52:34 +0100
Date:   Wed, 8 Jan 2020 10:52:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+7f87c1e8811ab0c1ca1f@syzkaller.appspotmail.com>
Cc:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        gregkh@linuxfoundation.org, info@metux.net, jeremy@azazel.net,
        kadlec@netfilter.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: general protection fault in hash_ip6_uadt
Message-ID: <20200108095234.GU795@breakpoint.cc>
References: <000000000000da2154059b9d5055@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000da2154059b9d5055@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot <syzbot+7f87c1e8811ab0c1ca1f@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10fe1469e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f87c1e8811ab0c1ca1f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1483fec6e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fd2325e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7f87c1e8811ab0c1ca1f@syzkaller.appspotmail.com

#syz dup: general protection fault in hash_ipportnet4_uadt
