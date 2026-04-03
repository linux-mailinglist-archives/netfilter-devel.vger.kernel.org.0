Return-Path: <netfilter-devel+bounces-11623-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAoiGPtT0Gmx6QYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11623-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Apr 2026 01:57:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AB39926C
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Apr 2026 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42E44301DCCA
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Apr 2026 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47A34E779;
	Fri,  3 Apr 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DWm/WCfm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LyBrtKT4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IbilKQbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKyYdxO6"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126751DC198
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Apr 2026 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775260664; cv=none; b=qDM3hy8JeA9xOPDHUyhxJ5zLPgKHT+OYMxxVJW+TF0KNmelGPLx+6CZHpXgyXDwKeCPw2vw4ijwDUVqZDU9UmEHvcbSDiY4GgqkDh7zju8AKRdFYc/rE1kHHLJpDWv2gHzKJ842ru7PHhj1NTQ/RRm1uZv0vFrWOJJiAHdg+E/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775260664; c=relaxed/simple;
	bh=hQZRt6WSgad+U+Pssq0KM4l6zxY4hq+Y/zwvXhp1K4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9NbHZVNjfOU1WFYzxTubU+fJ3KvIlZeLIv0PAK4bc6WPVRd4YbMxDxEjzj/Qil4wZsRfTccLbn6njJIr2gOxFF15GuS86VsiCPUM+asie8P5WI5r+SdQcrqDBYhl8bAn64bYgL/KSkE1gVZu7CWjnA1R0YEx2b4I2+08CaxRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DWm/WCfm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LyBrtKT4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IbilKQbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qKyYdxO6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 892965BD23;
	Fri,  3 Apr 2026 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775260660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnoRqdUzNz0azZfM3b8bxze0ANQ+k8KxBHbyif5QGc4=;
	b=DWm/WCfmU2Sl0a8JBoazZ32/EkmZLi1k7GUPtfr2jyK1baB6K6l4xzzm5MUW+ZHuAG3isA
	wr6VwyJpPTfwSHXJdSbCGGy1UsoUl898nYhGXI54SPJMAWHBHl429KnWjE9MspgkSjuQvm
	iWd0O8OTb4h0x5On48iP7rF1OaaAIRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775260660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnoRqdUzNz0azZfM3b8bxze0ANQ+k8KxBHbyif5QGc4=;
	b=LyBrtKT4Vejik99h7ClA0vh6Livh2N5zDtUP4IrVKLzWbQ0Nghd4AyvKT73kP/sS+kwKcL
	v8UkavyTYSIVQ+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IbilKQbk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qKyYdxO6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775260659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnoRqdUzNz0azZfM3b8bxze0ANQ+k8KxBHbyif5QGc4=;
	b=IbilKQbkSlGLC5Tv4w909FE7+Ih/LS9E3edJR7kPmHPCwyLAQirUXGXFUrQWydzWKKsLig
	PPxsOD/CJRcFf8hXLGIwDdNf8TGRznVJfZCrbvEMUR5y9DELKiOLKKmeH/jh8b0YfrrUJm
	0unzGmM93wbaeaAQThrkYIRDOh2+BdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775260659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnoRqdUzNz0azZfM3b8bxze0ANQ+k8KxBHbyif5QGc4=;
	b=qKyYdxO6Ej7NYxrF06rEDNc0N5AF8k/Oo0HP+IkOPOnRPvvWADCytrxniUKWRcjXlV1UfM
	uMsHML5Oy0ZDPSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 509B74A0A6;
	Fri,  3 Apr 2026 23:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y3SdEPNT0GnObgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 03 Apr 2026 23:57:39 +0000
Message-ID: <b0c495e4-2137-443b-986e-ed0c10251d0c@suse.de>
Date: Sat, 4 Apr 2026 01:57:31 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfnetlink_queue crashes kernel
To: Florian Westphal <fw@strlen.de>, Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: netfilter-devel@vger.kernel.org
References: <ac-w6e33txkgTRJj@strlen.de> <ac_EY9ciqt5yQ6wr@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ac_EY9ciqt5yQ6wr@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11623-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[strlen.de,gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: B82AB39926C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 3:45 PM, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
>> A probably better fix is to make the rhashtable perqueue, which is
>> much more intrusive at this late stage.
> 
> Tentative patch to do this, still misses selftest extensions:
> 

I could help with selftests. I have written a couple already. Let me 
prepare some this week and I will send them as proposals on the list.

Thanks,
Fernando.

