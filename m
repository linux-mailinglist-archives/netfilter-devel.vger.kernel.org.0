Return-Path: <netfilter-devel+bounces-11316-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDzTLIQrvWmI7QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11316-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:12:04 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7922D95A8
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8E5B3009F0E
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9E38D682;
	Fri, 20 Mar 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="KzoX5obv"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086D3803DC
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005104; cv=none; b=R26Alu11kIeUTDim4XY8DqYhImtGXXzuw1uTxnmRvsTFNURA2687yeHDy91l4qbw+fuF58pwmw/TVwuNNI7q8I/tasBsRMQuzmVg9iKVqIQ5Ujv065E9X7hy2yOIa4ZOJuQ+5+D1U6aK4KRpMyjwsjvtzWJMatAsZFPoAc74JqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005104; c=relaxed/simple;
	bh=1bfx3YP0wGIl+U7CIUPG4i5J4a1CPltHbtNuLwbzku8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEt7rNeKdQr36lEAG70XL/kLll0iVL+h82ELp2Hnh9GQgxPwI/TiYVrdTtEAGrSo5fkBYPaRMrR9BXVgDsyo1RPN9EzqnnmlETJRseuZTx2v6+bYlK4OrThyGNodKAECEYxnqTB3G94EPpLtORWNQcAF35EHltjDF09T43Yvrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=KzoX5obv; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1bfx3YP0wGIl+U7CIUPG4i5J4a1CPltHbtNuLwbzku8=; b=KzoX5obvkAsLoc0A0nrAB14cok
	iAUy2BfByb2F10xHJZn5Njwcj8xZgIxl3+LrSjiEQUy6Oan22NZbU07xf1bNEAngsDE4KWr495/U1
	r0Yg+wXN7HbI8OcsJG0CO8cgR2yd5c8sp5ytzLNjAjiIjoSADfxy0+TOrdIlrWQZvbtcJhUSX4x0X
	9TGciwBuwASD988aSStbKLKV74UzVK1qiIA9SA3KMP1/JE/bfkCveNXQa8JEhKbHaKbTXEDLiTBS7
	QibsOYjgJOSl19EJvtcBpnEK7G6Bhy9+I92QacrRJ1Rza9oWw241jm8ZxgAuXRFNXIAljbhJoaHQd
	0wCez0dg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w3XlV-000000006hu-05iC;
	Fri, 20 Mar 2026 12:11:41 +0100
Date: Fri, 20 Mar 2026 12:11:41 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: nfnetlink_hook: Dump nat type chains
Message-ID: <ab0rbTfE7LWIk7f-@orbyte.nwl.cc>
References: <20260313153220.19662-1-phil@nwl.cc>
 <abwegj2TijkaQVLz@strlen.de>
 <abwraHUuxizN4krg@orbyte.nwl.cc>
 <abwtAkSF8-SmH684@strlen.de>
 <abxlzn7lymOxWUFa@orbyte.nwl.cc>
 <abyTyJBv47f3v9gd@chamomile>
 <ab0enMtOAFiG0mSN@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0enMtOAFiG0mSN@orbyte.nwl.cc>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11316-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.228];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AC7922D95A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 11:17:00AM +0100, Phil Sutter wrote:
[...]
> A remark from a practical perspective: Florian's suggestion to dump the
> nat-type chains in their order with the dispatcher's priority value is
> super-easy to implement (just have to pass the priority value to
> nfnl_hook_dump_one() via parameter) and does not require adjustments in
> user space.

Famous last words. :(

In fact, user space calls basehook_list_add_tail() for each received
hook message which (contrary to its name) inserts sorted by ascending
priority value. It does this by skipping as long as the cursor's
priority is lower than the new element's, i.e. hooks with same priority
value are inserted in reverse order than received. This is a no-go since
ordering matters, right?

Cheers, Phil

