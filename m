Return-Path: <netfilter-devel+bounces-13455-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q/aJEJNGPGo2mAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13455-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 23:05:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA76C156E
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 23:05:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13455-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13455-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72B30307326C
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F143E5578;
	Wed, 24 Jun 2026 21:00:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C835BDDB;
	Wed, 24 Jun 2026 21:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334830; cv=none; b=ruea8zSZMkhzajwXtHPMPLGBi8w3Ry0mYFGuRJHIcaQZzXr5v9cvw2uMHyjMG2WvEJWE9BwKAd3kOgwjyIWaqQdPemQDIk0saFUsByR2Q5mvJwCxRWJIUu27/zw0esirHgF4b2dWpow4rq1O4BvezReDr8tvuFSYlNQ12BpKR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334830; c=relaxed/simple;
	bh=dPgf/IJ9qzzwy8zDMuHuLckZCQqxfojfxbU/z3DkVA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJji1i49HW+3xQIfnmtqOn3khByuqd3d7arIaoTroLMqShVAURU4PdAJ78Mu/QaawzbDBWlBSJtdVk5p40148Hw01jhL5rrKD1z/aqUcpVRtI/9S/2x/YPEATf+48JTpyebQhrD5hK8JienxOykOa1+Bcpvyn58oflphVuPtX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0FE6E602A9; Wed, 24 Jun 2026 23:00:27 +0200 (CEST)
Date: Wed, 24 Jun 2026 23:00:26 +0200
From: Florian Westphal <fw@strlen.de>
To: Carlos Grillet <carlos@carlosgrillet.me>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next 1/4] netfilter: nf_conntrack_sane: replace
 u_int16_t with u16
Message-ID: <ajxFah1khNl5brEl@strlen.de>
References: <20260624184036.71051-1-carlos@carlosgrillet.me>
 <20260624184036.71051-2-carlos@carlosgrillet.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624184036.71051-2-carlos@carlosgrillet.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:carlos@carlosgrillet.me,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-13455-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime,carlosgrillet.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0AA76C156E

Carlos Grillet <carlos@carlosgrillet.me> wrote:
> Use preferred kernel integer type u16 instead of the POSIX u_int16_t
> variant.
> 
> No functional change.
> 
> Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
> ---
>  net/netfilter/nf_conntrack_sane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_conntrack_sane.c b/net/netfilter/nf_conntrack_sane.c
> index 39085acf7a71..130b3e68090e 100644
> --- a/net/netfilter/nf_conntrack_sane.c
> +++ b/net/netfilter/nf_conntrack_sane.c
> @@ -35,7 +35,7 @@ MODULE_DESCRIPTION("SANE connection tracking helper");
>  MODULE_ALIAS_NFCT_HELPER(HELPER_NAME);
>  
>  #define MAX_PORTS 8
> -static u_int16_t ports[MAX_PORTS];
> +static u16 ports[MAX_PORTS];

These port variables are useless and will be removed soon.

