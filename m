Return-Path: <netfilter-devel+bounces-11790-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOfeMhCx2GljgwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11790-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 10:13:04 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FE3D3D5E
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 10:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 059C1300372A
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52123AA50C;
	Fri, 10 Apr 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2SJBvG9z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1a4yTWgh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2SJBvG9z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1a4yTWgh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4A3AA1AF
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Apr 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808779; cv=none; b=QBn3a+8PQd7tQWGDifJzAVZobB4EeFhiKB8qSF6ThqReequsGYVrkrc6ReMgJqEzzckoKG/QPNYBhEFboM6hPDxc0UvDVp9thdhrR1BSOx38v3BxDWHRNqpGoFieZAe8aElHy1Bw2Q0WMEfqSVEXwM8fhkBzoZIS3iD0tSzWHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808779; c=relaxed/simple;
	bh=Z3c6DbQjoJUnFwMnh5bHvENDYVcuhXjreKDbJRcQxtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5H+rq1XQEFqS76wybirt2M35JEupKfOCelx+Sm8P/nG/UamjtvneheEEnZ/I4kydyBE2rEg9+XY5QnyTL/krR88pZEEaUVp60FLoTzzo3sUIV/gv22oXJ8s137qsYqK9dNxdcnQtaEe/T5wQ0DxXB9cQakxyOj13RObZ4tFa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2SJBvG9z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1a4yTWgh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2SJBvG9z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1a4yTWgh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0A6C5BCD9;
	Fri, 10 Apr 2026 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775808776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpjQGMoa/1Q9u2vyHGf4u72KTGOh3wLf3cnv8rgJIrI=;
	b=2SJBvG9zsef1Td2SRQ4bUiQJ0Qvx00RZHQFqqQ2nzAXJBJIR6UmvACPIYhqVBe0Q0z5Yqr
	uAJX2KBWP8uvf5tOGs78BcaaqRBlQZ7CMh8jd6V3EpKO1JPFcd2BO0DjphhsiGBaYc9eZW
	dqIAWqe/qRxCRUthK7/5Q6IR96XxLzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775808776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpjQGMoa/1Q9u2vyHGf4u72KTGOh3wLf3cnv8rgJIrI=;
	b=1a4yTWgh70WAZlCE3ATx9ZwJS+Ol9ffZHv2A7Pdl99khPL7GaaB9vThv4CZIdOg+c9f+fc
	C3O51a8U0aqjU5Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775808776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpjQGMoa/1Q9u2vyHGf4u72KTGOh3wLf3cnv8rgJIrI=;
	b=2SJBvG9zsef1Td2SRQ4bUiQJ0Qvx00RZHQFqqQ2nzAXJBJIR6UmvACPIYhqVBe0Q0z5Yqr
	uAJX2KBWP8uvf5tOGs78BcaaqRBlQZ7CMh8jd6V3EpKO1JPFcd2BO0DjphhsiGBaYc9eZW
	dqIAWqe/qRxCRUthK7/5Q6IR96XxLzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775808776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpjQGMoa/1Q9u2vyHGf4u72KTGOh3wLf3cnv8rgJIrI=;
	b=1a4yTWgh70WAZlCE3ATx9ZwJS+Ol9ffZHv2A7Pdl99khPL7GaaB9vThv4CZIdOg+c9f+fc
	C3O51a8U0aqjU5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 518024A0B2;
	Fri, 10 Apr 2026 08:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNT6EAix2Gn/cQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 10 Apr 2026 08:12:56 +0000
Message-ID: <f1e44c0f-4fc8-4362-9e2e-262349d96ea0@suse.de>
Date: Fri, 10 Apr 2026 10:12:44 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf-next] netfilter: Kconfig: make NF_FLOW_TABLE_INET
 depend on NF_TABLES_INET
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
 fw@strlen.de
References: <20260326144246.4430-1-fmancera@suse.de>
 <adhNyRO3j4Fw5_ml@chamomile>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <adhNyRO3j4Fw5_ml@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11790-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: D12FE3D3D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 3:09 AM, Pablo Neira Ayuso wrote:
> On Thu, Mar 26, 2026 at 03:42:46PM +0100, Fernando Fernandez Mancera wrote:
>> As it is not possible to create an inet flowtable without a parent table
>> on inet family, it makes sense that Kconfig NF_FLOW_TABLE_INET symbol
>> depends on NF_TABLES_INET. This reduces the kernel image size a bit when
>> compiling the kernel with CONFIG_IPV6=n.
> 
> The nf_flow_table_inet.c file also defines ipv4 and ipv6:
> 
> static struct nf_flowtable_type flowtable_ipv4 = {
>          .family         = NFPROTO_IPV4,
>          .init           = nf_flow_table_init,
>          .setup          = nf_flow_table_offload_setup,
>          .action         = nf_flow_rule_route_ipv4,
>          .free           = nf_flow_table_free,
>          .hook           = nf_flow_offload_ip_hook,
>          .owner          = THIS_MODULE,
> };
> 
> static struct nf_flowtable_type flowtable_ipv6 = {
>          .family         = NFPROTO_IPV6,
>          .init           = nf_flow_table_init,
>          .setup          = nf_flow_table_offload_setup,
>          .action         = nf_flow_rule_route_ipv6,
>          .free           = nf_flow_table_free,
>          .hook           = nf_flow_offload_ipv6_hook,
>          .owner          = THIS_MODULE,
> };
> 
> The file name is a bit misleading, someone decide to squash ipv4, ipv6
> and _inet_ into the same file.
> 

I see everything is squashed into the same file and indeed under the 
same Kconfig. Then we need to throw away this patch.

Yes, it is a bit misleading but given it is like this I do not see a 
benefit into splitting it now into NF_FLOW_TABLE_IPV4, 
NF_FLOW_TABLE_IPV6 and NF_FLOW_TABLE_INET variants.

Thanks Pablo for pointing this out!
Fernando.


