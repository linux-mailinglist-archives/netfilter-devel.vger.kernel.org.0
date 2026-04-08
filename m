Return-Path: <netfilter-devel+bounces-11717-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHbVAq9C1mkFCwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11717-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 13:57:35 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7EA3BB8E7
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 13:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35AD9306B118
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C09D3BD22D;
	Wed,  8 Apr 2026 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTd0P04Q"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480333B9D98;
	Wed,  8 Apr 2026 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649245; cv=none; b=RvV9WDn1UNKSuyKhUFM645aHiMzbleiarp+oePgMBGYcDW9uF+w4P16WjBoqo5eZmMo3z1l1fCHJZPYK2hPM9MyPw71shbhGRlvcFzDTwjbxHBa37oEh4md10kCqXkN6ZfKBrBY8whpXqse0wU26Q75+s5M2fsCpWZ63jRFh/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649245; c=relaxed/simple;
	bh=C9YlNozrQiTNSBjvrTYffGhKh+u7r91EEMREnD1qMfE=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Uub1BpEHk+MCjIU40/+3Dfpp+tpHJKYuvL+Db+rK0HbWbhPwJrEmqeXDZOlhN1RhOUtv8U9rWDy1C5Z/RkUduCTdEf8ww+p2ppVBnn2v4/eAc4MOzZqyfOsG8Cy9wo7XLzS28xb3Y3HM3rFGRMHqnyfle+hPTAgIpEMilEl4nQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTd0P04Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B744C19424;
	Wed,  8 Apr 2026 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775649245;
	bh=C9YlNozrQiTNSBjvrTYffGhKh+u7r91EEMREnD1qMfE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=cTd0P04QcW5sWAV4M3ecA9ZwxuQBkVlEfmkCIPp8nQ/F4/6lVOWvXT7jxqAUk2sAX
	 s3EbPUYjjJI8hhcC0p1xpvFTOY/5ZtAnNAasYrfciwcZrKMu1SvFRCUtrgG1hzQYH0
	 7mutRly4w14FSfisZHRYME0s2HKa3y6KdyBoujOKJCG0CgYojtG3N+F0d7Kfv4sRdl
	 gYCyixZut4E5c6mVxFgLjFIjjW5GIPDWWDNm9CIvL195lk1Jmo3HsYbTlf3ziueIzF
	 UHNs6riSum5VfwPitpt9Zjlf5pOu4D/q6mHnsRguNsit13UlUEbdT6A9/v8gDFsfm2
	 hDqWXeZrXHVMA==
Date: Wed, 08 Apr 2026 13:54:01 +0200
Message-ID: <20260408114952.198028466@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Calvin Owens <calvin@wbinvd.org>,
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
Subject: [patch V2 04/11] posix-timers: Handle the timer_[re]arm() return
 value
References: <20260408102356.783133335@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11717-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,infradead.org:email]
X-Rspamd-Queue-Id: 8C7EA3BB8E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The [re]arm callbacks will return true when the timer was queued and false
if it was already expired at enqueue time.

In both cases the call sites can trivially queue the signal right there,
when the timer was already expired. That avoids a full round trip through
the hrtimer interrupt.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>

---
 kernel/time/posix-timers.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,6 +299,8 @@ static bool common_hrtimer_rearm(struct
 
 static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_itimer *timr)
 {
+	bool queued;
+
 	guard(spinlock)(&timr->it_lock);
 
 	/*
@@ -312,12 +314,18 @@ static bool __posixtimer_deliver_signal(
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
 		return true;
 
-	timr->kclock->timer_rearm(timr);
-	timr->it_status = POSIX_TIMER_ARMED;
+	/* timer_rearm() updates timr::it_overrun */
+	queued = timr->kclock->timer_rearm(timr);
+
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1LL;
 	++timr->it_signal_seq;
 	info->si_overrun = timer_overrun_to_int(timr);
+
+	if (queued)
+		timr->it_status = POSIX_TIMER_ARMED;
+	else
+		posix_timer_queue_signal(timr);
 	return true;
 }
 
@@ -905,9 +913,13 @@ int common_timer_set(struct k_itimer *ti
 		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
-	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-	if (!sigev_none)
-		timr->it_status = POSIX_TIMER_ARMED;
+	if (kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none)) {
+		if (!sigev_none)
+			timr->it_status = POSIX_TIMER_ARMED;
+	} else {
+		/* Timer was already expired, queue the signal */
+		posix_timer_queue_signal(timr);
+	}
 	return 0;
 }
 




