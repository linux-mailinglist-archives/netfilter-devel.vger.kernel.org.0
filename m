Return-Path: <netfilter-devel+bounces-12578-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNwOAHObBGr3LwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12578-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 17:40:35 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166F53651A
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32D1330EF02E
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015038CFF6;
	Wed, 13 May 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hRK4wTQq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oB2ay75Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hRK4wTQq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oB2ay75Q"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699642253FC
	for <netfilter-devel@vger.kernel.org>; Wed, 13 May 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683981; cv=none; b=FaSSxEmnV8qrE1EXZP9qxMUOUKPPYFaliKNENooTYQi5dqF8s2gXhPnfxot17AXyg0DI/eNN3oPlbpS1lgKvCmjc38rn8SxpMU7bBD5fA115favEecCZI2zOiVremkVqKEHJmCBTX3qUKB97bKgXXL/cIlQaTcMKJGY8PJzCs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683981; c=relaxed/simple;
	bh=yh7W8TPukbs7vQi2iQ7hChVx93uR2ur64qyuy+rAA20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2OyO9nl3FwWRBbcYwupjgiV+OWfnsSN/mAxZ7/Y29b055cmGBIf1etpnHYiF4Ky7KqBUyuLMSnCtkCtpwGE0EAiuXyRi727FnFdh/eBhblsBFZepAO6HZLyxRHIE/cgtiwd/OkIFfdoDzeizocBQ+r5lCniKvGrQAWAZ1Li6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hRK4wTQq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oB2ay75Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hRK4wTQq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oB2ay75Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CC036270B;
	Wed, 13 May 2026 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778683978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5zMZR7SuI7oFBK4PHgX4+47NnJp7FOdesE/JOzeUHg=;
	b=hRK4wTQqlfMgqzafZQKlMcGndEKu5XCIGbXi0fOAix77IqbB6R3uk5ZbMoLAb3o48yx9e5
	bDWqNkPFQPvCx1IJUqXMM8OHvuZxYvxZmsXP21Esxu7QjXTV57+oPk9itVoVkNfJexORaF
	idAgx9LQaRwPT0FBek9jZoUO7Bd1Nko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778683978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5zMZR7SuI7oFBK4PHgX4+47NnJp7FOdesE/JOzeUHg=;
	b=oB2ay75QHJY3yCLokvEPfs+TTP8Srk9ujahfLo0zl7IHlwnfPf25ct5/GA26LFIwkSv2zS
	xs32V7EtN5PZcLDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778683978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5zMZR7SuI7oFBK4PHgX4+47NnJp7FOdesE/JOzeUHg=;
	b=hRK4wTQqlfMgqzafZQKlMcGndEKu5XCIGbXi0fOAix77IqbB6R3uk5ZbMoLAb3o48yx9e5
	bDWqNkPFQPvCx1IJUqXMM8OHvuZxYvxZmsXP21Esxu7QjXTV57+oPk9itVoVkNfJexORaF
	idAgx9LQaRwPT0FBek9jZoUO7Bd1Nko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778683978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5zMZR7SuI7oFBK4PHgX4+47NnJp7FOdesE/JOzeUHg=;
	b=oB2ay75QHJY3yCLokvEPfs+TTP8Srk9ujahfLo0zl7IHlwnfPf25ct5/GA26LFIwkSv2zS
	xs32V7EtN5PZcLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46009593A9;
	Wed, 13 May 2026 14:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7klJDkqQBGrQNAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 13 May 2026 14:52:58 +0000
Message-ID: <7ed7e852-79e2-44ac-9705-32a1258ca7ae@suse.de>
Date: Wed, 13 May 2026 16:52:47 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: nf_conncount: prevent connlimit drops for
 early confirmed ct
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
 pablo@netfilter.org,
 Alejandro Olivan Alvarez <alejandro.olivan.alvarez@gmail.com>
References: <20260513121547.6434-1-fmancera@suse.de>
 <agRygM7hHtKs8jQB@strlen.de> <7fbd428e-93b7-4e17-8360-5434f0d1f6bc@suse.de>
 <agSHD2ZVclEeKSJC@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <agSHD2ZVclEeKSJC@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Rspamd-Queue-Id: 5166F53651A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,gmail.com];
	TAGGED_FROM(0.00)[bounces-12578-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 4:13 PM, Florian Westphal wrote:
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>> About IP_CT_ESTABLISHED, I added it because it was not clear to me that
>> IPS_ASSURED_BIT is always set. I guess yes for TCP/UDP but what about
>> other protocols? (Are we supporting other protocols???) Anyway, I have
>> tested it and confirmed that for TCP/UDP it is safe to drop it.
> 
> SCTP is the only other relevant one for this use-case, I think.
> 

Then we can drop it, thanks Florian.

>> And please note that the idea is to be cautious when returning --EXIST.
>> If IPS_ASSURED_BIT is set we can for sure skip the tracking BUT if not,
>> we run a GC skipping the skip optimization..
> 
> 6 months from now I will no longer know wtf this assured check is
> doing.  Please consider rewriting the existing comments so that this
> makes some sense.
> 

Fair point, let me add some comments around it.

>> Is it that bad? I mean, it has some back and forth and I apologize for
>> that but overall this is fixing some real use cases.
> 
> I know, this isn't your fault. Conncount is used in all kinds of cases
> that it wasn't designed for and thus we have this esoteric breakage in
> first place.
> 
> No way we can avoid it.  I think your patch is the best we can do here.
> 


