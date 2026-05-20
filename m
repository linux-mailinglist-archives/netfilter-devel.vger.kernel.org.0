Return-Path: <netfilter-devel+bounces-12722-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIHaKukNDWqesgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12722-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 03:27:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11510586887
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 03:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F25300AB26
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 01:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FCA2DF137;
	Wed, 20 May 2026 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vU6N6YZQ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CE258EC1
	for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2026 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240382; cv=none; b=Q9PIQZg1N+Pr8LoIGAlCmVaQamyxLqzIenwSHJ5aV7xf6ixDf37S21j1ufZPWwVupbbgFarYgAk++9DbwrYq4yDFsK4ZXSbkhi8xMpejOhtA22rsrEJpLJaK1z610LyKnA/2lcImZO3deiw8rTMePFo9GYv9CC5rEKkuesuv6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240382; c=relaxed/simple;
	bh=cuwr5fGN4GoLEBnaLulAKcHHHWTQA3fUhwXs74XKqs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbq90k/Dm5/61CknGvfu74kKlHL/YhX5i61Kmo6waYO3l3ldxuPg0kS1RrpWNt/UHve5SdHPQoYSbcM/yOKEJIpfPV0NdkwQaRsygnm/bryYiveMk5AK2CoDvAOQfPEeGpXLQrdXByFLH4kDAGls/Yca5wgivA+pdUtprYztGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vU6N6YZQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2552567e-9e35-47f8-9c3b-cff2dac75ea3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779240377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuwr5fGN4GoLEBnaLulAKcHHHWTQA3fUhwXs74XKqs4=;
	b=vU6N6YZQA7XvrEs4BlOqVePhtS4w0tI1N/aVcb2CYViR6pOTQA8lcmrQxGdIkLHEP/Vdhz
	7AvNozBTFci/EFT4JIGukAxcCdRU5HquTbWhQlX8wGo7JQnfIpBVNrSkrpP/AyiTtmyHKQ
	4kJTPfww7AGKygvIYDnKDbCYaOK5OB0=
Date: Wed, 20 May 2026 09:26:06 +0800
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH nf 2/2] selftests: netfilter: add nft_fib_nexthop test
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
 coreteam@netfilter.org
References: <20260519041431.396218-1-jiayuan.chen@linux.dev>
 <20260519041431.396218-2-jiayuan.chen@linux.dev> <agyxv8capFWhPo5I@strlen.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <agyxv8capFWhPo5I@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12722-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11510586887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/26 2:53 AM, Florian Westphal wrote:
> Specifially: 'Does the test need to verify the datapath actually
> evaluated correctly?' and
> 'It looks like the test also sets up an nftables counter rule but doesn't
> verify if the rule actually matched any packets.'
>
> I prefer functionality test over 'bug trap' tests.


Agreed -- functional verification is the right approach here.


