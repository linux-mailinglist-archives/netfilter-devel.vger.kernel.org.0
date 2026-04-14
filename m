Return-Path: <netfilter-devel+bounces-11895-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMtXARS53mkqHwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11895-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 00:00:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F203FEBF5
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 00:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4F0306D1C3
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30B335C19D;
	Tue, 14 Apr 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AeX7psOB"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65092282F14
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204047; cv=pass; b=doj5tBEMGfgZAHW2ExsqO4eSiOOzvL4l2AVfurpabPc/6BQimws76UlsLOXVsTnsaeqoFcM5CcEXcarsNWl4r5tSo1kFxW5i5Mxh682+hkYM2ZXgLGDHOmeUHeV7IV7uygoh7/qZzwNZM4ktdvoqkFQruHFlrZW0Wa0WsnVDUO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204047; c=relaxed/simple;
	bh=sz/F8/PmZFkJxJpabbbK1Zb7efc7hQIJsQZyrtNMs54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hyb65swziHt6P7fFzCjsGMH4pjV8YcWjR4F6VMoh2TYwM/IeZG2W0Wgwg53JnstFq8Wdiz6t4T1nR+NISscbHBP/2Dna+TByuJf0Hf0XskUsxXF7l94on5LG5NWp4uFXL+zypti7a59FXV+HIu2bmTl+cmic2tVvDT7nNo4d+UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AeX7psOB; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c742d4df00cso2254276a12.1
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 15:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776204046; cv=none;
        d=google.com; s=arc-20240605;
        b=G3xTo9jdG+yLap5Y+nrwj/Ubx/v5r5RdI7jcSvd95dTZZ86eisIQ1AYq7AJ7zyLWCV
         LMF0myyEhXNJ9PMlYfc371qOReXBGo/160S3T6mkd40UY7t8GsibmxRll5IAD65VUfgw
         8MvbZPfEzSnLg2fc+nJrQKYcKgSK9wPzvgfZU2p9PlVpyaiOv2E1oa3WxknVxOVI45VE
         We76XK2AjFa66RiehcXcEnWEwGbqI5QIYn+F9dW2NKmr6xtbm33NaMerOFvhJP/hHF1b
         kbSb/803HBlzxbKMJqP1uP8EVt47+R2nRppa1Rtcr/UYldchuhLjYBG+JlhlEwl9csop
         cGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ceZIdMhLRnh9RyYVBOqFR3dRVpkiUcZi/iUWMzpGHAU=;
        fh=w1iQL2KaBpWAGuXlFl4v9F9HVqIXZwc+vWD2qbDmRNM=;
        b=ivr3vyHBL3Xrhwk2vCnZ8UFXWLTpGwfvdmNu5r2Bkk89WqRLElxZpjxQSeo75HVaHw
         m44FGu9hdJjRh7BrCMxYoqGsOF+dHHmFVjEDViVGQ9ZehP0/moT+AjIX22NrzKsDleHE
         y6J4l4OqrsLWctLAxICdf116Gj64NnhKTk9bf8ulxAM3B9N+JbeFgDp6B3D0xGs/nphw
         YAeUOU3iIZ6ihgVVIWufiy0wUz07LSNizbmDgEPPP7UD2NJSb1DzPMVmNjtExsQO5vvE
         G+pgt+yz/F8k48ZBHLA1+bVOoja2j/8tq1aX13gWtuokCfkq1fKxyichR2CgvnvMk8o5
         BgmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1776204046; x=1776808846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceZIdMhLRnh9RyYVBOqFR3dRVpkiUcZi/iUWMzpGHAU=;
        b=AeX7psOBs9oSWp32P2E9/BTrfK+BOr7NQFN8oVGxb4+3nyENEVOtpFtS/+5chZShXA
         rG9KRpqVxUgeRg7AJ1ITbiAzKJTreagW6vJUu5J/PpNgFkyHv0uaaWDRJjVbJClhHCsZ
         A87xCoQ9ZMmlm4NSPVA+goWBWGCkC6e+scKTOSmGVwU2tjk5MnaMyEep0LYJtGCV+HyB
         sDs3rCVq7xnWEcWoNDF9uYVRW3xvvINEOUQk4yX5NtmIhBu5Jodsc5cVviKEBDwvedtL
         esqoWQ3jNWm0vrKiLr3oB5KkLwpEL6+skzo//htMcA3raSq7PztWS6sqVT469rNarSKK
         Jmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776204046; x=1776808846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceZIdMhLRnh9RyYVBOqFR3dRVpkiUcZi/iUWMzpGHAU=;
        b=Ot2IQyCa2WmwfOXjP7n2JKMAObk4EJSJQ6I1sEDkcZo/7z+rtHhE+o3lWEqsC6FkIG
         Ko4APk80k/c/LeCjSygo4fzNxAvMCg9pIb6uHHmKFT9p5BDqoQriT4Qvo1IcPS5StYKc
         Jr6KBqLspj6doTx6CGnRpR45tfmh10DnOYamY848MBQCRrMKAGMRHTJ/yMs4nFwrH+yA
         LtyoMFBblkA8hCHDeUT5kDi+LjU00L2mCwmqcbIwZbLvo+YomlsOjKvZWjfyp/MeyNyp
         WuvfNBkJVH3gCR3gNeWbtUrCOXlS6ghL4bAslJ/oKn1IjWuiY7fp4hcpSzPJvxIxHUpY
         GmGw==
