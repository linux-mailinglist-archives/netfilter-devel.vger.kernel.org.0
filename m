Return-Path: <netfilter-devel+bounces-12930-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMafBUpPGGpMiwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12930-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 16:20:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E085F399C
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CE58302D1AE
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C94317171;
	Thu, 28 May 2026 14:12:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB92E2852;
	Thu, 28 May 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977551; cv=none; b=KniP41cYWc3tlEHMQu69qEzYRhhTmqQ3oR8D8X1n8qPu43B3oD1o4gGH4I0QX5jENC8TgnaCILQVPdb97DAL/ZgL31jpjYKL51W8RrplIQ1hZDMIeqvZtJVcRq+qYw7uom2oFv91gu2MlmHiKvRALuEkfh5qnu6gLfIl6rARPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977551; c=relaxed/simple;
	bh=cP2kA8+YYchg2ex0Elvu/5FOstG60ZZc/wj3YLEwDNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+uHYCxtC3XDjpTWtqP5aVZ0c5z157j/+xIDyWIWStg1W7hS0oO3zm9ipP8NpenTF7hG7ssfNkKvknPmQh7Jgq37WqGhe2DQr5B6/blX6cbAtp2jW4v9og4coiixI3/zZJdqKH4D/Lj4uIJJX6cbz7PxO6xuzeL6ln9dN3spaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 611D460551; Thu, 28 May 2026 16:12:26 +0200 (CEST)
Date: Thu, 28 May 2026 16:12:26 +0200
From: Florian Westphal <fw@strlen.de>
To: Siho Lee <25esihoya@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nft_payload: move offset bounds check
 outside csum condition
Message-ID: <ahhNSscKHjx7bebv@strlen.de>
References: <CAOYEF6nf5-B-P7DHf_cpLaqUSoZC2FJphBqE2s4zE8MygMCb_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYEF6nf5-B-P7DHf_cpLaqUSoZC2FJphBqE2s4zE8MygMCb_g@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12930-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: B2E085F399C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Siho Lee <25esihoya@gmail.com> wrote:
> From 574604a1b4a98ee130d7f727ad3c8a7df3f3b6f1 Mon Sep 17 00:00:00 2001
> From: Siho Lee <25esihoya@gmail.com>
> Date: Thu, 28 May 2026 22:39:03 +0900
> Subject: [PATCH v1] netfilter: nft_payload: move offset bounds check outside
>  csum condition
> 
> The bounds check for offset + priv->len was placed inside the csum
> condition block. When csum_type is NFT_PAYLOAD_CSUM_NONE and
> csum_flags is 0, the entire block including the bounds check is
> skipped.
> 
> For NFT_PAYLOAD_LL_HEADER, offset is computed as:
>     offset = skb_mac_header(skb) - skb->data - vlan_hlen
> which evaluates to -14 (or -18 with VLAN) after eth_type_trans()
> pulls the Ethernet header.
> 
> Without the bounds check, a negative offset reaches:
>     skb_ensure_writable(skb, max(offset + priv->len, 0))
>     skb_store_bits(skb, offset, src, priv->len)
> 
> max(-14 + 4, 0) == 0 makes skb_ensure_writable a no-op, and
> skb_store_bits(skb, -14, ...) writes to skb headroom (OOB write).
> 
> The signed-unsigned comparison in the bounds check correctly catches
> negative offsets: (unsigned int)(-10) is a large positive value that
> exceeds any valid skb->len.
> 
> Move the bounds check outside the csum condition so it applies
> regardless of csum_type/csum_flags.

This breaks link layer update support.

# cd git/nftables/tests/shell
# NFT=nft ./run-tests.sh testcases/packetpath/bridge_pass_up C
W: [FAILED]     1/1 testcases/packetpath/bridge_pass_up

