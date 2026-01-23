Return-Path: <netfilter-devel+bounces-10393-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLN+MQDWcmlhpwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10393-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 02:59:28 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D916F6A0
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31E9A30015A1
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 01:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14D335078;
	Fri, 23 Jan 2026 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htKdHt15"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAC2D879B
	for <netfilter-devel@vger.kernel.org>; Fri, 23 Jan 2026 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769133560; cv=pass; b=F/HPGOxxSbA8Otpq0KTOFUNAlR3cR2ajJ/ZclJ+JJW097xOhZSoOVYb6/fv3YV6ky3bKyjE68OkfGcO3dzXQg9vvOFq0cTzghB90QOH8euKzqX/dNmR1u6Ga1tZTXlopy7syxBD8HtFkkjwQASFowJvfKuggDd/gjBBDhH42hMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769133560; c=relaxed/simple;
	bh=TKHVUarC838bxCMY8bmTOECjRb1OuLtb14Hn7swPGfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFZSzaaSt9ceEje+LXUdzDzlySEYllY3RIk51+PA9HW6fYLcq9mngjy5mkoLCK6/a1qowkfgBZVgaJRbfpmhOi9Zi4D+nS3prpXUNzhMx1AViDCpIyZ1v78drv4j157BR2X5xcnJevi41I4/+PP0BEotdToj2wSd+fSOxY8p/ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htKdHt15; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5f52fa0d48dso491510137.1
        for <netfilter-devel@vger.kernel.org>; Thu, 22 Jan 2026 17:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769133545; cv=none;
        d=google.com; s=arc-20240605;
        b=MzlZ+lVKDPp3c6DUQaxa+pIgeylCmFhYuv8Y7iHPkmpkiNGXlZH+yaEObQY2+/Be2f
         HFIPJs9jEmKAhQCQglA11iHu9Bn29w1h7l1bQyyDlaLcFH55v9w6rZIFXxmM+1M9fpRg
         /1UoTrcH+BAIrXZoSDFJFedqEuuiW2q7Py1aA2NIfe6VjrNCsamejhsS8zQSQk68JJi9
         nRQPGPjKW12wDObzPaNuqb5J2elG1xBJAr1U9Q6wQfz+Ufos1cbgTaYcYXdlDDmXIxE2
         iS2vdBhdshuxZa4rwvjTLbA8/byqhy2e1WcoI9Uqp7xp/5sOcuJ4mYSprcnHow4ZGe7B
         yQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0Eyt+rVMuMXzxVQZg2iXRaPH70ogqJocllRlVOs8dtc=;
        fh=6o508ip0gR7vYwWwuRhyOT4DWPIt45TeavJkzNdl6Hk=;
        b=j5tQiAGZ6CuyrV7V722na+VAc7Gi3go0hIMToaxb2OXHe00IIu9VW8eOUvk2fncnvQ
         2+Uwhm/V2p4eTa1D96HqNPEvR6tabXil1APMsxZOgtIPYYkQYVYZVP0HHb8IfdKoYnov
         hWZs7ykO5cS6yq1LgbYYjQUx4JP9deGarsW0wPa2lgyFQ/WyVUGj2oOlugvfJTg6b7df
         BoHGRIsjZqdI6DW3zi9Yt7CJJEaDnfnzlDiw+ectv9gH6LKtp7pBpciagaaG0sYvzJwm
         rrhnaZ0+mA2dx3eoaO88PQmmoPtlG3eEKI5GtI6yi3oevY5IXo2xB8coLh6WFHyd09GN
         wr7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769133545; x=1769738345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Eyt+rVMuMXzxVQZg2iXRaPH70ogqJocllRlVOs8dtc=;
        b=htKdHt15GBBaB3WxHMhvrUdvNKogkCABO5y8wnB44vhDeXj5Fp8x1+UFelQuRm7ssG
         FYJ94paJrXZmtCdw4zuaICR0o8IxDtZ0CTGkobph/5T8lDcHp5qPuU5mD10XFzabEbCA
         L/b/k332QnySeQv6u75pigCjeuMyiUmDsue6Zm1FTF+LrpLKp5eMAfnLcumYr9KrQodI
         XkJNb0hOvu0DbNByDc8LWORxfxaDwjyv6JI+u+Z6YSOwvJ+BRuz7M1d+ollqf0OT6wBG
         X6CryugRPTNbk9hzEC3CMhsax+RNuh+wO6mIheqthaZ+hl9qw5YfLy3P5rn0HszJDjIu
         geIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769133545; x=1769738345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Eyt+rVMuMXzxVQZg2iXRaPH70ogqJocllRlVOs8dtc=;
        b=CixnjXGshy1lFtj2a/OlWrMnEsPPM/n0V6+9AcBSEvdmzrlwe+V43Pv32yoWNvkdyi
         TaExBhXmtJDERSPbcfYJg6d+1Bj9a+NMMZnqk81viWnyOVFE+o+bgppphNpYyN/35cS7
         2nmOCITPUpbmudee47W31SwEZ8Ejylf3GG5yhGMEQ11bmD2jkGkx9RnBD88D4XzipDde
         cBIcOlHAn9L0ERtsHbhGmVkTI+jYIhDvLYEYaIrmK5Fl0AVVfd0hKda803DtXU2cHXZB
         TkomO6oSxys9dGOPmsLIxhbnk6yLWbwF2R2oHwCBpxzeiO93ulgT4Psh7Jder79Hf5dy
         uXPQ==
