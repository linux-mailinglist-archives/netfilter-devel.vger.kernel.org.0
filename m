Return-Path: <netfilter-devel+bounces-567-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB95826A74
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jan 2024 10:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2BF28290E
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jan 2024 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B91170B;
	Mon,  8 Jan 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MzNX37sC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728B12E44
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Jan 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso449397566b.0
        for <netfilter-devel@vger.kernel.org>; Mon, 08 Jan 2024 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704705356; x=1705310156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQw0PBv7H3F9npAXhHpc/yO+0aZTdw3iW7XYRioBY9M=;
        b=MzNX37sCftG06J7zDqRoVr0ASbCiDMbrmnnww9QwIfjHn6v305+3yC4sf5ZhItJ/P9
         dWgD/FpnTIJwHE4ksSWe0LyKUd6OfMRRTu2GsW3LrzyYIlk1hIm1lWPPTQTB7KlqL7yN
         TZ4o5IaKMtV94FWQY6kwJIi2YrmviStlCIrez+Ok7YKHBE61mw9794RlBmRCxk8r8RUL
         VrdvaM3wBX128iDc7clv/XxbWwBql1tdTSo4hEdAuX6o0HA2yEC1qaVMYbdyxbkpNlPz
         Usmp583j3JFO42mG5KGuZPz8LDrv6DbVyXe7CC8l1Vt6gXrWdave70ArygI0WAZ/X/pQ
         wOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705356; x=1705310156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQw0PBv7H3F9npAXhHpc/yO+0aZTdw3iW7XYRioBY9M=;
        b=FRWlblUOQApp7/xEafHoXmHJhEEJ9rOt8Gf2FTU2uneICvvpUqC3lcz4qQ1QfmRY/W
         BagjvTxoXCWa5Z6LYLR9wgA14Bg0etoUE2nqy8oaHlAWHaDZX0AeZoozBvdcRzHbvBc5
         FZzvSjukyLFqgUFSMlR9LfSBy7IOBBazPr5Fhf1qGEpY7R5gtJFYattOoc093l3N0UCM
         N/ud8DTYy6x5Ce9kcvOAK8c3bpDQI6wJZaM97JD7EdCuKPrhkXk3dq+4yEwS+PysuLda
         HkW3jlmScKAV+NvXi6jWHFFmbgNQ9cE6RGAr8IZgq+XCksHvdJHNT1EHgu/97VrJidLr
         WV+A==
X-Gm-Message-State: AOJu0Yy9J7I5uoqBSQ3xHT3HnuWMva2PKoUAtNNoiTeaCkuWu8CVKpsS
	NlwCvZKlYKTwPCV0dIg8qYqpLQ0KaX5RZl1BpEH/y3NjDJL6ug==
X-Google-Smtp-Source: AGHT+IF5FdPBR02bei/X14Ub000OcoVXRo17m86hQ2MPBeQuC7hWG3H6v1jptH9g+ATyuoxWlGDUexOGIPMl6jmv1Ns=
X-Received: by 2002:a17:906:1797:b0:a28:bd9c:8363 with SMTP id
 t23-20020a170906179700b00a28bd9c8363mr3034170eje.57.1704705356043; Mon, 08
 Jan 2024 01:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704565248.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1704565248.git.dxu@dxuuu.xyz>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Mon, 8 Jan 2024 10:15:45 +0100
Message-ID: <CAN+4W8gPeQ2OjoYLKXsNPyhSVTB+vcSaS3Xzw=-M9Rf5MXfKPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-input@vger.kernel.org, coreteam@netfilter.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fsverity@lists.linux.dev, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, cgroups@vger.kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, quentin@isovalent.com, 
	alan.maguire@oracle.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 7:25=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> =3D=3D=3D Description =3D=3D=3D
>
> This is a bpf-treewide change that annotates all kfuncs as such inside
> .BTF_ids. This annotation eventually allows us to automatically generate
> kfunc prototypes from bpftool.
>
> We store this metadata inside a yet-unused flags field inside struct
> btf_id_set8 (thanks Kumar!). pahole will be taught where to look.

This is great, thanks for tackling this. With yout patches we can
figure out the full set of kfuncs. Is there a way to extend it so that
we can tell which program context a kfunc can be called from?

