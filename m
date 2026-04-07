Return-Path: <netfilter-devel+bounces-11668-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFPRFbXr1GkjywcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11668-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 13:34:13 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118D3ADC16
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6C12301B4E2
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB143AE19E;
	Tue,  7 Apr 2026 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYid9cix"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D338AC86;
	Tue,  7 Apr 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561646; cv=none; b=hGvQgHiKXoR6/UGlt6PE9FsS0THDsGiGwGzANhibfP0VTZevJEQumNnIYb2KdBl/NjsPrly02WJnqZv7gbbCUPYzXi+x4C2tKJXOnCrJvudMcF3HGe3tB1CG54/1GIpduTiHAI1lvftI8xJ1n7OvzNTUJfyOI7cgCbT1ix8kfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561646; c=relaxed/simple;
	bh=yUDM3hFghJ6baIkLXjXRO9LIWzDz12fJ6chmAdiLZG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fd3WG9NBzTOosT1ke8gtoZe4Ohaa6tiTGeqoXuv5fkF2L4hD6mQZDTflhafopdHkgOlQlpwQbJ94q7+xY+gOR1EYIj18vjyGBIRejgBCnL6+IKnEwZIwtxNehlUBmTZYWS7JlN3Ko3BzmLA59WKFvaYPrsBvfbyw2Qaw8Zq/l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYid9cix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC040C2BCB1;
	Tue,  7 Apr 2026 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775561645;
	bh=yUDM3hFghJ6baIkLXjXRO9LIWzDz12fJ6chmAdiLZG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FYid9cixGFlaEndKwF1W5Z/APgig2klLq1AAkPKmWkbCqjZvvb2y1nlR1R0AYLmQx
	 NdNdarAy7GAUMUOdjE2F8aDM1KCDAovw3k0ubMvVSIXcM7kpaGtLqkjrAXOfb9mdJM
	 OH0oOetFFUq4i/d/I+wPCkw/L/LVmq9k9bkzzOg0ElgQhWRAmbfzTEzP8x6EnUQmaC
	 5F1YvUwxJ9hn7IV+2BEvmT2Rn1UAmBxD1teksdxj3TTMbBjp31gTUQu1WFcpP+tCgC
	 eBLqoSkPViaEsoCZJk0CV90aCbh7dWaxIbF8wBk8HsWFlGwTNEUcB7/AzjdwR4fGk2
	 yfumHFLut2Azw==
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
Subject: Re: [patch 02/12] hrtimer: Provide hrtimer_start_range_ns_user()
In-Reply-To: <20260407095758.GN2872@noisy.programming.kicks-ass.net>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.630389532@kernel.org>
 <20260407095758.GN2872@noisy.programming.kicks-ass.net>
Date: Tue, 07 Apr 2026 13:34:02 +0200
Message-ID: <87ika357it.ffs@tglx>
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
	TAGGED_FROM(0.00)[bounces-11668-lists,netfilter-devel=lfdr.de];
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
X-Rspamd-Queue-Id: 0118D3ADC16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07 2026 at 11:57, Peter Zijlstra wrote:
> On Tue, Apr 07, 2026 at 10:54:22AM +0200, Thomas Gleixner wrote:
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(hrtimer_start_range_ns_user);
>
> Can we do that hrtimer_check_user_timer() in
> hrtimer_start_range_ns_user() and then not duplicate
> hrtimer_*reprogram() ?

We probably can. Let me have a look.

