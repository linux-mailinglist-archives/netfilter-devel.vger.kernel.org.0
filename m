Return-Path: <netfilter-devel+bounces-11616-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M2FDkoZ0Glj3QYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11616-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 21:47:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0504397DBC
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 21:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F00630457D8
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Apr 2026 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F134F27B;
	Fri,  3 Apr 2026 19:44:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF806337BB5;
	Fri,  3 Apr 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245469; cv=none; b=sUt2HFDkIOIyE/iveXAmVF31YjBnviBFvfqNwezx3K2TWaOlSzjgkXkYxVpnSKetLHQBO4ypQN2F/Sr5wMXOcZRc/zg88K6bO71xbogtN9T1iq+XFV9Y9a28gsMP5Au5UJVqRXBiPSaCKm5dOiCChKBtoCDeYEofvudrlfYFcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245469; c=relaxed/simple;
	bh=R0dKMEEN+1FaU3xTIXRdqAmp6Y6V+svvcwk60Pu0QOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPNAeHdqwJwXCBifeD5qeeIhwsICplOMG/h2sP7yC8f8bJREsrErFRCO63eSYJedvayAq9/WdfXN6vGw6VysCr3ShtSPtNNDaErRkvfg33CIiZhnMK4igw/0CFtF5JHmk972NyXyQW67KP71namZhJZn7vhXdwjRS5XvTDj2c6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DE8AD60913; Fri, 03 Apr 2026 21:44:25 +0200 (CEST)
Date: Fri, 3 Apr 2026 21:44:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Marino Dzalto <marino.dzalto@gmail.com>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marino Dzalto <marino.dzalto@icloud.com>
Subject: Re: [PATCH] netfilter: xt_dscp: replace -EDOM with -EINVAL and unify
 match functions
Message-ID: <adAYmfP8XBYu-q0M@strlen.de>
References: <20260403185337.87676-1-marino.dzalto@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403185337.87676-1-marino.dzalto@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11616-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,icloud.com];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.636];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,icloud.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0504397DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Marino Dzalto <marino.dzalto@gmail.com> wrote:
> From: Marino Dzalto <marino.dzalto@icloud.com>

This is where you add the explanation why you make this change.

AFAICS this patch provides no benefit.

