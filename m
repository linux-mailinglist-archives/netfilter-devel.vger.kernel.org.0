Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93635AB63A
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Sep 2022 18:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiIBQJ3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Sep 2022 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiIBQJC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7C12BF74
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Sep 2022 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662134487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SgHJl1w30qXGPLJjsRfodiLaezwna9ogLkShAQBO/0Q=;
        b=ZtKUr/iB8nZpXAzo2dTPPDOpmjvpTvxtT/RezQodyCIkLuci/eV0Wi5oFipwz2VewZnCHP
        bh4xxuBbLh8d2xWdpfBWckSfriViBGfFCPPrJc3s1/kXWtdCbW0XlEK7/ix9fuqtylAhxu
        jhz0Oy01FleomX5uQDnEYDxg7SV1Yls=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-yxMzdJwHP9my5QayDO3gKw-1; Fri, 02 Sep 2022 12:01:25 -0400
X-MC-Unique: yxMzdJwHP9my5QayDO3gKw-1
Received: by mail-ej1-f72.google.com with SMTP id hp14-20020a1709073e0e00b00741a2093c4aso1252434ejc.20
        for <netfilter-devel@vger.kernel.org>; Fri, 02 Sep 2022 09:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SgHJl1w30qXGPLJjsRfodiLaezwna9ogLkShAQBO/0Q=;
        b=6Ik32oX853KiizgD3503OnHXxSi3/MhL9aT3c8mAKz4g/H2FBbXA0m3lKXIZbnH3Ge
         SfaL8SOBqCKB4g6xrDstpANpsAUCUtkfQ/JufOw1RAvW26QW2mWJ1ulpEW/QeXpDKBke
         /tTHKdUSanzizIcbSkYTlrtChcmIYb7iWVVOJWv0qXOL5SXyCKeZksoDI5oSE6CKQmVo
         qTIoogB4AmjDrcOXV5tE5dKp2Z8AE5HN5HaQ3VK9ENT6f1GhXQmULgMzEZatXTW/w2cH
         u243csvNvdgiI6J05EgI3yGtaMOSH7akHuaOYDhQ2f0J3wNvRUwE5tMCKqEgOIzz4a9i
         eKgg==
X-Gm-Message-State: ACgBeo3ch8gU2jHd/NTzsI9AbNsCpT6BhSvfFLkxjW4hK28PppSudZjL
        s5cbdJyV6McPSIpl7MpjX+Jho6x132uuqrW6Cvk2vlZp4Wvh+NrHFWp6prPGy0dTukWrgmVad2j
        vq7WTFPwKj/83EF4BRlob8GjOhahR
X-Received: by 2002:a17:906:cc5d:b0:741:38a8:a50a with SMTP id mm29-20020a170906cc5d00b0074138a8a50amr22564458ejb.650.1662134483325;
        Fri, 02 Sep 2022 09:01:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4aXddeqj3eWlfmKtGE0FV/hQh7Xo7rnOr/ynEFGCa9cz/OWQAGbaqljgEGqCoZ+QVC64Rsew==
X-Received: by 2002:a17:906:cc5d:b0:741:38a8:a50a with SMTP id mm29-20020a170906cc5d00b0074138a8a50amr22564429ejb.650.1662134483058;
        Fri, 02 Sep 2022 09:01:23 -0700 (PDT)
Received: from localhost (net-93-71-3-16.cust.vodafonedsl.it. [93.71.3.16])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073a644ef803sm1464635eju.101.2022.09.02.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:01:22 -0700 (PDT)
Date:   Fri, 2 Sep 2022 18:01:20 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, pablo@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, brouer@redhat.com,
        toke@redhat.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next 0/4] Introduce bpf_ct_set_nat_info kfunc helper
Message-ID: <YxIo0AisyNproeRX@lore-desk>
References: <cover.1662050126.git.lorenzo@kernel.org>
 <aec3e8d1-6b80-c344-febe-809bbb0308eb@iogearbox.net>
 <YxIUvxY8S256TTUf@lore-desk>
 <df144f34-b44c-cc96-69eb-32eaaf1ac1fb@iogearbox.net>
 <20220902154420.wpox77fwlamul444@nuc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tlrij5E7duojB1Rs"
Content-Disposition: inline
In-Reply-To: <20220902154420.wpox77fwlamul444@nuc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--Tlrij5E7duojB1Rs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Sep 02, 2022 at 04:41:28PM +0200, Daniel Borkmann wrote:
> > On 9/2/22 4:35 PM, Lorenzo Bianconi wrote:
> > > On Sep 02, Daniel Borkmann wrote:
> > > > On 9/1/22 6:43 PM, Lorenzo Bianconi wrote:
> > > > > Introduce bpf_ct_set_nat_info kfunc helper in order to set source=
 and
> > > > > destination nat addresses/ports in a new allocated ct entry not i=
nserted
> > > > > in the connection tracking table yet.
> > > > > Introduce support for per-parameter trusted args.
> > > > >=20
> > > > > Kumar Kartikeya Dwivedi (2):
> > > > >     bpf: Add support for per-parameter trusted args
> > > > >     selftests/bpf: Extend KF_TRUSTED_ARGS test for __ref annotati=
on
> > > > >=20
> > > > > Lorenzo Bianconi (2):
> > > > >     net: netfilter: add bpf_ct_set_nat_info kfunc helper
> > > > >     selftests/bpf: add tests for bpf_ct_set_nat_info kfunc
> > > > >=20
> > > > >    Documentation/bpf/kfuncs.rst                  | 18 +++++++
> > > > >    kernel/bpf/btf.c                              | 39 ++++++++++-=
----
> > > > >    net/bpf/test_run.c                            |  9 +++-
> > > > >    net/netfilter/nf_conntrack_bpf.c              | 49 +++++++++++=
+++++++-
> > > > >    .../testing/selftests/bpf/prog_tests/bpf_nf.c |  2 +
> > > > >    .../testing/selftests/bpf/progs/test_bpf_nf.c | 26 +++++++++-
> > > > >    tools/testing/selftests/bpf/verifier/calls.c  | 38 +++++++++++=
---
> > > > >    7 files changed, 156 insertions(+), 25 deletions(-)
> > > > >=20
> > > >=20
> > > > Looks like this fails BPF CI, ptal:
> > > >=20
> > > > https://github.com/kernel-patches/bpf/runs/8147936670?check_suite_f=
ocus=3Dtrue
> > >=20
> > > Hi Daniel,
> > >=20
> > > it seems CONFIG_NF_NAT is not set in the kernel config file.
> > > Am I supposed to enable it in bpf-next/tools/testing/selftests/bpf/co=
nfig?
> >=20
> > This would have to be set there and added to the patches, yes. @Andrii/=
DanielM, is
> > this enough or are other steps needed on top of that?
>=20
> Yes, I think it should be set at said location. Nothing else should be
> needed in addition that I can think of.

ack, I will wait a bit for some more feedbacks and then I will post v2.

Regards,
Lorenzo

>=20
> Thanks,
> Daniel
>=20
> [...]
>=20

--Tlrij5E7duojB1Rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYxIo0AAKCRA6cBh0uS2t
rIbZAQCj8I7wj7VpXQ+MtZxUeYwUL5FahOtLqn7oN6s5fEWFyAEAx41hI9kY/c5v
ILpn9IjIxu/xIMkJtMxuytiEmuOKBg8=
=cGkM
-----END PGP SIGNATURE-----

--Tlrij5E7duojB1Rs--

