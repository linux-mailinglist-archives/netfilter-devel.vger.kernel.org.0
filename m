Return-Path: <netfilter-devel+bounces-11816-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC+bCGll2Wk5pQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11816-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 23:02:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360D3DCA9E
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95F13300A257
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 21:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AD3A7F4D;
	Fri, 10 Apr 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeoN5wlC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907533D4FB;
	Fri, 10 Apr 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854938; cv=none; b=XODcgYs5D3j/k28qwgrhp4WDdOuFuGxA3zcg0N+E1Lb562PVQ2H/Y06p1RLgLsjrp0IarmMOO/qeo8SaxIv3eb76YoZNsCma1dkgSV9SRY+hYyLSVwpWUjse2R6FVTBCJUu13xk2c/T0UlGGLaVlPdL/1Bc1LaW6xV5FIYiQj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854938; c=relaxed/simple;
	bh=NebN3Wxx3EkDVXNhorgAZBBDdQeK7iIH/y0vHwzj9Oc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gYQFqCy/l5K6aShuontPWISBkaFZh2PgZWAHU7Jb8T7N3bb44mVCsvI+MrvJnou1wDp7CkqYb0rmZ6non8jr42GE6BOLbpCtZvXU36Kb+LZzUTBsHjb2d/DRhn8NONJuZS102UM9yWSvnBmg0ctugmWfM49GAsXtX6WF4L+E0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeoN5wlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACCC19421;
	Fri, 10 Apr 2026 21:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854937;
	bh=NebN3Wxx3EkDVXNhorgAZBBDdQeK7iIH/y0vHwzj9Oc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XeoN5wlCW42zNPVn1fPVthkRRoraLHnYocRifeTqIdAYIAyxH4QXSJi6oanAJ4fjT
	 VaDEbWQKEuIZHoGKXlWknwuem2NTfBhhq7C2FOmhP8EEd+otnyzMWMEBgUJYzB2OjK
	 InDvmdp2mfRRbw08h1lEoNH+G7PJJtmlfBdPH6TlfI+4s+UP8yrXbAVJ9ufWidLcho
	 ujtCcO0XusveIPX2RzI8dmBE4QngzbueBungtdvFDMQQFwhQS79pSfO4LqL+Ugomzh
	 5tp/HhSwKVO7vTm1pX74h6STU2jQp2drJK+xlkfSmyAdoadaHFCxKJlrbofsLv3lTI
	 8k9yqcdHTKosg==
From: Thomas Gleixner <tglx@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, Florian
 Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 01/12] clockevents: Prevent timer interrupt starvation
In-Reply-To: <20260410205203.GA3922321@ax162>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org> <20260410205203.GA3922321@ax162>
Date: Fri, 10 Apr 2026 23:02:13 +0200
Message-ID: <87fr52zfze.ffs@tglx>
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
	TAGGED_FROM(0.00)[bounces-11816-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2360D3DCA9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10 2026 at 13:52, Nathan Chancellor wrote:
>> Link: https://lore.kernel.org/lkml/acMe-QZUel-bBYUh@mozart.vkv.me/
>
> This change in -next as commit 1c2eabb8805d ("clockevents: Prevent timer
> interrupt starvation") appears to make one of my test machines
> consistently lock up on boot (at least I never get to userspace). Most
> of the time I get stall messages such as

Can you please retest the changes I just pushed out into:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
    
namely: d6e152d905bd ("clockevents: Prevent timer interrupt starvation")

Thanks,

        tglx

