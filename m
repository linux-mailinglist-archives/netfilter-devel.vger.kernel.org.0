Return-Path: <netfilter-devel+bounces-11836-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE8KBmAd3GmAMwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11836-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 00:32:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A718C3E64A1
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 00:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17F823001FD1
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EE309F19;
	Sun, 12 Apr 2026 22:31:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0C43147;
	Sun, 12 Apr 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776033116; cv=none; b=EjhG/8NCqWdiCXrk2l4Djn0c44FD7XYmtlv/HiiiNOetK9GaI/kyyBa9snOrQaDQ2P9q7y1HpAOywsELuw95HO/EDfS2FuZAE3k+fQH2udS9ofGppjDO3k9ej6Mc8PQc0kyBpHXDntXQ6eypyZmxJqTnR6t9mst7q6LCGzq/uHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776033116; c=relaxed/simple;
	bh=VQ0E2CPHBAKyPinm9SCfzHRTKJ0Or0lZ8hhPAVGSE4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUaxzral1olVn2uwJejoaMq2YCiwZE9S6vJpjRpwn9j8Jgd5W/XtdLgAG7YYMpQRYzxShHvHR/1Vl7rOULDzA+Kvg0XGo7d/KP1bS0d8YMRl8ACJnB+EW+GT+CHQuM0wYcyjhuLT1Y4610h7K9rlvp/IHxm1LEnJtGqOO2bDgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E057F60491; Mon, 13 Apr 2026 00:31:51 +0200 (CEST)
Date: Mon, 13 Apr 2026 00:31:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Marko Jevtic <marko.jevtic@codereflect.io>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org, phil@nwl.cc,
	coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] netfilter: nft_set_rbtree: fix use count leak on
 transaction abort
Message-ID: <adwdV0qGeRhSNLuz@strlen.de>
References: <20260412222801.34965-1-marko.jevtic@codereflect.io>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412222801.34965-1-marko.jevtic@codereflect.io>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11836-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A718C3E64A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Marko Jevtic <marko.jevtic@codereflect.io> wrote:
> nft_rbtree_abort() does not handle elements moved to the expired list
> by inline GC during __nft_rbtree_insert(). When inline GC encounters
> expired elements during overlap detection, it calls
> nft_rbtree_gc_elem_move() which deactivates element data (decrementing
> chain/object use counts), removes the element from the rbtree, and
> queues it for deferred freeing. On commit, these elements are freed
> via nft_rbtree_gc_queue(). On abort, however, the expired list is
> ignored entirely.
> 
> This leaves use counts permanently decremented after abort.

I have not seen a reason/answer why this needs to be rolled back.
GC is an implementation detail, its not part of the transaction.

It could also be done from work queue, for example, not just from insert
or commit.

I see no reason to change the existing approach.

