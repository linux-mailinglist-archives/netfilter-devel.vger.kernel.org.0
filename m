Return-Path: <netfilter-devel+bounces-3151-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6284947B64
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Aug 2024 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0605D1C2032B
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Aug 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECC415ADB8;
	Mon,  5 Aug 2024 12:54:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9615ADA1
	for <netfilter-devel@vger.kernel.org>; Mon,  5 Aug 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862464; cv=none; b=pG6sF13BHkWrfFGfM6xz8/3VILzP3dHTevicLBaGcRfGRYPtbeJfCTR8WJNvzUS6zEaqO8Oy77qamhbLnzA1xcMNYzjzrJ7cbfQf5fOm0degK1rusl3BfIGP7xvjw61BbzakMs9GBiwFzGc1+8yiC6bjbJtr8mW1ssXFNCv0DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862464; c=relaxed/simple;
	bh=yuJZEcBEMqvyrqge5m0+PRMHE8hGMmvMYa57tBPGSc4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qeHGQ3y4XFEtjUzSTEnYX17Sd9/DHoNW3GPXWfIiwfakJS/DTiCeR7DYU2k+Sq60sM6QoaPnsWoF9NHYpkGvGRP2AGZDLl1pV0F1x2NyHHq516FavV4jCECec/NbYcjmy3khtBML23HF1eojcbAgFNaem5ZwXV9Fb6xZMWQvPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso1142413439f.2
        for <netfilter-devel@vger.kernel.org>; Mon, 05 Aug 2024 05:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862462; x=1723467262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vedShJ3qHOydwe0PS7IY31SetgcMJJeyAmG2uC/Jjw=;
        b=cZskZH9Lj0A959ZnKERGhTk3hK9Pg520sH6mw4Pc0H19lfCj5MUJaHu5h5zciuJYOa
         5VjmSnRi1lZbChDt2aDiNYGa6YvvCNwlvXIRBrK7Tqau41F2q1exlI6LzvMshHsnNB0V
         DSM5UVr+12nMSWjhihhgJvl3CfKD49z4kIaM7NQUu/7yJVjbv5sLhFBHz9cMfhq0iskD
         zklzHBNRLodzzQ+MzLL1BDoH4DwhQCbRuEfUQ0VwOl3pcptFDDC/gvV6qjnkEhXW8pm/
         omdp9TD6I7/9/JH+adixChxBQlYCg57odI2yG0L6uAs96BB6nzQACKCY0x1ReihIywgu
         +Q/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJtHDPzWb7GcQVH4mSl8zRTZITB3EhvCMouaOZF3RIrxeHfZV5MEpZApU4Gs98B/Hs2lt/Srwyr+NvFB5Qf42aC7NnIUo4mC3UXD/mQSHf
X-Gm-Message-State: AOJu0YxZdHjOKdqaCDbESW2YURwXf/CY90q1C9+39DOInbzTcuzqboBh
	qphlnnemZ0g37AYCxLh38vPMvTrTfVS3hGWOrruK3LWYqCsAuD1KZZAEMVonGvcvXxaWDeXD5+b
	d0A+QnK/JLX48cOsAqAgkfIjwfcaSMOKDLzN7ZppJttZZkXfrzIxlvP4=
X-Google-Smtp-Source: AGHT+IETjZpuDvXqM09m5u6UCBoa1KtfdON7AIQfd4X1CCN2+VvqXFoN18lWWJrPUWD4HAf+dlmO4X127iHs47vlS3k8ZBvFEN8w
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-39b1fc4a7c3mr8788585ab.4.1722862462515; Mon, 05 Aug 2024
 05:54:22 -0700 (PDT)
Date: Mon, 05 Aug 2024 05:54:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000134fbb061eef2d35@google.com>
Subject: [syzbot] Monthly netfilter report (Aug 2024)
From: syzbot <syzbot+listca8d1ea06b0f6972495e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 171 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 352     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 97      Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 65      No    WARNING: locking bug in __schedule
                  https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef
<4> 29      Yes   INFO: rcu detected stall in ip_list_rcv (6)
                  https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

