Return-Path: <netfilter-devel+bounces-6883-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56AA9168D
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Apr 2025 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49EB4448C8
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Apr 2025 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85156224B1C;
	Thu, 17 Apr 2025 08:38:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025821C162
	for <netfilter-devel@vger.kernel.org>; Thu, 17 Apr 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879108; cv=none; b=BiSVhhcr0eeMTqGmSdOeK7Tw/tl7QsmVx+uXjEZO2d/gZ/95jzj7nFhimaH1smYelaib895CK+XKQhXBC1lEj5EAXok4dw4ZxLbylyX71lgP5i599JngpBo19WmlZNInDmS1IxgjeaAnLe821uUoG20M5PXhbkK0IyLmFeLoamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879108; c=relaxed/simple;
	bh=UH9voSbXHY2ibx2R017hySv+7p94nIaOHgfqFIOkwDg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=em+bn1xlCP+kLvKo80CQWOiY9hx44GXPV396NV7bNiTHddDhTFYUB9J+nQhSG77cAutaCyXzO7M4RQ9YkD9z4k7KzQzd9pl6fUJrpUSho5Z1LfCTCc3fxwsC8yRcgGAdXUYX90Oev0Oxx03vXbxQwUic4KSJVc9Qp/kQkim5tKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d5da4fd946so12004065ab.1
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Apr 2025 01:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744879106; x=1745483906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZi5ZNPX9S5wyizuS3a6KFqu7CE6UegjxBqKHLcgHyY=;
        b=ZjUA7wvuaZB2YTXs0BKdSzMoLE/Kq2z/ky3VTl8S5lHdNJUSasr1JYJn5c0xzyJ0xa
         qdzXMLv9HDV+BGLX2tYMWrYuI2sxmEcwLWwsD3N9DV15uEyDZMVW0wy/eAxvu9Cr1d4h
         ER0ZAT+QWNzu7zKU9ZMm0YxVOcn9InpVbDkPvwaUn+WssthPBIg0asHQo/Q0O+nU1KFR
         iwmn+DVFWdnHN3d263+Q9roIaY5M/zpW/ru5m17eUjJmxbhM5YlAVDadqnurNnw2L/dp
         1npVx8ROGSsjRy5YLkoc/O3kWnb5tq2S72STmB0Ik0R1fgGiSHmuVjsb5DTWGEuAaNgQ
         oxRg==
X-Forwarded-Encrypted: i=1; AJvYcCVl+Ypb1zztavQoQE4y8bFNuwJ/gtpxKBu2/8geqGiNzetaK+mp7/bSJ8PafNvbUcp9wd2PwDpygIAArgR9m3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZKvt+mfYY9Wn54dchfa1ACxxM6k8Qh8czlOwIUI06w/xNN0I
	y/xozWK1F9piE9/PvElR1YKLRjNo/DdpJmej351dbwHF9YzSGqMrCJRunNavCWMPBC0cM/y8dwE
	c/lve0LmWJlaVnvA/4kUTF8BBKA7yQgM2zprT55kSSE8KHh4SvGZX6sE=
X-Google-Smtp-Source: AGHT+IEqoHGrUKvaaGvRUz8O7WU/jvu68WMIVM/pDoMJBtzCXkfzYf8QDQqXQWmtIka0No0EBP92ntn/wxZjPsEbzeLZ6goADD17
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2402:b0:3d0:4c9c:965f with SMTP id
 e9e14a558f8ab-3d815b70372mr56966505ab.20.1744879106169; Thu, 17 Apr 2025
 01:38:26 -0700 (PDT)
Date: Thu, 17 Apr 2025 01:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6800be02.050a0220.243d89.000f.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Apr 2025)
From: syzbot <syzbot+liste217d44efb9077d8089e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 185 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 428     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 157     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 67      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 11      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

