Return-Path: <netfilter-devel+bounces-12934-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ObwD11wGGoSkAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12934-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 18:42:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0745F523F
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7B6130C0109
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3E3F6C2F;
	Thu, 28 May 2026 16:08:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7942202C46;
	Thu, 28 May 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984505; cv=none; b=Cz3nhjvO4ryJfpme34oIZOUhs4eOMzQWf9HGez8frBwSuv4NcVC4UZf6GRrgU6It3X4YfMVe4k6UfBOcNTohS1JkbuYDDOm3YuBUyps5U3PoEMnlzykiaSgiw59cd4sT8bVur9tScs5i6ibM/mebkU9qjBx+gS8qYFSQZH8Yks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984505; c=relaxed/simple;
	bh=Qed73ts4bhhkI9YN/oNaXj0K0g/+yqN5022z0Oro6Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPXMOJT6NoOfBX3x49lfThOd7067smHfxoGRscCaZVyofqEwy1OnXPGqNOAmCUiJvMT+82afIkjo5G+vi9JzRC6Ui7qCAZmLb/EzNEUPt9Pwfdiss8IM2tUMORHDlwLLxVJikfMLoxcOpkA7Ae2/H0YyEwKZgcwFz7GrFKWpf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BF76D60503; Thu, 28 May 2026 18:08:20 +0200 (CEST)
Date: Thu, 28 May 2026 18:08:20 +0200
From: Florian Westphal <fw@strlen.de>
To: Siho Lee <25esihoya@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] netfilter: nft_payload: validate offset for all
 csum_type paths
Message-ID: <ahhodI4Ou64n9HEq@strlen.de>
References: <CAOYEF6nkrD4o_Kw_gxbv7Vefxpp=E6N4X_s-3KEcS1f3Hb1uAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYEF6nkrD4o_Kw_gxbv7Vefxpp=E6N4X_s-3KEcS1f3Hb1uAg@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12934-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: DF0745F523F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Siho Lee <25esihoya@gmail.com> wrote:
> For NFT_PAYLOAD_LL_HEADER, offset is computed as:
>     offset = skb_mac_header(skb) - skb->data - vlan_hlen
> which evaluates to -14 (or -18 with VLAN) after eth_type_trans()
> pulls the Ethernet header. This is a valid negative offset that
> refers to the Ethernet header area (used by bridge/vlan rules).
> 
> However, without any bounds check in the csum=NONE path:
> - skb_ensure_writable(skb, max(offset + priv->len, 0)):
>   max() converts negative values to 0, making it a no-op.

Are you sure?

> - skb_store_bits(skb, offset, src, priv->len):
>   A negative offset that exceeds skb headroom writes out of bounds.

Sure, but how can that happen?  This should be explained here,
because I am NOT seeing a bug in the first place.

> Add proper validation after the csum condition block:
> - Negative offsets: ensure they fall within skb_headroom(skb)
>   (bridge/vlan rules legitimately access the Ethernet header)
> - Positive offsets: ensure offset + len does not exceed skb->len

Large offset/len should make skb_copy_bits return an error.

> Also remove the max() wrapper from skb_ensure_writable() since
> the new validation guarantees the offset is within range.

No, this patch still breaks test cases we have.  Please figure out
if there is a bug in this code, and if there is, explain it in a way
that I can understand (e.g. provide broken example that triggers OOB).

Then, git clone https://git.netfilter.org/nftables and make sure the
tests pass.

> +	if (skb_ensure_writable(skb, offset + priv->len) ||

ensure_writable has unsigned arg, so this -14 + 6 will asks for
4GB and this aborts here.

