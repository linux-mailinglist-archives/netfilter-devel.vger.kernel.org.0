Return-Path: <netfilter-devel+bounces-11984-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGrFIVPo4WmKzgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11984-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 09:59:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543C4184F8
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E84A31FCC66
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D922382380;
	Fri, 17 Apr 2026 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Dmy4OPGU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E026382F12;
	Fri, 17 Apr 2026 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412312; cv=none; b=QiUe440Bn5vhrfi5VJjuYLYnsdo0dnnR6ZCUYMX5lNwJ8SAhcOy6rwoBY1ldwB0SWBCJEoOdTqAj/TdS4hBRUsPQl33mbxRq5lvCjFK5DmqaLR0W7YuR4z7JeQ4zud2vR4P/bhd8w1x1U4edhevuxrNll4ReNNgXVLmJaO7cFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412312; c=relaxed/simple;
	bh=OYAGwy9MTm+ow03iecXkfmblodkn/G0PyBhnwKBU0Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPklDtNIesVNa2uxaHMmmKYzWOl8Qw395Tci2x/EvoSEiONyje0ZPefcjDfiXI/kdYCbKzt4+54BW/AURVpQO9eyfFNFAX6h/LToECNbHoylO0lbP3zJjBsXIkllLY3Nb1NfvlBu9FqoWoJjV8vu6h1RpFRlMDWKa+zQpdAW8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Dmy4OPGU; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id F1BF560178;
	Fri, 17 Apr 2026 09:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776412301;
	bh=BpNM+GQZCW6hrf6VGd87Afd90Vl6W3KFzh5DaZW4unY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dmy4OPGUqLQI4HTeXvlrtV8evQKdS8uMbbWptjPhLJ3dbV6wqX0hgHs3FBhkq70bF
	 sn+pKTO2ptsfjAico8OVKG087ZT8OSGsk6r/idUSR3y+JCJIBlaoWQOIvaoAakn9KE
	 5H2BJnSj9M8r5G2/WPJdNPpCBp8xEEU0Rb1YGEUFO1trodYndyzTh82KVEd/g6X2x+
	 J2k2JK9o2+8KTDwidqtlSC5KhW3v5T0Qy0V4zghIsgRuqlaf3zvqbHI55pehsu4mMQ
	 0SUB1FCxrm7E0sQsN8Pj3CLE0a5Up+YHFjkj2fXKVtIjDnMIBGxZqMpznRo3F7fMzN
	 fGsMTjy9Vt43Q==
Date: Fri, 17 Apr 2026 09:51:38 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net,v2 00/11] Netfilter/IPVS fixes for net
Message-ID: <aeHminpmIiI4SVVw@chamomile>
References: <20260416131453.308611-1-pablo@netfilter.org>
 <aeFRt__YQqJ84ZaN@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeFRt__YQqJ84ZaN@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11984-lists,netfilter-devel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2543C4184F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:16:39PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
[...]
> If you don't want to take this v2 because of above issues, please
> consider at least applying
> 
>   ↳ [2026-04-16] Pablo Neira Ayuso <pablo@netfilter.org>: [PATCH net 08/11] ipvs: fix MTU check for GSO packets in tunnel mode
>   ↳ [2026-04-16] Pablo Neira Ayuso <pablo@netfilter.org>: [PATCH net 09/11] netfilter: nf_tables: use list_del_rcu for netlink hooks
>   ↳ [2026-04-16] Pablo Neira Ayuso <pablo@netfilter.org>: [PATCH net 10/11] rculist: add list_splice_rcu() for private lists
>   ↳ [2026-04-16] Pablo Neira Ayuso <pablo@netfilter.org>: [PATCH net 05/11] netfilter: conntrack: remove sprintf usage
>   ↳ [2026-04-16] Pablo Neira Ayuso <pablo@netfilter.org>: [PATCH net 06/11] netfilter: xtables: restrict several matches to inet family
> 
> manually.  nf:main always tracks net:main, applying them manually
> doesn't cause issues.

Florian, I am going to prepare a v3.

