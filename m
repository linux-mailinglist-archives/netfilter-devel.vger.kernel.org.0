Return-Path: <netfilter-devel+bounces-12751-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBIIHK8jEGqsUAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12751-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 11:36:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E88585B14C2
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0097C304E436
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB93B95F2;
	Fri, 22 May 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMKwGauE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAfuSZXV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMKwGauE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAfuSZXV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724339A053
	for <netfilter-devel@vger.kernel.org>; Fri, 22 May 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442170; cv=none; b=nzjkVatXBI0/8rmR2MobE0yUYk5M3RyV9xOWDFARrsvMhlaYkF+FZKfM1woOMKqHM7Lzx0VZezM1JXvVQCtTuqg2O8QWEe+o/gkvmUIFz7eOPsz7tqbup1QGWH72izKMmtRLsNyjf1AsYBdtRhSZBSPo6oywjbcrRGVQGFM6Gac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442170; c=relaxed/simple;
	bh=38E9WaYFUQskEYBYA8GkjZoUQyn7v3eHexFoQ51haKk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c+yn4o3xNqarXtkrpGBMLA5Ri1ezY1rLo9rxOmoTw8lj29uZJjzX7m+O8Uel8unRoY704wc8WoD7V3WZBE4hHUgZcP9c2f5PeUWQekyRWRlokS2v+3wwdBGh31/EpLuXq2Gwp4ID1zvd1DfsPlH7eVgpmD831e+ERlct7bc8KJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMKwGauE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAfuSZXV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMKwGauE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAfuSZXV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEDE56BCC7;
	Fri, 22 May 2026 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779442166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gR2pmZR63NPZdo0TPimXkjFtHDC+5XRp1YhdhTxbzo=;
	b=tMKwGauEMLfGIIWznytwH7q1DNDQAHHzjYqbPx0wLUxZUkjbrKTZDM1Q3ouYuQhf2clOru
	IoBM6dddnkzaYu3FqQGJG3vqHuaRP2HzkFbPHyRU4KiRJDXHQq9tDBd6PXtpZdDDzQCMDl
	P9bWiznay3p3YFxcigkO4FHp7nJn3xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779442166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gR2pmZR63NPZdo0TPimXkjFtHDC+5XRp1YhdhTxbzo=;
	b=lAfuSZXVsHwmN0xC/UKYgf4S7xd8ZxZmuTYzwvFZ42qmqyeVSx0Qm4DOnKcUA4+Nzq7LYG
	TPR3CTOIxGSjHfDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779442166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gR2pmZR63NPZdo0TPimXkjFtHDC+5XRp1YhdhTxbzo=;
	b=tMKwGauEMLfGIIWznytwH7q1DNDQAHHzjYqbPx0wLUxZUkjbrKTZDM1Q3ouYuQhf2clOru
	IoBM6dddnkzaYu3FqQGJG3vqHuaRP2HzkFbPHyRU4KiRJDXHQq9tDBd6PXtpZdDDzQCMDl
	P9bWiznay3p3YFxcigkO4FHp7nJn3xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779442166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gR2pmZR63NPZdo0TPimXkjFtHDC+5XRp1YhdhTxbzo=;
	b=lAfuSZXVsHwmN0xC/UKYgf4S7xd8ZxZmuTYzwvFZ42qmqyeVSx0Qm4DOnKcUA4+Nzq7LYG
	TPR3CTOIxGSjHfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8ED593A8;
	Fri, 22 May 2026 09:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7A45B/UhEGrDRwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 22 May 2026 09:29:25 +0000
Message-ID: <27a6aeda-de7b-4a5e-9cc7-94f5012a9bdd@suse.de>
Date: Fri, 22 May 2026 11:29:11 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf v2] netfilter: nf_conncount: prevent connlimit drops
 for early confirmed ct
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
 pablo@netfilter.org,
 Alejandro Olivan Alvarez <alejandro.olivan.alvarez@gmail.com>
References: <20260514141628.4636-1-fmancera@suse.de>
 <agzGsaehgIuc0vIT@strlen.de> <35fd02b9-468c-40bd-86bc-833be7abda89@suse.de>
Content-Language: en-US
In-Reply-To: <35fd02b9-468c-40bd-86bc-833be7abda89@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,gmail.com];
	TAGGED_FROM(0.00)[bounces-12751-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: E88585B14C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 11:31 PM, Fernando Fernandez Mancera wrote:
> On 5/19/26 10:23 PM, Florian Westphal wrote:
>> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>>> Commit 69894e5b4c5e ("netfilter: nft_connlimit: update the count if add
>>> was skipped") introduced a regression where packets for valid
>>> connections are dropped when using connlimit for soft-limiting
>>> scenarios.
>>>
>>> The issue occurs when a new connection reuses a socket currently in
>>> the TIME_WAIT state. In this scenario, the connection tracking entry
>>> is evaluated as already confirmed. Previously, __nf_conncount_add()
>>> assumed that if a connection was confirmed and did not originate from
>>> the loopback interface, it should skip the addition and return -EEXIST.
>>>
>>> Skipping the addition triggers a garbage collection run that cleans up
>>> the TIME_WAIT connection. Consequently, the active connection count
>>> drops to 0, which xt_connlimit mishandles, leading to the false 
>>> rejection
>>> of the perfectly valid new connection.
>>
>> What do you make of https://sashiko.dev/#/ 
>> patchset/20260514141628.4636-1-fmancera%40suse.de
>>
>> Is there a way to handle this with a different solution?
>> I don't see a good solution.   What about making
>> __nf_conncount_gc_list() return the number of removed elements and allow
>> a single re-add attempt if we released some entries?
>>
>> (Note that I don't think that conncount with unidirectional traffic
>>   is a sensible thing to configure, but I can't say "not supported"
>>   either...)
> 
> Ugh I read it and to be honest, I am not sure this is valid feedback. 
> The problematic thing here would be that GC is always called.. which is 
> fine?
> 
> I can try to generate 50k connections and generate unidirectional 
> traffic to understand the consequences but I expect that it will not be 
> that bad.
> 

All seems to be working fine on my side. I couldn't reproduce any 
soft-lockup or anything. IMHO, we could disregard that feedback unless 
someone finds a real issue..

Thanks,
Fernando.


