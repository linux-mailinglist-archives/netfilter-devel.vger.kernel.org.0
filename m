Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024A7482755
	for <lists+netfilter-devel@lfdr.de>; Sat,  1 Jan 2022 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiAAKln (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Jan 2022 05:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKlm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Jan 2022 05:41:42 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83CC061574;
        Sat,  1 Jan 2022 02:41:42 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so27540488pjf.3;
        Sat, 01 Jan 2022 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=Yt8vNYQAAK95dzSgvlKhcBmDDOtr4TluB8u8Suf0cAfKFGkIFSrcywDheRENkVtl1C
         feMPrIST4BkRD3M3Jh+ivCTkwkvZntvSGK1nMHzccNJmEndN/X+4a+mCOlDMW/4mHlKP
         gM50SyXCIbcfIaNgZseMM2vWVa/2VzSrJoKPKe3MoXX7qfu96Li1k5VwL8Q9ZPGWgAFp
         1cPlXKOdKRpe1x0f6+eO00pvr2vgAWQ7g512jLwvrA1CGa2EeexywA7L6sSa7x03I2sD
         CoDYQUQafVCG0qGsPQB6182eNNufA3EqbDckSaVEnDKCGtN2DOMAOtEWmafJ3RPe95u/
         eIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=MAn0Hev2ZxWTGLkY/7VmOePZOOOGPTHhnEFMWgudZ/8FAtWH5fK43mNHcLY0zK55NS
         WY1/XX7Dd9G50zMZkIFp8kgZFp9JZfpWt/bh9Iw/9ntJIMIiwOSgDRzsatS8sa1eOGKC
         iJe5J98euFVz+vQ4GIIYpP8LFsC5aAgxCK6t6+H5pRTu4LoPBzcLjPvqeCavKX8Pvc+w
         ieNXvd0d2MN+adtlhwlc0ywW+pMg4t/5xEfwI+EsOeaZ9s0p96xIsBOoTRoM2xOzXANf
         4vXe+FqhPHo9RFfIYNtXcp18J8kfhSACB2oDvYioOtoOJDYve71SBOsWMGCTg8jfNVT2
         /SeA==
X-Gm-Message-State: AOAM533VycrdEyouDl3AUbtshtwaQGQqbbLB9SdWWIR/TpbEnBGjenbM
        lZ5jgL2TZZ2HYcP+hA32BIc=
X-Google-Smtp-Source: ABdhPJwKFj6Gf9cfMCCy9natrauGoSUadaQ0dhQMb5jpbldxd0YnaG1stPeSGzsI8XGvIIK3waH7NA==
X-Received: by 2002:a17:903:124f:b0:149:a740:d8bc with SMTP id u15-20020a170903124f00b00149a740d8bcmr9393324plh.79.1641033702226;
        Sat, 01 Jan 2022 02:41:42 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id m13sm27022455pgt.22.2022.01.01.02.41.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:41:42 -0800 (PST)
Message-ID: <61d02fe6.1c69fb81.1bc40.c0ed@mx.google.com>
From:   hyaibe56@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:41:17 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

