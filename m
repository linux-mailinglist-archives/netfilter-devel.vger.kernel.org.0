Return-Path: <netfilter-devel+bounces-10832-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEAsKVennGksJwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10832-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Feb 2026 20:15:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2B17C29F
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Feb 2026 20:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C684A3026519
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Feb 2026 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E036AB50;
	Mon, 23 Feb 2026 19:15:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE936A034;
	Mon, 23 Feb 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874126; cv=none; b=ebJEorhATNqnAChoe8Vwhg99Ne3gN8Nn3zq4sSkgJ4aBYZchFAlOFJZhOSaxgZCEwaYlElaD+DQ7KYrF8pmovPYCtcis+TlRjaPHd7bzV8lzDaDtVTGznmeH5EZUrHeJdMZC/7PZKsnoGjkN/4I0I732YNXUBeqqBFTYFPhj1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874126; c=relaxed/simple;
	bh=euGYXGgYWMyZMGsz4MxkxdkxaAM2S/q1TAQT4GS79vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJeMdTZx6zLphhK6mdmwCaNe8/TKP6e/TGtmFX2lpgN5amUJaCXe5tmzLjrie4YzwSDJe4qJiPo3ZEudw1JloE1S2KTOJTkG6LDcncRGUJExIqciCTzJkngzrkkSQ7Q8L8I+Li6EwCT7k2vwuUiMATWlcsU6/Ht+AZRC/hFTBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 929E56033B; Mon, 23 Feb 2026 20:15:22 +0100 (CET)
Date: Mon, 23 Feb 2026 20:15:22 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH v18 nf-next 4/4] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
Message-ID: <aZynSuGMtK7JOOCj@strlen.de>
References: <20260222195845.77880-1-ericwouds@gmail.com>
 <20260222195845.77880-5-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222195845.77880-5-ericwouds@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10832-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.909];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63E2B17C29F
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
> and packets encapsulated in single 802.1q or 802.1ad.
> 
> When implementing the software bridge-fastpath and testing all possible
> encapulations, there can be more encapsulations:
> 
> The packet could (also) be encapsulated in PPPoE, or the packet could be
> encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
> encapsulation.
> 
> nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
> known from the conntrack-tuplehash. To access the header it uses
> nft_thoff(), but for these packets it returns zero.
> 
> Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
> offsets.
 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
> index d4d5eadaba9c..66ef30c60e56 100644
> --- a/net/netfilter/nft_chain_filter.c
> +++ b/net/netfilter/nft_chain_filter.c
> @@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
>  #endif /* CONFIG_NF_TABLES_IPV6 */
>  
>  #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
> +static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
> +				  const struct nf_hook_state *state,
> +				  __be16 *proto)
> +{
> +	nft_set_pktinfo(pkt, skb, state);
> +
> +	switch (*proto) {
> +	case htons(ETH_P_PPP_SES): {
> +		struct ppp_hdr {
> +			struct pppoe_hdr hdr;

Hmm, this seems to trigger warning on NIPAs build_allmodconfig_warn test:

../include/uapi/linux/if_pppox.h:153:29: warning: array of flexible structures

Would you mind a new version?  Its the last patch, so I leave it up to
you if you want to resend the whole series or just 4/4.

Sorry, I did not have time to run the entire test pipeline with the
pending patches until today.

