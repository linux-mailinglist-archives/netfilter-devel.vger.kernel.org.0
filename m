Return-Path: <netfilter-devel+bounces-12177-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +En3EdWG62lBNwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12177-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Apr 2026 17:05:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8324607C7
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Apr 2026 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E48A300EF97
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Apr 2026 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2144282F27;
	Fri, 24 Apr 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpXPxbvd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R6zilqoZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpXPxbvd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R6zilqoZ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9E282F14
	for <netfilter-devel@vger.kernel.org>; Fri, 24 Apr 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043001; cv=none; b=h3JvqsX/yHu6CyuTKxg+RCjsgxojKy5J3/05IyTvbO49R8WGyx1RaF0bzNLAEpZyevUeuM1k/Evj/0njjGaDoBy2MvXJU4VuLL8SI3DIpPMqbsZHUa5ScPyzuB/Gcfx6O5jPFySkStUb+q6kgYGp0W1q9HcMz813NTIHPbIIFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043001; c=relaxed/simple;
	bh=QGyDHsy6gpNnOdvz052XFtA4uMqbWyDYx5AzxE01M4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRUSQeRXlLmXdF8bq6CnjDVfnQaNpgxjAO+7NZF/UVLogeZW88oL8Opb3VgL55rrzS0nPFNmPQaVhSes+U2pOoz0/tXeO26z4laxJACiOopSPPsU8kdyur4ecsHgnH4gTGdMiIrCPbTWuvKLf+0fjZEXKl8cSoTvd3Dy4FgpP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpXPxbvd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R6zilqoZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpXPxbvd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R6zilqoZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 984B86A869;
	Fri, 24 Apr 2026 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777042998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf/WeSjesDWq9fMP1Egzq/M9bqh/fedm0IAgBxupDyw=;
	b=KpXPxbvd11DNvQBQadFVTx5DfnjR3wq01v/O+bt+fDDWRKwsCtjv8XUEIRZKSHUQkl+zPd
	BJ045XnnEIqEC8hce1FfbuYCISDcyEY4eOn8oofSfoz0WLOiNa+Wol2NZglWFSc5EREciK
	ByHR6I61AEIaVcLqQbb2o/5sCJHMQ7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777042998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf/WeSjesDWq9fMP1Egzq/M9bqh/fedm0IAgBxupDyw=;
	b=R6zilqoZUU3MWvMW9FwwRt3lc64Idondo0a8GleFo7ZPv1w5dMYq5UHAKEMmyYfgekgv8f
	Kb5gKbP7XriemECg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777042998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf/WeSjesDWq9fMP1Egzq/M9bqh/fedm0IAgBxupDyw=;
	b=KpXPxbvd11DNvQBQadFVTx5DfnjR3wq01v/O+bt+fDDWRKwsCtjv8XUEIRZKSHUQkl+zPd
	BJ045XnnEIqEC8hce1FfbuYCISDcyEY4eOn8oofSfoz0WLOiNa+Wol2NZglWFSc5EREciK
	ByHR6I61AEIaVcLqQbb2o/5sCJHMQ7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777042998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf/WeSjesDWq9fMP1Egzq/M9bqh/fedm0IAgBxupDyw=;
	b=R6zilqoZUU3MWvMW9FwwRt3lc64Idondo0a8GleFo7ZPv1w5dMYq5UHAKEMmyYfgekgv8f
	Kb5gKbP7XriemECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 434E6593A4;
	Fri, 24 Apr 2026 15:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DWuDTaG62l+FgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 24 Apr 2026 15:03:18 +0000
Message-ID: <a40745d0-ee68-40b8-8eba-70edb89e25a0@suse.de>
Date: Fri, 24 Apr 2026 17:03:17 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf v3] netfilter: nft_bitwise: fix dst corruption in same
 register shifts
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 jeremy@azazel.net, phil@nwl.cc, fw@strlen.de
References: <20260423155453.7499-1-fmancera@suse.de>
 <aetRiG3x9S3PQHaw@chamomile>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aetRiG3x9S3PQHaw@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 9A8324607C7
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
	TAGGED_FROM(0.00)[bounces-12177-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]

On 4/24/26 1:18 PM, Pablo Neira Ayuso wrote:
> Hi Fernando,
> 
> On Thu, Apr 23, 2026 at 05:54:53PM +0200, Fernando Fernandez Mancera wrote:
> [...]
>> @@ -201,6 +206,11 @@ static int nft_bitwise_init_shift(struct nft_bitwise *priv,
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (priv->sreg != priv->dreg &&
>> +	    priv->dreg < priv->sreg + n &&
>> +	    priv->sreg < priv->dreg + n)
> 
> Is this enough? Just to make sure we are on the same page.
> 
> NFT_REG_1
> NFT_REG_2
> NFT_REG_3
> NFT_REG_4
> 
> have a size of 128 bytes.
> 

Right but if I am not wrong these registers are mapped/normalized. That 
happens during nft_parse_register() earlier in the init() path.

Therefore we must expect priv->sreg/dreg in the range [4, 19].

> Then, NFT_REG32_00, NFT_REG32_01, NFT_REG32_02 and NFT_REG32_03
> basically overlap with NFT_REG_1. They split the 128 bytes of
> NFT_REG_1 in 4 registers of 32 bytes.
> 
> Is this check above enough to deal with the partial overlaps?
> 

I am not very good at math but as long as we have the length of the data 
we can calculate the overlap in 4 bytes segments. Of course if from 
userspace you mix both APIs the math should hold up.

let's say we have NFT_REG_1 as sreg and NFT_REG32_O1 as dreg and length 
of 8 bytes.

That is after normalization:

sreg: 4 and dreg: 5

sreg expands through registers 4 and 5
dreg expands through registers 5 and 6

The check is able to catch it. Of course, if the length would be 4 
bytes, the check would pass but that is fine.

At the end NFT_REG_1 is mapped to 32bits register number 4 while 
NFT_REG32_O1 is mapped to 32 bits register number 5.

Does this make sense? Anyway, AI suggested if this should be applied 
XOR, OR, AND, etc. I think yes, as the partial overlap could corrupt the 
result there too. So a v4 is needed anyway.

Thanks,
Fernando.

> Thanks!
> 
>> +		return -EINVAL;
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.53.0
>>
>>
> 


