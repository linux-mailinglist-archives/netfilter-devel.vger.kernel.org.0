Return-Path: <netfilter-devel+bounces-11737-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBS0C5Jy1ml2FQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11737-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 17:21:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B97993BE1C8
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 17:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080E63005798
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B33D6663;
	Wed,  8 Apr 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW/ctqfW"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AF33CEA8;
	Wed,  8 Apr 2026 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661536; cv=none; b=YIDqanZrVvQ9lKC7T1+Fas+O/MvGd14zjpMkvCCX0e7LSje0UIY9zk6pPb6REhPuEjviKz+KX2m3ZET0m/pdbcK2P0Azujz+la2j3mqj0hR0s+JpyrnoNr7RNg9uxp19g60hUEltBLkL234oT9U6+tkxHga3jJHVAwivD0Abadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661536; c=relaxed/simple;
	bh=K0smtATRRlPhzZC/f2FuIGBbZSELomfitHg/FX7/F+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEO/y9+6ejXZVaGCFO8haC0YEsA72V0c4lpaJJlMixkC2GaNgYG0N4sZ5wMzjKjUqqgX9gaZ8xGBeCvVEiu18ACdbDwM9LI0qYC6vpqUu/pp2MdvvSOw+zg9c0ERRt8/VitzKZfBugCoz6pN6kRiuK9r4J1v326pYY457tTYw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW/ctqfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AAAC19421;
	Wed,  8 Apr 2026 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775661536;
	bh=K0smtATRRlPhzZC/f2FuIGBbZSELomfitHg/FX7/F+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VW/ctqfWbUrk670cLw5GbIb5IloiAdZviNrvkFPmmqRL6p6+EHv5DTHowzQ3ovPHw
	 aRyqchU1bT7LNV6SxiCzsNRrDzSIksRADxnKGdFnxZu5htqCFFWMc5u4QUutAHEU1e
	 bbeMUvdRBC/OUqesuEbPWcgFzb7v3IPc6PFqJ5FWwDz5RC8ZiqmsiYY+EOitBJtd7e
	 +CqsG0M1uIUi6yhv0paoxwNL2WB4EdiwtIPK93Jo3LVqSamcT+azpoKYqcMOBSsiMo
	 dcSjPFgJA5WWka/2nOwZ8pzHBEmYJXn6Y5bhs6DwVHhWS5jUB27L4TVtnPgc+wdJD+
	 nz239NiXc2oxw==
From: Thomas Gleixner <tglx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, Florian
 Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 01/12] clockevents: Prevent timer interrupt starvation
In-Reply-To: <20260408155353-42aeefa4-db66-48aa-ab07-0538a8cfdbf0@linutronix.de>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <20260408143313-ac6c3b82-70e6-4ce3-b33a-20f5e6ba160b@linutronix.de>
 <20260408155353-42aeefa4-db66-48aa-ab07-0538a8cfdbf0@linutronix.de>
Date: Wed, 08 Apr 2026 17:18:52 +0200
Message-ID: <87zf3d32g3.ffs@tglx>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11737-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B97993BE1C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08 2026 at 15:55, Thomas Wei=C3=9Fschuh wrote:
> On Wed, Apr 08, 2026 at 02:41:20PM +0200, Thomas Wei=C3=9Fschuh wrote:
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -369,7 +369,7 @@ int clockevents_program_event(struct clock_event_devi=
ce *dev, ktime_t expires, b
>         if (dev->next_event_forced)
>                 return 0;
>=20=20
> -       if (dev->set_next_event(dev->min_delta_ticks, dev)) {
> +       if (dev->set_next_event(dev->min_delta_ns, dev)) {

That's wrong as the callback expects cycles (ticks) not nanoseconds.

I've just pushed out an updated version to tip timers/urgent which
addresses a potentially related issue. Delta patch below.

Thanks,

        tglx
---
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -324,6 +324,8 @@ int clockevents_program_event(struct clo
 		return dev->set_next_ktime(expires, dev);
=20
 	delta =3D ktime_to_ns(ktime_sub(expires, ktime_get()));
+	if (delta <=3D 0 && !force)
+		return -ETIME;
=20
 	if (delta > (int64_t)dev->min_delta_ns) {
 		delta =3D min(delta, (int64_t) dev->max_delta_ns);

