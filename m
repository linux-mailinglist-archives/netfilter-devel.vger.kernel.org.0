Return-Path: <netfilter-devel+bounces-12525-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDh6OEmJAWpJcwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12525-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2026 09:46:17 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FB5097B9
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2026 09:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12FC630067A6
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2026 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE973A544D;
	Mon, 11 May 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="Lud3vwda"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53363A2541
	for <netfilter-devel@vger.kernel.org>; Mon, 11 May 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485571; cv=none; b=YgCx7UWVLD08+M2B+lCQx8+WKUd+vy+ts4lxKsxVPBqb/9Q48u7cLcr56YBzWCX+6b13pdpy5hLtWC4lOQoe0/+YNlRlDxkzPN5fMMTGIXM1YnH3kEe9Rkf5Rcl/p2EyV2cd/LBwFUGpPBAGwKZRvOIoYNCfoQNEZym4L1EvyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485571; c=relaxed/simple;
	bh=kY7RLynMJB9wQTDEmLywVV6NWa3BN4XCNQ/MQzfCkbg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n9KBr3IE1yKyafDSiPyjDAEMWH3GkS6GOIOElsd0RMLmKFc1gkYf5Zh+9eIWwDPedBAn2njRUDo2Eklwf2otlaDCaq6aYa37nHhVpKKDIf7R2R7vAiZ7WvGx3Qlsth6hbBpEdhMIjekcJ6CHxTmsw8psqgd0pMt8b6EpzIk05hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=Lud3vwda; arc=none smtp.client-ip=148.6.0.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4gDWxF5JbvzGFDMM;
	Mon, 11 May 2026 09:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1778485550; x=1780299951; bh=RIoow0ZFrQ
	X1sjkMmyUzSjHsN1HQThRtzP0Jz5p/OhI=; b=Lud3vwdaYuT8cv75FYoka4iyN7
	Jvd6kIdSFW5qYS9HYRYMQi64V/V+2qL3TTyJ/AS2sAO1XPQmfci7gMun664l5yRZ
	Hfqm2NqJs2qJoXhocuaJPPJ5qRDMUCOkuG/ky8WNvLpjZTpEGBe5cm7Fy2pnOf/x
	ikq9lf4vOuNVb9xjU=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id A2t6V0e0F0XS; Mon, 11 May 2026 09:45:50 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [IPv6:2001:738:5001:1::240:2])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4gDWxB3dKczGFDLk;
	Mon, 11 May 2026 09:45:50 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 6FC7834316A; Mon, 11 May 2026 09:45:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 6E13D340D75;
	Mon, 11 May 2026 09:45:50 +0200 (CEST)
Date: Mon, 11 May 2026 09:45:50 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Pablo Neira Ayuso <pablo@netfilter.org>
cc: Florian Westphal <fw@strlen.de>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
    netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] netfilter: ipset fixes
In-Reply-To: <agD7_1W1G6aYuXPI@chamomile>
Message-ID: <2b36b527-2bf5-5e5a-119f-004ecc4d143f@blackhole.kfki.hu>
References: <20260508205903.10238-1-kadlec@netfilter.org> <af7rnaoD7TlglbhL@strlen.de> <agD7_1W1G6aYuXPI@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Rspamd-Queue-Id: 894FB5097B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[blackhole.kfki.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12525-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@blackhole.kfki.hu,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Hi,

On Sun, 10 May 2026, Pablo Neira Ayuso wrote:

> On Sat, May 09, 2026 at 10:09:01AM +0200, Florian Westphal wrote:
>> Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
>>> Hi Pablo,
>>>
>>> Here follows the new revision of the fixes for the current list
>>> of ipset related issues. If sashiko won't find any issues in
>>> the patches themselves, then please consider applying them.
>>
>> I think it would make sense to start taking the first 4 patches so we
>> make some progress here and Jozsef doesn't have to respin all patches.
>>
>> What do you think?
>
> Agreed.

Thanks! The patch "fix a potential dump-destroy race" definitely needs 
improvement and I'll check sashiko comments as well.

Best regards,
Jozsef


