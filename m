Return-Path: <netfilter-devel+bounces-5081-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EE9C6D67
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Nov 2024 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200E8284A47
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Nov 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB71FF02F;
	Wed, 13 Nov 2024 11:07:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856A1FDFB1
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Nov 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496046; cv=none; b=Te9+eBrw6J0Km+votDl5wl5P0f850Cqu8zW1LJ5qv6CQ6hR3YKfjTDrAiMI+2u9nrKMGUuYjxYcI/KXAAXRz5vpfyrXhfmEZxQwD7ALg8kx1uGebLeGDA/XtjfGR0rJmLonQqfleJKsEJbdumZXi5ue3SCDSoBdpewDfqchRp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496046; c=relaxed/simple;
	bh=3nNM0RWOHRwOh7vCR5bAGUb3yt8DqN9rgmZNmyv+1dA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DYCjLAO9xvGHhNhDb7ItOmlaPNTlb9IymRURLw1KT0Avz/QAH3kCbieAkD66ce9mVCkPXB6wETHVHavN/AEItETMbXQc985O19tH5wi5jzB5EGcOWc9iAyWNP2cr/+zfHiaeElQ/pimOR0OpH9HPWKrxXzbvG7hxa76huR34/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so80005315ab.3
        for <netfilter-devel@vger.kernel.org>; Wed, 13 Nov 2024 03:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496044; x=1732100844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwSOEAvBktMgftzuxBHvBD9aUQ+nzTMLZyoeTaPM0CE=;
        b=Z87ruMv6q1lB/wOdwLc2UePf5YuSRGa6B+sBzg3SnDhA0iHwsAumOJfzaYgDVS3sgu
         1LZtNf4TsdWj9SUgiRcO2VTEA8g8MnCBXw/8S8rkP1vqKbG/GsvUdHQ7qhZUrVOoNsSm
         Ge/M5+r9hxcK2UEi+qdC0HGGg0BKLiGXOGBjsLbyMT/3EXeON68cxtIZ7rW+sGnvsG/S
         VlXzo//p5MYaazrRRiDqPNlyf0j3cV9EUGRObnR128Hm+JChgM39YwjxR0f1sp90a8XW
         LIss9ns6nBzIJXrmPYCB7YK+8qPABLpWmUE1nKtmqh7vvdPBsVCtQ8zj/WHi1q7fBd93
         5e2A==
X-Forwarded-Encrypted: i=1; AJvYcCXgxA4j0YjZuz+AtgeP5waIdtx02Q335vV0dCi8HDb+lOo+6g9xLr2AzZN6VyNzsN/yVfgCQNjzz1kXIJ0WUpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHla9I2HdkFQ8qqjSmYGOQcx8FyA24VA+7ttch7NNS5AHiJUj
	sMj/5cJPo/VSV0VscK2Fhl+VOIcYjpf5hi9b8839B4e3JuxBcp995qXxS5V3MgIugxEK35IlGO1
	/YoUmn3MsOKq0eYgb29PjCQD9Z0FBfdGb3ROR8wTunLtVnIM7yhSEfPk=
X-Google-Smtp-Source: AGHT+IHc+ihD1CVYxIdzETMaxBkZllwA44W9mPFRV4QkVI/dOD/r9sngDbwP1exuFO+kJoaz8wB0v7JQPSv6nZFBRR6bZVgtedxn
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:680d:0:b0:3a7:18ac:1fd1 with SMTP id
 e9e14a558f8ab-3a718ac209fmr10563875ab.2.1731496043720; Wed, 13 Nov 2024
 03:07:23 -0800 (PST)
Date: Wed, 13 Nov 2024 03:07:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734886b.050a0220.2a2fcc.0008.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Nov 2024)
From: syzbot <syzbot+lista609c7c1ef075b5cd57f@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 177 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 117     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 47      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<3> 45      Yes   BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
                  https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

