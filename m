Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06921461C
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Jul 2020 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGDNaj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 4 Jul 2020 09:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgGDNaj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:30:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE74C08C5E0
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 06:30:38 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so30301944edr.2
        for <netfilter-devel@vger.kernel.org>; Sat, 04 Jul 2020 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYXNB8sAYPR03z+7yXMvQjkDEkew3CoGHxaB14N9l3o=;
        b=c7UsYj0Lh39A+4qQDoIM8UAT0oPZ089C4wY54z+FI+hjKJoHqfZ+OSKJ7pK/eKAzO+
         T7h9fPkTqD0YYgXGbcszXQVBpQZzfECPoTaiJSGKgFPEOiS0bmZOKBCgcrfKjvEdRMi8
         ky7eDfhq2RRrihjXm8dQdD6Hedc2JnwUqwscoh1W5k3VqOOPGf5jhlp6vbXB7HwDuuuA
         l6lArMUWn4qcA6162GFXILJmBuS2liiSETUEkV2qAh7X0km7lbiqZ9omHzHGqNRHaFyc
         TmsOjTYv2/H0FKRf0bMOTc1qIUhtzUtzAS0OOkKa0/6QnCfPSRLp3MPHy4Nwd0KH+RTE
         ygpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYXNB8sAYPR03z+7yXMvQjkDEkew3CoGHxaB14N9l3o=;
        b=GLh1KtpqaKXoIWboBD7Woieto379vedI5xIqjLTOX0pp9CVVON6Wc6XRTvxsDUAUjz
         LzzIu2CkyNMkz8kw+6JKGMRpgKrLA2Ffg7DdKuqI6967cKY3sYkD7s0ku7t9DO2RhFlw
         K5CKjeKDrb3QeczO1ZlKPWE1RXCP7OTikhgUjvW6/Bzt2US/MZhiPGN09tJxoAafwdFG
         qGsQ7642pLQNaAnaUbM8fVWq+GJ6eGv3rK/N5S0GV6VyckO7rydZq1tXwdEjyX/dNrLg
         nU3y0KXp59fNo4I4uU5T2vam0oCIeus4i8nRIH6OTW/M4RT8O+An1TWgJrndcm4ED9aI
         aZOQ==
X-Gm-Message-State: AOAM531xcNLM36UCmux8J1NyQWKl8CKl/fMlR3zI8TFijeB/i5Zvy0m/
        r3yiOv1Jkl+/PfV5Z8p1VEk024ENXNENLsg5+LZC
X-Google-Smtp-Source: ABdhPJxXnEAomjGOTfVoMxiJBSuMBpETmOS+i8zhHtjzsBKGVLhQISOvjpbb5e1kLK73pS32uCKmaU1565rkftQCo+o=
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr44774064edr.164.1593869437418;
 Sat, 04 Jul 2020 06:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <e5a1ab6955c565743372b392a93f7d1ac98478a2.1593198710.git.rgb@redhat.com>
 <CAHC9VhTcFrPDSmvBBXevo-atCnxy4WK2YQ0WOeg4M1Sfz0qPgA@mail.gmail.com>
In-Reply-To: <CAHC9VhTcFrPDSmvBBXevo-atCnxy4WK2YQ0WOeg4M1Sfz0qPgA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 4 Jul 2020 09:30:26 -0400
Message-ID: <CAHC9VhTW+pTES3g7gOoCWT3tXG3NsP0KjDLLyBHs_i3HSQMspQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 02/13] audit: add container id
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 4, 2020 at 9:29 AM Paul Moore <paul@paul-moore.com> wrote:
> On Sat, Jun 27, 2020 at 9:22 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Implement the proc fs write to set the audit container identifier of a
> > process, emitting an AUDIT_CONTAINER_OP record to document the event.

Sorry about the email misfire, you can safely ignore that last empty message.
