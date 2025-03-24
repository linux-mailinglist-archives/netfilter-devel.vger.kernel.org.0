Return-Path: <netfilter-devel+bounces-6526-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE4A6E201
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Mar 2025 19:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A45169BDF
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Mar 2025 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795A2641F2;
	Mon, 24 Mar 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ek8qr84k"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519392638BF
	for <netfilter-devel@vger.kernel.org>; Mon, 24 Mar 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839280; cv=none; b=f+Fs3XDYoY0t7IvGHRyMZZRjEMGwbNNV9hiZmbHRbeIFw1IorB6+9tWrLfSmizOYLyx4PrIhALtTEBj1Ncq+fKBSa+L/BOjvwIR9PdHnNutZpCmwnVtdJjgYuT9uJ+PICOJQjbmcLr+D8Gq9vYsAZ3aoDztPmNg+wJUJuKQzJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839280; c=relaxed/simple;
	bh=eojI4yLCU5ZM+KEblfqsXQnd371BEMPPymG9U6eyyN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuJBVwC2qfCM5ZT7a4jydgKgzUmOImMhBYMtWYzu8cf6uUW6D9aRljm8WtuFH15JaaRzFO3+AM2PZCqplQqUTTVDcQs56TVK28TYJLEzKguGkOUK3Byh8pzUoNxdqE+mI9sZ13i0IDMmcnWSWdII1mKg6O0t+jJc63xzRRPrii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ek8qr84k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so28334225e9.1
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Mar 2025 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742839276; x=1743444076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBaEI+J75lzSBFPYWcAssMLNcEktwqaN7tmaEftWXME=;
        b=Ek8qr84kYlf0TixvmxR8kqQcep3wxV5k2VfEpASIRySaBsF8NQbw1bLStBPs3kkhw9
         dTr+jgh7Y1z+Rt1hP6JWD5nbf4y5dbhPsl8n/MsSNxgjf6Yc0IBRzarpkfWdE5b/Msaj
         GXsKl7rxtqRlR0gJ83T3jcDG9irZhNb6q7JniF3ignKkHAGilvj9n5ItoGHvxxSt6cqs
         YxrZsyIGhOvfZm03UqOtspciqKJeoSuRHclYyaaStnwnnXppIQywI310iwvrWorok45A
         cY8SwnOyZ3nQfk6BW2b48WQfdo2wLIMkm7jd74+X0S1QSmz0oCUMB7cEcFJ8ac/9p0VB
         v5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742839276; x=1743444076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBaEI+J75lzSBFPYWcAssMLNcEktwqaN7tmaEftWXME=;
        b=a5F1Ag2dM0WStYGj42iPv6omp2eIf9QvDKduuNenYz/y9wAbyMX/IBweVkpmmzVDPI
         eRoSQNjR/jcGYqUgfpsKaO+JuxnP0Q/T9SvWCuF6/Y7G3xu2/jRaVhmMV/HpSoFmnXoI
         8HBP3ZTneqnBaRvrqHLpZGiKzGn77YHTEsHYdHBEk7LR0rSstBUzXkpHb1Ex4S+y52nU
         3Hqb5JlqbEKV8qSxh3FUVY5PcLDaboLsKnohJ7vUmiVraNMB+HZ6DXFC4nGo+hfqspX7
         JOdliQGK+/UDpQE0wXs27Ge2Ntd7L0Jl5rVX5Yyufe28bPh0X2FzASC+PfUt6/0XZv/Q
         +kMA==
X-Gm-Message-State: AOJu0Yxps7Jjz2BwzUAd/VO/SeZBsobVAxakZ0wSaMczz/pUgyUhUJNf
	hLA0QK7tWI6CGZblare66+85JsFNOQqKVYNpIBt3pgKT49alO9IzDgIRn91bvCE=
X-Gm-Gg: ASbGnctrw4/WOn+BRmJzKaHRdnZpYTJMiRDTvfLEkCrMmXD7rXSKVuibGWiPpzMDFTd
	LJR/6qR2zgbOEIteF2Co7/+F1UAZ4bSfe3bnH9hLpDPKzstaNHS/lxUNgMD5FIld4EgWlMmlnKh
	cWRJRpjxyF3zbw5998teq8mUkuCxOryfqNYA95ZsInF7Ql7JnuQn5uESGnCXOnaqpfqSavNiTeO
	Fsg/zEeG3GsGE6VcbgPPegR+iBKuNeoLO4R/T4accS3V9KCteSfQgCDaouB5o11QHGKDwsaA/Bw
	v5qfdNaWrfyDAoJD3WTjp40ew8Ru4cEUoEGwpKEkCrbYURo=
X-Google-Smtp-Source: AGHT+IEdWNCbUcRtv0+28TrRm1gV/H/bWh9BvUkWbDbOi0k67J4zzVJ5xlOGZqnUUGJ6UxUKmd2efA==
X-Received: by 2002:a05:600c:3552:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-43d491bfe15mr214453805e9.15.1742839276464;
        Mon, 24 Mar 2025 11:01:16 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39abfc2115asm5569294f8f.4.2025.03.24.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:01:16 -0700 (PDT)
Date: Mon, 24 Mar 2025 19:01:14 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org, 
	Jan Engelhardt <ej@inai.de>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <iy3wkjdtudq4m763oji7bhj6w7bj2pdst7sbtahtwgcjrhpx6i@a4cy47mlcnqf>
References: <20250305170935.80558-1-mkoutny@suse.com>
 <Z9_SSuPu2TXeN2TD@calendula>
 <rpu5hl3jyvwhbvamjykjpxdxdvfmqllj4zyh7vygwdxhkpblbz@5i2abljyp2ts>
 <Z-GNBeCX0dg-rxgQ@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mcnpin23l7ibeznf"
Content-Disposition: inline
In-Reply-To: <Z-GNBeCX0dg-rxgQ@calendula>


--mcnpin23l7ibeznf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
MIME-Version: 1.0

On Mon, Mar 24, 2025 at 05:49:09PM +0100, Pablo Neira Ayuso <pablo@netfilte=
r.org> wrote:
> If !CONFIG_CGROUP_NET_CLASSID, then no classid matching is possible.
>=20
> So why allow a rule to match on cgroup with classid =3D=3D 0?

It is conservative approach to supposed users who may have filtering
rules with classid=3D0 but never mkdir any net_cls group. Only those who
eventually need to mkdir would realize there's nowhere to mkdir on (with
!CONFIG_CGROUP_NET_CLASSID). Admittedly, I have no idea if this helps to
5% of net_cls users or 0.05% or 0%. Do you have any insights into that?

> Maybe simply do this instead?
>=20
> static bool possible_classid(u32 classid)
> {
>        return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID);
> }

Yes, if the above carefulness is unnecessary, I'd like to accompany this
with complete removal of sock_cgroup_classid() function then (to have it
compile-checked that it's really impossible to compare any classids w/o
CONFIG_CGROUP_NET_CLASSID).

Thanks,
Michal

--mcnpin23l7ibeznf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+Gd6AAKCRAt3Wney77B
ScRdAP0Z92ut0NmVTI6f/3wmuCsg0BNO0oPH4rVwOdXSZhSyBQEAvG/T076Mz7ge
O2ZxP29tnCTjMeotK+HG03tvZSnluA8=
=5gNv
-----END PGP SIGNATURE-----

--mcnpin23l7ibeznf--

