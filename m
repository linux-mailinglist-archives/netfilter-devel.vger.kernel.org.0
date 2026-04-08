Return-Path: <netfilter-devel+bounces-11733-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB/CHA9N1ml8DQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11733-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 14:41:51 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7483BC4FB
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC9B302A53F
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F001D2E541E;
	Wed,  8 Apr 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1n91fiiJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7JLpCYf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B517A309;
	Wed,  8 Apr 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652083; cv=none; b=uURpJnWTdostMKvHT8cGbvlbvQoRjxKDfDjwWAZ9PSPrxDzkx3PomRTkmExD9u4jPg7VRsJR1kOvbiXlQ6tjXYO3oMDEtnVMJhoqyXecFMw6smt5W5TSbVdTpsZh9WQpYNICSuuaDZUhWdbrywsBpvCRHsFJEimvNetIvuSY43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652083; c=relaxed/simple;
	bh=XXbT5wATVXm4JD/GqE3qctRgdVlK+QcWdXInoVA0dEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6fTby33+P595p9QCzspHRj+/2c3j4fNCrXOYe30Alf5Y1GSAt6wEYmGZPPvxuFv6kSi/6p0Bu7kZRtayq6EJJzeFhY0WVbg+zVKmoQVYRDldeuHdkn+baZiQTcK8TTpNlgMlpViPCTW18wXoZJW7QzqHnMODm9dPlsllrR3c1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1n91fiiJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7JLpCYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 Apr 2026 14:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775652080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjtFJLsP9NFWdv21cGYCI8ngeEXhsnmB0domogAqwu8=;
	b=1n91fiiJpKrIK1G6+LKIjYUoFteRmu8RoRSCKHQyX+K8QWongS2ErrP6DsXsqtx+RuWdId
	z2R4St5cbfTmc1U+OsVkDrucJJP796PanwJlVtgL7zBZqjZ0/7vgCL1fQMcsHCRVp8PNP7
	QBUs7oxAPhlSqzlpamhaWnm7vo0X52YAWTF0Q0ggvAJLAu5F8uGZ4pQmtvp1mewnCpsOAS
	QETiwcAXi70/a5puQXgYELHxFVTvmaE8GMuAw0sBqn7FkQ9Fa9vOdbFra4azb1SyBYwybf
	SvDcTXxpDdtNiGVnoQpQ/xEAFYVqNzBzwfS40PsjA7HwufoveiqHzZ8RPrRm0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775652080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjtFJLsP9NFWdv21cGYCI8ngeEXhsnmB0domogAqwu8=;
	b=g7JLpCYf2VmRPHNYq91fqb0Gi3QAksbyIzlI905BFuId/PaFxj9z7u1L8THQw7Y5ovLP5n
	rvymZ7LueNwJiODA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>, 
	Peter Zijlstra <peterz@infradead.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 01/12] clockevents: Prevent timer interrupt starvation
Message-ID: <20260408143313-ac6c3b82-70e6-4ce3-b33a-20f5e6ba160b@linutronix.de>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407083247.562657657@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11733-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: CF7483BC4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Thomas,

On Tue, Apr 07, 2026 at 10:54:17AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> Calvin reported an odd NMI watchdog lockup which claims that the CPU locked
> up in user space. He provided a reproducer, which sets up a timerfd based
> timer and then rearms it in a loop with an absolute expiry time of 1ns.
> 
> As the expiry time is in the past, the timer ends up as the first expiring
> timer in the per CPU hrtimer base and the clockevent device is programmed
> with the minimum delta value. If the machine is fast enough, this ends up
> in a endless loop of programming the delta value to the minimum value
> defined by the clock event device, before the timer interrupt can fire,
> which starves the interrupt and consequently triggers the lockup detector
> because the hrtimer callback of the lockup mechanism is never invoked.
> 
> As a first step to prevent this, avoid reprogramming the clock event device
> when:
>      - a forced minimum delta event is pending
>      - the new expiry delta is less then or equal to the minimum delta

with this patch now in the tip tree my QEMU/virtme-ng based machine
fails to boot. The startup seems to freeze in:
start_kernel() -> rest_init() -> schedule_preempt_disabled() -> schedule()

CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_HZ=1000

CPU: i5-1135G7
clock event device: lapic-deadline

The clockevent device is still reprogrammed each millisecond,
presumably for the tick.

(...)


Thomas

