Return-Path: <netfilter-devel+bounces-10980-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHgIG7eqqGmfwQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10980-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 22:57:11 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B48520838B
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC64302204E
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B2391844;
	Wed,  4 Mar 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="T1VgREoe"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746826CE11;
	Wed,  4 Mar 2026 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661427; cv=none; b=XgN206lQ3NxQ8280hlKHxDHDA+JOtsPO7xKauBilsZpH3hKPrO9rUJ32/z5I2EkSBkXNGrPwbmw6ortYVydiGwEzhG9GP7GeIYdBEtXdA1e2TQRgH0l63LKD+M+aEMwNAqsKy49/XpzkV3FHNeW/DSkQz4YK2DNANSHswAaxOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661427; c=relaxed/simple;
	bh=bazpq+SK+eoSsQxMUAjR0z1xDF+0vDKXWPNbWnOt65M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/NiDmZAhZM62gYwgCoLCr5XsrYPUf2ZzMe2RvEXdImTq69VsIBMWPE82AFeGtsANymNCaHHwVGZlc9sBPl2TqXkobGpcpBTnYVtOF9EUlVftbW5nQzlyGQRY1a9r5h4fzfT778uFQzWH0u1dQ9La1lqNoQ7emLPzqsm14hxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=T1VgREoe; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id D65BA60251;
	Wed,  4 Mar 2026 22:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772661423;
	bh=NZcQ+LOkyu6s20xwD3Bz2rY2z596cUhb0rAmyG47cpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1VgREoeiBgiv/Z41ARc6LbmDPM63wse5ULAlEPTEtoVreap9B1bTJ8lC3Z0C8sSt
	 IRXmzSSnY2LAd6iK7Ia9fv+LZBa5gPd5OGUuGJNNGsIQVhKrlfK2PHvYSksWqT8iEi
	 fKkXOk+SVa12adKEz8QbK2Q2NGDhlys0rVYNiCamCGs86tyu66pBN1jfsxbTAHO7oD
	 cDW8vjhSTuWhkawO8H+blO2C8vU7BC2KtOhUALfmC2ibdE7CV9jJkEpBlG7Y6PTrPg
	 VG5jSN3oSD91lWrxgqf/YmU7/QfyMqR7XX5q+BDkNzSZEdA3h3NT+PRuJ+VEtvK8Rd
	 LNhaj/bXdOpZQ==
Date: Wed, 4 Mar 2026 22:57:00 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net 0/4] netfilter: updates for net
Message-ID: <aaiqrFrus1syOmlT@chamomile>
References: <20260304172940.24948-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304172940.24948-1-fw@strlen.de>
X-Rspamd-Queue-Id: 0B48520838B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-10980-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Florian,

On Wed, Mar 04, 2026 at 06:29:36PM +0100, Florian Westphal wrote:
> Hi,
> 
> The following patchset contains Netfilter fixes for *net*:
> 
> 1) Fix a bug with vlan headers in the flowtable infrastructure.
>    Existing code uses skb_vlan_push() helper, but that helper
>    requires skb->data to point to the MAC header, which isn't the
>    case for flowtables.  Switch to a new helper, modeled on the
>    existing PPPoE helper. From Eric Woudstra. This bug was added
>    in v6.19-rc1.

In patch 1/4, why is this new function so different wrt. skb_vlan_push?
 
int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
{
        if (skb_vlan_tag_present(skb)) {
                int offset = skb->data - skb_mac_header(skb);
                int err;
 
                if (WARN_ONCE(offset,
                              "skb_vlan_push got skb with skb->data not at mac header (offset %d)\n",
                              offset)) {
                        return -EINVAL;
                }
 
                err = __vlan_insert_tag(skb, skb->vlan_proto,
                                        skb_vlan_tag_get(skb));
                if (err)
                        return err;
 
                skb->protocol = skb->vlan_proto;
                skb->network_header -= VLAN_HLEN;
 
                skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
        }
        __vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
 
 
In case there are two VLANs, the existing in hwaccel gets pushed into
the VLAN header, and the outer VLAN becomes the one that is offloaded?
 
Is this reversed in this patch? The first VLAN tag is offloaded, then
the next one coming is pushed as a VLAN header?

Thanks.

