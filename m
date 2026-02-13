Return-Path: <netfilter-devel+bounces-10765-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEBKII0ij2mJJwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10765-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 14:09:33 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D888513635A
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 14:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C87B3034568
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812835E556;
	Fri, 13 Feb 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="qTXpki0i"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CA346E45
	for <netfilter-devel@vger.kernel.org>; Fri, 13 Feb 2026 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988170; cv=none; b=pR5Pb8BBTeMe1eplNw4z2Af+qGOWinV6gZm0S2iVWv318WH3yl1+f+QuEGpqsgfrPK3vHSoSAbm2Z+1vFLjr32wAIahQRX8qJtAIbSQ1vg7aaI76UELud1k0pF4BjaE3oNqKpgITO3LjCf6PqeYwPDTxKMwvDK+LnzqCTvthFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988170; c=relaxed/simple;
	bh=EA+5pkQ7b1Ud2q2JLYOxw/d9bUAEm7Qh3JLCdq8wqt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR1WqTQOdc5nLM+sXqpknG3Rr8fAOpJMyZrZ8fW3fkfnVfAVLv3Gh/XV4Ww7fQUtN1HPSimwbO6ZhCGi4feGK5nrWjTjoaIS2Aavv8C3J+68eBn3sD3ecYdlZT1PGKzrUu9wuq5+jAGlCYdDwyw2wV+556IqbWAXewhwKx9tUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=qTXpki0i; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y76jjHJuuAqOO2KrXxsFGDS0ls6p9xQGkl7kAiB+UnA=; b=qTXpki0i4AI7lYxi095QZcIrMS
	GvmQNHWOt+UUdoylVmhrX5ammX8gmnI6wdF9zjPsD7faNKxxIrHUwLFAvfKmChYwZqpE3XPm9GAHa
	aiHYoO28WfL6DoWXbWCiCEt6YMIsqs4DPO66ZCf1tprNpQPXRXlGWyznBq7OJhZHO4Qm8Vhl/6qC2
	hkuIVfUxggAkMcR1yh5+1c8teZrL1AdVNE1gLrMsYBOON3FzVpZMfFi/lO1xdFZQoxE0D7S/biraC
	I0H2lGjBRC0BGtNm5UyoPIZaZn2/tQ5t2DokhlmNC21MLxOYSWzmiIgZ7l5tKLmw6HCyhhf6yv378
	7WnLvs7Q==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vqsvH-000000007Kk-32mK;
	Fri, 13 Feb 2026 14:09:27 +0100
Date: Fri, 13 Feb 2026 14:09:27 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v4] configure: Implement --enable-profiling option
Message-ID: <aY8ih5bMqveTrF7Q@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
References: <20260212205023.32010-1-phil@nwl.cc>
 <aY8Mk5eCymlbN8UA@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY8Mk5eCymlbN8UA@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10765-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: D888513635A
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:35:47PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > This will set compiler flag --coverage so code coverage may be inspected
> > using gcov.
> > 
> > In order to successfully profile processes which are killed or
> > interrupted as well, add a signal handler for those cases which calls
> > exit(). This is relevant for test cases invoking nft monitor.
> 
> LGTM, thanks Phil.  Feel free to push this out.

Thanks for your thorough review, patch applied.

