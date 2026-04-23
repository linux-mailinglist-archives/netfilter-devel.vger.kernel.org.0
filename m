Return-Path: <netfilter-devel+bounces-12149-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCwcI3LT6WmmlAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12149-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 10:08:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045DB44E575
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0918306C973
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC1363096;
	Thu, 23 Apr 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoadnRKk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KpEpZpYr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="spGm+MrF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qxQgqvCA"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F9364024
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2026 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931642; cv=none; b=Eo+9sh2mmXZxFrN6/GciH3bu2XaboIRYRlCeXGNfYTiD3Tbe1ze/Wxx8yRzVUWnFqa5LmZyUzLxGl9A49z6y32N8onEvhA9z574OK06zex3mrlTBXti523tqiU8riWIq8XMmm+Mw2hn12YzIIEbFNIg3qDrJ6WOB69hJWesLCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931642; c=relaxed/simple;
	bh=GC920YgwM4gDPrYX5Nr8pS6beuLQI8MQBk4Xa1QD29A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk6OMtczjBTZI562Tx9FLOt92kxgGsRKfFkNU8hSXQkb57CMYjlNuWDfbRlDTpP/1azS5dt/Kf7HoZq58F9etpLJes1JxUaOQnEDiJK9szy7Iz5upYU6dIetAItU5WTgQxDd9IMfAqiAQG6N0ewk2EHpPF9RbpnpvQsqZD1XRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoadnRKk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KpEpZpYr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=spGm+MrF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qxQgqvCA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E8EE5BCFD;
	Thu, 23 Apr 2026 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776931639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3DWCrE7/tEab+2mucdJsTZQUB4Efb2SB+1uaReKlwU=;
	b=HoadnRKknk7Rx3/cdMUHyhNyBpYuT1Vl6sRyisl+kq2QAzYVqLoTZzNyBy5MZ8G+7xT2Y3
	5Mp6xJLeKCoO5xVxIryS97TOAhxJRwtkoNfAEhzZjHtbMopfC76DnrtdC+hELt39X3tGYD
	S85o5HOII5iCCneSH4fusG+NZaI60ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776931639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3DWCrE7/tEab+2mucdJsTZQUB4Efb2SB+1uaReKlwU=;
	b=KpEpZpYraOZ4MrXefhI3eOvTGtHHxyN4Cn1hL/IHMmL3hkATK4NLy1YMeD3yEr71kYj0LU
	x5h9TfKge3VJc6Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776931638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3DWCrE7/tEab+2mucdJsTZQUB4Efb2SB+1uaReKlwU=;
	b=spGm+MrFuvj0S0mwy02bjcCoMWMoaUkmkHj9wKUPUudx74MK5qncqjfRaL/kB95m2gxfwL
	lxXJwWaKfHoQt3hwvycMFOLM8hl+ujd/uNUQUn8zBu4HzHzBFb94D6/AKjmuDXYuVki00v
	O/pYA0iZlz18n/ydSqKK6CgYG+tur80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776931638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3DWCrE7/tEab+2mucdJsTZQUB4Efb2SB+1uaReKlwU=;
	b=qxQgqvCA8jSeqBELkVKkFMwZLQrNJfy0ECb23/GAtLjc0t4tP1MoX+a1Myv/SOAQx52ebC
	PLOv9IuM4VXavkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDAF6593A3;
	Thu, 23 Apr 2026 08:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8CFvLzXT6WlzXAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 23 Apr 2026 08:07:17 +0000
Message-ID: <00d155a5-76f9-4011-90dd-e5ec94918740@suse.de>
Date: Thu, 23 Apr 2026 10:07:03 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: nft_bitwise: fix dst corruption in same
 register shifts
To: Jeremy Sowden <jeremy@azazel.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
 fw@strlen.de, pablo@netfilter.org