X-Forwarded-Encrypted: i=1; AFNElJ8MnU7bRSU85LTarCmx+0gHNFY+A+9dRM8uD6Wr82/ga3MgyD3LeDoKsuzDJUtjEo0CwwLVQuZ9RRhq2Vtr5PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvi8tTy204j/B0K3abXtqcAxBGJcTdl6Uwy4SnJNBf/8ki0E9
	78mcKPF3N/eVsZl6/pz2nExuIQMnAxhNdwsl37F2rO8sqP1GpBTXZ8oTccN1OD/E8nHvZMUnbJE
	/Uxrqj/eqOni/EcTL8y3a0eiKhvx/0qTRVbkUh2VF
X-Gm-Gg: AeBDietMIaAsfC6lG9djm/dHYp/NOQTB7p9iFNojx0MJYqTqgvG99lVM+ZwTrhHkC6U
	BnQdBVUuCDVIByPnySFzvFmqRzJ7aHZ91nJ04e41mCOoKjnq8kiqBJhL4OVgbKiTPtYiqVJpjT1
	KPn/fhqs1Ba/EnKJjKEitWIOa+MvuLGIPnJ5SrLaJcTyjtQ2s6EuVQs9TPPyOnZloC8+VyqPU8g
	nUtWLMReGHZiVLGfyusYLLayFHcEQMSKdVhDGOLd1TXP+yx3f8IfO6VRnfds8cV5K+6oAnOtdR5
	qnH4G1iaRaS2+cPeT84=
X-Received: by 2002:a17:903:3e0b:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2b2d5c558e4mr102545865ad.3.1776204044111; Tue, 14 Apr 2026
 15:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410204843.64259-1-xmei5@asu.edu> <adqx_IBgoyAMIJ5I@strlen.de>
 <ad4elUEYrkQ18iX8@chamomile> <ad4g_guOwNXWxd40@strlen.de>
In-Reply-To: <ad4g_guOwNXWxd40@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Apr 2026 15:00:33 -0700
X-Gm-Features: AQROBzBNmkTJ5aONCXQbv7wnnx7YL38Ugi1nw1njGrXnKxdvKHBveiXpBC8ujMM
Message-ID: <CAPpSM+SztD=MC-Jm6zvcNRjJo7a19f92o6OuLVPEb6vtYHC8YQ@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	Phil Sutter <phil@nwl.cc>, coreteam@netfilter.org, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11895-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,nwl.cc,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,netfilter.org:email]
X-Rspamd-Queue-Id: 67F203FEBF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry for the delayed reply.
Thanks for the suggestion to patch it in the configuration path and
for correcting the fix commit.
v2 would be sent ASAP.

On Tue, Apr 14, 2026 at 4:12=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > @@ -329,6 +332,15 @@ static int nfnl_osf_add_callback(struct sk_buff *s=
kb,
> >                 if (f->opt[i].kind =3D=3D OSFOPT_MSS && f->opt[i].lengt=
h < 4)
> >                         return -EINVAL;
> >
> > +               switch (f->wss.wc) {
> > +               case OSF_WSS_MODULO:
> > +                       if (f->wss.val =3D=3D 0)
> > +                               return -EINVAL;
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
> > +
> >                 tot_opt_len +=3D f->opt[i].length;
> >                 if (tot_opt_len > MAX_IPOPTLEN)
> >                         return -EINVAL;
> >
> > If no concerns, I will post a patch.
>
> Thanks Pablo, LGTM.

