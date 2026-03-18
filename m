Return-Path: <netfilter-devel+bounces-11265-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIb9HA6YumnSXgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11265-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 13:18:22 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3F2BB54A
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56C0A300ACB2
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9C39B975;
	Wed, 18 Mar 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lbnBDFQ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zfr97DWD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lbnBDFQ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zfr97DWD"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB4373C0E
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836298; cv=none; b=EZGxU5fdECEixivE/OPR3RRLjDcHIBleL6I4Tub9rpxOSVzBzuBZa5AmFaM0TXdYCX7UUUfwNusRUDWq51VxuU772rdljrrTiyFziK1ycQIy+2vuUMKwraqsJ7R/8I10wYLtzS1iuwmj3kexM6Hyk6yUeYQj6icN8qm1mAmUvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836298; c=relaxed/simple;
	bh=qFYVODBgW076nTnIyiRhEbso0ehT3TAq5qtnSxchToU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eR11e8UB8sR9KyKj9yJN1RFpSnSGKQHzgL6CWnVhVHbMSQdU8LD/ze28HTJo7ObeU1wj+iayf4Whr5v2Rri/TxPPtRmo26fOgSvW77mDnEmDxWbHqzJx0UOoNWLLjw8JhMwU0uGUfoHShvprUK6xo4zsAQ+7nu0hAjPhFjdldIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lbnBDFQ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zfr97DWD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lbnBDFQ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zfr97DWD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25A894D3BE;
	Wed, 18 Mar 2026 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773836296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjzkAdsKqyzy2RAr0gJdbGGCQ8XMcqsw6IHKwaChdb0=;
	b=lbnBDFQ+UHtTDIzbiQKZ4oJsi5xPAkTzUe8jDJqd9okj9JYMwR+tSjp5PCures4HsKTOeO
	8VP4ZUubh5UGqzGv16G/V3P9sdcpuEyjVRuoOnarL4THgXjuPOH3fDBH/6s5lMfOXV4HP6
	wvYc2pxMzEffZIzuShN8FAgbnde9JD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773836296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjzkAdsKqyzy2RAr0gJdbGGCQ8XMcqsw6IHKwaChdb0=;
	b=zfr97DWD5x8Vp55IKc+gJpmXm+dlGkG7RF9/8R5AF+uuJwvr9dWbJrVGhQAUrNnfAFmhVV
	6cDSojStNEJGQfDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773836296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjzkAdsKqyzy2RAr0gJdbGGCQ8XMcqsw6IHKwaChdb0=;
	b=lbnBDFQ+UHtTDIzbiQKZ4oJsi5xPAkTzUe8jDJqd9okj9JYMwR+tSjp5PCures4HsKTOeO
	8VP4ZUubh5UGqzGv16G/V3P9sdcpuEyjVRuoOnarL4THgXjuPOH3fDBH/6s5lMfOXV4HP6
	wvYc2pxMzEffZIzuShN8FAgbnde9JD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773836296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjzkAdsKqyzy2RAr0gJdbGGCQ8XMcqsw6IHKwaChdb0=;
	b=zfr97DWD5x8Vp55IKc+gJpmXm+dlGkG7RF9/8R5AF+uuJwvr9dWbJrVGhQAUrNnfAFmhVV
	6cDSojStNEJGQfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D0F54273B;
	Wed, 18 Mar 2026 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IuvTBweYumkLVwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 18 Mar 2026 12:18:15 +0000
Message-ID: <1e6a2a0e-db8d-4618-b253-cc07d576fe85@suse.de>
Date: Wed, 18 Mar 2026 13:18:14 +0100
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10 net-next v3] netfilter: remove nf_ipv6_ops and use
 direct function calls
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-11-fmancera@suse.de> <20260317201704.GB3581148@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260317201704.GB3581148@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11265-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16D3F2BB54A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 9:17 PM, Ido Schimmel wrote:
> On Tue, Mar 17, 2026 at 03:01:06PM +0100, Fernando Fernandez Mancera wrote:
>> -#if IS_MODULE(CONFIG_IPV6)
>> -#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
>> -#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
>> -#else
>>   #define EXPORT_IPV6_MOD(X)
>>   #define EXPORT_IPV6_MOD_GPL(X)
>> -#endif
> 
> We have quite a lot of these throughout the kernel, remove them?

Yes it should go away. It probably deserves its own patch. Thanks for 
pointing it out!

