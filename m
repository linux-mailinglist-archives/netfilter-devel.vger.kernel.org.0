Return-Path: <netfilter-devel+bounces-11004-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MSrCZ8Aqmm9JQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11004-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 23:15:59 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF4218D4D
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 23:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59DEB3012AA8
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2026 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9CF3630A6;
	Thu,  5 Mar 2026 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Y2NYW/gg"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105B225417
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Mar 2026 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748943; cv=none; b=ohvMZ1kGK4DWt57FrG8ocerrEP61eGE27eIo6jEChRzAX33k8kCFTwAXCNulnqsb7fHjRvWfyUvpijk+coNjYQKjzMGPn8nzQbBJuqX60dNJyKYJ0D+Uu3cVzikD62qwyRjDwmW0YiH4z3IgBX1dlz4If5niHnErJGO+TN2QqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748943; c=relaxed/simple;
	bh=rGaPtfIRxcgzxD6mpULZRgSTrToE6tmlA+ypaR+b1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB6zhWTyPraxCt86RRv+oK3GyrRR6UqILIAt1h14tgkEa4wMCy/JtjNCItCb49DV27OFCvmFsf2iIhm3NsfczT1wsFEwRFVi3ihgGXYfTLRk3LPrBiUMJ/tiTKp7V8qDq0LDDHR/SUAgEmwGXyMXd1cUfzlPTKhErWKWlrtJP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Y2NYW/gg; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b6HVDw8mV4Z1ijQ5IOm/2L7F/kbBYKZejlQzmQU/sNQ=; b=Y2NYW/ggJ1x46To5ZtM07DMs3+
	E0qS+RhvDRZCwXYV5d8aDCxJcg3BTpz8f4qVRyr/slKIaB4kLXre3xVAO+53PuXDNbv6AnHaukodX
	VzXmPCkvoxI1KsC8nA4A+bFRq4ACNuazMPcB3BAcNcgJhcCohc9k8zSowu22CcGBNPCUmsebr1uqg
	c6nBcu41dLKvEfhjc7l797ww05zaNqD2rvqbEVn7Lq8nxAeaiGVqg146vYnBpA17TMY3zicccOk2n
	wndFiHVUYzgSVoEL+GVAQG5KWEPlc4u2bFu9SGBzYwY5/uR6fC755IifhbFU+cogUKvUuIhi4FXwb
	fm5qy3+w==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vyGyo-000000000Kk-2JHU;
	Thu, 05 Mar 2026 23:15:38 +0100
Date: Thu, 5 Mar 2026 23:15:38 +0100
From: Phil Sutter <phil@nwl.cc>
To: Jeremy Sowden <jeremy@azazel.net>
Cc: Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] tests: py: use `os.unshare` Python function
Message-ID: <aaoAio3UjWvoBVbq@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Jeremy Sowden <jeremy@azazel.net>,
	Netfilter Devel <netfilter-devel@vger.kernel.org>
References: <20260305175358.806280-1-jeremy@azazel.net>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305175358.806280-1-jeremy@azazel.net>
X-Rspamd-Queue-Id: 11EF4218D4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-11004-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.837];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 05:53:58PM +0000, Jeremy Sowden wrote:
> Since Python 3.12 the standard library has included an `os.unshare` function.
> Use it if it is available.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Patch applied, thanks!

