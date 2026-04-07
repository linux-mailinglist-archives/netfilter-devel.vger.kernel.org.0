Return-Path: <netfilter-devel+bounces-11645-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI/4ObvG1GlbxQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11645-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 10:56:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF13AB9D6
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 10:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C203039837
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50439A800;
	Tue,  7 Apr 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEozzz2D"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40513959D;
	Tue,  7 Apr 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552071; cv=none; b=mc173cvBNuq5u7Ddk4andjoajGIAHYTslm+ji+gBeoZfRialL/CCwFpd6omWM5z907pgjpoofMv7nkSLRuzfz1lNnFHsKpq6D+0bFbPbY7IHa0+/TthsG0mr6waWYj4BxQcxzeGR9iM+xaVmyV1CPcIBX30qAsyy23B7x74rgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552071; c=relaxed/simple;
	bh=rPiPz7V/oa6BVLR04d4w2xpckltBEql69hps4FtNBgw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dFya22lCoHdZSxa5o8sYcSnvSmeBQ2zdPoJ3fPH2smUNHiKgnis9oGAvQ5PDEsfusGb8/9FPduYD0LmdUysG9g/v8HH30Xgw4b9FZ+Ck1oGtNwHo9eBpeadwXm4CXdZPxQE6o7G4HeJfzpIDFXC6xRDDF00shbNnGktR/5Vt1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEozzz2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB3EC2BCB0;
	Tue,  7 Apr 2026 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775552071;
	bh=rPiPz7V/oa6BVLR04d4w2xpckltBEql69hps4FtNBgw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=tEozzz2DUvKuprkn0KlMRnl92+kN8kWSiP9lI9cpjAf8QvQlTKNuRgXAs6g+cejd6
	 B9bDz79b4vdywpFarLLlN8i9f2mqJbg1wpcje0zqKqX4ntwTobEDRxHRSAhjowbWTY
	 UJt9UvNfYi6kmZr6U1GnIsJZI8wKFCGSqAXb+D+R8KBwJRfGHbes4CFWvj36XQ2mc2
	 mC9fMbgouXbGZxwS2g58RckGdMdZKI75F2X5Yg/+n3lqVSmnTAyocqZbf69slkS7He
	 QfC7n2b72THhiwWYq/tRt2Kd0lPXkvfXwTlk/niFoODO1KQN+DEjJ6Tm4aBEW1Xq/2
	 SU0x5J/BIinXw==
Date: Tue, 07 Apr 2026 10:54:27 +0200
Message-ID: <20260407083247.696142908@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
Subject: [patch 03/12] hrtimer: Use hrtimer_start_expires_user() for hrtimer
 sleepers
References: <20260407083219.478203185@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11645-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 74BF13AB9D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most hrtimer sleepers are user controlled and user space can hand arbitrary
expiry values in as long as they are valid timespecs. If the expiry value
is in the past then this requires a full loop through reprogramming the
clock event device, taking the hrtimer interrupt, waking the task and
reprogram again.

Use hrtimer_start_expires_user() which avoids the full round trip by
checking the timer for expiry on enqueue.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/hrtimer.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2152,7 +2152,11 @@ void hrtimer_sleeper_start_expires(struc
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
 		mode |= HRTIMER_MODE_HARD;
 
-	hrtimer_start_expires(&sl->timer, mode);
+	/* If already expired, clear the task pointer and set current state to running */
+	if (!hrtimer_start_expires_user(&sl->timer, mode)) {
+		sl->task = NULL;
+		__set_current_state(TASK_RUNNING);
+	}
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
 


