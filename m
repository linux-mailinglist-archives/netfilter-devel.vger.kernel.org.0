Return-Path: <netfilter-devel+bounces-11657-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFiRMS/V1GnuxwcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11657-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 11:58:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E293AC651
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 11:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE645300909F
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD63A450C;
	Tue,  7 Apr 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BeJ4qaRH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585A3A3811;
	Tue,  7 Apr 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555884; cv=none; b=msidFeXdIlnUbw8rxN+klRr4p1E4n3yLE1ow4C8nZ1GL3pxu+UjFgjI1ELZEIXMnStQoW5oCWgcGJCdK+BfNr2fOBs6Bqx/4say6wB/v1IsUf8fQhsyhOyUgJksCdUBAPinJVYU/EgVkOPO4c3PZKWS/bzVe6THkulHwUGET0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555884; c=relaxed/simple;
	bh=RgfU0I9zIP442zw/XGMTZKb4QwJmbpxXUGPsC0kef7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axJy2EjO1HSYzrLT8cGfxZt163zCV9GRqwx7QW3Fh72ixuYDYw2x6GxtCDEbhsqOju4NgnFlZsjnWGC9yqi/+kGBV2WdQYBLh+R7IX8dFIff/kmZyvD6WpKrdpuyIRX0wTs+stDq+W8Nx6esri8EA9OjeaCSTMLpiD86eVITr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BeJ4qaRH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l+v9qfHlGicecrX/JIMoy5WRYW+qnKSed321NIzNjcw=; b=BeJ4qaRHXncm/yzaNqzFpCqAA9
	Ys9Mz6VK4WJYhzGafch0tQNttHuL5PaICSHfXage1VBYl5Vc/0vXSDMZ84kdCXGJH8PErM2dgcAd/
	K5kebdb837bfBBtMiEndL2kudRd4ma4OzB2nma4aI5fOv9Zq2BP0cnZYPEhLIljVmY3Qns4xloSyO
	TIfGbPc5APjFUWP7nx4Ulb5e2FmLdUevAtiZ0fXEyUdiInlPKjv0wFQ8fOPUyvTDwbXrTZyTS/aod
	8HknEzB4hr81lcUbHY5PU9JtC3SsVPlqZbUH/1bK1q0JmyNlGLDYr+MTRrrNqicWw11uMdb3TmI2h
	3JId8zSA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA3C3-00000003Ofl-24UN;
	Tue, 07 Apr 2026 09:57:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6E5830035C; Tue, 07 Apr 2026 11:57:58 +0200 (CEST)
Date: Tue, 7 Apr 2026 11:57:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 02/12] hrtimer: Provide hrtimer_start_range_ns_user()
Message-ID: <20260407095758.GN2872@noisy.programming.kicks-ass.net>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.630389532@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407083247.630389532@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11657-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70E293AC651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:54:22AM +0200, Thomas Gleixner wrote:

> +static inline bool hrtimer_check_user_timer(struct hrtimer *timer)
> +{
> +	struct hrtimer_cpu_base *cpu_base = timer->base->cpu_base;
> +	ktime_t expires;
> +
> +	/*
> +	 * This uses soft expires because that's the user provided
> +	 * expiry time, while expires can be further in the past
> +	 * due to a slack value added to the user expiry time.
> +	 */
> +	expires = hrtimer_get_softexpires(timer);
> +
> +	/* Convert to monotonic */
> +	expires = ktime_sub(expires, timer->base->offset);
> +
> +	/*
> +	 * Check whether this timer will end up as the first expiring timer in
> +	 * the CPU base. If not, no further checks required as it's then
> +	 * guaranteed to expire in the future.
> +	 */
> +	if (expires >= cpu_base->expires_next)
> +		return true;
> +
> +	/* Validate that the expiry time is in the future. */
> +	if (expires > ktime_get())
> +		return true;
> +
> +	debug_deactivate(timer);
> +	__remove_hrtimer(timer, timer->base, HRTIMER_STATE_INACTIVE, false);
> +	trace_hrtimer_start_expired(timer);
> +	return false;
> +}
> +
> +static bool hrtimer_reprogram_user(struct hrtimer *timer)
> +{
> +	if (!hrtimer_check_user_timer(timer))
> +		return false;
> +	hrtimer_reprogram(timer, true);
> +	return true;
> +}
> +
> +static bool hrtimer_force_reprogram_user(struct hrtimer *timer)
> +{
> +	bool ret = hrtimer_check_user_timer(timer);
> +
> +	/*
> +	 * The base must always be reevaluated, independent of the result
> +	 * above because the timer was the first pending timer.
> +	 */
> +	hrtimer_force_reprogram(timer->base->cpu_base, 1);
> +	return ret;
> +}
> +
> +/**
> + * hrtimer_start_range_ns_user - (re)start an user controlled hrtimer
> + * @timer:	the timer to be added
> + * @tim:	expiry time
> + * @delta_ns:	"slack" range for the timer
> + * @mode:	timer mode: absolute (HRTIMER_MODE_ABS) or
> + *		relative (HRTIMER_MODE_REL), and pinned (HRTIMER_MODE_PINNED);
> + *		softirq based mode is considered for debug purpose only!
> + *
> + * Returns: True when the timer was queued, false if it was already expired
> + *
> + * This function cannot invoke the timer callback for expired timers as it might
> + * be called under a lock which the timer callback needs to acquire. So the
> + * caller has to handle that case.
> + */
> +bool hrtimer_start_range_ns_user(struct hrtimer *timer, ktime_t tim,
> +				 u64 delta_ns, const enum hrtimer_mode mode)
> +{
> +	struct hrtimer_clock_base *base;
> +	unsigned long flags;
> +	bool ret = true;
> +
> +	base = lock_hrtimer_base(timer, &flags);
> +	switch (hrtimer_start_range_ns_common(timer, tim, delta_ns, mode, base)) {
> +	case HRTIMER_REPROGRAM:
> +		ret = hrtimer_reprogram_user(timer);
> +		break;
> +	case HRTIMER_REPROGRAM_FORCE:
> +		ret = hrtimer_force_reprogram_user(timer);
> +		break;
> +	}
> +	unlock_hrtimer_base(timer, &flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hrtimer_start_range_ns_user);

Can we do that hrtimer_check_user_timer() in
hrtimer_start_range_ns_user() and then not duplicate
hrtimer_*reprogram() ?

