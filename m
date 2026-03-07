Return-Path: <netfilter-devel+bounces-11032-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iqPlGKxvrGnJpgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11032-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 19:34:20 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAEC22D3DE
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 484C030080A5
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Mar 2026 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A236E484;
	Sat,  7 Mar 2026 18:34:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E62355F47
	for <netfilter-devel@vger.kernel.org>; Sat,  7 Mar 2026 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772908455; cv=none; b=Ekj8zUsDisRJUaiQCRABSYztIFKF60aOxIpidRZeTGje/UNjibeBq5t616fYtQuZUgGk9lB0f3UUbRvVA7xvXhWWgUWuSIkm4JNX0DM9mIOsCkVkfeh1emw0mSjWD62BiO7NOO4Atyt8bBjffHWliMO6jpgxJkEEcq3o15GvWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772908455; c=relaxed/simple;
	bh=3jIOgTLFYrIKXBL28OEeR8JdjeU3+sJZRUV8YJa5Xp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDZdSRkq18YUw0yFG2yaOHjgwp/2wtQqmM/SSzjnEuawp6f7+6uijcHq0ji/MhtotMZnwyIiOrYP030O1a6Sz8x0oxdJ+fJVZOFgmf3hRgb1bcB+x+XSZu0xnDMTP/16pWeiTKNlHA+BjdBNSrPlMEH24ryyXLrkV7JgpPVYWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 71DDF6077F; Sat, 07 Mar 2026 19:34:11 +0100 (CET)
Date: Sat, 7 Mar 2026 19:34:10 +0100
From: Florian Westphal <fw@strlen.de>
To: David Dull <monderasdor@gmail.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: guard option walkers against 1-byte tail reads
Message-ID: <aaxvov0E_yR6SvcJ@strlen.de>
References: <20260307182621.1315-1-monderasdor@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307182621.1315-1-monderasdor@gmail.com>
X-Rspamd-Queue-Id: 5BAEC22D3DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11032-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.017];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

David Dull <monderasdor@gmail.com> wrote:
> When the last byte of options is a non-single-byte option kind, walkers
> that advance with i += op[i + 1] ? : 1 can read op[i + 1] past the end
> of the option area.
> 
> Add an explicit i == optlen - 1 check before dereferencing op[i + 1]
> in xt_tcpudp and xt_dccp option walkers.

Fixes: 2e4e6a17af35 ("[NETFILTER] x_tables: Abstraction layer for {ip,ip6,arp}_tables")

