Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C429DC5B
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Oct 2020 01:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgJ2A2J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Oct 2020 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgJ2A12 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:27:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A57C0613CF
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Oct 2020 17:27:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n6so890318wrm.13
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Oct 2020 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EhaQv7Xqn9C10/6kPilmFG/LY90YB69CHHSm/P4LmUk=;
        b=Lj2eTMWdQNRX51rp+69kJ+7MIJveC7lv8t0w/6GAwNCZDU97tO7fXzTZewOx55Ac1l
         qfo9NYf3w/1oZOOMsUpmk5QFBOLD6rEq4Y+xGwdcqgYSlAvt/V1eCOoLhOGtMpxn22lY
         BpPv8So2RSzkwV4VqW9Z81xo/sm6G/2qErp4megpsjRLRnCsLMimzT//EYKnBmWXYPYY
         Sljt2SxpJGW+CX70ABsj4p+oWaehsd7e48Xa9uvPlScUQdjQsFInIzQICwjOLHYNYT2Z
         rVKc0MWZtpSmx99XULBfKIiPaFC7zAwivfy+JYaPy+FhDaqHk6y3p83LlgRiUo5yGc2I
         JWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EhaQv7Xqn9C10/6kPilmFG/LY90YB69CHHSm/P4LmUk=;
        b=fjY9dvzVChaYaVLg2SVOKZ5jpJ+cw1FCDUETbw1bCqZuc2u4BcAQpNUz86ZHGLaKiw
         bWsFHgsZmyI2YXJD3MM54ce0hBJD/zIPwS9TC/QiuMsVZP2G/jz83uJEVlPRZXDM2enF
         eHzc381Vy/2BjoWwS4HJTW/z+XTZb8L2TeS1ldUw+0uZn02R77fiOeQOQIiztezTmmPA
         xeSC2CdIKjTAoO7kPWq90OOBfV6P4C9iEP01L3DCMqPgj8Ej7Vt9AoqT+O3XGiZm8BkZ
         DkngIbiTyPRIK9tVxk2vBBHcD5yQ61cEFSX5j/DCDXdwQ52G5A+1+Dqz5N9SjWAC80UA
         h/tA==
X-Gm-Message-State: AOAM530mFMEfcTmZh38Gbmh0rzrRTDhD7eEtStTBpZPijB1Hv9hJEakL
        3/GO2RwgsMzvGHKOo2GKlNnXOOWXd6LmnjWwYY41rEvd/g==
X-Google-Smtp-Source: ABdhPJydImqf6rjIcFvdKoVKRijlUJM6c3tT5+zpyIh0DgksT/WwCUJmb9M0MAWnaqlVZBE1LbPiRD1v+2NmrHAlBa8=
X-Received: by 2002:a17:906:4811:: with SMTP id w17mr4982322ejq.431.1603848928683;
 Tue, 27 Oct 2020 18:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <6e2e10432e1400f747918eeb93bf45029de2aa6c.1593198710.git.rgb@redhat.com>
 <CAHC9VhSCm5eeBcyY8bBsnxr-hK4rkso9_NJHJec2OXLu4m5QTA@mail.gmail.com>
 <20200729194058.kcbsqjhzunjpipgm@madcap2.tricolour.ca> <CAHC9VhRUwCKBjffA_XNSjUwvUn8e6zfmy8WD203dK7R2KD0__g@mail.gmail.com>
 <20201002195231.GH2882171@madcap2.tricolour.ca> <20201021163926.GA3929765@madcap2.tricolour.ca>
 <CAHC9VhRb7XMyTrcrmzM3yQO+eLdO_r2+DOLKr9apDDeH4ua2Ew@mail.gmail.com> <20201023204033.GI2882171@madcap2.tricolour.ca>
