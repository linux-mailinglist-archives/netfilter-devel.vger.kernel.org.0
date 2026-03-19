Return-Path: <netfilter-devel+bounces-11289-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCdfFxPFu2mYoAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11289-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:42:43 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB62C8E2C
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2E75305511C
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A72374733;
	Thu, 19 Mar 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="A5/Fn+hF"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A97364E9E
	for <netfilter-devel@vger.kernel.org>; Thu, 19 Mar 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912756; cv=none; b=lphdU+CQpxazSDEVCbK5hlc4f4NzbyLtunIdddZmwgcFdG3jdika1RBv76cYMdlG5wcJp1WytiUjWDyTBqQFFtUHOpbNssyQ3o0sYvtSJ/xLPCY0N7EGRlKTVWq5K8eztgFHV11DkwQ0e0UYsh5oqsMADPr07zc+GXVEo628t3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912756; c=relaxed/simple;
	bh=7rYI/qxgNwMTmHnOssNndpIvG3UbWuHviaBuTsrPj8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWVrEDxNBGCFZR7sztj2hNlKUSENDSpNu3ZAtM5M9Kdej7n4eZj3F+72u5+HOhG+8srwe2MmXF4NTmeNU3TT7GJtXaCBWdyVXD/4xh2GLlx+sO4jo/t/1C3fJMKOCKCb3YDtuR0pLkfJibN4FhTh6x9uzweskcZ+Qomi4itVAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=A5/Fn+hF; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jvjt169TSK8PpfjNIgrJSE9JR0dETFX8YLfMm4C33Ls=; b=A5/Fn+hFHE7BpCYDWKxLJhkGO9
	Mkd8PjamaIXhuJimCHfv/+ei4IwQEtCeFHv/mddJGPM2k1F9gVOCADzHtecNXiwDW//Djq4EY0jne
	6o44E0yDdFznEKNO1IAKHo21/4Q8ri5gC9N+gT/vUMqJd3oZMbbuajDFUNGqzh3d8r7zvV9NdHpeB
	GB7W37rJzC5znaXzb+Wqa64Xzsj4484TDePxslkqlG90PTc3UcKI4yPp+sw3BVt36Fwpom6h2+vv9
	yjW0usyJaNkYLcSFLFPl0kRVrzN5Dr3oJH1lTaI1AwChRp7ilkTw9jz8ODf5vZNYxSIhRsZPaHuTG
	pHMO4bwQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w39k1-000000000wA-0ZTe;
	Thu, 19 Mar 2026 10:32:33 +0100
Date: Thu, 19 Mar 2026 10:32:33 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Chloro Dose <chlorodose@gmail.com>
Subject: Re: [libnftnl PATCH] set{,_elem}: Drop nftnl_set{,_elem}_clone()
Message-ID: <abvCsUj2xKhOerKk@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Chloro Dose <chlorodose@gmail.com>
References: <20260319090613.13874-1-phil@nwl.cc>
 <abu_U5twbHFFv-FT@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abu_U5twbHFFv-FT@strlen.de>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11289-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,gmail.com];
	NEURAL_SPAM(0.00)[0.620];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,nwl.cc:email,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: B3DB62C8E2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:18:11AM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > These functions were never exported and are not used internally anymore.
> > Maybe due to that, they became incorrect (e.g., they ignore expr_list)
> > so drop them altogether.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Patch applied! :)

