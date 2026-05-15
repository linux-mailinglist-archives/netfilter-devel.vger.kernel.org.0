Return-Path: <netfilter-devel+bounces-12615-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCjcMpRkBmqbjQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12615-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 02:11:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF8547E87
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 02:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CF963011E9C
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153E32C8B;
	Fri, 15 May 2026 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="c1x0L2VH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE825776
	for <netfilter-devel@vger.kernel.org>; Fri, 15 May 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803856; cv=none; b=WZ4kJPtXEGWZErIZ2FTVgxtNYODOiNpzAOG4k+wFUiu3QJMBeaTabnOrL8Mc/LA759RW9Vp/8cW3ogbSXQLODg1ugc8nF0licbDasfbCZeTxStFLMbIDBaf8sR4svWXACLZ+cUbEz6xPLeyMIyS/hqPP3m/YIf2wpwqz0ho3yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803856; c=relaxed/simple;
	bh=fbmBEsJbZ2OmQsp1EOcGogW5CTbk/79MSYvgWUmVjpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4c8+VwO0YeQnuY+QSwSsgU5VM5Yo6GnCkrCceLxo6EWTckF0Lc6SCmO0lj1mS8K1pitNygzTqwvv9ifzDkLxdXOgc5B4YwWrN0qtM6uCQEFSrTwFJgSo5tFKo4XY+x8aqB+ohWbx3/Bk+FsKTr+uOoOBSfUMcY3uE9IHaZHbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=c1x0L2VH; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 5E2086017E;
	Fri, 15 May 2026 02:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778803853;
	bh=j8Wbl3oxghy8mdPyTOCBh7YBL4TdGkgunoQ6ubsNz1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1x0L2VHp/5dMebpwNAUZIgauljTP0Tf1Bxp2bNknB+dYUEXw4+Z7sB7sAvcyH959
	 DsyvQt2h8HqKKv3Odf0Pg03ekwebk7fDT5kgY5xABd9n62pwpzxR8coUsq62pZ+rVO
	 Xs6fgwJAVmghjgepfb4kmeLNKWaHZ4rQ9C4+sCRjMJqyaCvVQBgaI3wp7No4bSxr5p
	 P3/6odJ9wfSb9HjDHcNoV9zCSi1f0EOQxcsRNDiD5spQccpaoSgFWlXWrrMjSW3s1E
	 BZp8e2V9t1OadxDnNFttkGzbF7RnRpVdvjyA35aEYgS1R+4bgaftWCO+f60kT1eycy
	 er0No+V5QvHvw==
Date: Fri, 15 May 2026 02:10:50 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2] netfilter: conntrack: add dead flag to helpers
Message-ID: <agZkiu4q1Ln9ImR4@chamomile>
References: <20260514143016.874811-1-pablo@netfilter.org>
 <agXfhQb8Dcl9p5ce@strlen.de>
 <agXl-3NDpK3YUZiF@chamomile>
 <agXt-m9yN-oayY1G@strlen.de>
 <agZbFvp_KgGUr2Kw@chamomile>
 <agZg3JjBx6xXyEnW@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agZg3JjBx6xXyEnW@strlen.de>
X-Rspamd-Queue-Id: 5FCF8547E87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12615-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 01:55:08AM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > The seqcnt can be pernet and it can be restricted to nfnetlink_queue.
> > > 
> > > Any better idea?
> > 
> > Maybe add a helper_id which is set at helper registration time. Then
> > nf_conn_help stores this helper_id field.  Unconfirmed conntrack on
> > reinject use this helper_id to re-lookup the helper when reinjecting.
> > This would force a slow path for unconfirmed conntracks, to
> > re-validate if the helper is still there.
> > 
> > cttimeout would need this too, a lookup to check if the timeout policy
> > is still around.
> 
> Hmm, maybe just re-use the nf_conntrack_ext_genid for this?
> I think this unreg/rmmod isn't so frequent.

nf_ct_iterate_destroy() is called for both cthelper/cttimeout, which
already bumps nf_conntrack_ext_genid.

Simply add the check from nf_reinject() path then?

> Another alternative would be to give up on this design completely
> and just grab module references :-)

But that would not be enough for userspace ct helpers, right?

