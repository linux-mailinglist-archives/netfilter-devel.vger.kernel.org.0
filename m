Return-Path: <netfilter-devel+bounces-10418-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLFJJ1aaeGk9rQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10418-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 11:58:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3C93417
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 11:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40DDA3003717
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411534575F;
	Tue, 27 Jan 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfMAw3/M"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56074343201
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511505; cv=pass; b=B8fPAxesaDHEBkEhcIziG18L/qjvbhNS4G6vh7RVyC/GJkAcRRI7ceHJZ2EdLAryEaU1sHGS3LvysyRKcEfIFf3b77L9ashXExN8NLVdz6GXZQV+uVPtXG3TGNCWsxfMGtVjrdOdLtgYW+fmccKlT9PjZ9aN2NhI6GCFw6u9qC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511505; c=relaxed/simple;
	bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONr30UnEbrwNxpR6WFA/niIQ4l/NQI1LFta8SB3WJgIT8N/MjUuezOZN3mtbLpT3Cy6Q1JB3n5yvWF8uNbA8nji+SfQ6/UXA930vI2ID9FfjKA0mwHNDkm8Uu9zyh/rx48QYc+Xjq9gGe/ZwS9E8xaaTnWrQ8SjX8BG6lamZqdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfMAw3/M; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-385b6a15affso59764691fa.0
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 02:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511502; cv=none;
        d=google.com; s=arc-20240605;
        b=LV7FoP8y+3LMyAj0r8t+rPIB4le/e71QeDGC2U6q4tTFR2qZv0jpxSZt0Wzm7WAadP
         OXc/+hu4wVPqaOg/fBeQ75VtaK2wX3FYWXyrESq8068dz92reeazqCOssn5SqFnWpgqs
         oY22y5QjVLvHOg16qwhsi3z8KdpCiskXZZ1SXqNIhJebcUGoTCsaLtKgtoWUlRVNr/Yt
         z/wtD5JVDtIuXbsfeU2iTP+KPvbHuvQtqC02B87i1n4QzvrwUhRReoYbU1qWTunWn7ON
         0Aqhiht8tvGxz1p9eFydHjO19paLvuoZKk7jUny2hbxmTY3asAhvaArJbBkSivh12nxB
         5/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
        fh=W6ssnP4oj71tmana/kui4dqj0fWHNDUvFrLPt59a+4c=;
        b=D+03UQtUhcVrxmvVrJW2Z9EhVQaZKnL1irtaWYpS7s1zEyeAm173x+A35vawX7jXH5
         03FcF+fNWTyQFZhmxlNCdRr1YU43fW3tXk3Oir586WihkkziiLGLptGr7fmQ0uFrs+rr
         I/OEQE0UUj00WHLL2jym+6DOxdzaL+qQjeG5kF9LQLOheak1HouM/uD+7qBbqIfkKDyI
         /7xzCHMbPG3uvEIbxywbEj8tkwThFSdVe3gYr8TJCzE31oIcgxzYfYinzi4B+r5vwUIs
         kOfQStNQaO9yMNK5f4WIaHF4A9bqPwQ0sNCsBDc1l4xMw9LSqe2vDaiNHcaBnfF+x0tw
         AS1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769511502; x=1770116302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
        b=OfMAw3/Mic2rqr1c4ldAl7P+FvOUuDD6RMHYqKLQHNAThUg3+149AJ/4KktNPrgg/A
         5QgdzukVlamnkp9LVkQD3SmXxb65cfmC8/2EJIwQi3BchlNHV+YbOI2kws5FUvrwlPHg
         k0jTtOlpdGEG33rmtNyOvanKzcZyOIqoMp/jYBeSEIxy9KXHa3TgsabW5GW8dREL7KcF
         yiry7+TpjjWJ2/zMiBmLslpVWUE1RCyN+wXVSE4V+qKpwKDmPJrJ49dRCjwohXAE5Hff
         //gvCqMfZRgdn0Yhpv0bsCFqj8XSYlry5KKWz1+8jCxGxGNKFYvCX35NKYkxS6/fy54J
         1etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511502; x=1770116302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
        b=LkyqvIUcdqvupL+b8XTtuaDVKOpMd5yf6kO0z2gSonN9hhxWUxXSHk9FAxnLpn11O5
         5WtU+4rxdCzgjvoK9t74KWbBLtE2wx8WOboKdv3UcLSGqY0D/AAjgLpjPCE3HyzCTvIJ
         S6zUqodO9efsEM70eDG1tnwz2rAaW3XMLOELNFHSVeuVsEexXHIihRN+04iqJ8eL/AhE
         QbDSz41ayTem+NAluBQB1SJq7WeAQH+c/sKU74Yk+81ZWTLyrgW4YL74CgDoUjma4Re3
         6BXEMjzjCrB1z+i0I2UkLrSCHJR7FVhRGHtEgwfkjzMwQbCGInr5v5h2o83Nd2BYFWVp
         nYDA==
