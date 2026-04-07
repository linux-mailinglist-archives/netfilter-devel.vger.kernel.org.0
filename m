Return-Path: <netfilter-devel+bounces-11670-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KITE33t1GkjywcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11670-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 13:41:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B763ADD77
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8922302D118
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A23AEF4A;
	Tue,  7 Apr 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peSKzZQp"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFE3AE71B;
	Tue,  7 Apr 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562100; cv=none; b=BN+JpfsXq4KZO3F/Z9avjqMIf2pALrZhQIFF3Jlo0BneVjV+HD+fDfiqOi7c/9R+n/hj+fAF636s1QFLckag4ejilsPW/bIAtJI202M24iNsqtH575f8qeHGyMuClbNIaDFy7snylLASZJOWJEdMVNh9L6mRthOqEe+t0IkouEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562100; c=relaxed/simple;
	bh=qbshZNj66asvJ47A+aeT0iqHEZRG3IFR7A8nyMw46bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ho2wUidSccXkWJ5i3XAEPyWIF0QzbO/zvt1eU24OXONMV5D+WKeC56b9bWTKs5srWUxIwbKvEDsejqoycOlTNjMA0zL0n84nyeOrOqni9qjnEe5kNJ1gtN1WpsjVyH7zShpFnOIjLwPTCxSU9pQnIdPboFmUEWcHjFE8ioUr6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peSKzZQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E475CC19421;
	Tue,  7 Apr 2026 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775562099;
	bh=qbshZNj66asvJ47A+aeT0iqHEZRG3IFR7A8nyMw46bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=peSKzZQpzHC1Nzl34iRbgyToOF4HtCapV3RySFz6+MnXnvCq/ijxGDGSTGVL/4MRQ
	 D/s5jBUey/Pforf1ACh4Rj2doByYaw8fHWiZmSspgZsLCIYQL4IIfXUJjdfnsMIekP
	 bxEbW0Z4Pe/2A7mAbGJEkH7MjnBjzchbC0DhdloKNUKQcGhm+ziUbjak+Z5MFsRtOP
	 VuDdx4MYtk26DsHWVSt/V4NM2L/h81LyUM/uJM/M0G1QzSPRrwbPidiZ/6w8wvJ277
	 BlVlNjc59yPty02ploxjtVsDH/XuyIWCt8tuSjKNiE5p57eMBVFd58EiqFsQ33nQLg
	 awgN448r0r2nA==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, linux-fsdevel@vger.kernel.org,
 Calvin Owens <calvin@wbinvd.org>, Ingo Molnar <mingo@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Sebastian
 Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 09/12] fs/timerfd: Use the new alarm/hrtimer functions
In-Reply-To: <20260407100920.GT2872@noisy.programming.kicks-ass.net>
References: <20260407083219.478203185@kernel.org>
 <20260407083248.102440187@kernel.org>
 <20260407100920.GT2872@noisy.programming.kicks-ass.net>
Date: Tue, 07 Apr 2026 13:41:36 +0200
Message-ID: <87bjfv5767.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11670-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2B763ADD77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07 2026 at 12:09, Peter Zijlstra wrote:
>> -			ctx->ticks +=
>> -				hrtimer_forward_now(&ctx->t.tmr, ctx->tintv)
>> -				- 1;
>
> (argh!)
>
>> -			hrtimer_restart(&ctx->t.tmr);
>> -		}
>> +		ctx->ticks += timerfd_restart(ctx);
>>  	}
>>  	t->it_value = ktime_to_timespec64(timerfd_get_remaining(ctx));
>>  	t->it_interval = ktime_to_timespec64(ctx->tintv);
>
> What's with the -1 thing?

Magic :)

Reading the timerfd returns the number of expired ticks since the last
read or since the timer was armed.

The expiry callback increments ticks by one, hrtimer_forward_now()
returns the number of expired ticks relative to the previous expiry
time. So it would double account that.

Not pretty, but we need to increment ticks in the callback because of
non-interval timers as for those we don't invoke the forwarding.

Thanks,

        tglx



