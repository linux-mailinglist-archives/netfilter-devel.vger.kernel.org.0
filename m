Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAA47E7AE
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Dec 2021 19:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349850AbhLWSgw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Dec 2021 13:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhLWSgv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:36:51 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95578C061401
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Dec 2021 10:36:50 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id g65so3730600vkf.4
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Dec 2021 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MWnMtKUTA+pdFLxssTMYrvKW+kgDVKLhBQGvMTDtV9c=;
        b=XlWD+aT1d/zCA2MoCJjWJPwmZ/779N52rkYEDn1hBANMankZEebY9s2QejjXUJRouw
         MLFH0hizvAEw6AzBZj9ZYjHf1ARv7bmY6d1cGF9CHmZI8DeRpzn+YgVtiHArTLTP8Ne0
         j9xE/a7mo9ImnNpztlCsKu28VvxMpjoCOyci/ARo3HBrBQ7xVy7JlcQH7iENAWeeGQhu
         zmL9l/xPFAQvmKs9lttkFEONak+/60RAmbmUk4/K34wLbs6Y9iWgJhcOw1WStce38ODm
         dkkY7TSqLqz9+bUE1dj3q9pZIa+VMG0jOb9dQAMYSq49qU/Kc5RPGAQy7Jvq2a7fKfyk
         Wjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MWnMtKUTA+pdFLxssTMYrvKW+kgDVKLhBQGvMTDtV9c=;
        b=SfF6r1m2K2xqgRxnyJkAyGxa20p5XLUzL5vxhHoDpbd4afxkzAhQXa1eVAY4dbRJ2U
         tQN8mHc+4WIxODp8+Z6dFMR0x/TURzzTHV+plizo9zGrUK+wSm02/99u0DJzUj4KtLGF
         fP/+vXLMO8OO3nSd4qr39nNKlHyQpbZHKNDm69MEdc/bfTaa1F1p0wxi06xyTLnRYh37
         EiVZer17MyG9J1YliN7TZNwtcdB80te2NN2csySfZxJy5avDi9i5WMHYTcc20G+FcrCc
         eiUitm+AwX/Ks1bWdG1C0Q7IEwq3FROwjjzR7En3KYDJB0cAzvxd50JCvAnpfobgvpMr
         a9jg==
X-Gm-Message-State: AOAM533dmGT7ieJ3ICchYMnZsV+/9tRZ3ccLkdoHsfLFZ14xb/vkQf45
        Xq0yNZohP3mAx0rOuwv8MJUqi9RqinJNxnunP0c/YA==
X-Google-Smtp-Source: ABdhPJzUHSBqRJvO39+xoKI18fvmsn8JWj592gdkYxAJvEn2tQ2Vje4KIB3Cj8+SyLRx3cQsV31A1iP0NC9rTESl5dI=
X-Received: by 2002:a1f:bf81:: with SMTP id p123mr1174324vkf.27.1640284609505;
 Thu, 23 Dec 2021 10:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20211223070642.499278-1-zenczykowski@gmail.com> <1nrqq669-2r5o-qq5o-207r-p6pnr614s769@vanv.qr>
In-Reply-To: <1nrqq669-2r5o-qq5o-207r-p6pnr614s769@vanv.qr>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Thu, 23 Dec 2021 10:36:38 -0800
Message-ID: <CANP3RGct11+Cu0z-ksEMcpQGyFp5Ek-99+z6qEFc1FFh0xUt7Q@mail.gmail.com>
Subject: Re: [PATCH netfilter] netfilter: xt_owner: use sk->sk_uid for owner lookup
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Netfilter Development Mailing List 
        <netfilter-devel@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 23, 2021 at 2:35 AM Jan Engelhardt <jengelh@inai.de> wrote:
> On Thursday 2021-12-23 08:06, Maciej =C5=BBenczykowski wrote:
>
> >diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
> >index e85ce69924ae..3eebd9c7ea4b 100644
> >--- a/net/netfilter/xt_owner.c
> >+++ b/net/netfilter/xt_owner.c
> >@@ -84,8 +84,8 @@ owner_mt(const struct sk_buff *skb, struct xt_action_p=
aram *par)
> >       if (info->match & XT_OWNER_UID) {
> >               kuid_t uid_min =3D make_kuid(net->user_ns, info->uid_min)=
;
> >               kuid_t uid_max =3D make_kuid(net->user_ns, info->uid_max)=
;
> >-              if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
> >-                   uid_lte(filp->f_cred->fsuid, uid_max)) ^
> >+              if ((uid_gte(sk->sk_uid, uid_min) &&
> >+                   uid_lte(sk->sk_uid, uid_max)) ^
>
> I have a "d=C3=A9j=C3=A0 rencontr=C3=A9" moment about these lines...
>
> filp->f_cred->fsuid should be the EUID which performed the access (after
> peeling away the setfsuid(2) logic...), and sk_uid has a value that the
> original author of ipt_owner did not find useful. I think that was the
> motivation. listen(80) then drop privileges by set(e)uid. sk_uid would be=
 0,
> and thus not useful.

Ugh!  Well, that's certainly interesting to hear...

There's like 6 different uids associated with a socket (sk_uid, inode
uid, f_cred->uid/euid/suid/fsuid)
- and I guess it might also matter whether we're talking about at
socket() [or accept()] creation time, or currently...
it's a mess.  [and 5 gids + supplemental groups]

I'm not really certain which of these have which meaning.  I don't
really understand the meaning of filp->f_cred.

I guess it's back to the drawing board.  The Android DNS resolver uses
fchown() on the dns sockets it creates
to 'impersonate' the clients on whose behalf it's doing dns queries.
This works for bpf, because:

bpf_get_socket_uid(skb) returns (roughly) skb->sk->sk_uid
[and there's simply no bpf helper that deals with gids]

but this of course results in -m owner --uid-owner seeing root while
bpf sees something else.

I wonder if the solution is to add -m owner --sk-uid X (or
--socket-uid) syntax instead... ?!?

I'm not sure if it would be safe (or even desirable) to get fchown()
to modify the existing f_cred->fsuid field...
