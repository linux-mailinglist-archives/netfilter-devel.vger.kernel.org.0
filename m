Return-Path: <netfilter-devel+bounces-11696-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNcZEARH1Wk44AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11696-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 20:03:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4423B2B24
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B3E309DC20
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C23B19BB;
	Tue,  7 Apr 2026 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffncIQTB"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200E33F370;
	Tue,  7 Apr 2026 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584906; cv=none; b=OPbYWPaCxt9fyXfFHXl2XGV8PhuloBhIwOzvTxW20fFfI6HgMVfTcGg0AzCPw59/WlskBf/sp9EqZ9t/F0XWfJC08FIFw0uBlANoIqYYaOrt0mMjTbp8D+quuztdSlIWxPPYbTEl1wo6M+Y/WDQOgpTPbGNfFNXD7GVadb14ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584906; c=relaxed/simple;
	bh=6B+bB4wDwu6y52UEp2vUDg3kQcT5fRjCxX/e9OhjKYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fDcrT/Vm+Pnt18Dl0mN+IoeLXXuQDxsfBY9GG5wQn80Sv68ASFpLflbV9ITALug6F7lw9kHpXu9AsDSVXrifP1VfrtuLkB5qySPS8IS8gbbwXiiK2A3cYSbtNB/Nelhpr30E/nqoqMIEAyWUYOeDr/yU9j32RLoKXUIZmTDSSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffncIQTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECE8C19424;
	Tue,  7 Apr 2026 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775584906;
	bh=6B+bB4wDwu6y52UEp2vUDg3kQcT5fRjCxX/e9OhjKYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ffncIQTB9uPSPzX+Hl67zcMc6bar4Dmd29wGTqpWwOeGOO4SU1YQ6w0FJYlm5PLeO
	 fgb/hVw5sv/eL6LG/wa2UmQxRzt2MVjRl+LDbJq4AKYtN45D3Y6b1Xa8dUkSSxkwPZ
	 8IIMG/iWcbW7ILFIU/Hy7qbxpuCy61KpvfMjemLmpYNLT4JLCROnyPxgh35IXVE5e0
	 CrzxrJWUq3nI+ByPHY2xTfuMpKfmLeShgRWSg3reO1A3ddBI6rfxbDA335mYN/KA1g
	 VEhzOrCmRP6zyYfLam0a05rOF06NG89aw/mchas8rn5jGzUuB/GsJMNazR1DSapjPv
	 dcpPxlH/SQl+w==
From: Thomas Gleixner <tglx@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Sebastian Reichel
 <sre@kernel.org>, linux-pm@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 01/12] clockevents: Prevent timer interrupt starvation
In-Reply-To: <87tstm4uss.ffs@tglx>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <adUN5Y9-1kx5FVHd@localhost.localdomain> <87tstm4uss.ffs@tglx>
Date: Tue, 07 Apr 2026 20:01:42 +0200
Message-ID: <87ldey4pkp.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11696-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: CE4423B2B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07 2026 at 18:08, Thomas Gleixner wrote:
> On Tue, Apr 07 2026 at 16:00, Frederic Weisbecker wrote:
> As I had to introduce the flag and prevent the other scenraio I just
> consolidated everything into one code path.

Just for the record. This whole -ETIME handling is restricted to HPET
like devices where the hardware people decided it's a brilliant idea to
build a 'equal' comparator and then followed up by making the write
posted to reduce the costs of the write. The original direct write was
already flawed vs. NMI/SMI, but the delayed commit into the comparator
made it insanely broken.

AFAICT that's a handful devices in the zoo of clockevent IPs the kernel
supports, so I'm really not too worried about the impact of this change.
Any sane hardware will never hit that code path so no point for
optimizing for it.

Thanks,

        tglx

