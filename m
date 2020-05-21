Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7A1DD9D9
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2020 00:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEUWGK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 May 2020 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgEUWGK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 May 2020 18:06:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B31C061A0E
        for <netfilter-devel@vger.kernel.org>; Thu, 21 May 2020 15:06:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l15so9858630lje.9
        for <netfilter-devel@vger.kernel.org>; Thu, 21 May 2020 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DZ/FA/udYLQhkcdjrjlCIMnUB3kRziPJ7IAgVq44WtE=;
        b=Q/vBtEY6k4FEhxyLF2EY78LcfekP2UlKuR/T7f8dc1LOhSMnGHSjvE/Zzv6bJ4wkwc
         ftSe80v37MH2+cxAn/nnxb2yVx7aqBmMRW79LEK7BG+fDnDkfbY/AE1CuZKFqXHL84Gh
         WvkdNUaDAn7lqOs1p5N7Ukke9dk1a0F9BJ06p/SiCWdN17l+cN0YqNcyS2DK8CtoNUWw
         9PXugL4QnjsK5+2p+whKrOasx/TTc7ty9wRzrhN52smEBjMqCdwx9OkdLZT52WeCN5pb
         HOc/0k5FpOrjjRcqG0l64JxWtQp233sp2ttaBgY7ruScETzajKF5ZcSYBGcJOibta6QX
         OwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DZ/FA/udYLQhkcdjrjlCIMnUB3kRziPJ7IAgVq44WtE=;
        b=p360MiSxKJ9uGaMt0fX9/YoTXkMVHPF+hfgwCbIFOzaLVQiVqg7xdGwtCoq5DJ2qDl
         FPOCOWgzig/MkpzXlD6ihOop0BosQz5u5oZlPS92JUpO3niz1Gip77bZoPFzgAuSytUX
         IRDBezX6+bxCSmXFZBOQg7uwZPlzkDAJu3z9vawxKe3hUOvafWz7FDDuDs5mDDIyMVWq
         C35+BXyIdm/liG3+52Tyliz18SFCiNXDkXxScPBB6HJjIC/EF/mssGfb6xmmKc1Rtyld
         UMPyQNqoAMz+60Gg/+7/VSUR4iD0LuqNr025K5xyGPvZlGzgixDFqUt0ByJL8WgxXN+G
         EkgQ==
X-Gm-Message-State: AOAM531K+C6mITRzmRiP/H+oP7LufG4O2Vg7TmGuNT1MjzlYjaMSQgFN
        FJRHZ6oiR1HOW5NZY6YB9NaZ9zZefp7Zq/z0lrcaPMwF4nA=
X-Google-Smtp-Source: ABdhPJwQn45ioPDG+HXg80ERHFq3dw1zm2G2YJkGnGNMWivrf/DzW2bWDfitsYLjRVvglk6IbOtmIp6yG5Xo+k1WRvQ=
X-Received: by 2002:a2e:3309:: with SMTP id d9mr3535147ljc.401.1590098768680;
 Thu, 21 May 2020 15:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHOuc7OX=a0OjLpyJf3bU9sfmrd+_XbMBt+JN3w1QeKGPod0pw@mail.gmail.com>
 <nycvar.YFH.7.77.849.2005212305180.7617@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.77.849.2005212305180.7617@n3.vanv.qr>
From:   Oskar Berggren <oskar.berggren@gmail.com>
Date:   Fri, 22 May 2020 00:05:57 +0200
Message-ID: <CAHOuc7O4P0kO64nH0sf+cuoXuJrOFD85bTZ0Xprqp9A2dWbt_g@mail.gmail.com>
Subject: Re: ipset make modules_install fails to honor INSTALL_MOD_PATH
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Den tors 21 maj 2020 kl 23:09 skrev Jan Engelhardt <jengelh@inai.de>:
>
>
> On Thursday 2020-05-21 21:27, Oskar Berggren wrote:
>
> >make
> >make modules
> >DESTDIR=3D... make install
> >INSTALL_MOD_PATH=3D... make modules_install
>
> =C2=BB make modules_install DESTDIR=3D/tmp/RT INSTALL_MOD_PATH=3D/tmp/RT2

Ah, cool, thanks!
