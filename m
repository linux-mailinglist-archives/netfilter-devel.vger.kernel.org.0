Return-Path: <netfilter-devel+bounces-11304-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOmhDnghvGnQswIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11304-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 17:16:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23AA2CE966
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C363832CE6C5
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA93EAC67;
	Thu, 19 Mar 2026 16:04:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C183E95B2
	for <netfilter-devel@vger.kernel.org>; Thu, 19 Mar 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936267; cv=none; b=p2qtr2yJ95/wHGb0AbGbOOSk4R0x9tGFbVY8Rs4Ok+cRFvYj78tMfyPI2Txn1Gz9zF903oABEkH/jP/bxYRWGcUke4NkjaDyHR6YqC7sjmQZyfMhPhRzaz0JgUC0FcQ54mVyQ1nRM9CIPIXGioZPMis32WN3YzfGIrfiC/kHmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936267; c=relaxed/simple;
	bh=1pvVf/fLO9BCOfPUwNbcip3uWMVq3AYH6qWZ/pQNIQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jut6hkrCMQwgHAwbn8VK8d8wlnuTona9+OOedhMAYL9FTu4WJRDrPOiIquHyq/BOcM6pTWbp/wU67bXoFkTUeYxswrdYp7R56rq0HZ+aRZu5VgFAbmJykWjF6gNQEHKvd1F6IxRyLi3GN2bawDjmjoCaUIWDVqtRKRvkvtJXxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 44284606E1; Thu, 19 Mar 2026 17:04:18 +0100 (CET)
Date: Thu, 19 Mar 2026 17:04:18 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: nfnetlink_hook: Dump nat type chains
Message-ID: <abwegj2TijkaQVLz@strlen.de>
References: <20260313153220.19662-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313153220.19662-1-phil@nwl.cc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-11304-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.701];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:email,strlen.de:mid]
X-Rspamd-Queue-Id: C23AA2CE966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> These chains are indirectly attached to the hook since they are
> not called for packets belonging to an established connection.
> 
> Introduce NF_HOOK_OP_NAT to identify the container and dump attached
> entries instead of the container itself.

Please lets not do this.

Before:

        hook postrouting {
                +0000000100 nf_nat_ipv6_out [nf_nat]
                +2147483647 nf_confirm [nf_conntrack]
        }

After:
        hook postrouting {
                +0000200000 chain inet nat postrouting [nft_chain_nat]
                +2147483647 nf_confirm [nf_conntrack]
        }

... and thats not true.  The nat chain isn't hooked at 200000.

It hooks at +100, this is a dispatcher.
Concealing the actual hook location and then unrolling the embedded
nat hooks gives a wrong impression and will mislead users wrt. the
actual ordering.

If we really want the ability to list the nat hooks, I think this
needs a new command to dump them.

