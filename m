Return-Path: <netfilter-devel+bounces-10713-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HpoDdf9i2kYegAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10713-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 04:56:07 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F512116C
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 04:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1923F302BDED
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 03:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68D34FF67;
	Wed, 11 Feb 2026 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjB1oht4"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA62FCBF0;
	Wed, 11 Feb 2026 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782163; cv=none; b=c2zg6JZn4pQkzcNZ4l9Ei6VJAW8BwBo8j+Xh5OUzOMuj/zDiKyWEGMvDHrMtpcAhikvXOHuryPEnoIG6ol8yvew506350GAHd53wj2kLOD7b/EViIX88GVfpTZUK5Vo0m8sVF/2gqLmVmdf0/EXBdtqDoVCMn47doE4yNf9QaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782163; c=relaxed/simple;
	bh=V0HQ8jM4urK3kh0UIR+xuD+hZmcFkHmmUz561pGmwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouVH1+iShNVDe/C2c622OeXHifizhEkrhZ1Qdc/EN07ZW4drt/48q3BLChasOk6DbS98vrTed94Kuc3jheqPMGDUOU3ttVXOU9BMUu1p2RdwPr5jTjCQRnQXuMR26GUWZuU0VFOb/tkiNGHgRd3DKTsV3SZZIfSvlmGmhw99caY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjB1oht4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4811C16AAE;
	Wed, 11 Feb 2026 03:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770782163;
	bh=V0HQ8jM4urK3kh0UIR+xuD+hZmcFkHmmUz561pGmwNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mjB1oht4khR2Swi3y9rG7du9PIwN5qDlBYmg+mHaLWCtY+BDvA8pOohSTgG3SadBe
	 TmvurEjLOsOX7UOAnPX2VmgCYqm7/EnV1JqDaP0UI17A72QQ61xwhz6HnFx8bO/585
	 tRgzJ54sziDuucGCKzBhniTg2otKdvsXd0u912cEW5ytGfQdP6+WKvjJnwtnsWs/lB
	 B6fKdkVmRjFhhzjiD1OQv7jzaSrU79SsSduhh6H/CS+Y+5q1Oc4QRVL99KxqZHZuna
	 GgE/yiPEER+4+c03C2obiaYl5luqHtnsJbyIxSsYipjtWu9P09cBJfX+eq4++Ug6/o
	 laMOAj9aoayJA==
Date: Tue, 10 Feb 2026 19:56:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH v2 net-next 11/11] netfilter: nft_set_rbtree: validate
 open interval overlap
Message-ID: <20260210195601.16c54ce7@kernel.org>
In-Reply-To: <aYtO3gzm0nRSR91a@strlen.de>
References: <20260206153048.17570-1-fw@strlen.de>
	<20260206153048.17570-12-fw@strlen.de>
	<4d02b8fc-ac17-4fd7-a9dd-bff35c3719e4@redhat.com>
	<aYtO3gzm0nRSR91a@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10713-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D2F512116C
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 16:29:40 +0100 Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > On 2/6/26 4:30 PM, Florian Westphal wrote:  
> > > @@ -515,6 +553,12 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
> > >  	    nft_rbtree_interval_end(rbe_ge) && nft_rbtree_interval_end(new))
> > >  		return -ENOTEMPTY;
> > >  
> > > +	/* - start element overlaps an open interval but end element is new:
> > > +	 *   partial overlap, reported as -ENOEMPTY.  
> > 
> > AI noticed a typo above, should be: -ENOTEMPTY.
> > 
> > Given the timeline, a repost will land into the next cycle. I guess it's
> > better to merge this as-is and eventually follow-up later.  
> 
> Thanks.  Comments are for humans not machines so I think its fine.
> 
> That said, I will try to set up some form of AI code review here for
> future MRs.

FWIW if you have a patchwork where patches are queued and a tree on
kernel.org against which you test -- I can hook up our AI bot to your
patchwork instance.

