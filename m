Return-Path: <netfilter-devel+bounces-11068-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDOFEGo7r2kPQQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11068-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 22:28:10 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97E241ABC
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0337306C511
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2026 21:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20734404E;
	Mon,  9 Mar 2026 21:22:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C007344056;
	Mon,  9 Mar 2026 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091334; cv=none; b=Wksg1DOLNM1nXxsfjxgLdjDs8QI4d40bMEQKcBIiijkup+Aca6Ya/fVH+Ch6/uUgF/GIFojQGRkCET3Szw2JYjJDM/yjIN78d1e7+HcmYWU0hOkAS6cpVI239gk9UVxsxF0ZbVG6fRcdhRjLqjku6crMMaI52Tz4y/y1kDf11VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091334; c=relaxed/simple;
	bh=d90gpbBPC3PluRAYfjB6TkGxh4phVO9cEThq8OWp0l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEFelsmCSCZH6SPViFnn1zbtfYLbAruTmWHdOhva3Z0kPPqo/ENjW/dbOfOBM6OBlcnl3BFdc+/R2Bexh71nL+DR8nmhCVyukqNA+LvUd1G54bmz7HzPCTAHVptF1D/3d+VllWTYyCirkKW6rRRYThqITy76V/rjdePehPj0bMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5A05E60D39; Mon, 09 Mar 2026 22:22:10 +0100 (CET)
Date: Mon, 9 Mar 2026 22:22:10 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 nf] netfilter: nf_flow_table_ip: Introduce
 nf_flow_vlan_push()
Message-ID: <aa86Ai1FRuJzthEF@strlen.de>
References: <20260227162955.122471-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227162955.122471-1-ericwouds@gmail.com>
X-Rspamd-Queue-Id: CB97E241ABC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11068-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.943];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:

Hi Eric

> With double vlan tagged packets in the fastpath, getting the error:
> 
> skb_vlan_push got skb with skb->data not at mac header (offset 18)
> 
> Introduce nf_flow_vlan_push(), that can correctly push the inner vlan
> in the fastpath. It is closedly modelled on existing nf_flow_pppoe_push()
> 
> Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
  
> +static int nf_flow_vlan_push(struct sk_buff *skb, __be16 proto, u16 id)
> +{
> +	if (skb_vlan_tag_present(skb)) {
> +		struct vlan_hdr *vhdr;
> +
> +		if (skb_cow_head(skb, VLAN_HLEN))
> +			return -1;
> +
> +		__skb_push(skb, VLAN_HLEN);
> +		skb_reset_network_header(skb);
> +
> +		vhdr = (struct vlan_hdr *)(skb->data);
> +		vhdr->h_vlan_TCI = htons(id);
> +		vhdr->h_vlan_encapsulated_proto = skb->protocol;
> +		skb->protocol = proto;
> +	} else {
> +		__vlan_hwaccel_put_tag(skb, proto, id);
> +	}

I did not apply this because I'm not sure if this preserves correct tag
order.  Can you clarify?

Lets consider vlan-offload-doesn't-exist case.

First loop pushes vlan tag 1, we get:

  [vlan1][inet]

2nd items pushes vlan tag 2, we get:
  [vlan2][vlan1][inet]

Now lets consider with-offload.  We have one tag only, so we get 1 skb with hwaccel
tag in the sk_buff.  This is fine, HW will insert it for us.

But now lets consider two tags:

First loop pushes vlan1, we get the vlan1 tag in sk_buff vlan info.
Packet is: [inet].

2nd loop pushes vlan2, we get:
	[vlan2][inet].

Now, when packet is transmitted, where will the HW insert the tag?

[vlan1][vlan2][inet]?
Or will this be [vlan2][vlan1][inet]?

reading though the SW-side (no hw support), it seems it will do the right
thing (i.e.. the hw tag gets added as the inner tag, right before inet
and not added as outermost tag.

Can you confirm thats the case?

Sorry for not responding sooner, there are lots of patches atm and
I forgot about this one when I yanked it off the previous pull request
at the last second.

