Return-Path: <netfilter-devel+bounces-11889-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B3VGFCF3mnjFQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11889-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 20:20:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB53FD92B
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 20:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 635FB301284D
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 18:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB17318ED2;
	Tue, 14 Apr 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="OxN7zcLq"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF1239085;
	Tue, 14 Apr 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190797; cv=none; b=GOaAHQ8AXFBcBnrlDSg3EtXrb5J0vyvy7PsiykqP77doqgNBf/no4GaQdcpL99b1HDMX5uiUIZucwZokXm0kf7DcIqqvEnPTPsrJziVNozsyoQXm/U4BCkOABYMJmUZkxGio5f5g9kQf1JKsKfhs7FOZ8S6qDJ+LW73zImKeuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190797; c=relaxed/simple;
	bh=7NLIVLEo1oZ9lp8JK2MqQPj3X/eSvySWABd833ymfEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBG0hV+HH2uL449R4nbfhm8CZUBnwo8XxX27laXMlQOw7qWw2s83QYq+0m6Nu7kFVKIK81pODQi0fHDJ0ixinHJA1OROp9n3dcnvNIe0rpIk4/YDnfVdC00P/XYNUWIBLal4KocjNVzvLxmC9JG5C8NVNu/uK0UJ87/2+96R6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=OxN7zcLq; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4300D285DF2;
	Tue, 14 Apr 2026 20:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776190787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QhA6fInA9ev/sumb0+jecuGAIgHW/ts30uXmTk7kTpU=;
	b=OxN7zcLqTH8SXiH6uWGZDIq0dKmbqVcDaJl9R/REPhY09HJCaxP1yGVKfmHVlwon7nGTnz
	WVskt5RD60gh5TrFWYeXi1N0UJrNp3OLq9eqklJuIa7Mr8r2SWl/vUNxk7CeVYQd9uz4f3
	v0Lb/ZrUJuMbsYfRJ9J9pSn9d8cmz7F52sQdb2OYjCFN6fPXcyPCklnIL+JLdgVRnG6m47
	Xz0zhnqWwHbthKjgOH1e06PbSf9MFkMLSwo7mD/33PKsXRCz74beFpwoT8TwYkVs00S97i
	jC7V+42+8JmZx+KaK9Z0EjVxBy7U71KXTnEiuMFMEcjRSqLwYQK+H1HV+rAyxQ==
Message-ID: <3a35daf9-edc5-4b41-b784-7b667d2738ba@cachyos.org>
Date: Tue, 14 Apr 2026 18:19:00 +0000
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: The "clockevents: Prevent timer interrupt starvation" patch
 causes lockups
To: Calvin Owens <calvin@wbinvd.org>
Cc: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com>
 <aeb848aa-404a-40fb-bd41-329644623b1d@cachyos.org>
 <ad54kGakZkvCoRaT@mozart.vkv.me>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <ad54kGakZkvCoRaT@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11889-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,infradead.org,linutronix.de,google.com,zeniv.linux.org.uk,suse.cz,netfilter.org,strlen.de,nwl.cc];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnaim@cachyos.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[cachyos.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,kernelorg];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ECB53FD92B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 1:25 AM, Calvin Owens wrote:
> On Tuesday 04/14 at 15:39 +0000, Eric Naim wrote:
>> On 4/14/26 5:20 AM, Hanabishi wrote:
>>>
>>> Hello.
>>>
>>> Sorry, but this patch as of 7.0 introduced *severe* periodic lockups on my
>>> Ryzen 7700X machine.
>>> I see such messages in the log:
>>>
>>> clocksource: Long readout interval, skipping watchdog check: cs_nsec:
>>> 2897344852 wd_nsec: 2897356996
>>>
>>> Reverting d6e152d905bdb1f32f9d99775e2f453350399a6a for mainline fixes the
>>> issue for me.
>>>
>>
>> Hi maintainers,
>>
>> several users from CachyOS has reported this regression as well. We landed on
>> the same bisection. One of the users that could reproduce this reliably
>> reproduced this just by watching a YouTube video in a browser, and observed
>> freezes and stutters when interacting with the system.
> 
> Huh, I can't reproduce this at all across 10+ machines. Can you share
> the Kconfig you're seeing this on?

Right, here it is [1]. CachyOS does carry a lot of downstream patches, but I
made sure to reproduce this on mainline before reporting here.

[1]
https://github.com/CachyOS/linux-cachyos/blob/4224303b6d7a50dd1cc3ffa78864050cc9536eec/linux-cachyos/config

> 
> Thanks,
> Calvin

-- 
Regards,
  Eric

