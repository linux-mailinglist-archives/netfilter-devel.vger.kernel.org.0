Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4E3E2CC2
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Aug 2021 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbhHFOfJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Aug 2021 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbhHFOfJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:35:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8598C061799
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Aug 2021 07:34:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l19so17016906pjz.0
        for <netfilter-devel@vger.kernel.org>; Fri, 06 Aug 2021 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/oMubRmlLM5EZ/UdY6Fj3wsfS2kyoMzN9ASXgZ3xneY=;
        b=WwtirH+AN5QEGc+PsYDg7GPmicCeAO3NPEqhZC74A3+cGIN9TIFUSUQWVdp/dEeJ0X
         ++0akNbjsW/3xJMMbrUcWsaDb/Yt8FhArvnBGhYYupKONjpXh07T85TTJ6z/R14UeK25
         VfrKT4PbBRG9FpAA5mPltqAa33Oy6oNBbUHIMXxZ8Pb8DDymDVISOJ0z/+FU283l+PC4
         CL/S0Mt/1jGAvk934eTBfkPJMYFqxNe9DmuvxRe6nTQgDgkYbQOxTC8k7gZ9Je0QkKHX
         pj04+ieraICgLCEIDsM+PSxXHeP7MukFzwmFuXJEWjT/gtCn4i9C831/d3PQ2UrLasbD
         Q6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/oMubRmlLM5EZ/UdY6Fj3wsfS2kyoMzN9ASXgZ3xneY=;
        b=DQslJBUII1cWzImJeU+Wx43+xG8Sp2QVNk/FjMuboN1/yjpriya0T6eQnYjjJHfNjk
         ThO34l39tiQ5Ag6/FC1tgqJF9K391sVK/vHNcHCvnkGrOhtxwrtXL/rJTUAEERGdrYl0
         UoFePx61hB0xIvSL4XdvWIkMY3oCryF9pb0os46K0AyHQU/8tRBlDaDh5JbazhRe1Rv7
         L3K+K2df49VEuI7ctfa2Cz/2Xpfk+JzWi1fvnPyTppNvjbNjqLugpRNdviUQA59PNOUF
         2U9rpMZSBYWYgbPh9PUcgAS/37oXlvmulbUHm8gtiQ0ZGypUq9W3t4W+48wCryPUEnIt
         mSMQ==
X-Gm-Message-State: AOAM531DFLOC90pK7xUNOWXnYRJtqKLOW3jylV5mmzVDMeU2/6w1R7Yz
        d7NsNWYYD01Cv4iZoU4Y6zC0wm+OoGvesC/V7Nj0R6QcpDF/Ig==
X-Google-Smtp-Source: ABdhPJxp5ET5L2YTA3wanMtEqCHLczOyx36yHFnFg6UZI0mLKFWZaADmnk+VVmvj6+SDnpgqRgA+ZQp8fhbmG7dX2Io=
X-Received: by 2002:a92:d088:: with SMTP id h8mr67865ilh.165.1628260482824;
 Fri, 06 Aug 2021 07:34:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6384:0:0:0:0:0 with HTTP; Fri, 6 Aug 2021 07:34:42 -0700 (PDT)
Reply-To: mrmaxwellwatford@gmail.com
From:   "Mr.Maxwell Watford" <matinmiller89@gmail.com>
Date:   Fri, 6 Aug 2021 14:34:42 +0000
Message-ID: <CABQ=EucNt8T50SyY_xMhf4eA-+FY+vTpH5-ztzQHBLq2ww-40w@mail.gmail.com>
Subject: i need your reply
To:     matinmiller89@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Greetings,

We are writing to you from Ecowas Finance Controller Office Lome Togo,
because we have received a file from the Ministry of Finance Lome-
Togo, concerning an Inherited Fund bearing your name on it, And after
our verifications, we found out that the funds belong to you.

It has been awarded and I will like to guide you to claim the funds.
Please contact me at my private email address
(mrmaxwellwatford@gmail.com) for more information and directive

I am looking forward to your urgent reply,
Best regards
Mr Maxwell Watford
