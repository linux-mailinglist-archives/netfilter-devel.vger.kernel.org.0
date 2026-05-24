Return-Path: <netfilter-devel+bounces-12796-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INkPC2cuE2oo8wYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12796-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 18:59:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA135C33B7
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5575F300290F
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBF3ADBA2;
	Sun, 24 May 2026 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9Szfnqp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFyX9X78";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pWVCb10N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="onLj8tKV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752503AE188
	for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779641936; cv=none; b=uyj3UB42l8bACdmBBy09brPIHnmS0Wv6vFHYm9CZrDDxaZg6Ugj1PXJ8DFbpdLvtn4J102m96iQKb6Wq0xdasJmTeyKy0socCcaBMvYYWmS+IAz7APID83xiZuQcfqOjNbOsFEtYUVXbWVQu+seDQbuVqPdE9KRdnkpJYHVytiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779641936; c=relaxed/simple;
	bh=tugzs8YELjee2wyM7wqF+fvVlop0B7VunixnPI4df10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvFEzOc388QE8Q1lSje+K05hAkVUJBjuw8czwHSiEnitkgN1eDqaqjjtv2tEnRe5WEtgTkydEhKJQUvJ0Cg0+X2IyAgNTIf6rHZ/3M4jYv83i8r1XhszhjzFy65w/kpbJAQqaUfmpFisIt/eyc9CRlNa8pAA87YT1U8rsKdFZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9Szfnqp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFyX9X78; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pWVCb10N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=onLj8tKV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 151686A923;
	Sun, 24 May 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779641927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpUh+AEP+pdf4Sz4dP6K33csxQQuYvardJ/YVWxzsoc=;
	b=l9Szfnqp3GVry3fOEhLG6NBJYIiLHBWw1ruoi6QGctHw85O3kIXh+pKps0PW3S/dc0Z525
	aodxfNDz9Iq6Y6vyaJCEn8NqTYS7u4FtTdxFjFOupg3Ic9dCUaJWaWOxlW/jrOjvS+PHH4
	FvMPGk8ZgWI8vtemqFzxyfH5r0G6DP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779641927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpUh+AEP+pdf4Sz4dP6K33csxQQuYvardJ/YVWxzsoc=;
	b=GFyX9X78VFvfwg1CJzCOYvkiVN6mwhP95/dwNFj6dXAgNDYbUWa7QjXMsPc4b8wePRJumW
	SLpVgTIZCoQRWmBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779641926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpUh+AEP+pdf4Sz4dP6K33csxQQuYvardJ/YVWxzsoc=;
	b=pWVCb10N7NXdYktnEV+wIOcnm87Jzxn86vN+iijbMhJE1T5Dh32oViTKKx+kdRdQiPufHT
	STqwKWzvTVqjTfUpBHdCCuwLptNmqX8sMgfOjVE7tWtQg1P3gK4iVpm/0LCxDtLBbmzmqi
	b9tWO2OS+jE8x8m/rDT09wo6oekcc7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779641926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpUh+AEP+pdf4Sz4dP6K33csxQQuYvardJ/YVWxzsoc=;
	b=onLj8tKVYiyMUVWvveSi+YsCKUWuswkmyNbjsnmT1B4nekVgW4rRbyBHLQf18Cgk/m6Jj/
	2hAdXWS/5Zii6VCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E35597AF;
	Sun, 24 May 2026 16:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P726KEUuE2oSbQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 24 May 2026 16:58:45 +0000
Message-ID: <7dcb73cb-11ab-4c9d-89bd-7418bdc86fdb@suse.de>
Date: Sun, 24 May 2026 18:58:38 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 nf-next] netfilter: synproxy: timestamp adjustment
 fixes
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org, pablo@netfilter.org, fw@strlen.de, phil@nwl.cc
References: <20260523194743.5888-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260523194743.5888-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12796-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:mid,suse.de:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: 2FA135C33B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/23/26 9:47 PM, Fernando Fernandez Mancera wrote:
> This series fixes several long standing issues during synproxy timestamp
> adjustment. From ignored error handling to unaligned memory access. Most
> of this are not issues impacting real setups as they would have been
> reported before.
> 
> I targeted nf-next tree as they are fixes for correctness.
> 

FWIW; I am sending a v2 but I am not sure if it should go to nf tree as 
it will include a fix to a UAF spotted in the same code so I guess it 
makes sense to merge it together.

See:

https://sashiko.dev/#/patchset/20260523194743.5888-2-fmancera%40suse.de

What do you all think? nf or nf-next for the 4 commits? I tried to 
reproduce an UAF but couldn't trigger it. Although, I was able to write 
to the stale pointer using tc mirred..

Thanks,
Fernando.

> Fernando Fernandez Mancera (3):
>    netfilter: synproxy: drop packets if timestamp adjustment fails
>    netfilter: synproxy: drop packets with duplicated timestamp options
>    netfilter: synproxy: fix unaligned memory access in timestamp
>      adjustment
> 
>   net/netfilter/nf_synproxy_core.c | 47 +++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 