In-Reply-To: <20201023204033.GI2882171@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 21:35:17 -0400
Message-ID: <CAHC9VhS7Gzd=pQ13eSOHDT8nO-z_yxsVW0E5r6mkpPYi3Txe2g@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 05/13] audit: log container info of syscalls
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 23, 2020 at 4:40 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-10-22 21:21, Paul Moore wrote:
> > On Wed, Oct 21, 2020 at 12:39 PM Richard Guy Briggs <rgb@redhat.com> wr=
ote:
> > > Here is an exmple I was able to generate after updating the testsuite
> > > script to include a signalling example of a nested audit container
> > > identifier:
> > >
> > > ----
> > > type=3DPROCTITLE msg=3Daudit(2020-10-21 10:31:16.655:6731) : proctitl=
e=3D/usr/bin/perl -w containerid/test
> > > type=3DCONTAINER_ID msg=3Daudit(2020-10-21 10:31:16.655:6731) : conti=
d=3D7129731255799087104^3333941723245477888
> > > type=3DOBJ_PID msg=3Daudit(2020-10-21 10:31:16.655:6731) : opid=3D115=
583 oauid=3Droot ouid=3Droot oses=3D1 obj=3Dunconfined_u:unconfined_r:uncon=
fined_t:s0-s0:c0.c1023 ocomm=3Dperl
> > > type=3DCONTAINER_ID msg=3Daudit(2020-10-21 10:31:16.655:6731) : conti=
d=3D3333941723245477888
> > > type=3DOBJ_PID msg=3Daudit(2020-10-21 10:31:16.655:6731) : opid=3D115=
580 oauid=3Droot ouid=3Droot oses=3D1 obj=3Dunconfined_u:unconfined_r:uncon=
fined_t:s0-s0:c0.c1023 ocomm=3Dperl
> > > type=3DCONTAINER_ID msg=3Daudit(2020-10-21 10:31:16.655:6731) : conti=
d=3D8098399240850112512^3333941723245477888
> > > type=3DOBJ_PID msg=3Daudit(2020-10-21 10:31:16.655:6731) : opid=3D115=
582 oauid=3Droot ouid=3Droot oses=3D1 obj=3Dunconfined_u:unconfined_r:uncon=
fined_t:s0-s0:c0.c1023 ocomm=3Dperl
> > > type=3DSYSCALL msg=3Daudit(2020-10-21 10:31:16.655:6731) : arch=3Dx86=
_64 syscall=3Dkill success=3Dyes exit=3D0 a0=3D0xfffe3c84 a1=3DSIGTERM a2=
=3D0x4d524554 a3=3D0x0 items=3D0 ppid=3D115564 pid=3D115567 auid=3Droot uid=
=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3D=
root fsgid=3Droot tty=3DttyS0 ses=3D1 comm=3Dperl exe=3D/usr/bin/perl subj=
=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3Dtestsuite-16=
03290671-AcLtUulY
> > > ----
> > >
> > > There are three CONTAINER_ID records which need some way of associati=
ng with OBJ_PID records.  An additional CONTAINER_ID record would be presen=
t if the killing process itself had an audit container identifier.  I think=
 the most obvious way to connect them is with a pid=3D field in the CONTAIN=
ER_ID record.
> >
> > Using a "pid=3D" field as a way to link CONTAINER_ID records to other
> > records raises a few questions.  What happens if/when we need to
> > represent those PIDs in the context of a namespace?  Are we ever going
> > to need to link to records which don't have a "pid=3D" field?  I haven'=
t
> > done the homework to know if either of these are a concern right now,
> > but I worry that this might become a problem in the future.
>
> Good point about PID namespaces in the future but those accompanying
> records will already have to be conditioned for the PID namespace
> context that is requesting it, so I don't see this as a showstopper.

Possibly, it just gets very messy.  Doubly so when you start looking
at potentially adjusting for multiple audit daemons.  Thankfully it
doesn't look like using the PID is a good idea for other reasons.

> I've forgotten about an important one we already hit, which is a network
> event that only has a NETFILTER_PKT record, but in that case, there is
> no ambiguity since there are no other records associated with that
> event.  So the second is already an issue now.  Using
> task_tgid_nr(current), in the contid testsuite script network event it
> attributed it to ping which caused the event, but we cannot use this
> since it wasn't triggered by a syscall and doesn't accurately reflect
> the kernel thread that received it.  It could just be set to zero for
> network events.

Possibly.  It just seems like too much hackery to start; that's the
stuff you do once it has been in a kernel release for years and need
to find a workaround that doesn't break everything.  I think we should
aim a bit higher right now.

> > The idea of using something like "item=3D" is interesting.  As you
> > mention, the "item=3D" field does present some overlap problems with th=
e
> > PATH record, but perhaps we can do something similar.  What if we
> > added a "record=3D" (or similar, I'm not worried about names at this
> > point) to each record, reset to 0/1 at the start of each event, and
> > when we needed to link records somehow we could add a "related=3D1,..,N=
"
> > field.  This would potentially be useful beyond just the audit
> > container ID work.
>
> Does it make any sense to use the same keyword in each type of record
> such as record/records as in PATH/SYSCALL: item/items ?

That was mentioned above, if you can assure yourself and the rest of
us that it can be safely reused I think that might be okay, but I'm
not convinced that is safe at the moment.  Although I will admit those
are fears are not based on an exhaustive search through the code (or a
determined "think").

> (I prefer 0-indexed like item=3D...)

I have no preference on where we start the index, but it makes sense
to keep the same index starting point as the PATH records.

--=20
paul moore
www.paul-moore.com
