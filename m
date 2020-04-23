Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD921B5DF9
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2020 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDWOhs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Apr 2020 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgDWOhr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:37:47 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA65C08E934
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2020 07:37:47 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id i22so5869952uak.6
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2020 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLh7a2wQdsNVczrscoyX7xl8nvD0UD4kLxy9J5N1VOE=;
        b=OHrDhZOvS9272EK31Ob9/tIOhexR8Bsfif4KnWZHO566Y7NennsFQZ337vNfvdRrA7
         4Z9VZVPZBoz1lWQQTnzujkQYxDKF5eHL2ic5mM2E6sa4i+QInoHhYSLUhopUjMchS4V9
         0tpRUz5olIqDNTLHUwTjlgLEwGSxb8QWHmirDphYXVOrptK3r1LezYWPnFBidhrdNpic
         5SBHhcaCQjiZ6ypxcJtCvedDKocOBSSCS+cu+a90sPMX0/QTipRpNyyzijZkAKATA/gT
         CfF0KC4pONx0pm6VjheQappyMbjAn+1zQ3DjQOiy05gcoaMz8his4TzXp2rxq+q+iLo2
         nHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLh7a2wQdsNVczrscoyX7xl8nvD0UD4kLxy9J5N1VOE=;
        b=M8c+3fTSjZg43A6XQbu5VsnWcYxVcttpWLtcdcYK5Xm5v/tQbDJZo0r5t+8JgGXzOK
         /ZCKBORXAB6s6gLevRaUoCkl+tjHj97UHpKraLcAl3saa3J+iCB3D+UzC3pZp4ioxqhO
         62KJlysp6a1ELDgA6Cg4bC3Q0f+hNmpAgQI+gBkfangVbS/4JVK+VkKKUfVk/Dxalvt9
         55LFOIbhwIi+jTVqFSiHjZwWd46POovXO0ZzFkZ5BrvQYTfB2Q+IkwkTtkKHzPBaYJ3L
         oSFIb2tGikKl9MyRSiqWF5tUtiq3O3ri0ItBpCKErgdhZR5MdBqv979MMhMiWxsyp64y
         fM3A==
X-Gm-Message-State: AGi0PuZArHSwff9vQiYYxhxo0UfN3+ZTXYSW8LWv1n7cjcJ0MnLBYHbV
        4D1prm3wKm1/rf4puajHBbhAmwwDH71tuVFjy5ziWQ==
X-Google-Smtp-Source: APiQypIy0Nc0fVP0K9xfqn7fT9f3mbUohj9XSNH5qUTj5rtstikhSrGW4munZWN3j4GyXF/W5lqGbBM96lsEvf9mZro=
X-Received: by 2002:a67:e98d:: with SMTP id b13mr3566047vso.55.1587652666679;
 Thu, 23 Apr 2020 07:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <5a20c054-cf2e-9694-2242-03e1d01cf568@newquest.fr>
In-Reply-To: <5a20c054-cf2e-9694-2242-03e1d01cf568@newquest.fr>
From:   Laura Garcia <nevola@gmail.com>
Date:   Thu, 23 Apr 2020 16:37:35 +0200
Message-ID: <CAF90-WgPBPaqjcwMv9qO3sFDPDR3VfoY-HdtmCE6FyOdNJPjiw@mail.gmail.com>
Subject: Re: Problem with flushing nftalbes sets
To:     Milan JEANTON <m.jeanton@newquest.fr>
Cc:     Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 23, 2020 at 4:26 PM Milan JEANTON <m.jeanton@newquest.fr> wrote:
>
> Hello,
>
> I try to send you the message again, it says it couldn't be send because
> it was an HTML type message.
>
>
> I use nftables for a development project with our company and I'm happy
> with this application but I'm still learning a lot with all the options.
>
> I'm using Debian environments (stretch and buster).
>
> My problem is with the sets of nftables:
> I use the sets to manage a large amount of ip addresses since it store
> only the ipv4 addresses without any rules and process it much quicker.
>
> So let's say I have this table configuration:
>
> table ip test {
>          set tmp {
>                  type ipv4_addr
>          }
> }
>
> I can add elements in my set without any problem, I can also delete them
> one by one.
>
> The problem I have is that I need to delete all the elements in the tmp
> set and as precised in the manual of nftables I could flush the elements
> of a set:
>
> SETS
> [...]
> flush    Remove all elements from the specified set.
>
> But when I use the command to flush my sets, it doesn't work and
> displays me an error message
>
> nft 'flush set test tmp'
> Error: Could not process rule: Invalid argument
> flush set test tmp
> ^^^^^^^^^^^^^^^^^^^
>

Hi, which kernel version are you running?

It works in my system.

Cheers.

> So I used an other method that worked on version 0.7 by selecting all
> the content of elements, but I updated to version 0.9.4 and can't make
> it work since there is a new line each two addresses and I would rather
> use a native command anyway.
>
> I don't understand what I do wrong ? If you can please help me.
>
> Regards,
