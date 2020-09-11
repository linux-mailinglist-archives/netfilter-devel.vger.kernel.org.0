Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7DA266830
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Sep 2020 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgIKSTw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Sep 2020 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKSTu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:19:50 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008EEC061573
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Sep 2020 11:19:49 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id u20so9859414ilk.6
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Sep 2020 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiF256gLk+ORRo4vw6k+nfuG6hCLwYmFa9yirWQYScY=;
        b=V5JQLRd9xk8fDMS2GJFMXGdtGuj8M6e2iU6ygleCdf7Ah65jHJQRivOu7zPLEKMJmT
         fzXbU66tk6J4A3ScCP3NO2xsIXHTlgumNUwnrq4t+RzdVrgt3DPnM06dAZqi1VkJht5O
         0sk4npsDQawmICqAvmpRqMCtKUi91ljI0kWHD9xG9FF6dc05jK3Gf0HMTtLE+Zka83X1
         KKFZyYjY20Ii/VVIIzLrwjhowBr5Y7x/8T3E4tntSsscgm/UT5cMu424ZOBjjfxVoXWn
         ZisAoUbe7l2a9eoQWntNyneVSNfZmMvwNxWF9Uzw7Yd4rptp7JlML5RzqxxpJhe4rBLz
         4yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiF256gLk+ORRo4vw6k+nfuG6hCLwYmFa9yirWQYScY=;
        b=mGbEL9K42IwvYXBvyRk7SSrjoVvpaPNtdFsxTk7WGbECzIUMr2QVtk2+MRM8OQ89KC
         jG5vo96pYf/+IaAcrcfJA+YY8PsBNSHywQjoEcQFhKVRTtxgduP0uVt29DvhOfcv6m82
         i8xmcEHl7zbjWcqk/rDJ5tMg5YYUO0jXgIT6ygKk9D//fJ26FdOA+u3KX8ZWL8Yd9Oo5
         ZRjV35ghoNBvRr7Rj75u2gmpgcGsmPXp3tT4k/1zKIthTHOwUBgGSyRa/uRmUAhk83NL
         8Ig2Uj1IgDtz/sTj2UJ5pajXMNxLQ6MPFysvLC2OeKapd/Q6PFvv4oELQ4Qscok3Ah5c
         +5tQ==
X-Gm-Message-State: AOAM530kGUjq/39hUpVwiw0MDWwzk6RC0a33RO/AHjNv9z52PAPJWMCO
        1kCfNj7FnRVcqRwTk9C9re7T8Jeu0cM7bU/dIEsU+maLIlM=
X-Google-Smtp-Source: ABdhPJxAztj3S6n3y3B6nORDucxkwYwoNq8YlQ1XSHlEUyLH+tW6jMJQYQqt+VFIDu5FqqffQhzm2VK398mwSVvI5vE=
X-Received: by 2002:a92:1597:: with SMTP id 23mr2668540ilv.58.1599848389306;
 Fri, 11 Sep 2020 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUOv8iRkeAVDn3UK8DHju+-RvWViopGajN_+9y+Rm30pTWa+A@mail.gmail.com>
 <20200909122354.GP7319@breakpoint.cc> <CAAUOv8jy2ryt8hS3BsmgNZAyU5Kc1qFw2L1UoHrB3L_qE98AFQ@mail.gmail.com>
In-Reply-To: <CAAUOv8jy2ryt8hS3BsmgNZAyU5Kc1qFw2L1UoHrB3L_qE98AFQ@mail.gmail.com>
From:   Gopal Yadav <gopunop@gmail.com>
Date:   Fri, 11 Sep 2020 23:49:38 +0530
Message-ID: <CAAUOv8gvWZAo+G_5mVsadiABUUGo+yYyM3Zu5vgzHBYPTxxqmg@mail.gmail.com>
Subject: Re: [nftables] TODO: Replace yy_switch_to_buffer by
 yypop_buffer_state and yypush_buffer_state
To:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:40 PM Gopal Yadav <gopunop@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 5:53 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Gopal Yadav <gopunop@gmail.com> wrote:
> > > Are there any beginner friendly issues to solve or any other
> > > starting point?
> >
> > This one for example:
> > https://bugzilla.netfilter.org/show_bug.cgi?id=1305
> >
> > Its "just" a documentation issue.  You could work from comment 4
> > and improve the nft documentation to clarify 'accept' behaviour.
> >
> > For many other bugs it would help if we had testcases that demonstrated
> > this problem in the nftables.git repo.
> >
> > So, if you can translate a BZ ticker to e.g. a new test case in
> > tests/shell that show problem still exists in current nftables.git then
> > you could submit that test case as a patch, even if the problem is not
> > yet resolved.
> >
> > Readily available test reproducers help a lot.
>
> Thanks for the reply. Pablo suggested to work on
> https://bugzilla.netfilter.org/show_bug.cgi?id=1388
> but I think his mail was not sent to the mailing list.
> I am currently trying to solve that one. Will get back to look at 1305
> after that.

I have submitted a patch for 1388.
For the doc issue I would have to read the entire manpage.
Will try doing that meanwhile any other issue to work on?
