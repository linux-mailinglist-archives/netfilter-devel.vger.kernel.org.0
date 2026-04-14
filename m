Return-Path: <netfilter-devel+bounces-11875-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WrJMI3cq3ml0ogkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11875-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:52:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055FE3F99E1
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C7783074137
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133263E122C;
	Tue, 14 Apr 2026 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JRMoU+YD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GZAKv62o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bEtBj5ld";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6H74mJFu"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C393E0C62
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167455; cv=none; b=lk9HPOsbgrc3PHw5CmtS8k1i0XFEWqGCe8BX9kEtq46u4QHBHhcO8UeN4aot7STHFCRndLcQQTj1ano+Xik7EU5lv3Xl6l3YFokq82xI2RhlA+gemkQbf9GRFfVx8F4SpFjx0drh5ryXDvXPV0nzTZ0O6PWgL9/YGNBguJTIdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167455; c=relaxed/simple;
	bh=hX3mTPNzGWs9JERXXxZpRnJlhPoWva3Uqe+7M6hSH18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjLU23xuyqIO8oE+ozh/Xj99fCqXZO7LKwnldpvCdCUGR+rFajYXC2JkBLk/QQSE6USVcx48OUk/aKBMDikKO0uD0dAIsKSoWeKt/dMFkiOQn5ejNQ0hZ0OeQVIyDsQmokTbX4SpXLTdUmB2JWIA9H7D43s5B4Sl5oJuOw1p6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JRMoU+YD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GZAKv62o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bEtBj5ld; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6H74mJFu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCFD66A8C1;
	Tue, 14 Apr 2026 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776167452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xoz1jFGyUNn/jdof2ijaIHRiP/NuHWpG2TflwhcJQgQ=;
	b=JRMoU+YDTi4Z1AgZvZGOlRjwW+BaRK1mFk4i4Hl3uikpOuybI9M5kqFVz8KpJKMk8SzE9A
	RbQr9Ng3shqyt28xN3OnfTaBZQaBMAvfP1f7UVxKHDV1CG4gGfYcYXKRnlyOopu9AMzWBv
	AR742S3FYD91lpQj/hEltD4d0ULMpL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776167452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xoz1jFGyUNn/jdof2ijaIHRiP/NuHWpG2TflwhcJQgQ=;
	b=GZAKv62o/p1yrIVRK7iksa3QI7YW55uDGdybvG824HsiGDujbsY7Et6v+VHj4YvV4sslod
	32GR25kJkmRzBoCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776167451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xoz1jFGyUNn/jdof2ijaIHRiP/NuHWpG2TflwhcJQgQ=;
	b=bEtBj5ld/ckETC2dBXj7vieJshDnol6t/LP6ORw2XCulXLS6Wt509OYoDiLWJCva7/Yi5m
	X/jxLzNeWlgcKgSa7Nn5tA4D9VUA2lKqI+mUYCFsstdouxvlwDvZJ27Q0wtYfkIFZdTnJZ
	tQ43kJwAx7IEULvUWtk4DKZ/sZ1gcv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776167451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xoz1jFGyUNn/jdof2ijaIHRiP/NuHWpG2TflwhcJQgQ=;
	b=6H74mJFuDG9xpPx4B8KwPBcrA+xblQpexiFXGSC0wcPGVr6OahMXbnMzjPwgjHT9ag4Ivq
	3LMRI6wL2A4cjJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 138034B41D;
	Tue, 14 Apr 2026 11:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L0iaARsq3mlPXQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 14 Apr 2026 11:50:51 +0000
Message-ID: <818aa828-7a16-4f89-930d-c38f42f7a0a6@suse.de>
Date: Tue, 14 Apr 2026 13:50:45 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] netfilter: nfnetlink_osf: fix null-ptr-deref in
 nf_osf_ttl
To: "Kito Xu (veritas501)" <hxzene@gmail.com>, pablo@netfilter.org
Cc: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
 ffmancera@riseup.net, fw@strlen.de, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, phil@nwl.cc
References: <20260414074556.2512750-1-hxzene@gmail.com>
 <20260414104900.2617863-1-hxzene@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260414104900.2617863-1-hxzene@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11875-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 055FE3F99E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 12:49 PM, Kito Xu (veritas501) wrote:
> nf_osf_ttl() calls __in_dev_get_rcu(skb->dev) and passes the result
> to in_dev_for_each_ifa_rcu() without checking for NULL. When the
> receiving device has no IPv4 configuration (ip_ptr is NULL),
> __in_dev_get_rcu() returns NULL and in_dev_for_each_ifa_rcu()
> dereferences it unconditionally, causing a kernel crash.
> 
> This can happen when a packet arrives on a device that has had its
> IPv4 configuration removed (e.g., MTU set below IPV4_MIN_MTU causing
> inetdev_destroy) or on a device that was never assigned an IPv4
> address, while an xt_osf or nft_osf rule with TTL_LESS mode is
> active and the packet TTL exceeds the fingerprint TTL.
> 
> Add a NULL check for in_dev before using it. When in_dev is NULL,
> return 0 (no match) since source-address locality cannot be
> determined without IPv4 addresses on the device.
> 
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> RIP: 0010:nf_osf_match_one+0x204/0xa70
> Call Trace:
>   <IRQ>
>   nf_osf_match+0x2f8/0x780
>   xt_osf_match_packet+0x11c/0x1f0
>   ipt_do_table+0x7fe/0x12b0
>   nf_hook_slow+0xac/0x1e0
>   ip_rcv+0x123/0x370
>   __netif_receive_skb_one_core+0x166/0x1b0
>   process_backlog+0x197/0x590
>   __napi_poll+0xa1/0x540
>   net_rx_action+0x401/0xd80
>   handle_softirqs+0x19f/0x610
>   </IRQ>
> 
> Fixes: a218dc82f0b5 ("netfilter: nft_osf: Add ttl option support")
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks !

