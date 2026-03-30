Return-Path: <netfilter-devel+bounces-11504-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDTdL4qcymk2+gUAu9opvQ
	(envelope-from <netfilter-devel+bounces-11504-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 17:53:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0535E371
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F4E63016489
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E903624B2;
	Mon, 30 Mar 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zOESjmCY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dUM45OA6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B1TSQ+1V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jmJu+N8B"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF90373BEF
	for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885591; cv=none; b=iof5wRclXPgmc8B6MUyHAu+1Hul1vy0F+HPLX53yH9kY4hQN83iT5zYBBc1uvTb16zZYwm6ztS+BaNDzKjgiD7goXHI9cUcd8/T5/0l18Xk71qFYsh1C6iUwj2NVQHlIrZaN5rwXEHkduYysy/Mk5uVtIMhZ48R75yD+GpdV8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885591; c=relaxed/simple;
	bh=6rI5K7pefwKHPinvLKnfGQNVVDrj6YHVgJbfqg/Mrck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlMbz8BKkrwTo+ytmLH0U6lgOgq7DCIWTIhWhqKtedRXaWfDbGdOtMvtpndLbWUW71QFU13HZjZDszLlRXypTJlDlCr0XuWsYmr+OI+jTitk6Xr1LyucECjzrUU+qECWiXU1LCN1CsajMiLXmejpnS2I/12VzeRfmJYHQo0t4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zOESjmCY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dUM45OA6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B1TSQ+1V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jmJu+N8B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E0B44D1FD;
	Mon, 30 Mar 2026 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774885588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVHhJC21g3B5ERrwwukgjLnDi1uq4KL21bBh6XtKj4M=;
	b=zOESjmCYaTFAD1Xe2g42ZqtojxJV3lLxPwyH+yGoiRc9JnIVUR6sq9p4hq28wQNnkKCszx
	EjVAP8WEWbxTOOY7W7+ZM7pAqeH+heIjaZ5FF0DYO6kzhYt92Ff5zYQT938zZKq0OttVmy
	bJ0L3LLnMVUrik5xsgNUztxR0J6T5zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774885588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVHhJC21g3B5ERrwwukgjLnDi1uq4KL21bBh6XtKj4M=;
	b=dUM45OA6WPEpJos5v6OAUcU5k1G5Q4F8ZXXEb4n/DFjhITYzkD+A2M2r/FubJnzCqLqJvb
	w0dCz5Hr7yNSGJAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B1TSQ+1V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jmJu+N8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774885587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVHhJC21g3B5ERrwwukgjLnDi1uq4KL21bBh6XtKj4M=;
	b=B1TSQ+1VKNvE+U5dVCEz/yqkYmBaQwgkpOz1hrvYQXpVVHoUlbNWrWBra92i48OXGXBtgk
	tHlUGcVXwpfnYQSW3EYR73CTGkyY4BgosrzVYRP3By0llpZhHq0GIvNP+bPA/hJNhD+uGa
	wkI3eNm68FHFIMj7B9bQQu76/gJuZnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774885587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVHhJC21g3B5ERrwwukgjLnDi1uq4KL21bBh6XtKj4M=;
	b=jmJu+N8BbEWYE41Ot+cL8mXGBRutFjyOxpUDUnvvzsvL7qz4kYvo3wj1toIs1OlnVzkuEJ
	GQTsygSlnfrUjBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45EFF4A0A2;
	Mon, 30 Mar 2026 15:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D7l5DdOaymkfLQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 30 Mar 2026 15:46:27 +0000
Message-ID: <609becce-893f-43ea-ac1b-dbfd11a7e60d@suse.de>
Date: Mon, 30 Mar 2026 17:46:16 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf,v4] netfilter: ctnetlink: ignore explicit helper on new
 expectations
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: fw@strlen.de, ffmancera@suse.de
References: <20260330143627.892413-1-pablo@netfilter.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260330143627.892413-1-pablo@netfilter.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11504-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 3AE0535E371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 4:36 PM, Pablo Neira Ayuso wrote:
> Use the existing master conntrack helper, anything else is not really
> supported and it just makes validation more complicated, so just ignore
> what helper userspace suggests for this expectation.
> 
> This was uncovered when validating CTA_EXPECT_CLASS via different helper
> provided by userspace than the existing master conntrack helper:
> 
>    BUG: KASAN: slab-out-of-bounds in nf_ct_expect_related_report+0x2479/0x27c0
>    Read of size 4 at addr ffff8880043fe408 by task poc/102
>    Call Trace:
>     nf_ct_expect_related_report+0x2479/0x27c0
>     ctnetlink_create_expect+0x22b/0x3b0
>     ctnetlink_new_expect+0x4bd/0x5c0
>     nfnetlink_rcv_msg+0x67a/0x950
>     netlink_rcv_skb+0x120/0x350
> 
> Allowing to read kernel memory bytes off the expectation boundary.
> 
> CTA_EXPECT_HELP_NAME is still used to offer the helper name to userspace
> via netlink dump.
> 
> Fixes: bd0779370588 ("netfilter: nfnetlink_queue: allow to attach expectations to conntracks")
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v4: actually... remove this entire refetch
> 
> @@ -3576,8 +3569,6 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
>   #ifdef CONFIG_NF_CONNTRACK_ZONES
>          exp->zone = ct->zone;
>   #endif
> -       if (!helper)
> -               helper = rcu_dereference(help->helper);
>          rcu_assign_pointer(exp->helper, helper);
>          exp->tuple = *tuple;
>          exp->mask.src.u3 = mask->src.u3;
> 

Just a note, I spend some time trying to apply the patch due to this. 
Drop it before running git am if you are experiencing the same problem.

> 
>   net/netfilter/nf_conntrack_netlink.c | 54 +++++-----------------------
>   1 file changed, 9 insertions(+), 45 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 35f859b24103..ec6771a0926c 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -2636,7 +2636,6 @@ static const struct nla_policy exp_nla_policy[CTA_EXPECT_MAX+1] = {
>   
>   static struct nf_conntrack_expect *
>   ctnetlink_alloc_expect(const struct nlattr *const cda[], struct nf_conn *ct,
> -		       struct nf_conntrack_helper *helper,
>   		       struct nf_conntrack_tuple *tuple,
>   		       struct nf_conntrack_tuple *mask);
>   
> @@ -2865,7 +2864,6 @@ ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
>   {
>   	struct nlattr *cda[CTA_EXPECT_MAX+1];
>   	struct nf_conntrack_tuple tuple, mask;
> -	struct nf_conntrack_helper *helper = NULL;
>   	struct nf_conntrack_expect *exp;
>   	int err;
>   
> @@ -2879,17 +2877,8 @@ ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
>   	if (err < 0)
>   		return err;
>   
> -	if (cda[CTA_EXPECT_HELP_NAME]) {
> -		const char *helpname = nla_data(cda[CTA_EXPECT_HELP_NAME]);
> -
> -		helper = __nf_conntrack_helper_find(helpname, nf_ct_l3num(ct),
> -						    nf_ct_protonum(ct));
> -		if (helper == NULL)
> -			return -EOPNOTSUPP;
> -	}
> -

I wonder if we should return -EOPNOTSUPP here and be explicit about it.

I know the rule is "do not break userspace" but as you mentioned on the 
commit message, this was not really supported. Better just explicitly 
fail so if by any chance someone expects this to work, they will notice.

Other than that, LGTM.


