Return-Path: <netfilter-devel+bounces-10565-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAqJG2mmgGlNAAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10565-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 14:28:09 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACACCB7D
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79216308130B
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Feb 2026 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC48367F37;
	Mon,  2 Feb 2026 13:24:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F8366DD2
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Feb 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038648; cv=none; b=hifz/DsHUWkd5awUL2Vu7949iO2FJ0T1Q1M1wRbOxgJrCtymWqoUusb0cS3y+4yWVLm7iIorow6vNcCDOfFsUdi36yEJ+4LHDzId1ZVX9+Zv7f8HybJCEMRk+EQied70ys3GBmYe9cbmzM0wkYeWqOdPMl9ukiq7N821CnR1kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038648; c=relaxed/simple;
	bh=fTE+LrA6znS42xZ0QM+GMFN4Ipbmy3rZoOKlX1ZcqCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaVifU0m6iCxkkGVbkleqAGfq5CA2R6Zf79+sMRoo5ie5WhMMDy9/sd6L9wMSTt46iYqKQ7bithNjzin48aiQ/YPPI63G580QDqd/KzQ/Il6p6VCP9aTQABbjdMhtUkmyengYMjxFy1V45ErFuIBbLYFrQTNOYwRkonmaieckQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DF5256033F; Mon, 02 Feb 2026 14:23:58 +0100 (CET)
Date: Mon, 2 Feb 2026 14:23:53 +0100
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	syzbot+d417922a3e7935517ef6@syzkaller.appspotmail.com
Subject: Re: [PATCH nf-next] netfilter: nft_set_rbtree: don't gc elements on
 insert
Message-ID: <aYClaSuzZYAj5P9W@strlen.de>
References: <20260129172842.6310-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129172842.6310-1-fw@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel,d417922a3e7935517ef6];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10565-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: 20ACACCB7D
X-Rspamd-Action: no action

Florian Westphal <fw@strlen.de> wrote:
> During insertion we can queue up expired elements for garbage
> collection.

This fix is incorrect.

> +	/* Can GC when we rebuild the binary search blob. */
> +	if (time_after_eq(jiffies, priv->last_gc + nft_set_gc_interval(set)))
> +		nft_rbtree_gc(set);
> +

This posts elements via call_rcu.  But we don't hold rcu read lock.

cpu0					cpu1
  nft_rbtree_gc();
  call_rcu -> elements are free'd
					rcu_read_lock();
  					rcu_dereference(priv->array);

  rcu_replace_pointer();
					cpu1 operates on old blob, UaF.

nft_rbtree_gc() has to be split into
a scan phase and a reap phase, where scan phase unlinks and
relinks to the private list, and reaping happens after
the call to rcu_replace_pointer().

Sorry about this, I forgot call_rcu can fire instantly if there are
no readers.

