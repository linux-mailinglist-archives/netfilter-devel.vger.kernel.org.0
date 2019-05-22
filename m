Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3AA265BC
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfEVOaa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 10:30:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43416 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfEVOaa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 10:30:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn7so1162225plb.10
        for <netfilter-devel@vger.kernel.org>; Wed, 22 May 2019 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m0QjYyjO2xHrKzFzTehhWEPphtJIzzFFRYPzTW3DMQ=;
        b=T2kYxw6M4VFwvrSg9HRUF2uPooKZ2Dk6AmNuLHygKvbtjUp1C79ABGleU4NpWQgtG+
         xyNerFhZb1XMy6mw5lQzehrEE7/NBqYQPzUt9jvyTeLj9vsYw3pAry+y23L3yjfCjhDJ
         yoMBcgsNSAsgypmbF99mRLSytz+s/UDYzeuQUPzFC6WTuCtGRKRYUgQx6yvSE/FxlWH2
         pqRUDuI5S4wSMke309nhIOWTIHwzEzKiKdSXZRidURLm26VHEBEOC1iIc3U2gexz0ynG
         vOxHFexpwwsDmgzyeSI00gmNJ0WAnYhTVwEa0K2+6EZjiULYXI9ZcdenQdTGsT3HwctH
         k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m0QjYyjO2xHrKzFzTehhWEPphtJIzzFFRYPzTW3DMQ=;
        b=dTV9kRqd70gqppDIskMtQ5NmHBOkTSbHQ0lirtMo6O7+eLnnKyjXFFl0eGd3F3CTUN
         7t2frxzJiC8Xcyouvo4l1t/kIvStJ8hb6d0nZ3GnmifuHQM03oam9oJf2Ec8JLSIhtPI
         gAZAh6bl8UdUAK/C2M18EEOU4oSX7eisBp3SNV3g1PaSDQIGBKzzlGfVPgPzSltCeTxh
         cNElvW+wtICaWAB3B1CSMrLaS9gF1IJC4Kuf3PW4clEZXMslDh/+RDI7t393wOJqlPZV
         dr32MJr3lbeJIuK3LuPYt5Y60c0oabZ/AniSOEiMGr1EoLiKP7zaBcdWzGp95g84+t0j
         6qnQ==
X-Gm-Message-State: APjAAAWN0dZFVFsakKK1c0ua3sce2C1LwS1+OfUR6XlMxOnLtddGY8Js
        WuL5TF1pOQv51t5XF3MSJciYjfw8jZtJ146Vs9+sHg==
X-Google-Smtp-Source: APXvYqxvo1fFJOMp10yWhcwkQF+EVwPZOIUCu4QXMKCMejzytyZV3guibp+FcWp+LRDJRt9vDpZ3/2/a9GARbq9GNuo=
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr15769604plb.187.1558535429532;
 Wed, 22 May 2019 07:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190515064405.3981-1-jeffrin@rajagiritech.edu.in> <20190521181125.anqj32v3gcwjxs3z@salvia>
In-Reply-To: <20190521181125.anqj32v3gcwjxs3z@salvia>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 22 May 2019 19:59:53 +0530
Message-ID: <CAG=yYwkAUzGZWdVpcjRScARyOyO9KaTCL_7LUxaav5os+6rsEA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: netfilter: missing error check when setting
 up veth interface
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thanks to all !

On Tue, May 21, 2019 at 11:41 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Wed, May 15, 2019 at 12:14:04PM +0530, Jeffrin Jose T wrote:
> > A test for  the basic NAT functionality uses ip command which
> > needs veth device.There is a condition where the kernel support
> > for veth is not compiled into the kernel and the test script
> > breaks.This patch contains code for reasonable error display
> > and correct code exit.
>
> Applied, thanks.



-- 
software engineer
rajagiri school of engineering and technology
