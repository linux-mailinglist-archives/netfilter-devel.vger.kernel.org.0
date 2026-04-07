Return-Path: <netfilter-devel+bounces-11691-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODBoIH8Z1Wli0wcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11691-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:49:35 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A110B3B05A8
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B480301A086
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7223EA83;
	Tue,  7 Apr 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgEZXQhl"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B41A9FB0;
	Tue,  7 Apr 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572996; cv=none; b=k3RNVqHlODmTWBuQLxpAD4oMSiHadDqFlvR+ENGVNhRfmYRCrOgC3hTjcrpqXa1rOnKQ8W9RmgDedu5G+VIkkieLMP7C+vWLKz8nYWl2YW49hIxfsMy2RP8zZLds9o06ATTl0445/RaB05FbnkNojNJKeHMCU5lNYdDBNwXdF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572996; c=relaxed/simple;
	bh=x0V8HDMD/+ttteoDJUS2U88l+YhpYc2Fl6aWUWMCqok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QTr7FUADV7sZqWfL/0/TcCvRtFxqNwmdl/yUHgjuytKLAiGC1gUCsbxGjMfjgdz7gMVsiN5dJt5FHOmL9My4beE4fKr5s2PN2tiO1TEIiCc26JC056b24GhtvltCmGusCrzn1bQJS9BWBGyyoMXH/q7vUTm8eyGIbCsYhLsekkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgEZXQhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59A2C116C6;
	Tue,  7 Apr 2026 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572996;
	bh=x0V8HDMD/+ttteoDJUS2U88l+YhpYc2Fl6aWUWMCqok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cgEZXQhlUkaZWRnOU01DIi6XvkoZTXLmpvxfJEv5ObbEvAfkis42+82Rx1GtRblUH
	 52I4eR2pw8DzuAAkIsYojEYtExUnKEiGccUTWBmxBxYmx5sqLp+cJ2PDbRkeEiS3T6
	 h4D+yrB994XCj2OtlWoL/u+lW34T1uYoLC4ipDC/aOFbRTdmT6OTKpHiaqtecX/fLD
	 uF7FZ6g3UIyXQNi234QAAH6tSrtqxYPWzedwnfBsa48ORmOB4Xr1Fd+nbELRak58w3
	 WPpsp5a4TKpGpL5TEumDy+EKbQY1vkazGFN11WFGsPMsMYQ/mCjCmN4MHAd8uUZind
	 RLvFPmrHC9v9g==
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Sebastian Reichel
 <sre@kernel.org>, linux-pm@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 00/12] hrtimers: Prevent hrtimer interrupt starvation
In-Reply-To: <20260407083219.478203185@kernel.org>
References: <20260407083219.478203185@kernel.org>
Date: Tue, 07 Apr 2026 16:43:12 +0200
Message-ID: <87wlyi4yrj.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11691-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A110B3B05A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07 2026 at 10:54, Thomas Gleixner wrote:
> There needs to be some discussion about the scope of backporting. The first
> patch preventing the stall is obviously a backport candidate. The remaining
> series can be obviously argued about, but in my opinion it should be
> backported as well as it prevents stupid or malicious user space from
> generating tons of pointless timer interrupts.

Peter and me just discussed it over IRC. With the clockevents prevention
in place, the effect of stupid/malicious code is pretty much affecting
only the user space task itself. As the timer is forced to expire once
the clockevent device has been force armed, it won't have other side
effects as device interrupts or IPIs are not blocked out and in the
worst case marginally delayed by the high frequency timer interrupt.

Once the task is scheduled out that subsides as there is nothing which
re-arms the timer anymore.

So we should be fine with backporting the clockevents fix and leave the
other parts of the series for upstream only. I still need to investigate
how all of that affects the pending changes vs. TSC deadline timer (and
similar devices) which are not going to reach that modified clockevents
code anymore.

Thanks,

        tglx



