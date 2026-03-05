Return-Path: <netfilter-devel+bounces-10997-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIthD0qLqWl3/AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10997-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 14:55:22 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9170212D97
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D0483032062
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2026 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B93A5E7D;
	Thu,  5 Mar 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="DVerCy4g"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92B39F17C
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Mar 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718894; cv=none; b=kMGqi64aQVTXZ5A2iD7pxoCsjvPD0AggXIfwXIfkMKF/nlsEnXogxiWFXLTCt2w1KHIwBEhQutlohSL/NSI5QyA+tuNrpMsLKGK77CYO1mwZ6e1DMQO1aDV7K/dNumdzwlZ0WVW/U81Q97l+C/eHHNpghdGl+4sZe/E+pTcUZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718894; c=relaxed/simple;
	bh=/xjXG4Zq7K5g+p7w4ym9nsF2VF5GX0Wr7wsTwW/Fjdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeiaW8cCdXrfZUMqlpAp21um+1RH0hKQiTvla+zj68BHJs4hP6iso/+PISG+weft/jHWGdF7IM0axzVU6uSVdcMrmBq+DV0fZffy6mzmr/Di2Ez+GpgW5hL+1XIdtAFWplcLkEJqzN/nne3OH0WvpmNi53v1eeGUM5siytDDBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=DVerCy4g; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rkTIdy8fNxm4iHVmiYkCpIt0JvH/FSCuzXdSNkQxPXg=; b=DVerCy4gn43+DHzaVq7G9Sl2V/
	/KySkQseUrma5JLtsV7MvIyD1oo7s6k/Ci8xtQkLuz+PZTpiH8Jvv6Hy4BOAZurbY3jeSAr6b50Fu
	UBdKFAo49QL8sq38xZgyNjYwXpKHMQTKKViI0QQ7wmuqygy3jXJtqekZaKzoCDJMuBThQ9zN9tXPq
	2sDopQykPArTJADxICNPsc1ByxzsY54cIkQEASvNgWGT7qtA/q/LWfVYBaZrN8cSpqK3CBprr9mp4
	bs/7J9WYNAIIIBfliHy2ufzsebJIJsA8JFla9WUWOJUAAva5/2a96Mv6sEp8Cb8O8ffBFsPVlYxbO
	jHpZ9lIA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vy9A4-000000001Bv-1d5A;
	Thu, 05 Mar 2026 14:54:44 +0100
Date: Thu, 5 Mar 2026 14:54:44 +0100
From: Phil Sutter <phil@nwl.cc>
To: Helen Koike <koike@igalia.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
Subject: Re: [nf PATCH] netfilter: nf_tables: Fix for duplicate device in
 netdev hooks
Message-ID: <aamLJOYJNYcHwHzG@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Helen Koike <koike@igalia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
References: <20260305120144.26350-1-phil@nwl.cc>
 <2c103e29-961c-4063-a757-c51367da8e60@igalia.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c103e29-961c-4063-a757-c51367da8e60@igalia.com>
X-Rspamd-Queue-Id: E9170212D97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10997-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.719];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	TAGGED_RCPT(0.00)[netfilter-devel,bb9127e278fa198e110c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url,nwl.cc:email,appspotmail.com:email,strlen.de:email,igalia.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:24:54AM -0300, Helen Koike wrote:
> On 3/5/26 9:01 AM, Phil Sutter wrote:
> > When handling NETDEV_REGISTER notification, duplicate device
> > registration must be avoided since the device may have been added by
> > nft_netdev_hook_alloc() already when creating the hook.
> > 
> > Cc: Helen Koike <koike@igalia.com>
> > Suggested-by: Florian Westphal <fw@strlen.de>
> > Reported-by: syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=bb9127e278fa198e110c
> > Fixes: a331b78a5525 ("netfilter: nf_tables: Respect NETDEV_REGISTER events")
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> I tested and validated this fixes the use-after-free as reported by syzbot.
> 
> Tested locally with Qemu using the disk image and reproducer from syzbot.
> 
> Tested-by: Helen Koike <koike@igalia.com>

Thanks for testing, Helen!

