Return-Path: <netfilter-devel+bounces-11652-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNxYAuzG1GlbxQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11652-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 10:57:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBD3AB9FE
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7D130561F5
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BD39B96A;
	Tue,  7 Apr 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUOBigyQ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19739B947;
	Tue,  7 Apr 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552106; cv=none; b=F6qMZBMMRw5ErCuaIFu4l24VieIFL25GhJQh4pWyygNEqIdI4KvnG30Wk9x9Cs/MkfjMXKdhMxlZVpep0Ta4+sht6vF+q2hQnte40KdbCQd00sXwlsbpYVJjl+sBmpb/Xpl5m/vMSBPYX+sjnNokh3K6SgLSuxCt8/Tg08FGpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552106; c=relaxed/simple;
	bh=a2rb0C/2jOI+xBjqnRW7gBLUVgARQvjzSs1wbr8yRxc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IvowmgOnxzOLrSvL7bDBzxzn1DP2waSndZfxFV+e+S/JCKgIbTV3QNsLVpgDEMuZrPEs/ng/0N3QZQ3c2F1xsyozYZ6Ppgzu4nP1c5iuWneMkrBgAOU4oGYMzrnTZ9t8FA62L0rd/xPQrF355V9qzxsvxRpFgyHnrWajatyPJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUOBigyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A69C116C6;
	Tue,  7 Apr 2026 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775552106;
	bh=a2rb0C/2jOI+xBjqnRW7gBLUVgARQvjzSs1wbr8yRxc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=iUOBigyQ2l3/0OaDrCtcIYXwmAlP2XLebtvC1T3dDB6DEGoSMg0Bgrnx4rqezikPu
	 G0jASXSRQUzQ0raUZ3Q6KnOvm3ehxa4HfZtrubpKaT9sQrPexkRjUiGEzV2JzklPR1
	 EhNxBFLpY+9mq9TJbT6RZCeklBaUI3TroyVx4kH45jXAvAbm1T2enveCiMR/2+loVG
	 GLtiYinuisRJFw5G/1io8hs13r5l7POWsXfDTCdecK5+HjmZsWG+wcy2wzJbv5xbhe
	 OmxHfPwBzR9q6KJS0wuZrMicXJTbwfN5qXypB9yq9c4hNcYisfFX9uCGyIyLU30XZp
	 W11OVgCB13J2A==
Date: Tue, 07 Apr 2026 10:55:03 +0200
Message-ID: <20260407083248.169005310@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Subject: [patch 10/12] power: supply: charger-manager: Switch to
 alarmtimer_start()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11652-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97BBD3AB9FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing alarm_start() interface is replaced with the new
alarmtimer_start() mechanism, which does not longer queue an already
expired timer and returns the state. Adjust the code to utilize this.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
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
+		return alarmtimer_start(cm_timer, exp, true);
 	}
 	return false;
 }


