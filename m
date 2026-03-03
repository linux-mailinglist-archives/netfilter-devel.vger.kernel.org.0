Return-Path: <netfilter-devel+bounces-10920-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGo0DWGHpmkZRAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10920-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 08:01:53 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 908DC1E9EFE
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 08:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E941330A9ABE
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2026 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECE386456;
	Tue,  3 Mar 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET+7OO36"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D20386445
	for <netfilter-devel@vger.kernel.org>; Tue,  3 Mar 2026 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521260; cv=none; b=JYiXhJxswlJcfgQrRu8LF0/U9+yaHKQayolnQF0ZtdDcMYP+gKBIZL822bzwusTj6P2wgE0uPgfVuZHIb/j0IiXfI8lZdrLV3xdLzmUA+NG9PIsFcmijJSVBeo5DyPlT3pPz5dJbICuh6ygEAPEiE1kcgd5osg50FMsUzLLbAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521260; c=relaxed/simple;
	bh=b9rnqGy35VMSCkesVvriXCdG6dEJtwn33l1f7OgUDJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNIjEocXehgeQXphnYyPPViL6qirKeqvjRSc4LQ4k7SaE1nNIfdEyoJT3vVeAE18k/WR0sUbLLNb2bXiHjQ2XeOgVA9oP9NTPUFkwV5FsUgn5RlKzBreBZ5rbsbzl2qwKS2Qgs4SC3NfrkQMgzEXSXYKZU/++OpMjZ8cgzMayao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET+7OO36; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso44939075e9.3
        for <netfilter-devel@vger.kernel.org>; Mon, 02 Mar 2026 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772521257; x=1773126057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8WrPNsxFmfZpCyYuZIoQyAgYSLblE5qZkSbhBEShgVI=;
        b=ET+7OO36+9PMJOLvxVuO39ylTPdgmwdBmT49CHcHbyEIs/0a2OvXRNQc0TFHPsE6bC
         UJMgq4tAoOs9MorX663KQOvE09zZoWlhRSq9+XYKMY4T85FvnFDTWQWQfvOF3NpY09Ue
         IKxe9/oIdtUt0NxKnMeyi811hStnwH9G6zMNV2VecOzLp2HE7WXZEq105BvOBoPKkCfR
         V2Uf8Ku4SveKwqvjsYIV+d6NJHULFfVFnqKoW3ORecccbdkl0hpDFnnmgGbigotzrSte
         tTnqOaED+7E46u47cbu0AWbyizvgdbZCbzqStDx/gU/wSooqxe9GmkjGTQgGeyYU6QnT
         K7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772521257; x=1773126057;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WrPNsxFmfZpCyYuZIoQyAgYSLblE5qZkSbhBEShgVI=;
        b=qPgv+EwU3/bx/Lo30XQtSBebBC/LWLwFQuytscuANCQbgxnsX6WS4BCoSW/6UBg4HS
         8iSdyOJq8xtY+2o1+5VGoinvuP74PinluSv1BQIY7eHttzkk39GKlx5AHz/hd3+D4/tS
         pzQj6JM0A99znn52y/70UXbANki2d3qLikE9b8csR8KIEQbbeHgaJE0q7U6voUw16Drb
         Lj+AcWBwNZ5zfEs79uxku18Suw8sZzDrtbUkzROA8pfg25E98P3AB63TNMYnlJQz/2Le
         JZty5rnwR5xbz08wyuiZoWCSx+uuRNZ5uJRe60bjqymgodNKQjI+CTdTyyWoI49E4WQc
         N20g==
X-Forwarded-Encrypted: i=1; AJvYcCWw3t8JpdidU/l4uKoVYM0Cj9xprORWzfhgIsox4TO+4n/jJmMTEa5J10xce2QKre2ar1b6FKaql0BQKcedj4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyaUuyL+BnWJJo989kRAVViGRmqe3saS91WDbuYTD3HbhXgVR
	a0E62sclXnoZOfULrU9bMGiYTKfyI6dxogjDyBbL1zAoKozuKqSn52Sd
X-Gm-Gg: ATEYQzzhUKiye5Ne+7Zir//39vdY7ytBNAXJbGLqY5/mexoCf2uzX3rry7n6x7RhYrP
	Y4qWiZWfhHggGcCvQ4eAINKgRSSDNA6PvU28pIcGAaZQqzyzeS5HABIPMqkbpmQECDhFOK730Eh
	/3iR+3xh+l7bd75o26BFxzFVw2Aw/tPpO3vxtayDoyEVQXNrPT7l3+XEuA2Nj+kymhqhyW30KIR
	IJBPHtuNhq89z2Xk/eQI2+u5CBAHTbTs0Q17gUhbTcR4TwQCrwZs7aoqoExDHGtlJsyw2DH2VVf
	4Pi5tiwhs+UxXmii+x3c0zURm8tqGDvEAiry2YFX7S2zw1YD5PwFT9WmXiO2JDe+pul8XeRxdae
	b43agJS+u7u1PpqufqZ6NzHI220KaAVTvsyjTdbC/tEOBwLR/qPOL6N6GaZIqD6T2zR2ojl5v1p
	YI22OVySxNqBxJPqjAvqGt2XBw4doPnV7AAn0LXQNd
