Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A31473689
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Dec 2021 22:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhLMVZo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Dec 2021 16:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233303AbhLMVZn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639430742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8ZoXvqnTXyU+fSxcQb0nWRbuEnwE4j20xX1vRvBOX8=;
        b=Tf4uRt2Pt4WIGiDYLPwFVK9qiEts7/XBNXpKx8XrWTyST9nmvOAJk4P3vGjNeoNTudgR8D
        VcoY78P61gIhQGJc7J1yEYcR1NA1I/nAwyRzct/3GvOmGC8h9kqImxL/PcKizibepUvIGv
        kSXe1P+jlxalkRxO4IcEG2aSQ+6Mgw0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-zyJoK6sEOEOwpqY8dWq5cw-1; Mon, 13 Dec 2021 16:25:41 -0500
X-MC-Unique: zyJoK6sEOEOwpqY8dWq5cw-1
Received: by mail-ed1-f69.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso15053063eds.22
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Dec 2021 13:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H8ZoXvqnTXyU+fSxcQb0nWRbuEnwE4j20xX1vRvBOX8=;
        b=CbdDlHSvC3dZ7ZvBY00QLGUXs6TuDQbK0rjeIYwz407l/qFTH+ssk+Z0Quz2vM7Yxs
         XWNgoNdOq/Z84D8tB/KVJQYSDcUJ5Mo+vIfchDXm8ugbX8kXV0tmq4pL8P3nhvxwMdbk
         DNhQwtnNoWKFdGCy+NRVCivUwBpvbaHP0tS2PTYF+5tsfYmV+fw6avwILvbS4ltTDIsj
         2iUzEZbGfV2YBq5Uz1dBY/V/35J/p0BlPXeXh493NoIil560Yd/N+XOx7dQFeKan9sho
         3YeoSPcvNpJmETGjybhD+huY68mMwvLxth2q17CS8IXVonc4U4REePGC7AqrW7uCz11x
         GYNQ==
X-Gm-Message-State: AOAM531ytgj1Eq3PI+VRsO+VT/nLVw8CgfP+z8bkyI0MBH8yRzsuCLE+
        yLf1NXyA6URxmw5Mj7DZvYWgCUc9kCgLm+J606N0rY/lBhmGYZ5RtFyw01HMytCWL2ihtAm9fAM
        Gbm2DQFFhf6wwh/afsoKfp8f7LxWu
X-Received: by 2002:a17:906:b785:: with SMTP id dt5mr900720ejb.515.1639430739606;
        Mon, 13 Dec 2021 13:25:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8q82txFC/iLUcmzva/RS0ZVHVyvAEWXIEByFJzlk88Br1P5RIVH1cuFavfwFtOUo5VBbGjg==
X-Received: by 2002:a17:906:b785:: with SMTP id dt5mr900636ejb.515.1639430738730;
        Mon, 13 Dec 2021 13:25:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o17sm523086ejj.162.2021.12.13.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:25:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3619F183566; Mon, 13 Dec 2021 22:25:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Florian Westphal <fw@strlen.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] net/netfilter: Add unstable CT lookup
 helpers for XDP and TC-BPF
In-Reply-To: <YbT5DEmlkunw7cCo@salvia>
References: <20211210130230.4128676-1-memxor@gmail.com>
 <20211210130230.4128676-8-memxor@gmail.com> <YbNtmlaeqPuHHRgl@salvia>
 <20211210153129.srb6p2ebzhl5yyzh@apollo.legion> <YbPcxjdsdqepEQAJ@salvia>
 <87pmq3ugz5.fsf@toke.dk> <YbT5DEmlkunw7cCo@salvia>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 13 Dec 2021 22:25:37 +0100
Message-ID: <87tufcyz72.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> writes:

> On Sat, Dec 11, 2021 at 07:35:58PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Pablo Neira Ayuso <pablo@netfilter.org> writes:
>>=20
>> > On Fri, Dec 10, 2021 at 09:01:29PM +0530, Kumar Kartikeya Dwivedi wrot=
e:
>> >> On Fri, Dec 10, 2021 at 08:39:14PM IST, Pablo Neira Ayuso wrote:
>> >> > On Fri, Dec 10, 2021 at 06:32:28PM +0530, Kumar Kartikeya Dwivedi w=
rote:
>> >> > [...]
>> >> > >  net/netfilter/nf_conntrack_core.c | 252 ++++++++++++++++++++++++=
++++++
>> >> > >  7 files changed, 497 insertions(+), 1 deletion(-)
>> >> > >
>> >> > [...]
>> >> > > diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf=
_conntrack_core.c
>> >> > > index 770a63103c7a..85042cb6f82e 100644
>> >> > > --- a/net/netfilter/nf_conntrack_core.c
>> >> > > +++ b/net/netfilter/nf_conntrack_core.c
>> >> >
>> >> > Please, keep this new code away from net/netfilter/nf_conntrack_cor=
e.c
>> >>=20
>> >> Ok. Can it be a new file under net/netfilter, or should it live elsew=
here?
>> >
>> > IPVS and OVS use conntrack for already quite a bit of time and they
>> > keep their code in their respective folders.
>>=20
>> Those are users, though.
>
> OK, I see this as a yet user of the conntrack infrastructure.

The users are the BPF programs; this series adds the exports. I.e., the
code defines an API that BPF programs can hook into, and implements the
validation and lifetime enforcement that is necessary for the particular
data structures being exposed. This is very much something that the
module doing the exports should be concerned with, so from that
perspective it makes sense to keep it in the nf_conntrack kmod.

>> This is adding a different set of exported functions, like a BPF
>> version of EXPORT_SYMBOL(). We don't put those outside the module
>> where the code lives either...
>
> OVS and IPVS uses Kconfig to enable the conntrack module as a
> dependency. Then, add module that is loaded when conntrack is used.

BPF can't do that, though: all the core BPF code is always built into
the kernel, so we can't have any dependencies on module code. Until now,
this has meant that hooking into modules has been out of scope for BPF
entirely. With kfuncs and the module BTF support this is now possible,
but it's a bit "weird" (i.e., different) compared to what we're used to
with kernel modules.

This series represents the first instance of actually implementing BPF
hooks into a module, BTW, so opinions on how to do it best are
absolutely welcome. But I have a hard time seeing how this could be done
without introducing *any* new code into the conntrack module...

-Toke

