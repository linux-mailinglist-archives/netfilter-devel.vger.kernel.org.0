Return-Path: <netfilter-devel+bounces-12554-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPFvNugoA2qw1AEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12554-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 15:19:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A819520FF9
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A60131C4AC2
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1C397347;
	Tue, 12 May 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OsXUaG7c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UbsnW+KV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OsXUaG7c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UbsnW+KV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81367394EA6
	for <netfilter-devel@vger.kernel.org>; Tue, 12 May 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590662; cv=none; b=JeLuiFmss7hJ66Vz7Jd5Ihsk6Sy3kWKCeOys2lhgavCfBeYyrTndoACrmI/lpOGw92Gbt5oc97mfVLHLvddrSPZQ03GHGWZh3ycyt2WWtCTvDTOoJEiOWMsCYID5Rtd2Zoww1XuVOcdfv7UFuv/bTVRq4t6i8oNYNByTUNDZgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590662; c=relaxed/simple;
	bh=/DyokFw0JWdXYlOyVaZen1ydwuIl0+eD6zruCSYN+oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H4m0HKL1X+aAHjECiGJc5YhqhccYnonvKC+xohOXcBuqlhBW+Xs8tPA6HZR/o6r1WFYn5cjuk/4hi4DUgGatX6heiQVypudgv4g4KVAUwcY1jg1/nFqa75BQw7X309asMYtDeoQoLNuE71iSz5yFEMmKGjvxIM8i+takp5NaFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OsXUaG7c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UbsnW+KV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OsXUaG7c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UbsnW+KV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84FC17597F;
	Tue, 12 May 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778590659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D92/84uOG8raQ+KYwq1+zD4iGp5NzmrB3CHIqJ3s2qE=;
	b=OsXUaG7cPChJqsqgjSEeoFMjNLwb6NH70kNtMM4FgZXcjjSuq8FHZVp05npsaixm/0acGd
	l1IQcXrqvhHpuPsriBmTtrxPebLPQQnw0FHlAGTVcn7c45ylJmJqC3AqPpf+nsLEBUvHKa
	L60bQOh2RfPlCD9CdaONFkgPBoKliC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778590659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D92/84uOG8raQ+KYwq1+zD4iGp5NzmrB3CHIqJ3s2qE=;
	b=UbsnW+KVGGnIJJcRjYgmcc45u8wXCQG12uFrkY2iOON/hUEV39upMcS2Hyo08kBxonjEbp
	CCI23Ysu5sT8k+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778590659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D92/84uOG8raQ+KYwq1+zD4iGp5NzmrB3CHIqJ3s2qE=;
	b=OsXUaG7cPChJqsqgjSEeoFMjNLwb6NH70kNtMM4FgZXcjjSuq8FHZVp05npsaixm/0acGd
	l1IQcXrqvhHpuPsriBmTtrxPebLPQQnw0FHlAGTVcn7c45ylJmJqC3AqPpf+nsLEBUvHKa
	L60bQOh2RfPlCD9CdaONFkgPBoKliC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778590659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D92/84uOG8raQ+KYwq1+zD4iGp5NzmrB3CHIqJ3s2qE=;
	b=UbsnW+KVGGnIJJcRjYgmcc45u8wXCQG12uFrkY2iOON/hUEV39upMcS2Hyo08kBxonjEbp
	CCI23Ysu5sT8k+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C4AD593A9;
	Tue, 12 May 2026 12:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LzK6E8MjA2qrNQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 12 May 2026 12:57:39 +0000
Message-ID: <fc385e02-d14b-4340-90a9-1bfbc45f76db@suse.de>
Date: Tue, 12 May 2026 14:57:33 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: nft_inner: release local_lock before
 re-enabling softirqs
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20260512093052.24326-1-fw@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260512093052.24326-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 6A819520FF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12554-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,strlen.de:email]
X-Rspamd-Action: no action

On 5/12/26 11:30 AM, Florian Westphal wrote:
> Quoting sashiko:
>   In the error path, local_bh_enable() is called before
>   local_unlock_nested_bh().
> 
> Fixes: ba36fada9ab4 ("netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>   net/netfilter/nft_inner.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
> index 03ffb1159fc1..85164369b924 100644
> --- a/net/netfilter/nft_inner.c
> +++ b/net/netfilter/nft_inner.c
> @@ -247,8 +247,8 @@ static bool nft_inner_restore_tun_ctx(const struct nft_pktinfo *pkt,
>   	local_lock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
>   	this_cpu_tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx.ctx);
>   	if (this_cpu_tun_ctx->cookie != (unsigned long)pkt->skb) {
> -		local_bh_enable();
>   		local_unlock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
> +		local_bh_enable();
>   		return false;
>   	}
>   	*tun_ctx = *this_cpu_tun_ctx;

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

