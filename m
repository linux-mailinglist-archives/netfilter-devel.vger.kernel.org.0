Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7F1F9D9E
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2020 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgFOQjy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jun 2020 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgFOQjw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:39:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B08C08C5C2
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i8so3458145lfo.4
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=hYqsrzQyaCq1kQgp0spHAppAk0hS2j5g++6SYxCLxYxJXAmMfKqTQ18qJkn1C27/AG
         eJGDl4TDVRdRqRzTxahAgnZfaGDf0lo3JVIvuqg2IKhggaqVKPMvCx5tTM7h4m+tvAMI
         wN5LBnLvHufylZ12CACwK78MI49zcsJYaDln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=kRjIF/T3kds9yqrv/Kkqk/4MnoK8coZdywviaynrwxk/gounehOp5iUNw9Jfa3V0BP
         Fq08AZhD/0Bv0UDk9JvnENVSCY4y3VhwsDPiWJbQ+HIFJPhP6VJ+IXIfjO+49e7SJcp3
         TBYBb+VVAeshjAS0GbiTGxpHgQDeuoMeJqELKtgSQOcVtfUSUmdCci8XMp8teva/L7d5
         rCKBQex5SSADyfH74XFoSZUmWDYJZimGcD1XfI6f29duDsXXCUc0BzMDvYuPGRMJVVOW
         vxFCLTDzooFY6AfUm8p3y0puw188gnbQuHoLMoweeED1fRUHANeJ2cqcdLXRDUdc2z2m
         YHTA==
X-Gm-Message-State: AOAM532dnBXLnUI2r9Oj818M0TIWruD+YIHbXmnRKRRHBjWFQf6/cUAr
        vT+34BG8vsAQnAEPaMlRfZF6BW+0vKc=
X-Google-Smtp-Source: ABdhPJzY4Lu7JGF9TJ/17Goic81Ejvtq56VSSrfsNbPeD/PipAl/CkFef+iWeGOgnTEY4Va/fyOwiw==
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr14096557lfn.77.1592239190006;
        Mon, 15 Jun 2020 09:39:50 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t13sm3906751ljg.78.2020.06.15.09.39.48
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:39:49 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a9so20016207ljn.6
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr12917365ljj.102.1592239187960;
 Mon, 15 Jun 2020 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-6-hch@lst.de>
In-Reply-To: <20200615121257.798894-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:39:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] fs: check FMODE_WRITE in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> We still need to check if the f=D1=95 is open write, even for the low-lev=
el
> helper.

Is there actually a way to trigger something like this? I'm wondering
if it's worth a WARN_ON_ONCE()?

It doesn't sound sensible to have some kernel functionality try to
write to a file it didn't open for write, and sounds like a kernel bug
if this case were to ever trigger..

                Linus
