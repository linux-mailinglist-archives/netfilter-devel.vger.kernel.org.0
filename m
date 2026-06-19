Return-Path: <netfilter-devel+bounces-13335-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bm6tI3oJNWotmQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13335-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 11:18:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 099EE6A4ED0
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 11:18:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cZ1SaRTa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NiLSTnNP;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cZ1SaRTa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NiLSTnNP;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13335-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13335-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E312A3031022
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6B351C3B;
	Fri, 19 Jun 2026 09:18:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA2360EDC
	for <netfilter-devel@vger.kernel.org>; Fri, 19 Jun 2026 09:18:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860708; cv=none; b=V1KIoE9/TMwfB2FynzLBGghwOW9Z03hSQySm1xlF7AodKHdIGKyAjhOqrkgFKE4nKkAdikUEfIV5pC2LJMmoE0VtQOy8gLln5Eq/ESvCX7wKDDQJ13CRw1fZoy58CyuCQAmVAYM+0R3AtmkNbO9A7V0Z/oHhZxldH11q5dms324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860708; c=relaxed/simple;
	bh=lTihVApC4Aw4YsFwbH938d90xKfb3aJCY+8yoi0ez4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c0cQGK88ssITzHSt13NTPOXOFSDKl4YapDuV9RilW2OiCHNjx2EICS0+fnNrkeCXr6MIacqDwnRJZisOkhzTrUxMjFq7FdkhMJAddIhPLf5xMiTzeJObtqhubI95qywGdWnNL2PF8OTMYS9AKAsYL8TiAhROXTazULbLwII/PWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZ1SaRTa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NiLSTnNP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZ1SaRTa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NiLSTnNP; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 247AB6D881;
	Fri, 19 Jun 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781860704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwgq7FWbOn6DX94CymExYFiIZQiFrKHwJqkDF/w76xA=;
	b=cZ1SaRTaWbmtU2ymUNTn8l8eBVdKOuWO0HbXWT3q2t066sGqJYpmpEt/wuhm6iamuWMw4i
	4LiflkW6oJRNPEoz2YvpPJmq02mQdGodnPhvUhRWPgfBsXnrtX62bMSD80kdkQDQ8uldZG
	6GzHTxOCYJ4sl4Ch74UKbYtnqvsSXi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781860704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwgq7FWbOn6DX94CymExYFiIZQiFrKHwJqkDF/w76xA=;
	b=NiLSTnNPA3G6GW+7CRk61Vt4RdgesZuJErYb9LzQsXSLXdUhItvpVaWCie/6O2ay+Cg0KV
	TmludrAb9YIUNQCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781860704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwgq7FWbOn6DX94CymExYFiIZQiFrKHwJqkDF/w76xA=;
	b=cZ1SaRTaWbmtU2ymUNTn8l8eBVdKOuWO0HbXWT3q2t066sGqJYpmpEt/wuhm6iamuWMw4i
	4LiflkW6oJRNPEoz2YvpPJmq02mQdGodnPhvUhRWPgfBsXnrtX62bMSD80kdkQDQ8uldZG
	6GzHTxOCYJ4sl4Ch74UKbYtnqvsSXi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781860704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwgq7FWbOn6DX94CymExYFiIZQiFrKHwJqkDF/w76xA=;
	b=NiLSTnNPA3G6GW+7CRk61Vt4RdgesZuJErYb9LzQsXSLXdUhItvpVaWCie/6O2ay+Cg0KV
	TmludrAb9YIUNQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED7C2779A8;
	Fri, 19 Jun 2026 09:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UtbYNl8JNWo8ZgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 19 Jun 2026 09:18:23 +0000
Message-ID: <e9ccaee7-2e37-4bcf-9616-cb456161abd7@suse.de>
Date: Fri, 19 Jun 2026 11:18:23 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] netfilter: nf_tables_offload: drop device refcount on
 error
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20260605114715.11297-1-fw@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260605114715.11297-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13335-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 099EE6A4ED0

On 6/5/26 1:47 PM, Florian Westphal wrote:
> Reported by sashiko:
> If nft_flow_action_entry_next() returns NULL, dev reference leaks.
> 
> Fixes: c6f85577584b ("netfilter: nf_tables_offload: add nft_flow_action_entry_next() and use it")
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!


