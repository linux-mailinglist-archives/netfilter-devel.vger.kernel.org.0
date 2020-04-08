Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDD1A294B
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2020 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDHTWA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Apr 2020 15:22:00 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46632 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgDHTWA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:22:00 -0400
Received: by mail-ua1-f65.google.com with SMTP id t1so375301uaj.13
        for <netfilter-devel@vger.kernel.org>; Wed, 08 Apr 2020 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGCTrJygLikFxoCFs8DccL2dg1LmyTyS+3ifIejc0BU=;
        b=BlpReYOZWGI6cGqGSNorbMCF3RPZS88tLPM2FYh3+LcgwmxA688cn7x0QjQBnjSOlT
         zCWxTegt7bPDqjRgfOiv+xOPFmOSAyxbqgha9qjVX3UuMgQ/ajegvuS3aDBDFBEIHRbU
         2W1Ibtu5j38QnGvV9S4t+6jT1ZHuAgMonN4wZBWImt9pi+sDx5FS/VvGckEbGfx0BTum
         mRyGZ6vC35VKwThVLmYGBLkXYVPjtuxRJo1q4oz24TFGusMwfrgOAfH4siSE2HVgVK7j
         vhwJ1lT0pnUyI6AX00Tns+w6cByriLDEt7j6tS+CH6v3CqITRrT3WdrJ3M7HT9AUJ5LW
         +ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGCTrJygLikFxoCFs8DccL2dg1LmyTyS+3ifIejc0BU=;
        b=Wi/ZBxFD9RUNwhMjyiNYAp7d3co69DDolQgqXXBmQbP+WmvPB4e7F7qaqwFDcB8+SQ
         RRGyOihicP+qCowLUEy5OSiM7n6rrBr2G/c7lnGjmySYKeI1nFB7Ux0vl0enDZPcvpDu
         AECeXbU/jtRyk1zu2VJsEvHH1WnmX4N3a6CB9GnhoKWEF2266T9xhISIGfvF+tt4/Rh/
         88eoeU1n4CANsSkI7AorC86gY4tgobLFJn+V0wqMpCiQqPe8lX+Lr9cW+UDxsYvV11rc
         EuDlt3ay2o8Ae0W8RukrM23aKFp8gNC9U4u87vTjIuGn0tVY5IkWJvLlCwymNDaTnjY1
         gIoQ==
X-Gm-Message-State: AGi0PuYum60+07OP7l9WwnKCwuDG3pv672mJAWxwGCL9Wm9690FRt2pU
        ZItvHBlB0Y7jag1eUisXgq1NpftOKkIVqJV92eU=
X-Google-Smtp-Source: APiQypJnJ5kzDKGEhIOz2eCEv3x+sck1O+PXVc37BGK7RiqHIWQGDC7kw58QxlssDp1tn1BdjonA/p0AckXJlr7cytQ=
X-Received: by 2002:ab0:764a:: with SMTP id s10mr1070504uaq.1.1586373719808;
 Wed, 08 Apr 2020 12:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200407180124.19169-1-ydahhrk@gmail.com>
In-Reply-To: <20200407180124.19169-1-ydahhrk@gmail.com>
From:   Laura Garcia <nevola@gmail.com>
Date:   Wed, 8 Apr 2020 21:21:48 +0200
Message-ID: <CAF90-Wg=uGXVOPu-OXupkFYYL0xDYTfV8vTNRvUQgspFMamL=w@mail.gmail.com>
Subject: Re: [nft PATCH 2/2] expr: add jool expressions
To:     Alberto Leiva Popper <ydahhrk@gmail.com>
Cc:     Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 7, 2020 at 8:03 PM Alberto Leiva Popper <ydahhrk@gmail.com> wrote:
>
> Jool statements are used to send packets to the Jool kernel module,
> which is an IP/ICMP translator: www.jool.mx
>
> Sample usage:
>
>         modprobe jool
>         jool instance add "name" --iptables -6 64:ff9b::/96
>         sudo nft add rule inet table1 chain1 jool nat64 "name"
>

Hi Alberto,

Looking at the code, the pool4db is pretty much an adaptation of what
conntrack already does. So, why not to put the efforts in extending
conntrack to support NAT64/NAT46 ?

This way, the support of this natting is likely to be included in the
kernel vanilla and just configure it with just one rule:

sudo nft add rule inet table1 chain1 dnat 64 64:ff9b::/96

One more thing, it seems that jool only supports PREROUTING, is that right?

Cheers.
