Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA7482790
	for <lists+netfilter-devel@lfdr.de>; Sat,  1 Jan 2022 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiAAMQG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Jan 2022 07:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAAMQF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Jan 2022 07:16:05 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E09C061574;
        Sat,  1 Jan 2022 04:16:05 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so11298267pjd.1;
        Sat, 01 Jan 2022 04:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=HSU6LlS58bEpB2J45ld4n8BOAbMivRHz77brIBOBowv5JbA+Uz6p/ymiwQiopod6S4
         8Bf54atMzqDYm1C+aLWWrdAvj4o1xhFyNL0+lwKLaBLWIRrqHx5csHCREAjABDGWKXuO
         uUKtNXzgRZvaw/cKPrDVt3kZ/z0p8czA7pAEyZ6W00VyDjuqdIXi74GFuvTb6rApMBvy
         Cu4OkY6Qpze8obTuwzLq1M53+70FT3jB9HyigA5oKI/m3gC0/XlbZTzB2Qsu/0Nm/wfu
         hxep7hvpYGPs2aXUZnlKDVq9X/t+kI/tdKTy/0VrZ8/poKZA3fHiWGNXue5LIvH8BQyr
         OHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=D3QY552p11iTvH1+4YbnOwsn+Q/eaBr1QqoJN5EPsb9CjW1Mr0/MzeIKPeNgnJarQY
         VTSqdZ+IO5zrS4hHIT7Dhv5/0cJFPz9u4IVVv/eAa6QJlzd92oCoeUXeeQrVBmQRteBC
         TWZG7KTf0MPBapBm46iX6LNXpDkwT55sFHbRlhH7OPzp2qI1xcoxgRyhDgLcFSExv6hF
         ORFW/ewsbuCPKRB6+V3wqi9pZM+hkgxUtdd5sfS5HkJa2hf6okPLY4S5wPTY5geUfZEA
         tloegzfXkasgjrxLo6PGPhSvWEky9uAL0VekPXnvLLZ+Ul1LaqoDlPbZ6lPqMgu8RqpS
         1LFA==
X-Gm-Message-State: AOAM532X0t09/+jeMRDWvGzAqbMx9+EYrj8Hl0kIzfIqArvNZ7/aLCYI
        xzwTYpNM0VYF4FHy4OmAfgg=
X-Google-Smtp-Source: ABdhPJxcqPaEo5gJbwaydkl0dADMvTigvyowjWFDsOIK0aFvKbynYkH7Vo8Ml3ckCsxMw6HNV5ErHA==
X-Received: by 2002:a17:902:7617:b0:149:9c02:f260 with SMTP id k23-20020a170902761700b001499c02f260mr15492300pll.30.1641039365075;
        Sat, 01 Jan 2022 04:16:05 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id u18sm34504293pfi.158.2022.01.01.04.15.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:16:04 -0800 (PST)
Message-ID: <61d04604.1c69fb81.403ef.ca38@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:15:48 +0200
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

