Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B065AFBFB
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Sep 2022 07:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIGFwl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Sep 2022 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIGFwj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:52:39 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C34895CF;
        Tue,  6 Sep 2022 22:52:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r141so10691728iod.4;
        Tue, 06 Sep 2022 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=19Xv0n0fOCkdGDvLcovAJZ2+3xFG0tfwQ4rbKsQHGqI=;
        b=cy3B3z+8EAJQ436dCDNov3aPd9plR9dtfurjowQPMP36qSn7HPjc9hhjLsyMApAbj6
         eM4NTIrhKx8T7wqHEvJgAPk8a3LyJ6llrT0LyrgaV1A2buKrLEKgquICZ5cuJEWiFhiZ
         iKExikyN0Z4i5BcONBB23n7KjFuiU/bJgAOcfolHRotm+WB9I7sLiQYJ8cLFVDT8F2vY
         r2+rYSmRZbjCNhHQfSQbYKLu0DS4++91v/pv1LCeXU3V+3HIncfVmbd2eOe28eGByWpb
         PIqHFAW/GDuUNw7/g40H5a5ELFyIn9uuOE3WdMOY4TgiKpgbU4ktROJ1ZT0jCGfnvQL0
         qBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=19Xv0n0fOCkdGDvLcovAJZ2+3xFG0tfwQ4rbKsQHGqI=;
        b=cPUcNu0UMztaczKx22GwfQ5IfpuVUJB0izem35lO86knVNrEAEpzyTdcTMNhnorSNb
         Q5Le+iUlvAmavcH6Pd+HABVyk3t5EuI3zJBovxo/5I80iYdDZCMRrJ3BtYQImqiDqNAj
         nJcpTsqTSWcuZA/1/u60m7lL9f8KBRm8DMNNr3HqhbOJgbpz90xnLRDfWBrvHLteLg9L
         kIYkkHWlps3SrLkkgmZwoC/J39KDCFc3wdCLe3rnpuUWB3eyWma+RrjiTbRPksVAHTbw
         cUn7zZLT5PL4Md78UJr7VTqs+zlwr290VaDG0yqth3czRP/HBdyXPZVmrUuFkg9cIPy1
         k5nw==
X-Gm-Message-State: ACgBeo2w06qsjf7NN3eJlzQGoO/gMqSi2P4OnKGvveXKXgxCSv3k/DXm
        UYPP0MiDHwtUAH1ErlimN5UT9IuTW89loq2vmVE=
X-Google-Smtp-Source: AA6agR4QI2lS+qeKb8jHNwdOWkbTBUydD+2uq3RgKO+qwKWjsO4tgVD4gSq6BqpEWumEnJPe81WvP3IrwSBxAJCSIPc=
X-Received: by 2002:a05:6638:16cf:b0:34a:263f:966d with SMTP id
 g15-20020a05663816cf00b0034a263f966dmr1169586jat.124.1662529951915; Tue, 06
 Sep 2022 22:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662383493.git.lorenzo@kernel.org> <fa02d93153b99bc994215c1644a2c75a226e3c7d.1662383493.git.lorenzo@kernel.org>
 <CAADnVQJ4XtFpsEsPRC-cepfQvXr-hN7e_3L5SchieeGHH40_4A@mail.gmail.com>
 <CAP01T77BuY9VNBVt98SJio5D2SqkR5i3bynPXTZG4VVUng-bBA@mail.gmail.com> <CAADnVQJ7PnY+AQmyaMggx6twZ5a4bOncKApkjhPhjj2iniXoUQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ7PnY+AQmyaMggx6twZ5a4bOncKApkjhPhjj2iniXoUQ@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 7 Sep 2022 07:51:54 +0200