References: <20260421173851.7945-2-fmancera@suse.de>
 <20260421194951.GA1976704@celephais.dreamlands>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260421194951.GA1976704@celephais.dreamlands>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-12149-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 045DB44E575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 9:49 PM, Jeremy Sowden wrote:
> On 2026-04-21, at 19:38:52 +0200, Fernando Fernandez Mancera wrote:
>> For lshift and rshift, the shift operations are performed in a loop over
>> 32-bit words. The loop calculates the shifted value and write it to dst,
>> and then immediately reads from src to calculate the carry for the next
>> iteration. Because src and dst could point to the same memory location,
>> the carry is incorrectly calculated using the newly modified dst value
>> instead of the original src value.
>>
>> Adding a temporal local variable to cache the original value before
>             ^^^^^^^^
> 
> "Temporary"?
> 
>> writing to dst and using it for the carry calculation solves the
>> problem. This was tested with the following payload:
>>
>> table test_table ip flags 0 use 1 handle 1
>> ip test_table test_chain use 3 type filter hook input prio 0 policy 
>> accept packets 0 bytes 0 flags 1
>> ip test_table test_chain 2
>>   [ immediate reg 1 0x44332211 0x88776655 ]
>>   [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
>>   [ cmp eq reg 1 0x66443322 0x00887766 ]
>>   [ counter pkts 0 bytes 0 ]
>> ip test_table test_chain 4 3
>>   [ immediate reg 1 0x44332211 0x88776655 ]
>>   [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
>>   [ cmp eq reg 1 0x55443322 0x00887766 ]
>>   [ counter pkts 21794 bytes 1917798 ]
>>
>> Fixes: 567d746b55bc ("netfilter: bitwise: add support for shifts.")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> Acked-By: Jeremy Sowden <jeremy@azazel.net>
> 
Thanks, I am preparing a v2 as sashiko spotted another problem and I 
have verified it is real. See:

"""
  Does this leave the corruption issue unfixed for partial register 
overlaps? If userspace provides overlapping registers where dreg is less 
than sreg, such as dreg=1 and sreg=2 with a len of 8, dst[1] aliases to 
src[0].

In the first iteration, this operation writes to dst[1]. In the second
iteration, it reads from src[0], which would now contain the newly
overwritten value instead of the original source data.
"""

I am testing the new fix.

>> ---
>> Note: I found this issue while digging into the lshift/rshift operation
>> ---
>>  net/netfilter/nft_bitwise.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
>> index 13808e9cd999..136e8f3a71c5 100644
>> --- a/net/netfilter/nft_bitwise.c
>> +++ b/net/netfilter/nft_bitwise.c
>> @@ -43,8 +43,10 @@ static void nft_bitwise_eval_lshift(u32 *dst, const 
>> u32 *src,
>>      u32 carry = 0;
>>
>>      for (i = DIV_ROUND_UP(priv->len, sizeof(u32)); i > 0; i--) {
>> -        dst[i - 1] = (src[i - 1] << shift) | carry;
>> -        carry = src[i - 1] >> (BITS_PER_TYPE(u32) - shift);
>> +        u32 tmp_src = src[i - 1];
>> +
>> +        dst[i - 1] = (tmp_src << shift) | carry;
>> +        carry = tmp_src >> (BITS_PER_TYPE(u32) - shift);
>>      }
>>  }
>>
>> @@ -56,8 +58,10 @@ static void nft_bitwise_eval_rshift(u32 *dst, const 
>> u32 *src,
>>      u32 carry = 0;
>>
>>      for (i = 0; i < DIV_ROUND_UP(priv->len, sizeof(u32)); i++) {
>> -        dst[i] = carry | (src[i] >> shift);
>> -        carry = src[i] << (BITS_PER_TYPE(u32) - shift);
>> +        u32 tmp_src = src[i];
>> +
>> +        dst[i] = carry | (tmp_src >> shift);
>> +        carry = tmp_src << (BITS_PER_TYPE(u32) - shift);
>>      }
>>  }
>>
>> -- 
>> 2.53.0
>>


