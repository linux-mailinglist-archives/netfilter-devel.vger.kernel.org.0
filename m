Return-Path: <netfilter-devel+bounces-11674-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOUnCzgP1WlQzwcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11674-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:05:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6813AFAE4
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C955306A42B
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85553B8BBB;
	Tue,  7 Apr 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQxfPSXu"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB843B636E;
	Tue,  7 Apr 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570377; cv=none; b=DRJRe+bHYkvVsy+aMHjisYhpp8Pf2U3j1mmMRJMpbmWE2B+n0oj0h0TLZKw8xHIIyaK+MCAGWv4BRmT5T0LIkWgHqa71hfD1I0Zu0Y8mssEJ/NF4FvLegsBa/pNNYcSMSdP1jNwdy8LDg1p+gLYKnmcYkhpUWPezpHkg72+OoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570377; c=relaxed/simple;
	bh=unwgo3pndGLEs3AMBmaplmpaq1/djqniJwe60B3hWng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWoqzLq8nvh/FO7y7e0WTv4mgsEcA0SSEEB17U3h5OPqQjYOsg87zTa6vo4GdPlRo9D5+YFPXLEUp3YBPGaK24tDWVeCEHYJH89JYP2X3eTSbql/BpSReLjWeXaOOJlX/CHoUxN0JKrv9leS97B4QFJNfew3sNzdE/WhVV4jYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQxfPSXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF0BC116C6;
	Tue,  7 Apr 2026 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775570377;
	bh=unwgo3pndGLEs3AMBmaplmpaq1/djqniJwe60B3hWng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WQxfPSXuMCd6xSvlhDRO6e+7fMGGLN/ThRI7h//PPrWpcfG8ZSXUgIjZhI0egEv+p
	 MjrTo9CiYI7Ciqv1uJ13bb2p5t59RLMmnbejRC2vpqFGU5xz65BrZ4BAPZHAcFV9Bc
	 L4XvgMQ6+licrdpXNtzIYybyKDHc+ZsI88lYDQZHMMMQCUi1rwOGCPdTue5jLCnJZT
	 YJ86PbLo/n7S7p30jWRgpc2So9oPYEjovdxMdtktg+JCf8z5D4pz0ag5oTXbPV80FS
	 rSEPffFevkOSo8VzzSNscUOgPyI8QZs4qel4/AVDp9O4XRWNLDKYapV7zLtnHEj5vE
	 DKmV+29DbQxJw==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Sebastian Reichel
 <sre@kernel.org>, linux-pm@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 01/12] clockevents: Prevent timer interrupt starvation
In-Reply-To: <20260407114905.GH3738786@noisy.programming.kicks-ass.net>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <20260407094206.GL2872@noisy.programming.kicks-ass.net>
 <87o6jv57od.ffs@tglx>
 <20260407114905.GH3738786@noisy.programming.kicks-ass.net>
Date: Tue, 07 Apr 2026 15:59:33 +0200
Message-ID: <874ilm6fcq.ffs@tglx>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11674-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B6813AFAE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07 2026 at 13:49, Peter Zijlstra wrote:
> On Tue, Apr 07, 2026 at 01:30:42PM +0200, Thomas Gleixner wrote:
>> > The only thing that seems to be different, is that the old code would
>> > return the ->set_next_event() error code, rather than 0 in the !force
>> > case.
>> 
>> You mean when dev->next_event_forced is set and the set_event() callback
>> above failed?
>
> next_event_foced = 0;
> force = 0;
>
> Then the old code would return rc (return value of ->set_next_event),
> while the new code will return -ETIME.
>
> (not 0 like I said).

Ah. Now it makes sense :)

> I suppose ->set_next_event() will only ever fail with -ETIME?

Yes.

