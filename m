Return-Path: <netfilter-devel+bounces-11660-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHQAGOzV1GnuxwcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11660-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 12:01:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46D3AC736
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9724E300AD47
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198313A6F12;
	Tue,  7 Apr 2026 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEx2UPhZ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76A2F690F;
	Tue,  7 Apr 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556071; cv=none; b=nHTS775iLcBSdgOOapBGL9rdEdyFzqx3w6GMtFWuALbHjq/uOxgO9lHLNpdGA2bZncL+S55Z8s5ieIHGx9fWJkdyccceagr5+pQDykY8imz1bt5F31EoWmM0PAaeQfmGdv/qSrMj7pZ6/9NYJGVfemPz6wraFemZgiNJzkQfUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556071; c=relaxed/simple;
	bh=SVZvZcW23j5b7OrpPVl9lfpOYgcKGuSaeaxO/0W/Z6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmXqdKm6ppXsSSIHxtNdqIny/ckuKzbj4Gwye8VbDK0MqXn2XM3EPGxKkgWwrkekK8beRMXsA+gYU7qdgxDPBlBxYeg4gfczy96+ADzmTbxX9XUTQPNtsU6fK4BFo48Yxte2CGOWeV8RjM2F1zVaM8Hlakr0GB4b4vKqCNSrcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MEx2UPhZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VL2JbSxgAfIh2iradYyQ8JthT9/Jt9Wx2KnswOgunw8=; b=MEx2UPhZGulHZfmKdMkP0k5hUr
	PxmPoqmdD+IgVqSkJF5l8y8X7t6WGVdvWsRO6jjUxDFGG7gvisjFSPpVKVkYHzcSRcSTvtfqKPysp
	dq8osPALbNAqR5rOqwTRnbk8KPctMr43kPt3/BhNeuPLdLvSO4IdERZGgCJ64ami7WXALT2j3SzoU
	vp7pfJIztl7WG1iqHhf7N6qhCulvC8eBjxJ+9M3Qa0VJ0cMG+xBPdObLga7Cxz8O5cwa/O3nQMjGm
	nHWH7U72mN8NYjko4U7r8UZghLqlZ2wlVEn/T3bE6D7pXPy3OZZZYMho6ppn0TLusF0WQ6c89ZT5A
	A+dNRrIA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA3F3-00000007zZq-2JSP;
	Tue, 07 Apr 2026 10:01:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15FE730035C; Tue, 07 Apr 2026 12:01:05 +0200 (CEST)
Date: Tue, 7 Apr 2026 12:01:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Calvin Owens <calvin@wbinvd.org>, Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 05/12] posix-timers: Handle the timer_[re]arm() return
 value
Message-ID: <20260407100105.GQ2872@noisy.programming.kicks-ass.net>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.831143104@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407083247.831143104@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11660-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,infradead.org:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D46D3AC736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:54:38AM +0200, Thomas Gleixner wrote:
> The [re]arm callbacks will return true when the timer was queued and false
> if it was already expired at enqueue time.
> 
> In both cases the call sites can trivially queue the signal right there,
> when the timer was already expired.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

