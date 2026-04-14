Return-Path: <netfilter-devel+bounces-11869-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDN8NQsh3mk1ngkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11869-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:12:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 816873F92E2
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAE693008D5C
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59939A040;
	Tue, 14 Apr 2026 11:12:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF06392822
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165128; cv=none; b=ixy/kWCBkh6rtLNSy7QKN5qp82SO+yTEZe7LqXZAOGyeLN1AXJExbq1Hb4aAEuK5mMPYRGfCJPhYFwOpJmZg1f/BhGQxcqDhtedHfngIa/u9JkVeYS3RHa2O3FwWnBxAJxOJM76LOomfvh8INbGiRIh6iw7OXaDWVAyAvBne2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165128; c=relaxed/simple;
	bh=dlZx45gGzV7JW5rnpIgAxpeIcAYdiMFddyH2ix+2cMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ9uR7690fMoGQ6ZVR0JdoTGAgilyY+gQMI4IxKmaeLyikbqGg4ua6shyuwbUADm0SzpyRQHWRb8speRW5nmrhmtcIctkHPq7GmOF3j8NeIh5Rv9Aru9Ww/J/CmniXMbOUejFIGEvu/BWri74RqvbqLkbkxosveDZGK2k55pU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 921B8608DB; Tue, 14 Apr 2026 13:11:58 +0200 (CEST)
Date: Tue, 14 Apr 2026 13:11:58 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Xiang Mei <xmei5@asu.edu>, netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>, coreteam@netfilter.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH nf] netfilter: nfnetlink_osf: fix divide-by-zero in
 OSF_WSS_MODULO
Message-ID: <ad4g_guOwNXWxd40@strlen.de>
References: <20260410204843.64259-1-xmei5@asu.edu>
 <adqx_IBgoyAMIJ5I@strlen.de>
 <ad4elUEYrkQ18iX8@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4elUEYrkQ18iX8@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11869-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[asu.edu,vger.kernel.org,nwl.cc,netfilter.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: 816873F92E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> @@ -329,6 +332,15 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
>                 if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
>                         return -EINVAL;
>  
> +               switch (f->wss.wc) {
> +               case OSF_WSS_MODULO:
> +                       if (f->wss.val == 0)
> +                               return -EINVAL;
> +                       break;
> +               default:
> +                       break;
> +               }
> +
>                 tot_opt_len += f->opt[i].length;
>                 if (tot_opt_len > MAX_IPOPTLEN)
>                         return -EINVAL;
> 
> If no concerns, I will post a patch.

Thanks Pablo, LGTM.