X-Received: by 2002:a05:600c:4592:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-483c9bad6femr255088915e9.12.1772521255334;
        Mon, 02 Mar 2026 23:00:55 -0800 (PST)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b4a121sm321462435e9.8.2026.03.02.23.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:00:54 -0800 (PST)
Message-ID: <9d110d860c0c7e110d018ea53a7666eba275da20.camel@gmail.com>
Subject: Re: [REGRESSION] 6.19.4 stable netfilter / nftables [resolved]
From: Jindrich Makovicka <makovick@gmail.com>
To: Genes Lists <lists@sapience.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	stable@vger.kernel.org, regressions@lists.linux.dev, "Kris Karas (Bug
 Reporting)" <bugs-a21@moonlit-rail.com>
Date: Tue, 03 Mar 2026 08:00:54 +0100
In-Reply-To: <b231fcdb6c66a7b24dcef3ee5c35c5f612d5c1a7.camel@sapience.com>
References: <a529a6a9a2755d45765f20b58c5c11e2f790eacb.camel@sapience.com>
		 <45f03b0b-fe8f-4942-bad1-3fbde03d4be1@leemhuis.info>
		 <143e1a402ad78dd7076516a6ceb637f378310b16.camel@sapience.com>
		 <10537f2b74da2b8a5cb8dc939f723291db39ff84.camel@sapience.com>
		 <2026022755-quail-graveyard-93e8@gregkh>
	 <b231fcdb6c66a7b24dcef3ee5c35c5f612d5c1a7.camel@sapience.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 908DC1E9EFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-10920-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makovick@gmail.com,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 08:39 -0500, Genes Lists wrote:
> On Fri, 2026-02-27 at 05:17 -0800, Greg KH wrote:
> > On Fri, Feb 27, 2026 at 08:12:59AM -0500, Genes Lists wrote:
> > > On Fri, 2026-02-27 at 07:23 -0500, Genes Lists wrote:
> > > > On Fri, 2026-02-27 at 09:00 +0100, Thorsten Leemhuis wrote:
> > > > > Lo!
> > > > >=20
> > > >=20
> > > > Repeating the nft error message here for simplicity:
> > > >=20
> > > > =C2=A0Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
> > > > =C2=A0 ...
> > > > =C2=A0 In file included from /etc/nftables.conf:134:2-44:
> > > > =C2=A0 ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
> > > > =C2=A0 Could not process rule: File exists
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xx.xxx.xxx.x/23,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^
> > > >=20
> > >=20
> > > Resolved by updating userspace.
> > >=20
> > > I can reproduce this error on non-production machine and found
> > > this
> > > error is resolved by re-bulding updated nftables, libmnl and
> > > libnftnl:
> > >=20
> > > With these versions nft rules now load without error:
> > >=20
> > > =C2=A0- nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
> > > =C2=A0- libmnl=C2=A0=C2=A0 commit 54dea548d796653534645c6e3c8577eaf7d=
77411
> > > =C2=A0- libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc
> > >=20
> > > All were compiled on machine running 6.19.4.
> >=20
> > Odd, that shouldn't be an issue, as why would the kernel version
> > you
> > build this on matter?
> >=20
> > What about trying commit f175b46d9134 ("netfilter: nf_tables: add
> > .abort_skip_removal flag for set types")?
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> - all were rebuilt from git head=C2=A0
> =C2=A0 Have not had time to explore what specific change(s)
> =C2=A0 triggered the issue yet.
>=20
> - commit f175b46d9134
> =C2=A0 I can reproduce on non-production machine - will check this and
> report back.

I had a similar problem, solved by reverting the commit below. It fails
only with a longer set. My wild guess is a closed interval with start
address at the  end of a chunk and end address at the beginning of the
next one gets misidentified as an open interval.

commit 12b1681793e9b7552495290785a3570c539f409d
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Fri Feb 6 13:33:46 2026 +0100

    netfilter: nft_set_rbtree: validate open interval overlap

Example set definition is here:

https://bugzilla.kernel.org/show_bug.cgi?id=3D221158

Using nft from Debian unstable

$ ./nft --version
nftables v1.1.6 (Commodore Bullmoose #7)

Regards,
--=20
Jindrich Makovicka

