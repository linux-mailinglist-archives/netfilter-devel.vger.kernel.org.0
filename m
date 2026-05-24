Return-Path: <netfilter-devel+bounces-12798-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC50DvpHE2qg9wYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12798-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 20:48:26 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D55C3715
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A1D3007E30
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E92F7F0B;
	Sun, 24 May 2026 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kyf1n0s8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HLgiCSJ2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kyf1n0s8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HLgiCSJ2"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E9233939
	for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2026 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779648503; cv=none; b=dk7WiBOEL7LG98z1vtK/Tf6Y5EVkH6Jbp2ivKI2o4VA1PtQBr5sQFHQSN21iuG5QGDk3NT08ttze9rklj+CVr/3y7mk+4Jt6UaisnXS//wmWH906W5mMFT8XrFVfkCg1ll0o92yCXkyRC/dfJvOLVKBYizTMDb0JmyOYvPTQgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779648503; c=relaxed/simple;
	bh=843HfV77S4fFshr9H4dTjQ0qENWjewYdzcTjD++RdZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4Fw8dD9wOZ1bfvx4H7Gda3nJonKyKDgdS+YqSbQEAaTGk2iDaA2QAwaQy6zK5heE4MnIyjopVXx1+WL9aP1UegCOI0A8xQDKNLNqCWnsOfdsM+sRqKBN+vcJjX3SZ1Bxq9nxQJpUyop6+eD7E35KnDDAdZWDU36Nc97YVe9rpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kyf1n0s8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HLgiCSJ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kyf1n0s8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HLgiCSJ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB2A366D9C;
	Sun, 24 May 2026 18:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779648499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jipFbt7ethnjj9GS00ajOmxxkGnKGtsJcuZE1/JWqdc=;
	b=Kyf1n0s8qMZE51XCLMoZ3lsJSHbBM5po+vxNRloQqiKoQ8UcjL2HBLiUJ6TjtXkKelHu+d
	3twX5tI+NUvAL3jhF6+3Ambd5tLsDBYyycNRcuHF/fb/CRdsXhZ2TS9GrcY7+H+2m6vY5h
	JHF2/H3JkdtmAsKp5auZ7/SGlE9hYko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779648499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jipFbt7ethnjj9GS00ajOmxxkGnKGtsJcuZE1/JWqdc=;
	b=HLgiCSJ2eYs6vk0CwWyKL2xrD6dqsudZlrJLdKKFvQsb8hH9f/zcgaCUWB9Ow+aN/NaQqX
	tu41aLxW63E5syCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779648499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jipFbt7ethnjj9GS00ajOmxxkGnKGtsJcuZE1/JWqdc=;
	b=Kyf1n0s8qMZE51XCLMoZ3lsJSHbBM5po+vxNRloQqiKoQ8UcjL2HBLiUJ6TjtXkKelHu+d
	3twX5tI+NUvAL3jhF6+3Ambd5tLsDBYyycNRcuHF/fb/CRdsXhZ2TS9GrcY7+H+2m6vY5h
	JHF2/H3JkdtmAsKp5auZ7/SGlE9hYko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779648499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jipFbt7ethnjj9GS00ajOmxxkGnKGtsJcuZE1/JWqdc=;
	b=HLgiCSJ2eYs6vk0CwWyKL2xrD6dqsudZlrJLdKKFvQsb8hH9f/zcgaCUWB9Ow+aN/NaQqX
	tu41aLxW63E5syCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 840015981C;
	Sun, 24 May 2026 18:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDujHPNHE2ppUgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 24 May 2026 18:48:19 +0000
Message-ID: <3178bbf8-552a-45cf-819f-bf3ec2de41e0@suse.de>
Date: Sun, 24 May 2026 20:48:18 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 nf-next] netfilter: synproxy: timestamp adjustment
 fixes
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 pablo@netfilter.org, phil@nwl.cc
References: <20260523194743.5888-2-fmancera@suse.de>
 <7dcb73cb-11ab-4c9d-89bd-7418bdc86fdb@suse.de> <ahMyVJYynOoa32U5@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ahMyVJYynOoa32U5@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-12798-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 758D55C3715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/24/26 7:16 PM, Florian Westphal wrote:
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>> What do you all think? nf or nf-next for the 4 commits? I tried to reproduce
>> an UAF but couldn't trigger it. Although, I was able to write to the stale
>> pointer using tc mirred..
> 
> nf.  But I'm not sold on this series: dropping patckets outside
> of rulesets should be a last resort.

Hm. That might be an appealing argument for the dup timestamp option, if 
we want to be more relaxed we can just adjust all timestamp options 
equally (we need to assume that this is a corner case of course).

But when failing skb_ensure_writable() or when encountering completely 
malformed options I believe we should drop the packet. Because either we 
didn't adjust the timestamp properly or the options are just malformed 
and in any of these cases the packet should reach the backend..

Thanks Florian!



