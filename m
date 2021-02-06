Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03A0311DDB
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Feb 2021 15:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhBFOkA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Feb 2021 09:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhBFOjy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:39:54 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE6C06178A
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Feb 2021 06:39:14 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id o12so9823549ote.12
        for <netfilter-devel@vger.kernel.org>; Sat, 06 Feb 2021 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=U86T9aBtyi70OsKIRDepEOEj62kPFcZD0vyBir2KyOyq/qRS9cbBSAetVzdhWAWKLy
         r7+Up5WRsFasn+an1ah+bDgPum/NFrEly21eQV4XI4lvE8urFwgm8E/JXqGHAUTLXFMI
         XR5wwduKqSRfUXH+a/23dDO11fA3ffHSjqyI0XIsHD1RUJGRCTACFbB1d/9cH5Y+xWAY
         KH8ohbAqmh57S6A3/T2eowLOP9IEHKzcQ4IIEzNJFyL1iKFT1s5dgoMvFa2xT2rMSSaE
         MUBYUu6uP4R9BuQovRj7ro2osH0OqhupmWJSFyRQdUPjMRmgicZsV29ktz3wzgK1VnP5
         J0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=r0e18kTYiu/NREUHQtNnMb9sSIu9uES/ALE+l7r5j5gRtCG9GDG+v27J3o9qnqiNOf
         sNBMdtgXbIrvB4Je5LzXkB063wnwsMsJQ7DPtYmmNLXQWmC/Heqr9iO0wUHWRBJQGo93
         FyLoJCDcDQ93xEhQ1LJsKRxYwqlfIN9I5OPjDmTwUL2apz4uo6znUt7ChQcw5/2dQMri
         oDZ5vqdNfIrmQr0Y7GI/N+yvDmhluLkGOnrNoUrXVGvpG7oNuQSJZerQQ3NCQ33wb0jK
         F8ZPXRKaWRCrSYHk9PZEzQloqUxTzjFxv5JWFzuo+59sDHk70r1WJQdJeq2NPcE70JjL
         1yvA==
X-Gm-Message-State: AOAM531yZczfSIpT8VZ0PNOfFTi7UWWE9bDJr5tililpSA6hCXvQS/JN
        o0NSMUNpsE2YeO1BBIDbceaTa9FUgbz7N1fnOoY=
X-Google-Smtp-Source: ABdhPJzemuc++HfkzpZjEGrZ7w84O3yT+AzVJK9+3EYUNItGOmdUNtV6wCa0k20TCb5aqJn8kWa8jt13uZwjfgHetsc=
X-Received: by 2002:a05:6830:1318:: with SMTP id p24mr6861366otq.302.1612622353656;
 Sat, 06 Feb 2021 06:39:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:39:13 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:39:13 +0100
Message-ID: <CAO_fDi9Pk1D6EeeMtarfFSuyA+g6REGEoPRYFdOUeGv3H2xHdw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
