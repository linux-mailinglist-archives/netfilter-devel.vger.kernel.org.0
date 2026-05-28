Return-Path: <netfilter-devel+bounces-12925-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM+bIO8ZGGoBdQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12925-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 12:33:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86B5F0A04
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 12:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E70A7309E4D8
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE53B5847;
	Thu, 28 May 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H9WNLuHs"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C583B27FE
	for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964033; cv=none; b=kpaxL+ASYnW9uefYpnOy21ErueZtbSaGcOHY5MOtd0IAaZglhZyiiQRuXYXVii7XSmBeilAayG5IoTE0m4xwCGQRHcloEJ2AZ/Nv+ADni4bUE41h8poLla4CGa9Ecr7ncsC5m4YvTPjisCCLTudZzgwgIu7Rx9j3IdDWKhIhwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964033; c=relaxed/simple;
	bh=6gyckp/Yq7alFvbBfF5eSvDYse6meMoHJZb6RvOCw/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4Kj6FZokqJHHt5RDYSJP1eCXxn7LbkjuzcsLLMkRLeEadEoX7fvnCSTwK7L7HkX2SkcWUuG0IwJYxW58SRPtrSQ2p2rfn9E0JxybI3rHIknGo13PYbVCg0LXM8Bjv2EmIVHeG+EYFfINDOziY/E3VmdCtUA/HdFw/tLElSQg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H9WNLuHs; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <013ca7c3-7291-4191-998f-7b675a7e7e77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779964027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K6/gasPkREiQYS6ehQF/oau2lXpXat9nc+U46AcBTc=;
	b=H9WNLuHsD+TilY82+JQ395kzQRCUi6fRh4DAoHWuZA7oe+iLwu5H2l6x9x9ReW2LEJcay+
	/IaibpWRw3DGrIXvM6yoSRowE2tllJGD0KaZmskTXZjwpcJmTSEO8tREQup2vV0OtHkrau
	b8OogYcnsKvMh0VfJeFMCw1OsPqAY04=
Date: Thu, 28 May 2026 18:26:45 +0800
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH nf] netfilter: nft_ct: fix OOB in NFT_CT_SRC/DST eval
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
References: <20260528042620.263828-1-jiayuan.chen@linux.dev>
 <ahfQGCNs8hl6FlHL@strlen.de> <ahfV6K6KrG0akLUZ@strlen.de>
 <88abc4d7-8316-4c9e-aca0-351fe0ecb2b0@linux.dev> <ahfqfM6xQKZr_xbA@strlen.de>
 <58fc5150-76e7-46e5-a72f-41133c408109@linux.dev> <ahf2XAmRnsjK0krp@strlen.de>
 <c1383a3a-6c76-411a-8ae3-1dfe90052fb7@linux.dev> <ahgLdDKloq01r7lK@strlen.de>
 <ahgS9K_8Q9AHhQ0K@chamomile> <ahgXzrLZx8J5NbVx@strlen.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <ahgXzrLZx8J5NbVx@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-12925-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 7C86B5F0A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 6:24 PM, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>> On Thu, May 28, 2026 at 11:31:32AM +0200, Florian Westphal wrote:
>>> Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>   type filter hook output priority -300; policy accept;
>>>   ct zone set 1
>>>   ct original saddr 0.0.0.0 counter accept
>>> }
>>>
>>> Then: ping -c 1 127.0.0.1
>>>
>>> should the rule match the template or not?
>> I don't think so, no matching on the template conntrack.
> Great, I will make a test case for nftables.
> Jiayuan, would you send a v2  that fixes the OOB+register leak
> and restricts template matching?
>
> Thanks!

Sure. I will send V2 since everything is clear.


