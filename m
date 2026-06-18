Return-Path: <netfilter-devel+bounces-13327-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hx8pIQUNNGpZMQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13327-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 17:21:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825876A131F
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 17:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JAALCZX+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VIv/1ieK";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JAALCZX+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VIv/1ieK";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13327-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13327-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF704301EC0C
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0A3F58D9;
	Thu, 18 Jun 2026 15:18:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08628686
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 15:18:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795933; cv=none; b=JyvKDjC++YO6kKsN8lH++TvO/3xyL8cOkxyWEGTqVzAb5P1MVBPUg1apGcnGLiYyaPziOFoyk222RhOL5Wrcx/8ltnmWOa35gXEhjIjedIkRNciae7+AmKqesau+wdQkjk5I0AHZ3nHkWH/9mOl42IDKCBxk46OZfS/XZd9Af0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795933; c=relaxed/simple;
	bh=wiVDLHtOIMhv5UsKa3NE0LAL4cHlYH2wA2YuTIen7wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GvQSD2m3tM9NA8AYeQNbqfHWeJ9tInqdXr6ZhbsFmLwD0XqauUnn4Jk/1FOUgccc5Dmcwuw6prj26Y/FyVcDrmb29enqYNszuxaUaynvJ7Rl/hHXBAjqAqCeKmq7a/swhBzl7G9yidQukNm00/LmMYc/yurIbC8z/88v+36xG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JAALCZX+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VIv/1ieK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JAALCZX+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VIv/1ieK; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AAFF75EE4;
	Thu, 18 Jun 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781795930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNvhRm7LyV/dJ0G0eDNecietzon7Hrx2+e+Iyvw1csg=;
	b=JAALCZX+QGPlGnJe/EHELQRsmFYFlZGwpXBvEfFNthhavrqxmYMqYrG7TCxADO4nB8hu0+
	fqkiyMvrattyG1naCP8Vdjg1E2Dw6eyW5pqG6Ed2xblS7VFtp8g31Du1DRoVntr2CPLHOE
	HUKz3gDPiTlQZ82/w96mjx6jZQAe+uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781795930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNvhRm7LyV/dJ0G0eDNecietzon7Hrx2+e+Iyvw1csg=;
	b=VIv/1ieKNwGO39Ypi6BJiFVyNh7TtCTBLfmwTZWjs8uX3pqdwzqYrbF6ivpXRm1uMoui7K
	smeK3TXIxP/tT+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781795930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNvhRm7LyV/dJ0G0eDNecietzon7Hrx2+e+Iyvw1csg=;
	b=JAALCZX+QGPlGnJe/EHELQRsmFYFlZGwpXBvEfFNthhavrqxmYMqYrG7TCxADO4nB8hu0+
	fqkiyMvrattyG1naCP8Vdjg1E2Dw6eyW5pqG6Ed2xblS7VFtp8g31Du1DRoVntr2CPLHOE
	HUKz3gDPiTlQZ82/w96mjx6jZQAe+uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781795930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNvhRm7LyV/dJ0G0eDNecietzon7Hrx2+e+Iyvw1csg=;
	b=VIv/1ieKNwGO39Ypi6BJiFVyNh7TtCTBLfmwTZWjs8uX3pqdwzqYrbF6ivpXRm1uMoui7K
	smeK3TXIxP/tT+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3397B779A8;
	Thu, 18 Jun 2026 15:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YmzaCVoMNGphTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 15:18:50 +0000
Message-ID: <0596e86b-7d7e-447b-8dfd-23fb29cfa6fb@suse.de>
Date: Thu, 18 Jun 2026 17:18:49 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: nft_payload: reject offsets exceeding 65535
 bytes
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20260618045826.2449-1-fw@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260618045826.2449-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13327-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 825876A131F

On 6/18/26 6:58 AM, Florian Westphal wrote:
> Large offsets were rejected based on netlink policy, but blamed commit
> removed the policy without updating nft_payload_inner_init() to use the
> truncation-check helper.
> 
> Silent truncation is not a problem, but not wanted either, so add a
> check.
> 
> Fixes: 077dc4a27579 ("netfilter: nft_payload: extend offset to 65535 bytes")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Uh, it seems I missed two other usages of NFTA_PAYLOAD_OFFSET, thanks 
for catching this.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

