Return-Path: <netfilter-devel+bounces-12335-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHJfN1Jt82lf2gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12335-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 16:55:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D54A44BA
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D671303CD24
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CBB42EEDB;
	Thu, 30 Apr 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DITLSG1F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R8YnYohC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DITLSG1F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R8YnYohC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2842EEDA
	for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560821; cv=none; b=VTf7Uz6mRbB5/xjFW3ERoY3o2K5Y9JZD7/+gWNeLHMv5DWKoGlDbHnLoHUl5mIUATB3a32bFGPk7A5UUDePPe2n0i3PusUUDMPPaczYMmRexbyzqyoAxLl+I3DSHZ1RaCpkH6x/FYvDRSBk/uNeRGAXThfe5JierS5hscvtUw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560821; c=relaxed/simple;
	bh=optO/4WNWofybBUndxss/0pHmpbbRU29lY9ufcCn4z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tla3CKDmCbQPnnV0ZcIno7ajTJcuvJ4D18WAcePRcE7y+pZTvqNuMd1jwq+vZS94HLgPWPCLU6jVS3xJ3DqAJBajbMCwFlxqo3SC3LCP3eOoS63BCrLexDgDRNFVUpYwPCUImE9iLQ5s9fZLUHBxBs2y5BYOuekUzZSRZYwG67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DITLSG1F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R8YnYohC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DITLSG1F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R8YnYohC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FC556A860;
	Thu, 30 Apr 2026 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777560818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3F/hRrLN6zM1gP6TFn8UX+XZdXCzHTsRnkYHGFhdvY=;
	b=DITLSG1F4sRDj0SkNX1ULlowcb2UDsWdHatru1tC3e4rj9P3j5iKzEK0prURnDkuxYlooj
	hvFVjNuuzeGqIFQE4tfxVW31VTRk2xBnrW3g1kKj4xhxB1jR44XllvqjD2mp33d7WuAON0
	qL61hAiDqEMoQ0X062mfBOxM6aOwzhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777560818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3F/hRrLN6zM1gP6TFn8UX+XZdXCzHTsRnkYHGFhdvY=;
	b=R8YnYohCdtBHrKBHAm4DFTO3UJ/3hEllVs9nOlfAlTDCqy+c6BvyjJbIR2B4gm64XKFLNs
	BjeX9tkmVpeOHUCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DITLSG1F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R8YnYohC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777560818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3F/hRrLN6zM1gP6TFn8UX+XZdXCzHTsRnkYHGFhdvY=;
	b=DITLSG1F4sRDj0SkNX1ULlowcb2UDsWdHatru1tC3e4rj9P3j5iKzEK0prURnDkuxYlooj
	hvFVjNuuzeGqIFQE4tfxVW31VTRk2xBnrW3g1kKj4xhxB1jR44XllvqjD2mp33d7WuAON0
	qL61hAiDqEMoQ0X062mfBOxM6aOwzhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777560818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3F/hRrLN6zM1gP6TFn8UX+XZdXCzHTsRnkYHGFhdvY=;
	b=R8YnYohCdtBHrKBHAm4DFTO3UJ/3hEllVs9nOlfAlTDCqy+c6BvyjJbIR2B4gm64XKFLNs
	BjeX9tkmVpeOHUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53C05593B0;
	Thu, 30 Apr 2026 14:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Et+KEfJs82kjDAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 30 Apr 2026 14:53:38 +0000
Message-ID: <236f1674-6ed2-4822-b313-3835c5895af7@suse.de>
Date: Thu, 30 Apr 2026 16:53:14 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 nf v5] netfilter: xtables: fix L4 header parsing for
 non-first fragments
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
 fw@strlen.de
References: <20260428102548.6750-1-fmancera@suse.de>
 <20260428102548.6750-3-fmancera@suse.de> <afLx347nrAJLqsyf@chamomile>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <afLx347nrAJLqsyf@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 689D54A44BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-12335-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/30/26 8:08 AM, Pablo Neira Ayuso wrote:
> Hi Fernando,
> 
> On Tue, Apr 28, 2026 at 12:25:48PM +0200, Fernando Fernandez Mancera wrote:
>> Multiple targets and matches relies on L4 header to operate. For
>> fragmented packets, every fragment carries the transport protocol
>> identifier, but only the first fragment contains the L4 header.
>>
>> As the 'raw' table can be configured to run at priority -450 (before
>> defragmentation at -400), the target/match can be reached before
>> reassembly. In this case, non-first fragments have their payload
>> incorrectly parsed as a TCP/UDP header. This would be of course a
>> misconfiguration scenario. In most of the cases this just lead to a
>> unreliable behavior for fragmented traffic.
>>
>> Add a fragment check to ensure target/match only evaluates unfragmented
>> packets or the first fragment in the stream.
> 
> One more little issue here: There seems to be an issue in
> xt_hashlimit, hashlimit_init_dst() drops packets via hotdrop if it
> returns -1.

Hi Pablo, I do not follow here. I think a hotdrop is the right thing to do.

xt_hashlimit creates the hash and later checks whether we are over the 
limit or not. The verdict is set based on that and the INVERT flag.. I 
don't think we should match or not match packets that we cannot parse 
correctly, we should just drop them.

This is the current behavior for example when protoff < 0 (because no L4 
header is found).

What do you think?

Thanks,
Fernando.