X-Gm-Message-State: AOJu0YzuQtkCBfWEdcEVFKBiwnwdfCUca2lnbE0W2BLefGJF9uH0LGdn
	GhcGhmvbFoy+R7pZvVU7KM6xPjGb/Qt6/oXaO5uwiNUFEuvrtdCydHHK8C7JlTbfbf6Sf3WfqGg
	VjJapzlUim6uBL35DVhgvU1a2iaaf3KNA8iwH
X-Gm-Gg: AZuq6aJS5dNJekBDlWOte86LuhxlfPKxmrb5UsDA7+nkKEbCrlbfxMlRgp1RqNbJygT
	PdPMUNujuacyiuIe7H2+TFXL6cIUMW6dRUU9ckZebqnmPSwezqZcCatIRToHl1L22PPe4lFJQtk
	yOJLL0QRzEx8VxlyiTNlQ62HNy4get6O8CMX/gxyIMbUfZlpTFrz8kMZlHgtvr7jIVIR3mAl6zD
	9Tmxm3wpF/Et51nvlGjcPpJCCRe8Ka2ABbiO2GWIcLOVnJzTI+QL8pxsDJMrcBfgHwB2NoOe5FS
	l563FJ30
X-Received: by 2002:a05:6102:2ac5:b0:5f5:3d46:e602 with SMTP id
 ada2fe7eead31-5f54bb45fb9mr487238137.18.1769133544637; Thu, 22 Jan 2026
 17:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117173231.88610-1-scott.k.mitch1@gmail.com>
 <20260117173231.88610-3-scott.k.mitch1@gmail.com> <aWwUd1Z8xz5Kk30j@strlen.de>
 <CAFn2buDVyipnvn8iW1dsPN827D1BBrZ9xLjcuJHC7W00xjioSg@mail.gmail.com> <aXD1ior73lU4LYwm@strlen.de>
In-Reply-To: <aXD1ior73lU4LYwm@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 22 Jan 2026 17:58:52 -0800
X-Gm-Features: AZwV_Qj3r31QE5_X5JH3OIFUwoUtetUPK6EsXR8vZKgLpc7Q9y2Fpcy2elCNOsM
Message-ID: <CAFn2buAFkjBHZL2LRGkfaAXGd9ut+uta1MaxaHuM+=MJdGf_zQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] netfilter: nfnetlink_queue: optimize verdict
 lookup with hash table
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10393-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[scottkmitch1@gmail.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D916F6A0
X-Rspamd-Action: no action

> > > +#define NFQNL_HASH_MAX_SIZE        131072
> >
> > Is there a use case for such a large table?
>
> Order of magnitude goal is to gracefully handle 64k verdicts in a
> queue (w/ out of order verdicting).
> Ouch.  I fear this will need way more work, we will have to implement
> some form of memory accounting for the queued skbs, e.g. by tracking
> queued bytes instead of queue length.
>
> nfqueue comes from a time when GSO did not exist, now even a single
> skb can easily have 2mb worth of data.

I agree byte-based memory accounting would be valuable for preventing
memory exhaustion with large queues (especially with GSO). However, I
believe this is orthogonal to the hash verdict lookup optimization
(hash table itself has bounded memory overhead, skb memory pressure
exists today with the linear list). Does that align with your
thinking?

For my use case, packet sizes are bounded and NFQA_CFG_QUEUE_MAXLEN
provides sufficient protection.

>
> > > What is the deal-breaker wrt. rhashtable so that one would start to
> > > reimplement the features it already offers?
> >
> > Agreed if global rhashtable is within the ballpark of v6 performance
> > it would be preferred. I've implemented the global rhashtable approach
> > locally and I've also implemented an isolated test harness to assess
> > performance so we have data to drive the decision.
> >
> > I captured the rationale for current approach here:
> > https://lore.kernel.org/netfilter-devel/CAFn2buB-Pnn_kXFov+GEPST=XCbHwyW5HhidLMotqJxYoaW-+A@mail.gmail.com/#t.
>
> OK, but I'm not keen on maintaining an rhashtable clone in nfqueue.
>
> If the shrinker logic in rhashtable has bad effects then
> maybe its better to extend rhashtable first so its behaviour can
> be influenced better, e.g. by adding a delayed shrink process that
> is canceled when the low watermark is below threshold for less than
> X seconds.

Understood, and that makes sense. Good news is the global rhashtable
approach is in the same ballpark (for scenarios I ran), and I will
submit a v7 with this approach.

