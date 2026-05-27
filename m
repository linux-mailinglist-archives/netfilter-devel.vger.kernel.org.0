Return-Path: <netfilter-devel+bounces-12903-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cs7IWD9FmoJ0QcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12903-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 16:19:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9595E5C18
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AFBE31C472A
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A362DECB2;
	Wed, 27 May 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HnSx7uMn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l/cULtnv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FFBvD1HE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5hIlbus"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D272459E5
	for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891053; cv=none; b=AepLNOuvVnAXs/dxvRGMRrfm7fr0E9ZTnJxsolTtde3hAaxRB0f5OscagaAIPES/dq0pMHYYtWjgoyZ8xStMNMtaUoUusxXDQsDU11P/bYwnIzeu9kP1suYihvN+0Eh//DkhJa2AbY75OFSKC126W4I4kS9NNm1XvrRd19KYx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891053; c=relaxed/simple;
	bh=/Mco4wEcnSFTlpd/KFmSLnbaUo6z+P2yK8x04y9CjWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGPY3gvsoWPUfedr9CasSTabG6bMrbJyhuQu4TnVrkxic47k0Z+D5/UPW++6FHTcoBO2mYyqsy0baHMYkAmjbObvBVH3DhdSlNAogEtOZ6Rl1w5DU+skvnEn66DumEWXFwg4Py9vFlw02pRuVvG4Ye/dXx/jwEaLZkP7jMptJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HnSx7uMn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l/cULtnv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FFBvD1HE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5hIlbus; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2DCD67A86;
	Wed, 27 May 2026 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779891050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCiJ4EnhQb2oo14A02uBEhMzoFONjTkywpZ2ddvP/LE=;
	b=HnSx7uMnr/35W/5nRTmmr6ru7Qo747kdm4U2GbjWS9AIjntsCTJEI7BqnEJ+eUxBNu/qH0
	LC5cuIDN4wAYIYSy0CVf3vK9wQ88qIbJBWmHuhtDtmCrGphtN/Trlh+eWBmWTb89yx4Rlv
	T+ne/FVtgD69nl/nYKytepj/5KBvNVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779891050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCiJ4EnhQb2oo14A02uBEhMzoFONjTkywpZ2ddvP/LE=;
	b=l/cULtnvx+QBK38Ob9HuudqW5Im/SPggAyZ9KcZGQ/sVMtPUdWi/6XwPy33w3eGrZ5j2a5
	Xj7jczu2QO7JjMCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FFBvD1HE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F5hIlbus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779891049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCiJ4EnhQb2oo14A02uBEhMzoFONjTkywpZ2ddvP/LE=;
	b=FFBvD1HEG56fw7f7aRZZPPtHidiMxlNsxlYmwlpu0v88ue/hJr9Ti+/HAZzcJG/G00lcZl
	299JOhMqu2k0hC5xHtPz29DYS7QxFe9ymSx6fN1HplEeq3Tn2xGpDfZEXXM7gle0+NPXL1
	9K4f9ORus4JAbGS7aaxH9R8n3A4K7JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779891049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCiJ4EnhQb2oo14A02uBEhMzoFONjTkywpZ2ddvP/LE=;
	b=F5hIlbusJyvXHymA5ZwSE3r7vbvEBM22G+5bxFhvE2vwCTJ8xrZccQ2tlWB0CViL3WmCiV
	f1xVWUUjKf2Vn/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54D445A881;
	Wed, 27 May 2026 14:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dGK+EWn7FmoXUgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 27 May 2026 14:10:49 +0000
Message-ID: <e610bace-a04a-4f6c-bea6-3e9d6646352a@suse.de>
Date: Wed, 27 May 2026 16:10:36 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5 nf-next v4] netfilter: synproxy: misc fixes about
 synproxy core
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org, pablo@netfilter.org, fw@strlen.de, phil@nwl.cc
References: <20260526215831.6726-1-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260526215831.6726-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12903-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 4A9595E5C18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:58 PM, Fernando Fernandez Mancera wrote:
> This series fixes several long standing issues during synproxy timestamp
> adjustment and concurrent hook registration. From ignored error handling
> to unaligned memory access. Most of this are not issues impacting real
> setups as they would have been reported before.
> 
> FWIW; I am sending these fixes as separated patches because they are
> addressing independent issues.
> 
> Fernando Fernandez Mancera (5):
>    netfilter: synproxy: drop packets if timestamp adjustment fails
>    netfilter: synproxy: adjust duplicate timestamp options
>    netfilter: synproxy: fix unaligned memory access in timestamp
>      adjustment
>    netfilter: synproxy: protect nf_ct_seqadj_init() with conntrack lock

Sashiko pointed out another issue around nf_ct_seqadj_init() not related 
to these patches. Could we get this merged (if it looks good) and the 
move forward with a follow-up? I am afraid of pilling up a series that 
it is too big.

Any thoughts?

P.S: I am owning the follow-up I just want to reduce the complexity of 
getting everything merged together.

>    netfilter: synproxy: add mutex to guard hook reference counting
> 
>   net/netfilter/nf_conntrack_seqadj.c |  2 +
>   net/netfilter/nf_synproxy_core.c    | 64 ++++++++++++++++++-----------
>   2 files changed, 41 insertions(+), 25 deletions(-)
> 


