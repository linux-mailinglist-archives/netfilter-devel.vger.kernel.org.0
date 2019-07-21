Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC946F3BB
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfGUOnw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Jul 2019 10:43:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43491 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfGUOnw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:43:52 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so68351917ios.10
        for <netfilter-devel@vger.kernel.org>; Sun, 21 Jul 2019 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OA/DzGMDK+swhwdTm/Hv7XU9V7bcVzmu2vMEaYY4Z0=;
        b=RLOmVEj1KzIAZ3NSTNsRj/HHo3ygHDFZrXgrkI9sVgu7T89wf359YJ4R6y4SR9D/tI
         4b4t0c13iuE9mGQ+5V8yPDtUxswMLvMz3vDnCQsJikFyt/0fyCEul39KAdY0oiDSMHbh
         aPvRXF/TWgL1CvqUP7sRFc90NB8uWZuAPBZ2ih1ACIusfQrW++8QLhphkQ/Rc3ybxJoY
         1tMfJxnmWm7s0qVxOds7l9nfuyX5edyauzfSxI2WhOhrO+dc67b/1ZnrA1hAIZy8RuiW
         5msiD2XfXu+dxIXDQ1rY/qLWAUA0Bs5/iPfSGNW7atn98Y3doFCnrAnh9Nyrnq4x7Y6K
         3pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OA/DzGMDK+swhwdTm/Hv7XU9V7bcVzmu2vMEaYY4Z0=;
        b=YujiNxdlw/Jgb+OceXPsb7nO4p84RMv7MS0+CHORFkl19cg7jxDp677aidIkQ5CYrD
         kHWpzyXQ99RXMnws9zJ9gy8spURGg2ri1VsSNNZhqq65Zrt/9Ta/p/fb38igZv3sT/UB
         Qd867rx9rRoPKBSgPfBzRFjwY9GKgTUPa34X065OfBMyFyPArcs6w2R2dHagM0zJvby/
         kV4Z/alR0VO0OMPiaf4S7XEaY4n2PyK5QOP5b2+ieYR8MOgG3COJ8NBP+XSi1DLxkJag
         PwFJ0HSkhv+TwG3yE0h6lw5Hx0fDVLFnOVQWNhx4XzrY4Qjl5lhylpm9Kd4epSyHUEZR
         /CkA==
X-Gm-Message-State: APjAAAUm4oLoj9oUryyMRCkYAj9vWoaYAt2l2XSVOqamfjQRVELkaPBo
        Kpfp12c8IMSBHmqvGKPrHMSt8E60+/38ustnAcYVHCQl
X-Google-Smtp-Source: APXvYqyxcSl0s3fk2rQrFvrqudnmMkiwTrZFdh5F1yre1r9hU/M2G1dwidoFFxD140EsJR4O9WTLgG7x9EeIV6STtgU=
X-Received: by 2002:a6b:6611:: with SMTP id a17mr37025429ioc.179.1563720231505;
 Sun, 21 Jul 2019 07:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190721104305.29594-1-fw@strlen.de>
In-Reply-To: <20190721104305.29594-1-fw@strlen.de>
From:   Jones Desougi <jones.desougi+netfilter@gmail.com>
Date:   Sun, 21 Jul 2019 16:43:40 +0200
Message-ID: <CAGdUbJGe8zYLBG7RwzXac=Ts1B3_YQ4gnO3hNBs89MmNTMfg_A@mail.gmail.com>
Subject: Re: [PATCH nft] doc: fib: explain example in more detail
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jul 21, 2019 at 12:48 PM Florian Westphal <fw@strlen.de> wrote:
...
>
> diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
> index 6eb9583ac9e9..124193626aa7 100644
> --- a/doc/primary-expression.txt
> +++ b/doc/primary-expression.txt
> @@ -274,6 +274,12 @@ fib_addrtype
>  # drop packets without a reverse path
>  filter prerouting fib saddr . iif oif missing drop
>
> +In this example, 'saddr . iif' lookups up routing information based on the source address and the input interface.

s/lookups up/looks up/
