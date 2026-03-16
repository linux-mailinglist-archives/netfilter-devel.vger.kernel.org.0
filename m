Return-Path: <netfilter-devel+bounces-11227-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBc8Fhf5t2n1XgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11227-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 13:35:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07FE2998D7
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F121D300E3B7
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692E386569;
	Mon, 16 Mar 2026 12:35:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB5231A21
	for <netfilter-devel@vger.kernel.org>; Mon, 16 Mar 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664528; cv=none; b=XHqPsGC/mgoVOkcu4XGoQa02GWY3YnE1yjRlB5XE5G2lv41TVC5FXF8sk0TizyNpFI8BpIDcsBfqZ59+A8hDAuW5Ncn6O0ysFtUdcAGazhRlW/jxj6T7kWj1suebr5J+L1qxCJNVVXX0XPQ4LRJyt5iA7IBNH9JEyYACFrZi+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664528; c=relaxed/simple;
	bh=rYcPnuGJLZoJM9iqurdTr1VzlsrVSAvzak732A7Phbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC2s187DREhn6yv0E49VdWVzNlixGrpirH59X/XdTXckEbQ1NiZQrpL55J3sh+iOBNdDq0Wib7BcXWQzQvDih2/px3Fpm9iUwHw/L7oNzvh9k+c+oB9+evU7XtyI0BN8B0lEYqjLoOuIG+CXUjKdU3VYeMvLdSsodsgCYjM2Vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8909D605C3; Mon, 16 Mar 2026 13:35:24 +0100 (CET)
Date: Mon, 16 Mar 2026 13:35:24 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, carges@cloudflare.com
Subject: Re: [PATCH nf,v2] netfilter: nft_set_rbtree: revisit array resize
 logic
Message-ID: <abf5DO7J4xXEb1qZ@strlen.de>
References: <20260316114835.3834812-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316114835.3834812-1-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-11227-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.920];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,strlen.de:mid]
X-Rspamd-Queue-Id: E07FE2998D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Chris Arges reports high memory consumption with thousands of
> containers, this patch revisits the array allocation logic.
> 
> Start by 1024 slots in the array (which takes 16 Kbytes initially on
> x86_64), and expand it by x1.5.

Do you think it makese sense to start with set->size for anonymous sets?
I suspect most anon sets are pretty small, 16kb / rule is a lot.

No need to send a v3, this could be done in a followup patch.

