Return-Path: <netfilter-devel+bounces-989-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A9384F168
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Feb 2024 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1449628722C
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Feb 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365C65BC8;
	Fri,  9 Feb 2024 08:36:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1831A79
	for <netfilter-devel@vger.kernel.org>; Fri,  9 Feb 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467786; cv=none; b=C53dmJBEemukcMjRBMdobQbD67tm8K9EcFbsBo35qy2tSpcKqv1z/FoMpS28FDCqC/mOgUukwkl6fcr5GtNHt5l/d7mCOYhbAx4gxwyUq+KUUxQ7gI0uC6eVX8dQH6Qi6RXm5ID4mx6aLGXLIT/q3xGYhzmJ8aVcjAWf9rn6NvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467786; c=relaxed/simple;
	bh=Zck6MFVSsVoeJrJI9g41GzXMVLesXH2u0cKmmnlZ1JI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nYNp2eRnmqDmwN6rvBYfDwste59G5b12q6R8CRx5aExwD39HTbA5jFHVp4JQHmkdHzTdFZfXckVR906x1zSV11dYZFpdvEG9n792oiFUd0r4nE4paYE4lc+DANPvhmzL/xz1GwP/pHj3GZsPD93jQBaUzvuHuECDFbmB2nCFdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363c3eb46e3so5796355ab.3
        for <netfilter-devel@vger.kernel.org>; Fri, 09 Feb 2024 00:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467783; x=1708072583;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24Yrgnnur9ND4ExOfD7XjN9zPiPpVt+LDVK8jBNwB24=;
        b=oHiaUeG6ozXTNJ3DwQExvP90YNBsBJE8in/PpZLd+F+Vsv/OhfcJfxtKF1BSj6tC3t
         a30JSo/rLNtrqZK/n2p8ZIFnwT6p2W6Bm3jaEGbbfZmIcGeHc75gUZAcRvATlqIlIheO
         ERuTTBRAFlHKj02KAOSS5/etBPNqkYIfhhm+Rg6PxEpciubQQv+9P4riKpDb01o5Ql6K
         O6WPqUuPXon2xSJz7nWDuxrcv9yayv55z6rL9Cq5oHzrAUFVJs23hQX+3pp7W41cmQ61
         7+66fplkjG17E6fGDEKirDQkAGNLYlwDauNX50lOP1Z8BLIjNpt+6WTy6YBmikwKB+Zm
         tooA==
X-Forwarded-Encrypted: i=1; AJvYcCWjdM3tniQNUrIeiuvb7eaFwI81C0t19F2KlVVn8eq7gfB3DC46jwuqjtHyUpuQPU8lGunIfhmmKSFEmdZSHubqt9Uk3nxTi0rIImq4fStT
X-Gm-Message-State: AOJu0Yzv1oTxWycGEvUuyAEGdRQ4t008CFUR5DtmRP1x/QVTtsr/D9kl
	l6XQdqnxBYYE3DdYpz8Qg0u3bl5ASFOqCZ9Jjz4/vsRGYNbwgODt4wA3/3orPp2gjygoL8a198U
	3wbLMNSTwnIp0spcI5XlAFWQ1iniBV/RHCXuVVc7UEGnFUKbUQH8V+rY=
X-Google-Smtp-Source: AGHT+IHBJbYxhXRQMd9Rfmr15cbvFKFPUBuW/TZQdWNmRozZQaLQJqA9PD+aJwrcavFgPhXueA01XHrWSDiqo/QuAICTYy1825Nx
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:363:ca65:7d12 with SMTP id
 s7-20020a056e021a0700b00363ca657d12mr58589ild.6.1707467783730; Fri, 09 Feb
 2024 00:36:23 -0800 (PST)
Date: Fri, 09 Feb 2024 00:36:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b700a70610eed280@google.com>
Subject: [syzbot] Monthly netfilter report (Feb 2024)
From: syzbot <syzbot+list54bd6dcf58b0a6cd42fd@syzkaller.appspotmail.com>
To: fw@strlen.de, kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 158 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 47      Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 38      Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<3> 29      Yes   WARNING: suspicious RCU usage in hash_netportnet6_destroy
                  https://syzkaller.appspot.com/bug?extid=bcd44ebc3cd2db18f26c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

