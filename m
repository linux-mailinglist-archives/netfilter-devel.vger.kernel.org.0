Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E232C44EE13
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Nov 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhKLUrN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Nov 2021 15:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhKLUrM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:47:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85FC061766
        for <netfilter-devel@vger.kernel.org>; Fri, 12 Nov 2021 12:44:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so42567678edz.2
        for <netfilter-devel@vger.kernel.org>; Fri, 12 Nov 2021 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=htlSI9PbweXay3zAqrSqMP+DpA1ClH8JSrIOkKm4ThM5VQWQeSQcQTuWqsEfU+IDbe
         QIUllEebtflPJL8Cv/ENnzIJTDRXjeJPxnccsg30WJ4yh/6GCPQx8bZfjt8NAF4Bh6Vd
         1rJPvM8EESgHfctOmZ+HPr1SV7NkIGVI9BqW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=uRn6TKlsHJ/+FZIlPs7l5JRKgj39kz8vqZ03GlF0YDuvTJ5gHzg6a6BHapV8RsoxQ2
         d5v0sEAjWLForicYQaTORSnU3z5MaEaNA0x1HB/9sHYJoGZkY7E/5nj+VHMpF/gZHUMu
         9P0stJPIRYbQ7IDLd9w7yOF2JyZU3g4icNGRhNh0dYxiRoaiEin6E2JRMZnrpOUkngRl
         8rUd3Ulec7DCaq0yrt2w4iQeOtt3UxGOu3fbXof5k2dgn7VipMQ0aJoy1hteHeUX2sET
         lirg5TzWrbJbtrC9xDIhhP4ky/o+EdaNW0o6kV0SBiAshvLegzuTb3YNnnxXF41w9GbW
         h7vQ==
X-Gm-Message-State: AOAM530fuMu4KHOPL8dne+NxsyL+ibDmvj0ISwSAjCcK5z46qDwFT/Hm
        SD7nG1YnqfGVPyJ7NXLYK5uJ/d3anSgobW2pfsw=
X-Google-Smtp-Source: ABdhPJzk5o3yfQMBM81gfT1e0bxbZnCSHO8lkvA2VDEXALIYpwkeYG13AHRzkNogxfUAJrlnst1xqQ==
X-Received: by 2002:a17:906:2bd5:: with SMTP id n21mr23101875ejg.337.1636749859164;
        Fri, 12 Nov 2021 12:44:19 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id r19sm3394820edt.54.2021.11.12.12.44.17
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:44:18 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id d27so17655045wrb.6
        for <netfilter-devel@vger.kernel.org>; Fri, 12 Nov 2021 12:44:17 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr22056131wrm.229.1636749857666;
 Fri, 12 Nov 2021 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111163301.1930617-1-kuba@kernel.org> <163667214755.13198.7575893429746378949.pr-tracker-bot@kernel.org>
 <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 12:44:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Subject: Re: 32bit x86 build broken (was: Re: [GIT PULL] Networking for 5.16-rc1)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 11, 2021 at 6:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>   +#include <linux/io-64-nonatomic-lo-hi.h>

I committed that fix just to have my tree build on x86-32.

If the driver later gets disabled entirely for non-64bit builds,
that's fine too, I guess. Presumably the hardware isn't relevant for
old 32-bit processors anyway.

                Linus
