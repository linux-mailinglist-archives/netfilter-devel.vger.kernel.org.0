Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7452160A3E
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Feb 2020 07:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBQGJD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Feb 2020 01:09:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40139 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgBQGJD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:09:03 -0500
Received: by mail-io1-f71.google.com with SMTP id m24so11175536iol.7
        for <netfilter-devel@vger.kernel.org>; Sun, 16 Feb 2020 22:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KjyO2CoXoWwnkM0ow4J41Qq6MSIdJgEthJmvcyKAp34=;
        b=gnZla4YghHVsOFkd+V0e2boNQfCQ1gWq+of8zGzjsO98nBqXcnZbzXk05xuHKFeWoe
         KK5p7FMGbjnnkcqoKE0HC5RLIcc3kTBrnkfI5OmhvKKQNQMHRz67yd0GhIn32xXU7pKh
         /TvLQEe0DDVEB/Gqg3T35R0/Klbx6XsYwyQh2KwZXV6e2W4CH4qR4urbJFubmI8fg7ag
         p09dkqAw4VztCvhTOnddj2UcgU7PAMG60GlveKww2dKDD2jwKJynRf3lqamJ0AaiYUEX
         hPiZ+qoH3d/ejhIYlFbi2i4+rmbVsnb+rBlGjqh8cAXPnmBgf6p209wNT/2AfXyOYdEX
         cDug==
X-Gm-Message-State: APjAAAUEMoQatwesqeIS6KTLc0+T2ewGC7Kv176F7KavtEjLcP4v8g1M
        RqsHqe68hZohO5nuCSx9IKW2Kbadx6NRf5Z72iscuG/L08Qa
X-Google-Smtp-Source: APXvYqw9e8S7Ik9ZMV2fme+AyYp2vlgWW5jiJuRFAympxlHFz2ZX4EV7M5BWi5Cs3LF+f9da1xKs8iUCxvXKigJf/lEaxfjPT2fk
MIME-Version: 1.0
X-Received: by 2002:a92:5b11:: with SMTP id p17mr13306532ilb.202.1581919741345;
 Sun, 16 Feb 2020 22:09:01 -0800 (PST)
Date:   Sun, 16 Feb 2020 22:09:01 -0800
In-Reply-To: <00000000000014b040059c654481@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f07f8059ebf6465@google.com>
Subject: Re: WARNING in nf_tables_table_destroy
From:   syzbot <syzbot+2a3b1b28cad90c608e20@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit eb014de4fd418de1a277913cba244e47274fe392
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Tue Jan 21 15:48:03 2020 +0000

    netfilter: nf_tables: autoload modules from the abort path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e9cc7ee00000
start commit:   5a9ef194 net: systemport: Fixed queue mapping in internal ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=2a3b1b28cad90c608e20
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15338966e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1667d8d6e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: nf_tables: autoload modules from the abort path

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
