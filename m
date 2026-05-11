Return-Path: <netfilter-devel+bounces-12533-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP2eNfgKAmqknQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12533-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2026 18:59:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3D512DB7
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2026 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CB1230509A1
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 May 2026 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58132426EC2;
	Mon, 11 May 2026 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Io036mJP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ylANIaAa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Io036mJP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ylANIaAa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA2421F12
	for <netfilter-devel@vger.kernel.org>; Mon, 11 May 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516849; cv=none; b=C8ng5SAmHZdvLM7BNEaEVl9MT5o05iNratp5rqUSjXX9kmGBMZvVfx7W8AUTbI4d2nFwO9iOuTmeo1A9zGOMbkIorfyhinFGUz2QxZLdTMMiwEaFRp00dhdMcM6lV8ExW9I8I63pGnT6q9QPEkYOkuWhArTysEyjLwsK2MhzkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516849; c=relaxed/simple;
	bh=sPJT0ISPJ8GDk0DyrwTaHFdTjL6MDKoE1ujApsKtAcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pojrf1ObSdC5uetOnZxmvobnjTycOEYFQWFJo5kH331VB1TZg+bz7TleTPUoGF4zRsvfOf4A3bEkNwYGehLiH8/PxXG2UIEmgxLvc3DbviZn/wme1a3jvh5hcNLEnmB+iTaMRDM5SvVKc29AdYIAartPnCPigiXzP9Li1u4IxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Io036mJP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ylANIaAa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Io036mJP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ylANIaAa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3055B5F721;
	Mon, 11 May 2026 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778516846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgRvNIzBsLTIQ78z77l/EJAf9qzgLk9PRCPH5qByPSI=;
	b=Io036mJPFlVomAUfa7mGoyDzwr4ChrH6G+I4kw+yh0exwn+rLkeN9/bARBuvrGUBuDmP8Y
	39SCCvIJB/JUCW85ds/zuDg54ttr0OMLWwvaU6Pb3p4GOx3Vo6sqN4bofAVk/HRyH9+UAw
	/AIELvQnh8bAzao9UtIWEycalc3Vm6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778516846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgRvNIzBsLTIQ78z77l/EJAf9qzgLk9PRCPH5qByPSI=;
	b=ylANIaAa9q+atmqp+xNHibBD/Shy163omcWN/bKY+N7itjSfw6NbMsy3iTmY/N0jpO+eLu
	cqLxWHZVpD3BUEAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778516846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgRvNIzBsLTIQ78z77l/EJAf9qzgLk9PRCPH5qByPSI=;
	b=Io036mJPFlVomAUfa7mGoyDzwr4ChrH6G+I4kw+yh0exwn+rLkeN9/bARBuvrGUBuDmP8Y
	39SCCvIJB/JUCW85ds/zuDg54ttr0OMLWwvaU6Pb3p4GOx3Vo6sqN4bofAVk/HRyH9+UAw
	/AIELvQnh8bAzao9UtIWEycalc3Vm6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778516846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgRvNIzBsLTIQ78z77l/EJAf9qzgLk9PRCPH5qByPSI=;
	b=ylANIaAa9q+atmqp+xNHibBD/Shy163omcWN/bKY+N7itjSfw6NbMsy3iTmY/N0jpO+eLu
	cqLxWHZVpD3BUEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56EF3593A3;
	Mon, 11 May 2026 16:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jHM4Em0DAmrhWwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 11 May 2026 16:27:25 +0000
Message-ID: <5a17cb3e-72c6-404f-8bbf-cde2c9047b0f@suse.de>
Date: Mon, 11 May 2026 18:27:19 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 nft] netfilter: nft_inner: Fix IPv6 inner_thoff desync
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, fengxw06@126.com, fw@strlen.de,
 horms@kernel.org, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pabeni@redhat.com, pablo@netfilter.org, phil@nwl.cc, qli01@tsinghua.edu.cn,
 stable@vger.kernel.org, xuke@tsinghua.edu.cn, yangyx22@mails.tsinghua.edu.cn
References: <0bbeadd4-a4b4-44e9-9312-85e563f2bd1c@suse.de>
 <20260511133744.6716-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260511133744.6716-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 8DD3D512DB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,126.com,strlen.de,kernel.org,vger.kernel.org,redhat.com,netfilter.org,nwl.cc,tsinghua.edu.cn,mails.tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12533-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[z.ai:url,suse.de:mid,suse.de:dkim,tsinghua.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 3:37 PM, Yizhou Zhao wrote:
> Thank you for your suggestions. Here's the v2 version of our patch.
> 
> In nft_inner_parse_l2l3(), when processing inner IPv6 packets,
> ipv6_find_hdr() correctly computes the transport header offset
> traversing all extension headers, but the result is immediately
> overwritten with nhoff + sizeof(_ip6h) (40 bytes), which only
> accounts for the IPv6 base header. This creates a desync between
> inner_thoff (wrong — points to extension header start) and l4proto
> (correct — e.g., IPPROTO_TCP), enabling transport header forgery
> and potential firewall bypass. This issue affects stable versions
> from Linux 6.2.
> 
> For comparison, the normal (non-inner) IPv6 path correctly
> preserves ipv6_find_hdr()'s result. Removing the incorrect overwrite
> ensures that ipv6_find_hdr()'s calculated transport header offset is
> preserved, thereby fixing the desynchronization.
> 
> Fixes: 3a07327d10a0 ("netfilter: nft_inner: support for inner tunnel header matching")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:5.1 Z.ai
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---

Please could you submit the patch as a new submission rather than a 
reply to the old one?

In addition, the correct target tree is nf.git so use [PATCH nf] 
instead, thanks!

>   net/netfilter/nft_inner.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
> index c4569d4b9..1b3e7a976 100644
> --- a/net/netfilter/nft_inner.c
> +++ b/net/netfilter/nft_inner.c
> @@ -163,7 +163,6 @@ static int nft_inner_parse_l2l3(const struct nft_inner *priv,
>   			return -1;
>   
>   		if (fragoff == 0) {
> -			thoff = nhoff + sizeof(_ip6h);
>   			ctx->flags |= NFT_PAYLOAD_CTX_INNER_TH;
>   			ctx->inner_thoff = thoff;
>   			ctx->l4proto = l4proto;


