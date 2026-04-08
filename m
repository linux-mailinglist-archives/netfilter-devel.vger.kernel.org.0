Return-Path: <netfilter-devel+bounces-11747-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDw1OIG91mnLHggAu9opvQ
	(envelope-from <netfilter-devel+bounces-11747-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 22:41:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4B3C3DDC
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD9323004D88
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBC3876D6;
	Wed,  8 Apr 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glmtp9Y7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CB4317D;
	Wed,  8 Apr 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680891; cv=none; b=d4HMPT2jhg9gUY/BuE6aQ10+NT/FgoiI55ywBJJeQjkjPaRXpsBrqhZNmGzmoeYVhWFV9/+osWVBG+Fc6ZQlrLVzy/AQVScr3A6j3+m2vsj4qFbvKDHiP/aD0pnKPKH2WP5/Ub5K7x6ELsdleNjbZWzK1IHoIs0LePGRGNBdI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680891; c=relaxed/simple;
	bh=xK+VNr9zO0H9I+Nt2uO8ZbcQkC6hmLaT6BOwXuSM6bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiB5IUzQ8Wg7HZoG5U7dqYrEo3GWEX+HjWzA1JwC/D/UdSH+KSH67c4SXhFphy9uS7pZcyAAlJwtDEvQZ3QqbQDngqwSz5o8UluQyQU5OmVOsSPdF7oLN+gHFu4VHdmbkD7Bss3eH8Pj5YW5W9Yc5LZYKr9mevNB9AVNB34eh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glmtp9Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61695C19421;
	Wed,  8 Apr 2026 20:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775680890;
	bh=xK+VNr9zO0H9I+Nt2uO8ZbcQkC6hmLaT6BOwXuSM6bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Glmtp9Y76L/kzqAltIpG33F4YjfJrkGtQiWCoQUagKUWsAyZzPhts9MxrF7MW81Iw
	 V58G0RWMRcuIKSWji1sqfbD2y7mQYnbdBwg0BzuJBjNPS1LaHRN7xgoby4QUMsviRR
	 N6ooMZJkE21NH66Z068VqNifi+Qs+G3ERS9bgvy4083wnHYNKvrU2WQYPOOZ15L7Tn
	 gGHvoviUKjg6zgUVF4o+uns+psSfO06sR2N45/IhvKnN/celpga+RjnxUy9q57FF3+
	 ROXfHe3YdDYbJQl/8FhJgVycgXVRas1sGjZtI85a2yCIBjDt7EcRRIsEa/tub8f6hw
	 iOn8FyJEp0oLA==
Date: Wed, 8 Apr 2026 22:41:27 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Calvin Owens <calvin@wbinvd.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch V2 02/11] hrtimer: Use hrtimer_start_expires_user() for
 hrtimer sleepers
Message-ID: <ada9d-r7NjOQew7x@pavilion.home>
References: <20260408102356.783133335@kernel.org>
 <20260408114952.062400833@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408114952.062400833@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11747-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,pavilion.home:mid,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAC4B3C3DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Wed, Apr 08, 2026 at 01:53:52PM +0200, Thomas Gleixner a écrit :
> Most hrtimer sleepers are user controlled and user space can hand arbitrary
> expiry values in as long as they are valid timespecs. If the expiry value
> is in the past then this requires a full loop through reprogramming the
> clock event device, taking the hrtimer interrupt, waking the task and
> reprogram again.
> 
> Use hrtimer_start_expires_user() which avoids the full round trip by
> checking the timer for expiry on enqueue.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

