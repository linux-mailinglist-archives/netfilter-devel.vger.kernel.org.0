Return-Path: <netfilter-devel+bounces-6010-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD49A33F39
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Feb 2025 13:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F73A9F8E
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Feb 2025 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71E221705;
	Thu, 13 Feb 2025 12:34:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E31E86E
	for <netfilter-devel@vger.kernel.org>; Thu, 13 Feb 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450065; cv=none; b=JQTdduOJH2T6QD/HZFaZNV97ggj8cehjiLgXkzRfwBrU9bJIekIzUh4QAKREiVxvAWO5JYXAHi0roT6D1rNIajZRh2nUCn/BdzRT3Elyrqm55EvOrb5rMSsGkXnCkF8xxN7kp14O2pn84nxfvaRW7A14TL/FQfg+lVvNlAfY4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450065; c=relaxed/simple;
	bh=sD5mXAs0RA1YhX4PpW9ed8iq/PD4N4vdb5CxzL1bD0A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m1ZTWE8dmUfi8p5W1/WQ4/5ZNd5hmIh4nxIbK6saNqDpwk6kL1x0je+Wmf4xkVCcn5E8AVZ9rcny/LLD4ZyNK7nfR2+J3svV3nU4dfdzQx7GeEEHbDplTyAGU7+XYBe5AikQn9q8Odjn3/ybjIfXqeyqs88gpBX5wEhIl3Rq9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so6381495ab.1
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Feb 2025 04:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450063; x=1740054863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOsijhvCigFjzeUnrAKfzrHq02qk08wDCDqZc+XWjnk=;
        b=eNCTKnqYJhsQkyktcY98Wp3yhMpiXMlXY7unAX4IcWSaBsR98TF0c/vr2vwiD1TZe6
         oOOPssPGY+MsEHQNW1vUcrku3UnIygZfx4AHHGBZkyltQ2zXhZipQO7Tmgtna1Mo8OBy
         gAVWJQszFwJ2N+gCrN9UBVKUDi/uf8em7dKf51oKWCtZ7kCfUuji17QnSNgqlaf46LGU
         AG76/ci+Bh5O1rBGeuIUwkYDOyPeocP30ltiem/sSB/UA93Z1dqA6tMtTpRdmJzNzLYy
         3ka0GGZDvqUI6JK3wnNeCJ5FxOnqfca+nA176g6/U4Jj3svxaU7ELlr1kYGLMaxCo8VP
         D43A==
X-Forwarded-Encrypted: i=1; AJvYcCX0gZoCzGhIdeqWOPvyJZ8IoqOrKkJTzeWZ092KVu01xTy5b2JXCoSFDn45tvS3ekot1ct3zvRcz8ky87tcv5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxichLHo90ndIfR82BH29bPhdXO0NNoKG+yBIaG3oSdSjVoQfkt
	1grCgnCvOjnuYrvpvwyxDo5nW2JgYRNlUAp83Y+yqaRgDvVmjbwXu8g7yr27DnHVbU15ylG8ZaF
	PC6hiZy2eOTJ3KbmzosJa19AqtFdJkCaQPeVcUev1B0+qnIVUHz9Spq0=
X-Google-Smtp-Source: AGHT+IGxqZHI1riEKhbV8ypBp5pEp0wgedke4FH5wNKfZsx2F6WsH05HnMBiuuS/DdikDfJQVcg41QmB4I8m6WTWMEWCGOaRQ/w7
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:3cf:bc71:94ee with SMTP id
 e9e14a558f8ab-3d17bfe4532mr51179275ab.14.1739450063243; Thu, 13 Feb 2025
 04:34:23 -0800 (PST)
Date: Thu, 13 Feb 2025 04:34:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ade6cf.050a0220.110943.005b.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Feb 2025)
From: syzbot <syzbot+lista9445699986af9d74946@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 181 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 128     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 11      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
<3> 4       Yes   INFO: rcu detected stall in tcp_setsockopt
                  https://syzkaller.appspot.com/bug?extid=1a11c39caf29450eac9f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

