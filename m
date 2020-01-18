Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC18F14179A
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 14:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgARNSC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 08:18:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36890 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgARNSC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 08:18:02 -0500
Received: by mail-il1-f197.google.com with SMTP id l13so21246102ilj.4
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 05:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vq35VVCLiUmdGfGTUu+QUj9vaGq4rOYJnMIEDAOexh0=;
        b=CN09bydiKyWuVlUzbK5crCcSLN9tWkEz+KSaZOXz7ay2ib7e2sXGROw1WeilPLmnjS
         mRudFqSvwr9FHWKo8EETseOm8OejZY6SLdgSVl31/2NCSp5+H3Ia7diRqB8m5XYX7Cad
         UcBz6nqLlT3LX0CvATZ+Xs2CNM3X/TlNsWMW116xIUrrJlVs2ys59Fs8SUU0xff7WMnv
         82ZQUy9QfT3b9wzi9J+C660fm053TdCbkOBsIvpzAnf3nVZ+qhyQVEVsjmCfldmga07o
         GAxiRNl19CSwKrG5KXA6pOFJZrQ8W2AXxNdEgf6u/94ahA836pHKL2qiA6rVl9OWeiWe
         tpMw==
X-Gm-Message-State: APjAAAV2ODVvuPQnujuUEF1ddnJyVVnRvpWAJs6yng3nFkZCBie3ZOW6
        UuoWxlrGJCYcDi6NSpGyyAqSd3YvHhB2AcxdCjWACW34/aOF
X-Google-Smtp-Source: APXvYqzqyVM1WO4urZ8jwJ7gyp+6An1CaUUfyk+oaSk6LhPtK6f3CFyjZy5MFZCQgV/r7Fb+ohevMMxbS9He7fx6jrgtiQUMv0Pw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr2982632ils.54.1579353481772;
 Sat, 18 Jan 2020 05:18:01 -0800 (PST)
Date:   Sat, 18 Jan 2020 05:18:01 -0800
In-Reply-To: <0000000000001ba488059c65d352@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004185c0059c69e3f9@google.com>
Subject: Re: BUG: corrupted list in __nf_tables_abort
From:   syzbot <syzbot+437bf61d165c87bd40fb@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot has bisected this bug to:

commit ec7470b834fe7b5d7eff11b6677f5d7fdf5e9a91
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Mon Jan 13 17:09:58 2020 +0000

    netfilter: nf_tables: store transaction list locally while requesting module

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1075ccc9e00000
start commit:   5a9ef194 net: systemport: Fixed queue mapping in internal ..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1275ccc9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1475ccc9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=437bf61d165c87bd40fb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1285ccc9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1424c135e00000

Reported-by: syzbot+437bf61d165c87bd40fb@syzkaller.appspotmail.com
Fixes: ec7470b834fe ("netfilter: nf_tables: store transaction list locally while requesting module")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
