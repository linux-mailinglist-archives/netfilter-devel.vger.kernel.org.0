Return-Path: <netfilter-devel+bounces-8394-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D86B2D5C9
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Aug 2025 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E1918942A9
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Aug 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F72D9EC9;
	Wed, 20 Aug 2025 08:11:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955292D877C
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Aug 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677499; cv=none; b=kw2c9SwGwxQBLwNd+eMjhHVk4+hM0qVoJiEyJL7/Bs14MK7qPntNO0KyS5nX4GXdgfw4LgWFsQes7b73EwIDYKSM25UYxuceJtAPwt3wR1JMgqDNIgf9HTKBmYLcqbtUE/50/sf9KbQ6cRTpmdU7T5dqlnPwJl6I6pPyyimHwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677499; c=relaxed/simple;
	bh=V2ORPdLKdyIF6IEfPL3tmlEaAeXzXJCqBpmsLyhacgY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=osw4Ulm74dnG1PnHayIGNQJ0ZDv1xWdWbWkGRCJW4bqQIBIYWyHkKahqkE2ABAiHN/2oi1q/LYi7pzwGOBeli82/6OESHrkIGPl0a+i5nLgM5EwJyMT+c64OPR/vdoOF1dnFNJPYwJ+Lp7yxkuFSPDfpFuSMK37BkVubfRTO43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432d88f64so1707132439f.1
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Aug 2025 01:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677495; x=1756282295;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfbB1FSHiw6P4C31LBsKWDW7GmtJlZq19wObesXeHDo=;
        b=GI2mtvQA74pAZdgI2kuRx66SCNptdrEgz7aS8TZgdkh3MinaRo+G6fxqbNgFUB+lIK
         KKtdi380q/Wnc4l3E4qgimrzhXJgZWUbfhVuSsm2JIKCf2hhZbhlVK1jqymxNCNM88Tx
         lcBJnMhMCVBSpeuoFOkJo4qViosipV0nlVr1SrpLCyK8DDVcU4QgIbkPXEnT+rneYoyR
         xjYyUTj2TQ480386ITRC0J4EGrg6+yDHtVJv+4WyDxreaEZTQVS2fClfNX7JaujrV5th
         JTXZErGl8gYaHQYbTiEdvp0NzlOmMqim8P0VqPn5vbpIob1TZKPHvjX/n8WtsElXLqQl
         9Wtg==
X-Forwarded-Encrypted: i=1; AJvYcCXeoVzGP3y8qO6Mn9Vi4ARWBwuhzuD1+sVJZFNremRyb9X7293lIwdmxBVQAfeAfhiODsVfocrlVhkMPQV92Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExpKKnxoSn40tgzcfqdkocbt8N7ZoZdHsu0LidrakHy2RcT4v
	n+ka1VdQAqhOwv58ETA3h8cbgGwAMRtkPwMRGsxjS/3jDFma53qJqGzUrGQuxI8p3DKC3VYgY0j
	owQ3S55e0hk6NlrSDrQft9A6ygudwSGt6ZZpl2s/JsoA6UORgoybr7q9cb/o=
X-Google-Smtp-Source: AGHT+IHnRF+BVNV37CIIil93Du05nxMCfrOSZyzGWdOXk9nJ995NrsrdEI3T3s9GiJy67Kvuu4cXP2vILSqqRV705ZzYbnkNZ5za
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2511:b0:3e5:50a5:a7ef with SMTP id
 e9e14a558f8ab-3e67ca7243amr37639535ab.15.1755677495685; Wed, 20 Aug 2025
 01:11:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 01:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a58337.050a0220.1b2f6c.000b.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Aug 2025)
From: syzbot <syzbot+list9abda43ae935f9073c3e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 1 new issues were detected and 2 were fixed.
In total, 10 issues are still open and 191 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 552     No    KMSAN: uninit-value in __schedule (5)
                  https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
<2> 203     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 104     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

