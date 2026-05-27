Return-Path: <netfilter-devel+bounces-12897-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNpPCMjNFmprsQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12897-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 12:56:08 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ACD5E3057
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85950300AB16
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D53EFFD0;
	Wed, 27 May 2026 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7rxXDrq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uZuo2cn7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7rxXDrq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uZuo2cn7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417C357CFE
	for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879364; cv=none; b=JMojP6ohHOVVDI+MjW/DwwXyXqU4Nw+Pxui2LQZ+92x0bjIv3Dgxbp0INzOrgK5omUGMsBzuvcZ27xaKNK6rJZC5DLRsd5OxVzG9qLLBq3gwICS+Qqgv4ho19JekqdkIFaa/805IdwDjdaAefPe84D6bytXMwpYre9pA5F19Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879364; c=relaxed/simple;
	bh=YT5YbCsXLj8uN9w4ODQTQUJ/nd7I51TcvTEFO620NpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i2t95ry1gpkgSf7+O7HgvYCaQjK52gySgaO5CL0Fyn53rOi6+8HCaIwacWwxsuMjMNUQAG7bhBlmqh8deXlnV7H4mCcD7WIAFHYdEsvh0djTvpNfRTMAGdqnUthOVn1qAe7NzFI/StXFKlN1ay/9OS0ibSqtc8db00bWpnQc7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7rxXDrq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uZuo2cn7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7rxXDrq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uZuo2cn7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C43C6AEBB;
	Wed, 27 May 2026 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779879361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z32WRtnxGuQQuiKMS0kEmgvbah7w9beAbQeqvu7U8i0=;
	b=U7rxXDrqRA+9xgCzNF6fw7wP+0oYkgU9jarGKNuOO98PAIGZU00YWKAeOBEVJWG1+1pXf/
	9ip1B4/HKtHknDpVYsgZ6G7rYMQIcmsm7/TU0Qf8/GTxTPihnDGiXSmchpnhuLVBkqc0cm
	xY8f941kloHy0m6er0Bl0t1Fb3yXdOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779879361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z32WRtnxGuQQuiKMS0kEmgvbah7w9beAbQeqvu7U8i0=;
	b=uZuo2cn7y0iNtdKaJhM7h3+Zo9tL+kEacXE7t5hTSBRjnvljGpV/IbPmNPWfs6sqAPvhpG
	7dKwc/zAkPFvsdBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U7rxXDrq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uZuo2cn7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779879361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z32WRtnxGuQQuiKMS0kEmgvbah7w9beAbQeqvu7U8i0=;
	b=U7rxXDrqRA+9xgCzNF6fw7wP+0oYkgU9jarGKNuOO98PAIGZU00YWKAeOBEVJWG1+1pXf/
	9ip1B4/HKtHknDpVYsgZ6G7rYMQIcmsm7/TU0Qf8/GTxTPihnDGiXSmchpnhuLVBkqc0cm
	xY8f941kloHy0m6er0Bl0t1Fb3yXdOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779879361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z32WRtnxGuQQuiKMS0kEmgvbah7w9beAbQeqvu7U8i0=;
	b=uZuo2cn7y0iNtdKaJhM7h3+Zo9tL+kEacXE7t5hTSBRjnvljGpV/IbPmNPWfs6sqAPvhpG
	7dKwc/zAkPFvsdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02DE25A7C2;
	Wed, 27 May 2026 10:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z4tfOcDNFmqfCQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 27 May 2026 10:56:00 +0000
Message-ID: <9250ac93-a4d6-4243-826d-e95a825bbd03@suse.de>
Date: Wed, 27 May 2026 12:55:51 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: conntrack_irc: fix possible out-of-bounds
 read
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20260527102022.9977-1-fw@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260527102022.9977-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12897-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,strlen.de:email]
X-Rspamd-Queue-Id: B3ACD5E3057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 12:20 PM, Florian Westphal wrote:
> When parsing fails after we've matched the command string we
> should bail out instead of trying to match a different command.
> 
> This helper should be deprecated, given prevalence of TLS I doubt it has
> any relevance in 2026.
> 
> Fixes: 869f37d8e48f ("[NETFILTER]: nf_conntrack/nf_nat: add IRC helper port")
> Closes: https://sashiko.dev/#/patchset/20260525182924.28456-1-fw%40strlen.de
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

