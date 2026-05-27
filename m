Return-Path: <netfilter-devel+bounces-12906-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KNyCbxfF2qpCggAu9opvQ
	(envelope-from <netfilter-devel+bounces-12906-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 23:18:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C15EA617
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 23:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2999D3011C5A
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC73B19D4;
	Wed, 27 May 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yDnC/DP0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bI8JFUFf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yDnC/DP0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bI8JFUFf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33309397B06
	for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916729; cv=none; b=Rm1NHhohr7wcCzYo6UuDUI1VJOQPQS4pXnA4MCvR/bQJrUbkr1zzS3zQNy6ViWZwtJeHV/WPTIE3NH70aU7XoRpjEzlrPMBCaVh9ukfDSqbLzBzESddzhSIEzwWCDFVKxmbhptjVT15Ca5ysNXE5OsNnBFJAxwk2mS5PBDCA8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916729; c=relaxed/simple;
	bh=BD6yebRIFku3/Rr5E0/S4ItPjrrqSoG7TA42eRVTCdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETzftrCTcx1GXJpxXOx5RReguKg5QyMNRCwaOeHpT3VpXp+Oz+PeU2jE0mJUGw6FyHt77Ot5EbFo4q0tBwfT08FrXa+tgdofGllYiNPy5m1iGbNl8RCZO/d4KffGrIPt81ROLcf6hfjnjtMri6koke3cGbMHC/iIzRais0OFAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yDnC/DP0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bI8JFUFf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yDnC/DP0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bI8JFUFf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EE1A67161;
	Wed, 27 May 2026 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779916726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FksTk+/U3qHRWzlZirjHrqG+KmzsSOzl0id9MwVftUc=;
	b=yDnC/DP0H3S2nEypxc2PHl/RC9hdBpfBZgLgGgHlFgynIXs8Wjide+sF67x4GfA+hS4i5h
	FQ/6rl9wIbkVNS8+cD7JqVgF24ZL1hlyM0ZH+G5awSuigDn1G+HKDbd2BqSTmgWGjXtXiu
	Fef3NtCXBQ2NFOZhcOTWKafy76R3/dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779916726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FksTk+/U3qHRWzlZirjHrqG+KmzsSOzl0id9MwVftUc=;
	b=bI8JFUFfimxb0Wp+USBZZJEKkaEevw1Mbzp72XhKPMneeZbZNHqg7TUquia6oe8+asPgA7
	ft7roLMaV1KLHlDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yDnC/DP0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bI8JFUFf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779916726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FksTk+/U3qHRWzlZirjHrqG+KmzsSOzl0id9MwVftUc=;
	b=yDnC/DP0H3S2nEypxc2PHl/RC9hdBpfBZgLgGgHlFgynIXs8Wjide+sF67x4GfA+hS4i5h
	FQ/6rl9wIbkVNS8+cD7JqVgF24ZL1hlyM0ZH+G5awSuigDn1G+HKDbd2BqSTmgWGjXtXiu
	Fef3NtCXBQ2NFOZhcOTWKafy76R3/dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779916726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FksTk+/U3qHRWzlZirjHrqG+KmzsSOzl0id9MwVftUc=;
	b=bI8JFUFfimxb0Wp+USBZZJEKkaEevw1Mbzp72XhKPMneeZbZNHqg7TUquia6oe8+asPgA7
	ft7roLMaV1KLHlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B1B55AA1D;
	Wed, 27 May 2026 21:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /wvbGrVfF2rkegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 27 May 2026 21:18:45 +0000
Message-ID: <227b1ecb-89b2-4b1a-b330-345ed4aabbd6@suse.de>
Date: Wed, 27 May 2026 23:18:40 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfilter: nft_tunnel: fix use-after-free on object
 destroy
To: Tristan Madani <tristmd@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260527135751.1031891-1-tristmd@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260527135751.1031891-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12906-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,netfilter.org,strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B7C15EA617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 3:57 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> nft_tunnel_obj_destroy() calls metadata_dst_free() which directly
> kfree()s the metadata_dst, ignoring the dst_entry refcount. Packets
> that took a reference via dst_hold() in nft_tunnel_obj_eval() and
> are still queued (e.g. in a netem qdisc) are left with a dangling
> pointer. When these packets are eventually dequeued, dst_release()
> operates on freed memory.
> 
> Replace metadata_dst_free() with dst_release() so the metadata_dst
> is freed only after all references are dropped. The dst subsystem
> already handles metadata_dst cleanup in dst_destroy() when
> DST_METADATA is set.
> 
> Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

