Return-Path: <netfilter-devel+bounces-10753-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOiSBvILjmmS+wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10753-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 18:20:50 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B083C12FD9F
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 18:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2324E301061C
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4434D1917CD;
	Thu, 12 Feb 2026 17:20:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06E12CDBE
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916848; cv=none; b=kx6b2PIXHTwce9p4FdJEphsmLU6CmxUg0kSRzCV+uAFQOADFLeja0ntEDpGykNubdYAYkRC+k7X9Uncu7MyOuVO4xUE3hSsHGU/cT3gwePTvJ6Ne6TzKlChnO81T5Zti2t6TfMn4SfJzZfkQt4NSwAgk+XYZz+WVrcXlJjI09d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916848; c=relaxed/simple;
	bh=gFqvlZvZ8RE8lGvxeMx6t0nD2F/oJb2J0eaBjMpi2dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9HUH3SBktjb5QNwIOu8tYb5Ne/GQ5zb1kgNcyBIhfJWAGOXkgJQ/reTqVPlF3GI+CEYszn3JSKqQzXszu/9lo53Dwvqpb1rzntmsXI+LlKRKtsTwL3DXFojlOGoM3ZbKzFL3htvfYIqOzVG60SND7/zXpNQEgXWB5EOPEgUPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 66D966063D; Thu, 12 Feb 2026 18:20:37 +0100 (CET)
Date: Thu, 12 Feb 2026 18:20:37 +0100
From: Florian Westphal <fw@strlen.de>
To: Alan Ross <alan@sleuthco.ai>
Cc: Jan Engelhardt <ej@inai.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] libxtables: refuse to run under file capabilities
Message-ID: <aY4L5azyFoRua6iM@strlen.de>
References: <CAKgz23F8EKsc2vhVAPyuZgUNA7Zohm0zS6-So+jPJTvCiNikig@mail.gmail.com>
 <aY3aAChfNI3LWvfO@strlen.de>
 <qq4or008-331o-628q-rr32-409p846r02o9@vanv.qr>
 <CAKgz23HD3UDEubpDfVK2dumYfTr+ODOyKmbfDunVeoPPjX2x3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgz23HD3UDEubpDfVK2dumYfTr+ODOyKmbfDunVeoPPjX2x3A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10753-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: B083C12FD9F
X-Rspamd-Action: no action

Alan Ross <alan@sleuthco.ai> wrote:
>  Good feedback. If the binary is built with NO_SHARED_LIBS (static, no
> dlopen()), then the env vars
>   never reach plugin loading, so the setcap risk is mostly gone and
> it's okay to allow it.

Not sure sure.  Yes, the dlopen() risk is gone.

But I'm not convinced its safe to setcap this; are we sure there is no
bug in there that could allow to redirect control flow?

CAP_NET_ADMIN is quite powerful, I don't think we should sanction
setcap-installations in any way, so I prefer the strict version.

