Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479E8DF651
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJUTxe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 15:53:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41576 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfJUTxd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:53:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so14669648ljg.8
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Oct 2019 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3ZB5cTWc/+E0YKg8QEclL2Ljwj65q5hsf0zgj4Z+rY=;
        b=1U3vsiCGcdSTOTzaQ4vA8rtgFMEgeQgVyd8UdGC3o/CdMtwBWN4F0gK1w2XsWWSBGH
         YNQV5ahyV/O6yw4h2p7vwNKddLsSKZA8aEdokn0w75hdbMsvb43uRjbJi8H6JHxCG71w
         Q4NjPgZg63RufqnWqJjnk2UAQF7YnLs+zbq9EPZiF4/9fTsCtv4l9nCyYbMUGLPTXat5
         APjvja2QOXD7cHp9B0BCAW/vEBE/sR2BENyelP9rlWUJuII/ey98aimoJiTVDGxwlViu
         HWB3hhBN5+9iFMdxD2Riji0ncS9ufRQXCLy1K0bA0PdNKWfK7SpaFe+eM4GU9HA2y+6W
         mAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3ZB5cTWc/+E0YKg8QEclL2Ljwj65q5hsf0zgj4Z+rY=;
        b=uJ2PGm4idWuz2QKBPQ2DGBqUrVnuflflAQbuw88oc0iCu4OTbbzCOsPmDQEcNULl3/
         SMUuiHfX1qJzy5sDT52ywR+IXQzlvDhFulIO/msmNS1NUdQ/IgqWyQXnP7R2wfaTR9e5
         Yzop91SEqVVOdIAd33/M2pcZ8GmjDjOMyf2s16HFilJKtHuXAdrAr0F+7Gpirk1QEC4c
         7g8Vv6jp3PWmUIN0kfQ/fcpoapxXqZHPwLjGNb4HtPP+tubc5MVqE6kvMLhHGfHWX7xn
         XmmfeVep1LQRzJ6yylxLFjq/PXui20TsjaIQykpA0BqJ8zNxpYJbr8sE0Q+6XQ/TKSu5
         ttnw==
X-Gm-Message-State: APjAAAVbvixd/ELx6Y7POw112Svvms6J99c4s12FJmRqtYY6ep3i1B/l
        gMbD8b9ECeoZlHyNbW1e81ODzwFIhVXGjrwg4/gT
X-Google-Smtp-Source: APXvYqwGLlTHAz4uYJDRoYV7X3sKMFSAWJhdAvt0BgqLKoPKw91r1AdS6gVNJnxX99zDNcARmS/mrYca8VZXodUJ0TA=
X-Received: by 2002:a2e:5b82:: with SMTP id m2mr394137lje.184.1571687611172;
 Mon, 21 Oct 2019 12:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <214163d11a75126f610bcedfad67a4d89575dc77.1568834525.git.rgb@redhat.com>
 <20191019013904.uevmrzbmztsbhpnh@madcap2.tricolour.ca>
In-Reply-To: <20191019013904.uevmrzbmztsbhpnh@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Oct 2019 15:53:20 -0400
Message-ID: <CAHC9VhRPygA=LsHLUqv+K=ouAiPFJ6fb2_As=OT-_zB7kGc_aQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 20/21] audit: add capcontid to set contid
 outside init_user_ns
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:39 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-09-18 21:22, Richard Guy Briggs wrote:
> > Provide a mechanism similar to CAP_AUDIT_CONTROL to explicitly give a
> > process in a non-init user namespace the capability to set audit
> > container identifiers.
> >
> > Use audit netlink message types AUDIT_GET_CAPCONTID 1027 and
> > AUDIT_SET_CAPCONTID 1028.  The message format includes the data
> > structure:
> > struct audit_capcontid_status {
> >         pid_t   pid;
> >         u32     enable;
> > };
>
> Paul, can I get a review of the general idea here to see if you're ok
> with this way of effectively extending CAP_AUDIT_CONTROL for the sake of
> setting contid from beyond the init user namespace where capable() can't
> reach and ns_capable() is meaningless for these purposes?

I think my previous comment about having both the procfs and netlink
interfaces apply here.  I don't see why we need two different APIs at
the start; explain to me why procfs isn't sufficient.  If the argument
is simply the desire to avoid mounting procfs in the container, how
many container orchestrators can function today without a valid /proc?

-- 
paul moore
www.paul-moore.com
