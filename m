Return-Path: <netfilter-devel+bounces-11705-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APDELNFw1WmN6QcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11705-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 23:02:09 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C46963B4D20
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 23:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9293301575D
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522F35DA6D;
	Tue,  7 Apr 2026 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+nE9I02"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48671313E30;
	Tue,  7 Apr 2026 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595500; cv=none; b=XE9gDT6iLPYV2x4HQI/oyNcv/UsKulvOg0eFKdW4OXaitPl6TaY8cZv8Vy1/aJQJDo6qLSIwUatrAsTDV/rJneqoCU1h0HkQgLoKzheiZUnXqNvQXnmsXYN6yZwT3IJ5vOZB1Hk3CG9SgsyzOfWjlU3/c313r1s/gpbED/SPqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595500; c=relaxed/simple;
	bh=azI9MIFpXRuzEZQXX/hxvHrFrp7m5B/1P6YlrzqI9C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxFdynfL5BW1sHkoQd2VvehIQTCMh84XDbchxnDBU8yT3QX248MJ62BgqeJkKmVMwbT1OHEU9AdhxIgETBOQyGs4J3RYCj1k/nTsXWldtR6hXJzJYzKtjcUW22RfhGkiLwM0LVPZpS80Vnu0XPIfGlQUmDcVc5OnbOocnhqieMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+nE9I02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A9BC116C6;
	Tue,  7 Apr 2026 20:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775595500;
	bh=azI9MIFpXRuzEZQXX/hxvHrFrp7m5B/1P6YlrzqI9C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L+nE9I02IxZxS4Ni9MXq6/89TVLA0jMQWLRuUe9unn2BRSZARrFeatLTGesgC0lhh
	 FyMJhUN/9Ih6oXz6cotXiaP60n5KI+Rzfy9u7l33aqx04PY9E3mpCm3+fv8oz2x1Qm
	 Sqixfln6WsMpm8aCtPVG8dLllQ+qHYRHdnqNInWq037b/dl2ymRLL4j8K8z6L6Feag
	 VAvKt7nxHoocnqxTq/k2WfyprCh+TMt+G0DjeERJhF/q1FuEnP9qT4fWNIM+KCUO0V
	 0VgkNma4b7imM4xCsRi0Z2v1V3JyNiWidmrQ87Dth1WTKuEy/mPjRqWnkzAOwtoYfy
	 si3zib4l86Ovg==
From: Thomas Gleixner <tglx@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, Florian
 Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 00/12] hrtimers: Prevent hrtimer interrupt starvation
In-Reply-To: <adVOdTnyIbKz2F91@mozart.vkv.me>
References: <20260407083219.478203185@kernel.org>
 <adVA_uv1srA_bsKj@mozart.vkv.me> <87ika24phf.ffs@tglx>
 <adVOdTnyIbKz2F91@mozart.vkv.me>
Date: Tue, 07 Apr 2026 22:58:16 +0200
Message-ID: <87fr564hef.ffs@tglx>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11705-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C46963B4D20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07 2026 at 11:35, Calvin Owens wrote:
> On Tuesday 04/07 at 20:03 +0200, Thomas Gleixner wrote:
>> On Tue, Apr 07 2026 at 10:38, Calvin Owens wrote:
>> > On Tuesday 04/07 at 10:54 +0200, Thomas Gleixner wrote:
>> >> He provided a reproducer, which sets up a timerfd based timer and then
>> >> rearms it in a loop with an absolute expiry time of 1ns.
>> >
>> > The original AMD machines survive the reproducer with this series.
>> >
>> > Tested-by: Calvin Owens <calvin@wbinvd.org>
>> >
>> > I'm happy to test subsets of it and stable backports too, if that's
>> > helpful, just let me know.
>> 
>> We'll only backport the first patch, so confirming that it still
>> prevents the issue would be nice. The rest is slated for upstream only.
>
> Confirmed, [1/12] alone passes.

Thanks a lot for all your help. Very appreciated.

       tglx


