Return-Path: <netfilter-devel+bounces-12418-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF2MHBcm+Wmz5wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12418-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 01:04:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6634C4BBF
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9EE7301C128
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 May 2026 23:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E9538D6AD;
	Mon,  4 May 2026 23:04:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB024A076
	for <netfilter-devel@vger.kernel.org>; Mon,  4 May 2026 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935892; cv=none; b=cvXZ4Y4uo3OnALS8NcOQAI3x3rzeMBIzUPoP91NiIgZvApSfNvEwYHMDyPV9CWHpMGiTmnGwCinEhOI2MeN4d0wHsmrKcPQaOQ1fp/TVtNri+n0LK1TMgq2A93HFvDGdfJgJHku6fnSA1/NhKwWI4A2vNnJBd5AFrYCji3LxK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935892; c=relaxed/simple;
	bh=Q4TTG9VqmUDlZhDAvRa5mJ8ooKYANcrgx3zAFKxrWWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGQt0ROlvdGACSQnXjEK52oqhl1Ya2NuYK7k1nBxk6Tzb8IT+6FSAntqNZe5BsqyZYZX5rAWJwQtOWUHjIgeUslWNszCKTiBoV1hPuG8CybbfrHzRikBDnxNa8SxeVmiGHMVx23MaLAmeNZJ4jqKGWs1pjhPKI2dPg3243acOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AAC00605F3; Tue, 05 May 2026 01:04:47 +0200 (CEST)
Date: Tue, 5 May 2026 01:04:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Tristan Madani <tristmd@gmail.com>
Cc: netfilter-devel@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH nf 3/5] netfilter: x_tables: unregister the templates
 first
Message-ID: <afkmDq1bDlQag9ec@strlen.de>
References: <20260502075639.7440-1-fw@strlen.de>
 <20260502075639.7440-4-fw@strlen.de>
 <177792044028.2307140.8003648539483235646@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177792044028.2307140.8003648539483235646@gmail.com>
X-Rspamd-Queue-Id: 0C6634C4BBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-12418-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]

Tristan Madani <tristmd@gmail.com> wrote:
> For the series:
> Reviewed-by: Tristan Madani <tristan@talencesecurity.com>

Thanks.  I've fixed this up in my local copy, I will need to send
a v3 (only minor changes needed, so I will keep your RvB tags).

