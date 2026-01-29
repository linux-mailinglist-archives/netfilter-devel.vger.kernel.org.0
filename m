Return-Path: <netfilter-devel+bounces-10514-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JJ6JaV1e2mMEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10514-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:58:45 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB0B13A6
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2C853004621
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E95284689;
	Thu, 29 Jan 2026 14:58:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E61E0B86
	for <netfilter-devel@vger.kernel.org>; Thu, 29 Jan 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698723; cv=none; b=MxvheXQ/BafQbEdwOXv2+Yvp5vK48vaJgeABKL3K6fohAJ2ktBl92+6wd39nOqgOc4WjgdLu0s6lbpd+wqWccZG0wSwcepgcQqikrXsLj7ZlMiaIMG7gaXkjgHnZSW0pv0vxaAyG9eZZ4UxedBkNFY9+CU3mQ63ncdAAVP9kmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698723; c=relaxed/simple;
	bh=MztOz9yVHgGNDgLvioZcdlJC3wY5FSemXUM0NJYjNf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4KmR4hNu9kMyY0yS2AklIhX0mrfFl7i54hrTVLzIjbuTIyiRJVeN31vyV3zbIqqYURXHfeNnJb+c2D42kQnDoc+jW2DJICGyLKfkS+A0Hu1wKQqu5kD3HA1md1H5SL6ZJBU2akyMF1LZ1Gjf1UUmQygZ0mV2NGWWTfXRC6vMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B2A7D60516; Thu, 29 Jan 2026 15:58:33 +0100 (CET)
Date: Thu, 29 Jan 2026 15:58:33 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ruleparse: arp: Fix for all-zero mask on Big
 Endian
Message-ID: <aXt1mToz6_7g9P88@strlen.de>
References: <20260128214443.27971-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128214443.27971-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10514-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
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
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 3BFB0B13A6
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> With 16bit mask values, the first two bytes of bitwise.mask in struct
> nft_xt_ctx_reg are significant. Reading the first 32bit-sized field
> works only on Little Endian, on Big Endian the mask appears in the upper
> two bytes which are discarded when assigning to a 16bit variable.

nft-ruleparse-arp.c: In function 'nft_arp_parse_payload':
nft-ruleparse-arp.c:93:77: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
   93 |                         fw->arp.arhrd_mask = ((uint16_t *)reg->bitwise.mask)[0];
      |                                                                             ^
nft-ruleparse-arp.c:102:77: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  102 |                         fw->arp.arpro_mask = ((uint16_t *)reg->bitwise.mask)[0];
      |                                                                             ^
nft-ruleparse-arp.c:111:77: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  111 |                         fw->arp.arpop_mask = ((uint16_t *)reg->bitwise.mask)[0];
      |                                                                             ^