X-Forwarded-Encrypted: i=1; AJvYcCXbRJJsHhuVE2lsNYZWznpiE66bLhxlT2ByZbqQ+3AS94XuDOw88d7V2DkPqs/LJkzEJcJNGmrb7zjSbu9jECs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+W0Vi7uSocG1ZGMxS8w8+flmiLdYWaCpSfdq6Za1rV4RSq4g
	NzQ4LMy94cqVMuiwm62m73BxMIAJBxLHegnMfFTsu+HuLrXEWwkgSs958pDoOzbUvP8Ly2n6U7u
	MLnpAfFKfh27BV/d//Oaql8ZL2zA0zQQ=
X-Gm-Gg: AZuq6aJY5ZGwlMTmBroQkWQgQ/ywT23NyLuQWHbRB8RSgUSM81qR/U0QPGkCrPvdl5n
	VShjvXh4WtBHFGbcuEMeScb5EUgDpVebCYH9l9YWE49g5K7qhJgJmy5DNc0+0H09/JqbH4zspyW
	PMGH4JAksrX7bcGzMPo9hXzyo6k4yJm1dJYbIkG5UWxef6fbK2pdtX8IYVFIhIj6kYaPp+sterD
	HJiEreoHvaaDQgYTr2WZ1py45liYuegZFmrcPKYHFgI8uxkKMR8T0KSX/81U9W/0Tf2OfsmObY9
	ftwNqjFRwiAgt2oruOV4iki5eQ==
X-Received: by 2002:a2e:a98c:0:b0:383:160f:c230 with SMTP id
 38308e7fff4ca-3861cdf742fmr6587841fa.6.1769511502131; Tue, 27 Jan 2026
 02:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-1-one-d-wide@protonmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 27 Jan 2026 10:58:10 +0000
X-Gm-Features: AZwV_QilmQ0M_E_OX9gIvzqQlcezsEx3A9Xsbwt7w5VyeNrZs3zZwncF7WeR9UU
Message-ID: <CAD4GDZwLgUW1STpjQegzsMSZb4mOh_L79FVJx0SvmhXSpxjVSw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] doc/netlink: Expand nftables specification
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10418-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:email,protonmail.com:email,netfilter.org:email]
X-Rspamd-Queue-Id: BBA3C93417
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 18:47, Remy D. Farley <one-d-wide@protonmail.com> wrote:
>
> Getting out some changes I've accumulated while making nftables work
> with Rust netlink-bindings. Hopefully, this will be useful upstream.

Hi Remy,

Can you please cc the netfilter maintainers (and we should add
nftables.yaml to the NETFILTER entry in MAINTAINERS).

./scripts/get_maintainer.pl net/netfilter/nfnetlink.c
Pablo Neira Ayuso <pablo@netfilter.org> (maintainer:NETFILTER)
Florian Westphal <fw@strlen.de> (maintainer:NETFILTER)
Phil Sutter <phil@nwl.cc> (reviewer:NETFILTER)
...
netfilter-devel@vger.kernel.org (open list:NETFILTER)
coreteam@netfilter.org (open list:NETFILTER)
...

