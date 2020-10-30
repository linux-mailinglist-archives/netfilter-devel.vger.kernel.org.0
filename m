Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C274E2A094C
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Oct 2020 16:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJ3PJc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Oct 2020 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgJ3PJb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:09:31 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767CAC0613CF
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 08:09:30 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id m188so5394489ybf.2
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=9fkQXWnoPSypfyxvIrXWSyd1r4Ua0eeDJczOBpIf/BU=;
        b=h7mhMMJyQC+m6Bmn+IYUapYZ8RnGeHVd3ASo+V4hqsoVRmxtRQf5exNgRinJkzi7oa
         EQki0FkKCMvOBZ3DBk+Gx57E53zyBZKjIblewa466Wt6uUrJYOJfnV+lppVLEXJlaSHl
         mhP8Kh3huQ9UDUHMFqvJ1PKUne7RW46+SzGJ4Dp0ZyLZDJESzN8v0aS3zE6zPQ+f+QxR
         FCtIMrM8A/Y4+9f5eEmOhe0x3kmfhSfdmWwmGRUUO/Gey1V+h2tyN1+7jgx14dD6UD+X
         rusZ6+EHq1NDtbO3m6Zpcwp8fzFoubbix26NVopl6zlXpD4fjtLrj6c1UCrDltM9gdDw
         tjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=9fkQXWnoPSypfyxvIrXWSyd1r4Ua0eeDJczOBpIf/BU=;
        b=XJLKU0DkfKyLhjLKeDVqX0zLPRcK5vepAFmCGWM0qYSLkf67gNMKqhmLEYV9FcUxm+
         NPhZlvqMZq+lJwa4jaZuUhWnsS/5EM/K1/71n4zQ4lLgI9oLkx279iI7XBxCBBky7RlS
         xJhp6eS+nN7GSWrUgY0C25lxNsNQjQ+9PgnMIxHk4r59h6FrgshNjFbxeBMkeDJAN9qk
         HevyzJ19J55ckI4KkxBBs4TZgLaBEbpeWuTTS+2/+IeCX9Y39YQNh9KzOcsmNQOF+nym
         P3kQ8wulnEU0Ot+bVcVSA2WKgVVdHwDqC6mX0ldecMqaGumGGHY+xnCsT7Kyu+tM2Pcw
         NTpA==
X-Gm-Message-State: AOAM532caClHZJMXR2SGcy6VR/Oio9nGjD3JA66PtBAsnGMPJ37sH2q2
        suhbAxmsZ1jtB3Z94pxDhLsxqvODo1ZErw7IOP8=
X-Google-Smtp-Source: ABdhPJwfui+HkSsbq07Vu0lFxxC8QkIDY6MgdwTu4cRLDciRIJ2HrLvfPTIJw/f+NYt9xXsQIQG0bLFv/Q/Fq+Rujrc=
X-Received: by 2002:a05:6902:4ea:: with SMTP id w10mr3966802ybs.379.1604070569747;
 Fri, 30 Oct 2020 08:09:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6d2:b029:2b:3c03:52a8 with HTTP; Fri, 30 Oct 2020
 08:09:29 -0700 (PDT)
Reply-To: li.anable85@gmail.com
From:   Liliane Abel <k.griest05@gmail.com>
Date:   Fri, 30 Oct 2020 16:09:29 +0100
Message-ID: <CADvfYkv-jucHbN+N3zbdsYUNQvTgKE6oB32EYHERVmw8VYn9Xw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dearest

Greeting my dear, I am Liliane Abel by name, The only daughter of late
Mr.Benson Abel. My father is one of the top Politician in our country
and my mother is a farmers and cocoa merchant when they were both
alive. After the death of my mother, long ago, my father was
controlling their business until he was poisoned by his business
associates which he suffered and died.

Before the death of my father, He told me about (two million five
hundred thousand united states dollars) which he deposited in the bank
in Lome-Togo, It was the money he intended to transfer overseas for
investment before he was poisoned. He also instructed me that I should
seek for foreign partners in any country of my choice who will assist
me transfer this money in overseas account where the money will be
wisely invested.
I am seeking for your kind assistance in the following ways:  (1) to
provide a safe bank account into where the money will be transferred
for investment. (2) To serve as a guardian of this fund since I am a
girl of 19 years old. (3) To make arrangement for me to come over to
your country to further my education. This is my reason for writing to
you. Please if you are willing to assist me I will offer you 25% of
the total money. Reply if  you are interested
Best regards.
Liliane Abel.