Message-ID: <CAP01T77goGbF3GVithEuJ7yMQR9PxHNA9GXFODq_nfA66G=F9g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] net: netfilter: add bpf_ct_set_nat_info
 kfunc helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, 7 Sept 2022 at 07:15, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 6, 2022 at 9:40 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Wed, 7 Sept 2022 at 06:27, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 5, 2022 at 6:14 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > > +int bpf_ct_set_nat_info(struct nf_conn___init *nfct__ref,
> > > > +                       union nf_inet_addr *addr, __be16 *port,
> > > > +                       enum nf_nat_manip_type manip)
> > > > +{
> > > ...
> > > > @@ -437,6 +483,7 @@ BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
> > > >  BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
> > > >  BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
> > > >  BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
> > > > +BTF_ID_FLAGS(func, bpf_ct_set_nat_info)
> > > >  BTF_SET8_END(nf_ct_kfunc_set)
> > >
> > > Instead of __ref and patch 1 and 2 it would be better to
> > > change the meaning of "trusted_args".
> > > In this case "addr" and "port" are just as "trusted".
> > > They're not refcounted per verifier definition,
> > > but they need to be "trusted" by the helper.
> > > At the end the "trusted_args" flags would mean
> > > "this helper can assume that all pointers can be safely
> > > accessed without worrying about lifetime".
> >
> > So you mean it only forces PTR_TO_BTF_ID to have reg->ref_obj_id > 0?
> >
> > But suppose in the future you have a type that has scalars only.
> >
> > struct foo { int a; int b; ... };
> > Just data, and this is acquired from a kfunc and released using another kfunc.
> > Now with this new definition you are proposing, verifier ends up
> > allowing PTR_TO_MEM to also be passed to such helpers for the struct
> > foo *.
> >
> > I guess even reg->ref_obj_id check is not enough, user may also pass
> > PTR_TO_MEM | MEM_ALLOC which can be refcounted.
> >
> > It would be easy to forget such subtle details later.
>
> It may add headaches to the verifier side, but here we have to
> think from pov of other subsystems that add kfuncs.
> They shouldn't need to know the verifier details.
> The internals will change anyway.

Ok, I'll go with making it work for all args for this case.

> Ideally KF_TRUSTED_ARGS will become the default flag that every kfunc
> will use to indicate that the function assumes valid pointers.
> How the verifier recognizes them is irrelevant from kfunc pov.
> People that write bpf progs are not that much different from
> people that write kfuncs that bpf progs use.
> Both should be easy to write.

That is a worthy goal, but it can't become the default unless we
somehow fix how normal PTR_TO_BTF_ID without ref_obj_id is allowed to
be valid, valid-looking-but-uaf pointer, NULL all at the same time
depending on how it was obtained. Currently all helpers, even stable
ones, are broken in this regard. Similarly recently added
cgroup_rstat_flush etc. kfuncs are equally unsafe.

All stable helpers taking PTR_TO_BTF_ID are not even checking for at
least NULL, even though it's right there in bpf.h.
   592         /* PTR_TO_BTF_ID points to a kernel struct that does not need
   593          * to be null checked by the BPF program. This does not imply the
   594          * pointer is _not_ null and in practice this can
easily be a null
   595          * pointer when reading pointer chains. The assumption is program
which just proves how confusing it is right now. And "fixing" that by
adding a NULL check doesn't fix it completely, since it can also be a
seemingly valid looking but freed pointer.

My previous proposal still stands, to accommodate direct PTR_TO_BTF_ID
pointers from loads from PTR_TO_CTX of tracing progs into this
definition of 'trusted', but not those obtained from walking them. It
works for iterator arguments also.

We could limit these restrictions only to kfuncs instead of stable helpers.

It might be possible to instead just whitelist the function BTF IDs as
well, even saying pointers from walks are also safe in this context
for the kfuncs allowed there, or we work on annotating the safe cases
using BTF tags.

There are some problems currently (GCC not supporting BTF tags yet, is
argument really trusted in fexit program in 'xyz_free' function), but
overall it seems like a better state than status quo. It might also
finally push GCC to begin supporting BTF tags.

Mapping of a set of btf_ids can be done to a specific kfunc hook
(instead of current program type), so you are basically composing a
kfunc hook out of a set of btf_ids instead of program type. It
represents a safe context to call those kfuncs in.

It is impossible to know otherwise what case is safe to call a kfunc
for and what is not statically - short of also allowing the unsafe
cases.

Then the kfuncs work on refcounted pointers, and also unrefcounted
ones for known safe cases (basically where the lifetime is guaranteed
by bpf program caller). For arguments it works by default. The only
extra work is annotating things inside structures.
Might not even need that extra annotation in many cases, since kernel
already has __rcu etc. which we can start recognizing like __user to
complain in non-sleepable programs (e.g. without explicit RCU section
which may be added in the future).

Then just flip KF_TRUSTED_ARGS by default, and people have to opt into
'unsafe' instead to make it work for some edge cases, with a big fat
warning for the user of that kfunc.
