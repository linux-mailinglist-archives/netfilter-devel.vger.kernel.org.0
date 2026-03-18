Return-Path: <netfilter-devel+bounces-11273-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLuFEYzUummfcAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11273-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 17:36:28 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B33192BF5C6
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15B3331A45C1
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671E29AB00;
	Wed, 18 Mar 2026 15:50:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE7194C98
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849010; cv=none; b=NZ3HCJ8xzPPpv9Th1eOXe/dQzEglwICugO2CcwnyULjLgrQ8H84Lomp1ZwwkpwR4SL2Ym74GNCeT1whJBszVRYdyvLxWJw1/eakA1NWtTSaqtEwK1Vc5nrVTdVIu7JgDsxNnrfIlexyPpelIIw1ThMECFp8Xq4OsSbmYIMDV5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849010; c=relaxed/simple;
	bh=nRC98jvHWdkdWwIgs0/ZvzJOJvgB+vAjP0ymRwhYLrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv5Jv9Rcb0ZS2g0QcRSMQjaHWsadSWPTKl7PDdLA1TWaq5LhXW7PF45ih0l1S/nH3S4Zi+L242MGaL8mvJx2Qk0enbcxkQBOu5v7dFSQ3QiRNnIVJgt1jzPg42/SGMXjOyQLEtk4DTwNB+tfkRhva6/5eHY093bevY6WzRfQljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3BEEA605C3; Wed, 18 Mar 2026 16:50:05 +0100 (CET)
Date: Wed, 18 Mar 2026 16:50:00 +0100
From: Florian Westphal <fw@strlen.de>
To: Chris Arges <carges@cloudflare.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v4] netfilter: nft_set_rbtree: revisit array resize
 logic
Message-ID: <abrJqK4aQWzlInCL@strlen.de>
References: <20260317170721.12396-1-pablo@netfilter.org>
 <abrI8CZV3c8fi9x3@20HS2G4>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abrI8CZV3c8fi9x3@20HS2G4>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-11273-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.727];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:email,netfilter.org:email,strlen.de:mid]
X-Rspamd-Queue-Id: B33192BF5C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chris Arges <carges@cloudflare.com> wrote:
> > Reported-by: Chris Arges <carges@cloudflare.com>
> > Fixes: 7e43e0a1141d ("netfilter: nft_set_rbtree: translate rbtree to array for binary search")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > v4: use maybe_grow: goto tag instead of grow:
> >     Add note in commit description: "The shrink logic is skipped by anonymous sets."
> > 
> 
> I will be able to testing this more in depth early next week.

Thanks, I will hold off on this patch and will defer it to next week
then.

