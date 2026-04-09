Return-Path: <netfilter-devel+bounces-11777-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ACeOHTM12mrTAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11777-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 17:57:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7A3CD377
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 17:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AD523108411
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DFA3E0C53;
	Thu,  9 Apr 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTCY6qbe"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F02BEC43;
	Thu,  9 Apr 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749790; cv=none; b=iiqzcIifHqNvoZMvt4odMHnGodL/r9OFN+100y35JkvjrLWtdxf997gZhlzqjfAr5NbUGa9DMOjYRflqmePdFa0NIAZdsclCFvTlFGyHfjrY9GZnQTDtjoAKUMj7+5stdnhnvu3kKjk9sWzDr/cQB2EAoImAVnzdTriH7A3/ocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749790; c=relaxed/simple;
	bh=KWGmALGio659Oy80+jPw2SWhMoDeQC8FENlJ3f19gpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQlSHHQUfdrCgbppwZdLflnrkkuvSZdniDGsHrNrH+bCIuURWGIcMkllANNG8CarIWSiK72OQgCzFLKftJDSK4pDvrh9MCcZsTA0iVQCyhqXB5tvIxcYwRrM7qnJhKTtVzz7AsEkwyGi6Pb2KCX1cGWRcA9xim3g2q24toSi5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTCY6qbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85789C4CEF7;
	Thu,  9 Apr 2026 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749790;
	bh=KWGmALGio659Oy80+jPw2SWhMoDeQC8FENlJ3f19gpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTCY6qbehuSFhO5Bd+Pv9NBW/fVuFCzBu4zdTRCjcZRx6oCzakjhDUk/MNy7F0Gqq
	 NnW3oCWND1ybX9FX7i+RK3FHLQUb9QYkfpXVFLsgiWDhMYfVrU1G057XEMzDkoS7jZ
	 GN/pBDjwO9PzzqOMw5cv3pUjcstmZQHNudPOUrCQRQJlV/7aefNrizlw7vUeBoxXdF
	 FofRfYlg3IpvTlAehrjiTNIndPkRoUviEC7DpF1FH//2Fl4aR2IaK42OOCPlijIRUg
	 dqwUTs7XZDCoFAXE0Oje+8sOilghlt+3264yhCd+ukL9HkWm6N1oInME++pSd8Zt9p
	 R2I9JaOSC/Iag==
Date: Thu, 9 Apr 2026 17:49:46 +0200
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
Subject: Re: [patch V2 04/11] posix-timers: Handle the timer_[re]arm() return
 value
Message-ID: <adfKmgvqH2R6qRAn@pavilion.home>
References: <20260408102356.783133335@kernel.org>
 <20260408114952.198028466@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408114952.198028466@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11777-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,pavilion.home:mid]
X-Rspamd-Queue-Id: 67C7A3CD377
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Wed, Apr 08, 2026 at 01:54:01PM +0200, Thomas Gleixner a écrit :
> The [re]arm callbacks will return true when the timer was queued and false
> if it was already expired at enqueue time.
> 
> In both cases the call sites can trivially queue the signal right there,
> when the timer was already expired. That avoids a full round trip through
> the hrtimer interrupt.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

