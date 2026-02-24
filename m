Return-Path: <netfilter-devel+bounces-10849-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDJIB+v5nWnLSwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10849-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:20:11 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C769218BEB7
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62850305A87D
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AA3ACA53;
	Tue, 24 Feb 2026 19:20:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9E3A0B3A
	for <netfilter-devel@vger.kernel.org>; Tue, 24 Feb 2026 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960804; cv=none; b=lyNuE8Ioj9/V15Glql3oILGmyb5H/po5zTrPHrmD1Dfs506S50S9vPnSyPqnv+V3aDkRkeaKWD3zfTTa8S/gGmlgHTakS5siuS0VGfz5GxoSsEBd2BAVlAkEeNZ4PhhrmbrzycXePYoqgBYiSF4jkX5/2GqL5stTA5BhSPNTXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960804; c=relaxed/simple;
	bh=RL4vdmaoJ80giJ+5y8hNYScEgqQ7uwaDufeTDaP/DVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoFdfdA8DCaGUr4muVjPEW2vsPJiFmwY5gwsveOdTTWmun0nqxhwxwPBgMohmxBPWSbnRDk2k6U6cwAR8hVBdP0PdH/BbSlS8IJmw0BTBryGOHdMtSB5y1aa1nrk85DBXq4ZLjW3NAjQaguZS84rRUmupVM9WuM03Ybe52/HV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1AC0560499; Tue, 24 Feb 2026 20:19:55 +0100 (CET)
Date: Tue, 24 Feb 2026 20:19:54 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: inconditionally bump
 set->nelems before insertion
Message-ID: <aZ352pI2B6v0yJzY@strlen.de>
References: <20260224182247.2343607-1-pablo@netfilter.org>
 <aZ30HscJe0XroBtg@strlen.de>
 <aZ334G68nwX2GXNi@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ334G68nwX2GXNi@chamomile>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10849-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid,netfilter.org:email]
X-Rspamd-Queue-Id: C769218BEB7
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Makes sense to you?
> 
> My concern is that this slows down a scenario that is possible, ie.
> adding an element to a full set.
> 
> ... compared to 71e99ee20fc3, where it is almost *impossible* to reach
> that synchronize_rcu() in a real use-case since you have to register
> 1024 basechains.

Thats a good point, actually.  Let me think about it. I'll do a nf-next
PR now and will get back to this today.

