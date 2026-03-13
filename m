Return-Path: <netfilter-devel+bounces-11178-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKlFH0oItGlvfwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11178-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 13:51:22 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D1E2833C4
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66CE23006812
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDCA37F8B0;
	Fri, 13 Mar 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="DbTrr/ro"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE637CD5D
	for <netfilter-devel@vger.kernel.org>; Fri, 13 Mar 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406277; cv=none; b=nTF2FQjnU1WGKbqKRQLI0EtB5GGdgUeEsRzs7ViZqluczACptk+lv7MZb0cxFxJIz4HFum73I9eFAc2RXSNdZCHcA43vNM79b+eCF13Lm+Mj00VYVGOSknNwRmdG9KSjXTrRcUigFP+JM1iTJvsIFMpo4l2Ni2SnfFZA2nA0QLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406277; c=relaxed/simple;
	bh=FLjn0qW8/uIPLUBi80P4TALJoaB6YCIbm99bjMHgVwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olkhiT3C0j+sJOpSgXlu3WrOr4R+CyWh5Y8Ysi4z/beiEvmJ5q360BXmz/Zo2ndls+s5/aL+CnHJjqBE1dCKmR3LuABxZrfecERWtQ+6SCd0PvvbePf/Bj1aunOf56swl18Zk339Z6I2Ze5HvYgAoOIAH7u0v3i7Dja+xck13xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=DbTrr/ro; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MZ8+kk3qQWrJ6BAKQxAlhi6TJBh1Y/yFtRHZONnDVGs=; b=DbTrr/ro7xruQv2ivVEACgr5NA
	DeXtWtfqnfY2sa0A5M72M26YshiaIp9Ni22DZNWyZtSuGuyKhO4r4mNiJoVhP1ZF8TGao7mi5qkLO
	wSRx6Phy90YJtTSn/I+o5fn8tqbGD4Xh5MAnQ0NWFlsOhdUbXKgrhSJ9JKOw6yD++EnFu9UabZLJz
	sWxRh30PEkUz9ox+pYrgOFEJRuG5NldelxMhqhBp3JE79UDDGZjIF0Bj1krWaaI6qkViy8+6ODtSe
	trTrJQdCph4pPYJDq5rRyiBsj+DAim0+fe9MC/IC7kANdlVOkJDGmiZiX6G2ZkwloLNc94En2KYzn
	oG6zcSvw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w11yy-000000002Op-2X96;
	Fri, 13 Mar 2026 13:51:12 +0100
Date: Fri, 13 Mar 2026 13:51:12 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-translate: Return non-zero if
 translation fails
Message-ID: <abQIQCN7Jg4p699v@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20260310171853.26362-1-phil@nwl.cc>
 <abBWyuHDm7MT9JC3@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBWyuHDm7MT9JC3@strlen.de>
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11178-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: 83D1E2833C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 06:37:14PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Untranslated parts in output are easily overlooked and also don't disrupt
> > piping into nft (which is a bad idea to begin with), so make a little
> > noise if things go sideways:
> 
> Makes sense to me.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Patch applied, thanks!

