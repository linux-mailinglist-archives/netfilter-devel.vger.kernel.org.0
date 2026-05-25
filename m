Return-Path: <netfilter-devel+bounces-12829-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD8vHsCcFGqpOwcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12829-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 21:02:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3385CDE12
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 901EC300441D
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151035E1DC;
	Mon, 25 May 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="stcZ9OE9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBtw5T33";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="stcZ9OE9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBtw5T33"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD130B53A
	for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735738; cv=none; b=gcllwUZ20gFRug0hr0oYtyjF5eCKPp7Jt4k6jjrBCXuyLfUyTooidU2b5q5P2w49If9pZF9dPhSyU+Lc95LN+zXn4P5kLRq/7zyishoJaXuIrRkOcHWc4zbJx4WRIQfl+4TY2Rm1REZC3+Y3JI1BfRe1o3RgZ9ykBHlMrsefKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735738; c=relaxed/simple;
	bh=Gb46aWttevn6e6IZVdQAPk4ayAXwYDo+jz6aMFzbZ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgO0SyvwoNrEvZjYdo42iqPsYB+pufLDvDhaKEo1s0wr22G9qCTzuk7N/cuqE9UprSJzq+GDccD6dG5vFmVQ7NqTP9OhnIfVzoonQuixr5RxvzEjIJzBisRhIGVyBMdUaROgb4kukMsN6xAZiKrjnvm6YwKTqEbR8oyY9k1eAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=stcZ9OE9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBtw5T33; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=stcZ9OE9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBtw5T33; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8D6B6AAB4;
	Mon, 25 May 2026 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779735729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLj545McEOp3h+Xyeq43udc0sYee4CuxBX3Ksviq9Rk=;
	b=stcZ9OE9x5YRo2uJ1WPchfVnwdU9Yl8F4hW2b8RQiaP5TWh3AuQT6dm2p07XerSbKYOcTD
	illHyh6DK1WHe4ii4dPxsPAOkMqktjY7/JfkX0NqrmIYG8XN/yIP/CuAIHyDKDUJENi6Gz
	ujR3EOHepjOyNqKOPUi5c6yTyg/FyIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779735729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLj545McEOp3h+Xyeq43udc0sYee4CuxBX3Ksviq9Rk=;
	b=WBtw5T33QoqU/bjjdewfr+NOT+vT+Ve5Uxl3+0ywtMj9ygTfg8lIC/P27kLvPTVX87B0mj
	5TQsnkI+z43/WtBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779735729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLj545McEOp3h+Xyeq43udc0sYee4CuxBX3Ksviq9Rk=;
	b=stcZ9OE9x5YRo2uJ1WPchfVnwdU9Yl8F4hW2b8RQiaP5TWh3AuQT6dm2p07XerSbKYOcTD
	illHyh6DK1WHe4ii4dPxsPAOkMqktjY7/JfkX0NqrmIYG8XN/yIP/CuAIHyDKDUJENi6Gz
	ujR3EOHepjOyNqKOPUi5c6yTyg/FyIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779735729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLj545McEOp3h+Xyeq43udc0sYee4CuxBX3Ksviq9Rk=;
	b=WBtw5T33QoqU/bjjdewfr+NOT+vT+Ve5Uxl3+0ywtMj9ygTfg8lIC/P27kLvPTVX87B0mj
	5TQsnkI+z43/WtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7781A59DC9;
	Mon, 25 May 2026 19:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2DXWGbGcFGrtPgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 25 May 2026 19:02:09 +0000
Message-ID: <457eaeef-30c0-4d9f-a144-079fca9f6a7d@suse.de>
Date: Mon, 25 May 2026 21:02:08 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 nf v2] netfilter: synproxy: fix possible write to
 stale pointer
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 pablo@netfilter.org, phil@nwl.cc
References: <20260525124450.6043-1-fmancera@suse.de>
 <20260525124450.6043-5-fmancera@suse.de>
 <df64cebb-1279-4e66-afa7-3d8ffca4928f@suse.de> <ahSb-UU8n9o1aHoI@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ahSb-UU8n9o1aHoI@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-12829-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 7C3385CDE12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 8:59 PM, Florian Westphal wrote:
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>> On 5/25/26 2:44 PM, Fernando Fernandez Mancera wrote:
>>> skb_ensure_writable() is called to guarantee that the TCP options area
>>> can be safely modified when adjusting the timestamp. As it expands or
>>> linearize the skb head it might reallocate the data buffer.
>>>
>>> This makes the th pointer passed by the caller stale. The following
>>> writes to the TCP header might be done to a stale pointer.
>>>
>>> Recalculating the th pointer after skb_ensure_writable() prevents this
>>> issue from happening.
>>>
>>> Fixes: 48b1de4c110a ("netfilter: add SYNPROXY core/target")
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>
>> LOL. I just realized I already reviewed this at:
>>
>> https://lore.kernel.org/netfilter-devel/20260522104257.2008-3-fw@strlen.de/T/#u
>>
>> *facepalm* sorry for the noise, Florian could you ignore this patch but
>> consider the other 3 fixes?
> 
> I know its tiresome, but would you mind sending a new version that also
> fixes up the other things pointed out by sashiko?
> 
> https://sashiko.dev/#/patchset/20260525124450.6043-1-fmancera%40suse.de

Ohno, more stuff. Sure I will look into it.

> 
> In particular, seqadj and concurrent registration.  As these bugs aren't
> as severe as patch 4, I think nf-next would be fine as well.
> 

Great, yes, that was my original idea.. routing a v3 for nf-next.

Thanks Florian!

