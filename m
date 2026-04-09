Return-Path: <netfilter-devel+bounces-11753-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLdIC1xx12mDOAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11753-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 11:29:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5153C87B8
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E89F6300C0F1
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47A23ACA7A;
	Thu,  9 Apr 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koYYWLOz"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEA26B756;
	Thu,  9 Apr 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726934; cv=none; b=KmjkqwnGJsx15wQoqJ/fSw6Gb+yNBiDgTGh8CvUQRZARRGRFdLujqrFdAzLp+vVG+b0hIhb8tZNHPb7Hs5J2fXhBAupIYqpHwQLppgQ/KM1Tio99RHd6EykETc8chXmX2BtxbLDXVX76y8dcpz0AOIieyZJ8mp2oyntIFRDOvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726934; c=relaxed/simple;
	bh=pw5T4JBGbsbSkt/xrLPyKelXMCX6olTcHia+nWsHwYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjUxWSZ002tf/4QfFee17ALdZENqciChlJ03ZIQRVsdeKhhAHpV1ojF1xLLHV2TITefkwfOMywCLZd29utbn6ct8FGkak7zUKwZLe2ArT1iN57zqV2fQPLgreG5e+b+moY78yFCImedazHIWPeQfOSaX+4Uf22uQwHvEIKWdYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koYYWLOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B88C4CEF7;
	Thu,  9 Apr 2026 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775726934;
	bh=pw5T4JBGbsbSkt/xrLPyKelXMCX6olTcHia+nWsHwYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koYYWLOzKEPUaSUP/n7tk4wnHpXA7zuFbzgpFTspYbMgHzNddcZpW0H4fRqx1+qfX
	 u9LX7VKiBNST88QOl4kb61QJenH0h6L0RA41jv95PIygnZGxglVnxbZAzQ7qOxcAqC
	 W3N7hxdmpJ21paC/ja5Hif9HzuJXl47rPGdBvKsp/xf7+tAezzRMKrEnzdPR9JFAdl
	 i4rZSWxL1+9XexNXBF/epY2vXluwWEzCUhZRPIaEfqMsqXnO1jbgaK2TFj3JpxWNyj
	 jtjM/mN3Gge1FFWG64lp/j9zvElOvjPbjyZfdnMe67eaZaNaKobAuZVP4aHDEbDONM
	 yYbmY0Qmaz+AA==
Date: Thu, 9 Apr 2026 11:28:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Calvin Owens <calvin@wbinvd.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch V2 03/11] posix-timers: Expand timer_[re]arm() callbacks
 with a boolean return value
Message-ID: <addxU8NybfBUyI68@pavilion.home>
References: <20260408102356.783133335@kernel.org>
 <20260408114952.130222296@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408114952.130222296@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11753-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: CB5153C87B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Wed, Apr 08, 2026 at 01:53:56PM +0200, Thomas Gleixner a écrit :
> In order to catch expiry times which are already in the past the
> timer_arm() and timer_rearm() callbacks need to be able to report back to
> the caller whether the timer has been queued or not.
> 
> Change the function signature and let all implementations return true for
> now. While at it simplify posix_cpu_timer_rearm().
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

