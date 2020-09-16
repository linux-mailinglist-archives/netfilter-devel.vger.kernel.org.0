Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0B26C68C
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Sep 2020 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgIPRy0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Sep 2020 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgIPRyS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FAC014D6C
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Sep 2020 06:37:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y74so8198167iof.12
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Sep 2020 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ublu4nKA40C29yVM2jRJ/4KGSNO9Lov9m/GAZVLjnmY=;
        b=MrlmZ3tUmVplNMn91KTmC6k6fz034ObUXce8UndN2YBb0gEFj0oN9rsLnfd6KXNjsg
         5786szKl538GsM2y2Ff+2mvXk4sGvPtmKC81yEA5pypWAW/apMIlBguHwsPUJYvv5Eg3
         iWZIj1Ix/p3t66A+ewnnKVfAkNViBCq41FjiOFfWNv5QG5FrUxJyQmiWT0pYvcToAEJ0
         P9UEanXvYHyxnJnpnk1Y7k31VLeCY03iziCk8KjPy8VII/1Ju4r8vDFxAmA2SngHVRLB
         U5cr6VVVZTbEdMGx8USIuuDT326MeNAjq1ADS1D67YQ+bUsnbUdKsCNf81bKMydg8PSn
         IYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ublu4nKA40C29yVM2jRJ/4KGSNO9Lov9m/GAZVLjnmY=;
        b=TxU4KKCdEkWcdkucyOrJWLH0JoQnnBEKzHaYEj0NhFDzhZLN7QopxKte+jmO1CL4YL
         uXXAMlPM/c3KCSCEAV5ylzuAR2XJ9FkYIULbJpWQh+KThJeYqhuCicZk8uBZOrNDOxG3
         AvXaePbv9CBj3RAzyrvGobeulmXnb/eG9I/tMUsNeGgreoAjCcu9ZrvMkvLzAXEP//on
         m9owfeIk872AYb7BWo3FGqWh/KI2jPdTKnA61vEd6BuLBBXFA0VrW4dn7kPNK4UOLGQz
         Wc1WX7VG0onpX1+JjE03hHFnQQ6ETb6srEShEHXm9jBJ/hvqs2I7TfsF0aeS22ObJNrK
         PVHQ==
X-Gm-Message-State: AOAM530RBJr/TwntfqkqqivJm3jjWtlv7+6FvMAMRckf9tKukHl+h2rn
        hV7aZuaA4qPrrcFfub64FLHVIUsXc1u6T7uEEdOtxtLT
X-Google-Smtp-Source: ABdhPJwdrBcwxobU1XDjtW5fNXVCf1BTNU8kBlq5GgIbTjMGL+De15Mvl+bApru1eDqF5L70BF6sWKc1CT7m8sHKn4Y=
X-Received: by 2002:a05:6602:2a4b:: with SMTP id k11mr19204572iov.85.1600263472276;
 Wed, 16 Sep 2020 06:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUOv8iVoKLZxx1xGVLj-=k4pSNyES5SWaaScx=17WV789Kw3Q@mail.gmail.com>
 <20200914104605.GA1617@salvia>
In-Reply-To: <20200914104605.GA1617@salvia>
From:   Gopal Yadav <gopunop@gmail.com>
Date:   Wed, 16 Sep 2020 19:07:40 +0530
Message-ID: <CAAUOv8i_1fx1OJFKtFAsU7Haq10qQisNqQhEGF75_+22_1A4pQ@mail.gmail.com>
Subject: Re: [PATCH] Solves Bug 1388 - Combining --terse with --json has no effect
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 14, 2020 at 4:16 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> It would be also good if you can add a test. For instance, have a look at:
>
>         tests/shell/testcases/transactions/0049huge_0
>
> which also adds a shell tests for json. You can just get back the
> listing in json and compare it. I suggest you use the
> testcases/listing/ folder to store this new test.

Do you mean get back the terse json listing with "nft -j -t list
ruleset" and compare it with "nft -j list ruleset" and check if they
are different. And also check if attribute "elem" is present or
something else?
