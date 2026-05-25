Return-Path: <netfilter-devel+bounces-12808-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDb8IKpSFGopMgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12808-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 15:46:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C15CB568
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03573005E91
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17733DEC2;
	Mon, 25 May 2026 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XccOCVEl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SFABcR+j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XccOCVEl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SFABcR+j"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A621CFBA
	for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716747; cv=none; b=pY9BFRhnS24JaVB/9d0HMnRf+FoIqz6o44TIjpnPDPHo+k1tQh4+a1rZvhlFeX5E0dHXSiQGLBKKEzOwnEuDCFvz17iWRHDwnGw3MlSf6SpaQjEu2+smOhBOumtHrr/YGbuCqMiVGgIqECcKWs8he3B3NMIfIKerR2izZjjtL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716747; c=relaxed/simple;
	bh=/MYkTSIm7n+OcGwqd19/UFHKU+18/6PWELZmIJ5DaOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u77wVQNnEVdW1f896BqSWyh5eAV6kUvKMyUXFR7x+1d09vsqW9RgeBWRTYc8tOMrlS1LYEiriE4d4SQlbHMQSjAHy3fPRHQp95dF2W2r5c+GcYVsiwLkF0XWw7jwHy+pyDHeb2Ss2DWh667lUvr521Z5xggVvfhL560uGWarGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XccOCVEl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SFABcR+j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XccOCVEl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SFABcR+j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28D936AFFE;
	Mon, 25 May 2026 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779716744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L4trA6yvlqeOnpDbhTVf6hAA4JKi6VNVixyDvp5mUg=;
	b=XccOCVElHpzyF1ejKMl+W0xB5+OaOGFTQKYzZpTdHf21JTjpqWDtal5x3f0xsruzfXcLWF
	I5sVehBrHjIJbz75N+cL1MupcvJGVNr/BD7odUNWVaQFJ7EUAV77xrYoYquLx8zWCv/bte
	McTQtS5E7v2Wt6CQeaEzO7YZJ3YqFmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779716744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L4trA6yvlqeOnpDbhTVf6hAA4JKi6VNVixyDvp5mUg=;
	b=SFABcR+jZ7RWpzi+sOMwnszvBHQda7DXw4FwoCf8BHeNfH4ZWlzuFJw8SuTwiuUYe4cDLz
	h4udJuDUFQN2kUAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XccOCVEl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SFABcR+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779716744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L4trA6yvlqeOnpDbhTVf6hAA4JKi6VNVixyDvp5mUg=;
	b=XccOCVElHpzyF1ejKMl+W0xB5+OaOGFTQKYzZpTdHf21JTjpqWDtal5x3f0xsruzfXcLWF
	I5sVehBrHjIJbz75N+cL1MupcvJGVNr/BD7odUNWVaQFJ7EUAV77xrYoYquLx8zWCv/bte
	McTQtS5E7v2Wt6CQeaEzO7YZJ3YqFmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779716744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L4trA6yvlqeOnpDbhTVf6hAA4JKi6VNVixyDvp5mUg=;
	b=SFABcR+jZ7RWpzi+sOMwnszvBHQda7DXw4FwoCf8BHeNfH4ZWlzuFJw8SuTwiuUYe4cDLz
	h4udJuDUFQN2kUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE45359C8D;
	Mon, 25 May 2026 13:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id amhZL4dSFGriBwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 25 May 2026 13:45:43 +0000
Message-ID: <df64cebb-1279-4e66-afa7-3d8ffca4928f@suse.de>
Date: Mon, 25 May 2026 15:45:31 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 nf v2] netfilter: synproxy: fix possible write to
 stale pointer
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org, pablo@netfilter.org, fw@strlen.de, phil@nwl.cc
References: <20260525124450.6043-1-fmancera@suse.de>
 <20260525124450.6043-5-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260525124450.6043-5-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
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
	TAGGED_FROM(0.00)[bounces-12808-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 079C15CB568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 2:44 PM, Fernando Fernandez Mancera wrote:
> skb_ensure_writable() is called to guarantee that the TCP options area
> can be safely modified when adjusting the timestamp. As it expands or
> linearize the skb head it might reallocate the data buffer.
> 
> This makes the th pointer passed by the caller stale. The following
> writes to the TCP header might be done to a stale pointer.
> 
> Recalculating the th pointer after skb_ensure_writable() prevents this
> issue from happening.
> 
> Fixes: 48b1de4c110a ("netfilter: add SYNPROXY core/target")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

LOL. I just realized I already reviewed this at:

https://lore.kernel.org/netfilter-devel/20260522104257.2008-3-fw@strlen.de/T/#u

*facepalm* sorry for the noise, Florian could you ignore this patch but 
consider the other 3 fixes?

Thanks and I apologize again!
Fernando.



