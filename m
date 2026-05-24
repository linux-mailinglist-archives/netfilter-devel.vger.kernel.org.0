Return-Path: <netfilter-devel+bounces-12799-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FGiAfpQE2pP+gYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12799-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 21:26:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED75C3906
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 21:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E0F3008214
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 19:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499130C158;
	Sun, 24 May 2026 19:24:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CFE30C16C
	for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650675; cv=none; b=XKoxMRa1KrFgwxcJs3mKZfBOY7ZPoKIiV019K4wEyaa2dMJFIU43fkI5jUyB127hXeB9rekPaNFAnDAlRE+40yozEGfCVfHVqjzIj0iZ1uu8Y9bTruvKlsnbz19nTeWcfH4eDSKkr7QMYtiH4Y1WL+tNfEeNt8yfbajslwFVCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650675; c=relaxed/simple;
	bh=dHf7NKSDF+0gStfWFSSFkPkHvRceO6sZguQ9gg9svqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfHS3U3M7xEv8nOnniALmPkCzgiyuHGSVJMhDlJ358E9+b8ho/2zTbvpr282OivdoIV43A+oEr7SICPFxzW54puoGfhV8lOwbw736RhCaxXxhcpXJzErP+HgzdbQ2wsMA2Xqulo5YD/9elvgkdM7DQmiAckkGqfdFKnwKWtxOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1D12160425; Sun, 24 May 2026 21:24:31 +0200 (CEST)
Date: Sun, 24 May 2026 21:24:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	pablo@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH 0/3 nf-next] netfilter: synproxy: timestamp adjustment
 fixes
Message-ID: <ahNQbjbK5DBNWnNt@strlen.de>
References: <20260523194743.5888-2-fmancera@suse.de>
 <7dcb73cb-11ab-4c9d-89bd-7418bdc86fdb@suse.de>
 <ahMyVJYynOoa32U5@strlen.de>
 <3178bbf8-552a-45cf-819f-bf3ec2de41e0@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3178bbf8-552a-45cf-819f-bf3ec2de41e0@suse.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12799-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: ABED75C3906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> Hm. That might be an appealing argument for the dup timestamp option, if we
> want to be more relaxed we can just adjust all timestamp options equally (we
> need to assume that this is a corner case of course).
> 
> But when failing skb_ensure_writable() or when encountering completely
> malformed options I believe we should drop the packet.

Not so sure. skb_ensure_writable() -> yes.
But for malformed options?  I think it should be done by policy.
Not even conntrack drops such packets at the moment.

Could you use NF_DROP_REASON() in next version?
NF_DROP conceals the drop location which makes debugging harder.

Thanks!

