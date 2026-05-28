Return-Path: <netfilter-devel+bounces-12916-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD4wKwDvF2q2WAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12916-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 09:30:08 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1605C5EDB77
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588D33090A00
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42C328267;
	Thu, 28 May 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lHf/e28m"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F79321F5F
	for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953270; cv=none; b=CiznwnJI4Dy0UfG9EaIjwvb2lYBDpnXvu8Lx2cy0jA/bWbtT2GkS3RPf1BkiomBM8TNYkwmMqvS8IIY2IfmKs5IhupbpeIZ5ppvObGNs9+YwS3jK2CMO0Amtlsz7n+UO7EpyPMZNgNg5XdrC3l+8GKqo+QsZLaSWwuqkRRdSGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953270; c=relaxed/simple;
	bh=YTA+PfyUHN8bpRCudtplWAl3a/qfJKAxYvLWX7VW9OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmQN1TQ+6MubXQFl1tObCGDi3y+eVwGxGvnnoAxJNrdC+JBK81Uc4R3w31BZ2fEH1K5LmD+IO+Vri34aXRIOsyUrUNTMo+GW7hTsDTn7XBgMxdBRGb2X06rZ+uA/f63VTI9WmZn8kTupAvwVbKxUBLie+ClDnQe7u94ki4sZg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lHf/e28m; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58fc5150-76e7-46e5-a72f-41133c408109@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779953266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8i8kgteLwN5G6ocfa4DRAqvFUspyLhNHU7pI+VpfeFo=;
	b=lHf/e28m8l6c03My+egMHO5n0JJi+5LC2K2yXOz1dfhcxoW93laWlx+hZdIZxpD59B2Ubn
	q1lIRrvTnYrgahdcLuweSOr9NcdEvONOkyXds0oIN0wBHVv+QDuu7pQrohiYbAycUlwwGm
	uy+vr4MJROyevrRBDlZ+gzoIHb2+hI8=
Date: Thu, 28 May 2026 15:27:21 +0800
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH nf] netfilter: nft_ct: fix OOB in NFT_CT_SRC/DST eval
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
References: <20260528042620.263828-1-jiayuan.chen@linux.dev>
 <ahfQGCNs8hl6FlHL@strlen.de> <ahfV6K6KrG0akLUZ@strlen.de>
 <88abc4d7-8316-4c9e-aca0-351fe0ecb2b0@linux.dev> <ahfqfM6xQKZr_xbA@strlen.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <ahfqfM6xQKZr_xbA@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12916-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 1605C5EDB77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 3:10 PM, Florian Westphal wrote:
> Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>> diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
>>> --- a/net/netfilter/nft_ct.c
>>> +++ b/net/netfilter/nft_ct.c
>>> @@ -78,7 +78,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
>>>    		break;
>>>    	}
>>> -	if (ct == NULL)
>>> +	if (!ct || nf_ct_is_template(ct))
>>>    		goto err;
>>>    	switch (priv->key) {
>>> diff --git a/net/netfilter/nft_ct_fast.c b/net/netfilter/nft_ct_fast.c
>>> --- a/net/netfilter/nft_ct_fast.c
>>> +++ b/net/netfilter/nft_ct_fast.c
>>> @@ -30,7 +30,7 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
>>>    		break;
>>>    	}
>>> -	if (!ct) {
>>> +	if (!ct || nf_ct_is_template(ct)) {
>>>    		regs->verdict.code = NFT_BREAK;
>>>    		return;
>>>    	}
>>>
>> It looks more general and also covers the other GET keys that would equally
>> misbehave on a template.
> Would you mind sending a v2?

No problem, will do.


>>> .... might also make sense to invert
>>> nf_ct_l3num(ct) == NFPROTO_IPV4 ? 4 : 16), i.e.:
>>> nf_ct_l3num(ct) == NFPROTO_IPV6 ? 16 : 4);
>> As defense-in-depth, IIUC?
> Yes, alternatively merge your v1 with the template check. I don't see how
> we can ever have nf_ct_l3num(ct) != nft_pf(pkt) outside of the template
> bug.
I think the template check plus the family check (nf_ct_l3num(ct) != 
nft_pf(pkt)) is enough as defense-in-depth.

