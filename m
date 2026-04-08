Return-Path: <netfilter-devel+bounces-11736-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMobNh9k1mnIEwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11736-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 16:20:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 798443BD943
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C547301F9E4
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095D3A8744;
	Wed,  8 Apr 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7RMpuEh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72C3D333C;
	Wed,  8 Apr 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657714; cv=none; b=OJpTODdXaBZDcbBLITSgn9c3zsJDh52+kuaw+XB9SHyxvQT61d7FsxBMSv1xoxqCaU7+c19qwhpgBseISoRXTDMyRFjxi2oi0YsvaoSrtyooOO14Cdr/CE+Y8mmmFCNAzD3279c3K9xwOD4Wi8EXuSJ6pmiDPkGoH04ZDgKp06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657714; c=relaxed/simple;
	bh=2GKBWezh0wJ1rxI7mwwrI3CADIBrRX0kcY4kXY4Vgws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHh2BLL5KKEoTgPFzanJTY4RWUYDev0yyGDR3Ie1fkReHT0YBW/PhyWIhkrwiY9WIcSpSLic11UtN3A/QRSoIzQ++UT1OhKEeS5wgN/7u9x49CS0GQbxp157oC+pM/ca0yArrYYvC7RQofUmnYgv1U+jmy9sqke7dWRb9ylKTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7RMpuEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A9AC19421;
	Wed,  8 Apr 2026 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775657713;
	bh=2GKBWezh0wJ1rxI7mwwrI3CADIBrRX0kcY4kXY4Vgws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7RMpuEhAPW7AoOpjukUkXJY+0IaS3EO36qhsh4pHP7RO2qD8o4j/LAfL2PLYnA9E
	 ipxgcOMKMjHnufFqMlmIaFmx6ikF9fMJpZSIjwzaA5QqgBONm/RUc6COFkqhGC/aXw
	 QzVD/keNQftVMS5w6AV3K6rQT2wVra5sdjm5ElRAeT99Jyk5UibxzfyoQ5mDAJTfpL
	 8bCNhdEucCP4sh76TdoEf+0DZHkNbt2zoXyZpFbNJ2nVZlprWaE7Ssn7oGmMfkPm6h
	 QFQXp64lSaUeTm976GITCQtllOBMqK5ELfwfUpBigReRcSwN8/oPD/yPVp7KL5peTw
	 D0jjt1EBvBonQ==
Date: Wed, 8 Apr 2026 16:15:10 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 01/12] clockevents: Prevent timer interrupt starvation
Message-ID: <adZi7iFB8hqoaPcu@localhost.localdomain>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407083247.562657657@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11736-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,infradead.org:email,localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wbinvd.org:email]
X-Rspamd-Queue-Id: 798443BD943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Tue, Apr 07, 2026 at 10:54:17AM +0200, Thomas Gleixner a écrit :
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
> 
> Thanks to Calvin for providing the reproducer and to Borislav for testing
> and providing data from his Zen5 machine.
> 
> The problem is not limited to Zen5, but depending on the underlying
> clock event device (e.g. TSC deadline timer on Intel) and the CPU speed
> not necessarily observable.
> 
> This change serves only as the last resort and further changes will be made
> to prevent this scenario earlier in the call chain as far as possible.
> 
> Fixes: d316c57ff6bf ("[PATCH] clockevents: add core functionality")
> Reported-by: Calvin Owens <calvin@wbinvd.org>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/lkml/acMe-QZUel-bBYUh@mozart.vkv.me/

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

