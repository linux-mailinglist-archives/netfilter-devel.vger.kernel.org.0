Return-Path: <netfilter-devel+bounces-11722-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HSaOoVC1mkFCwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11722-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 13:56:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C80063BB898
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 13:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFDDB30414DC
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC283C1411;
	Wed,  8 Apr 2026 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmqPy74P"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E53BE64F;
	Wed,  8 Apr 2026 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649267; cv=none; b=cKGFP567KyBpymtNB37LLurpKV3cf6fQvVafctyE2c6Kh/iN/jTCwewRrr70hChpKY+SyFL05p8+ZfSqK7D+kkiRE+Fm9PN3aVbC02QcIysA/BiW/skRvyAbEw2X2kEisuVqCS2q1vjNh1DIhfdsp77MuR3vEb/+rMQ1O4c/N3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649267; c=relaxed/simple;
	bh=N3UyrKXFvbYPC9SWjSoXyNWVoHD6NX6pR7oLyS84Pyo=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mixjPTEBRzCxpPzhKkb5XdDnrf205kqC9RJRM7lF2YmfjCK72sEsvOTLtOOkDVbZuwD+XeWdNFCTm+at0WxmWkT46l/P3AfVWIIA0DUoc+4vuAFsiWWSosF+/4EhPt63jpwTVZqia0bPxzRrY4CbzhrYj10jYMwXhmlHaNpsP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmqPy74P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA388C19421;
	Wed,  8 Apr 2026 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775649267;
	bh=N3UyrKXFvbYPC9SWjSoXyNWVoHD6NX6pR7oLyS84Pyo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dmqPy74PecC2TqdZIRNumMF4kDqapll9gZwD+bf1zzWTlbDWgnyQc5FSlde2eDLYA
	 aEFQJzJd0yZnnpaMXwf9tITBwj5XQS5Mur11uA8M4RyqJ3+n0uPkbHQdQ1AuZ9L4tO
	 aQWX+gRotWjMqj7ulBbALE17tDONO4LYTmO2QHATVvNvHRhKfP5cd9zNGUAXiQXbb1
	 +Gs2PQfjMwoV2f/NMHzwQUya2NHRFVtM6dqF7CWWjjSPsqJu17eSW5fOi+Pu5eGlAP
	 IhlOxUvGeRgBPlyEkEu+hwXG/lLOB11WQhIaZf62HQ4qBtVHEsKCKoTDLeOrNtvuvp
	 SpEr2kRfYgbHQ==
Date: Wed, 08 Apr 2026 13:54:24 +0200
Message-ID: <20260408114952.536945376@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 Calvin Owens <calvin@wbinvd.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
Subject: [patch V2 09/11] power: supply: charger-manager: Switch to
 alarm_start_timer()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11722-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C80063BB898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing alarm_start() interface is replaced with the new
alarm_start_timer() mechanism, which does not longer queue an already
expired timer and returns the state. Adjust the code to utilize this.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
V2: Rename to alarm_start_timer()
---
 drivers/power/supply/charger-manager.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -881,7 +881,7 @@ static bool cm_setup_timer(void)
 	mutex_unlock(&cm_list_mtx);
 
 	if (timer_req && cm_timer) {
-		ktime_t now, add;
+		ktime_t exp;
 
 		/*
 		 * Set alarm with the polling interval (wakeup_ms)
@@ -893,14 +893,16 @@ static bool cm_setup_timer(void)
 
 		pr_info("Charger Manager wakeup timer: %u ms\n", wakeup_ms);
 
-		now = ktime_get_boottime();
-		add = ktime_set(wakeup_ms / MSEC_PER_SEC,
+		exp = ktime_set(wakeup_ms / MSEC_PER_SEC,
 				(wakeup_ms % MSEC_PER_SEC) * NSEC_PER_MSEC);
-		alarm_start(cm_timer, ktime_add(now, add));
 
 		cm_suspend_duration_ms = wakeup_ms;
 
-		return true;
+		/*
+		 * The timer should always be queued as the timeout is at least
+		 * two seconds out. Handle it correctly nevertheless.
+		 */
+		return alarm_start_timer(cm_timer, exp, true);
 	}
 	return false;
 }


