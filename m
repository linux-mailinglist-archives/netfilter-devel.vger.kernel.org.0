Return-Path: <netfilter-devel+bounces-11322-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFkqNoowvWmI7QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11322-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:33:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04B2D9A41
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C18D4300FED1
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406653563C6;
	Fri, 20 Mar 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="asNmLYmu"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E173736F43E
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006337; cv=none; b=iLk45hnOh8ckdjxlB40aKZaoB5j4uC/ZskUNLJga4ZvWl8uVNPCTk8+4LHbLwNtfPjUESXu8+tCYDyGrLbZvsEGUCwhrjgEt/ZqXPAcQ9794LldEoD2lpogOo9W0iNPtqWzbNjbvMOc5oiQ3hSbMpyXr6ZdjWz7QENd9fbfzgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006337; c=relaxed/simple;
	bh=d4So9LQpzl1WZPFfY+Y2slEiOwJ/48n+YcrEwOwjCok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjLLPNL2320TLMJOTT+U4jJnwJuQ/Yb2eYfsYm7BRNMfeXdbBX7Z217ziUBhJYqmUyNv6p0lh5CeMxH3mR+HUmAqI4rQHjNOCn4Q5TGseZMiwp5zEGxaQbeMU068Dp1Tj+Wx2ihQzfKjFoRwqLoyozIVvLhm/+lfb7DMTmQfZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=asNmLYmu; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pPNnGFdFefkokeWfBw5WdK6nIU4uh/A9WDNDPrH3Lbs=; b=asNmLYmuWSNjiNjESw66peFT64
	LYLLZv2iS4pE/UYVbVhrVvpJs3T5cNax/pJAWq6T2UwYuTXZ3KN/ifARXC7gv4mPWNtD7OSLeuYLW
	OvVIgeGRcFxvkDQi9U2zvD8Wx2SKHRBCJCKLgH6xqARyiC3uDAehflysjB2y8Qpv3AVE1nO8E4MxL
	OkBz+C5TnNqGqLTaUHO+ATMLGKP2C/+FTFfK2NYFotiPpj7/qhh5YICChYuiAQ6KbGs8R2o7XeW1E
	Zxb2jkRTAUfQige/9aOIDU4deLWBJcACeBmC/u5e0YtVoFU8qNXJk1AdMryeRzhQtkcw5OWWH3dnJ
	96zXY33g==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w3Y5O-0000000075B-1wvc;
	Fri, 20 Mar 2026 12:32:14 +0100
Date: Fri, 20 Mar 2026 12:32:14 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Daniel Winship <danw@redhat.com>
Subject: Re: [nft PATCH] parser: Support table spec in 'list chains' command
Message-ID: <ab0wPnzsHj-jW3Yk@orbyte.nwl.cc>
References: <20260319133240.20143-1-phil@nwl.cc>
 <ab0slL66fr_fScNm@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0slL66fr_fScNm@strlen.de>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11322-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.187];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC04B2D9A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:16:36PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Make it possible for users to list all chains in a given table.
> 
> LGTM, thanks.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Also applied, thanks!

