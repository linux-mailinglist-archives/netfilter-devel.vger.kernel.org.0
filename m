Return-Path: <netfilter-devel+bounces-12685-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZWlLEQcbDGp3WQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12685-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 10:10:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA9579B78
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E055D30A6B70
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA63DFC70;
	Tue, 19 May 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="LBNXX+Sq"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0E3DA7CD
	for <netfilter-devel@vger.kernel.org>; Tue, 19 May 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177832; cv=none; b=h/5cw3NIRm7Fc1u9WFTPH5nGSsSwOLnW/zm3LLtdePur/+ZUIEKcTSfI4nRf8nKfVCj/9BJ7AtCSGM5/0psOtwjZzAD6dattZQ1OZmLaO7jfdtvjaQqsCNO7SoypUF/dFlaLQuDosCeKHKrTUXs96bdpCXQUaF0Gx+tj36w9aHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177832; c=relaxed/simple;
	bh=F0fbxY1x4c6TGpMyunEZvTLdrp/Znf7v8pdcwm43Zws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky6rKfoaMMnqqHwytSRSrWUBS9qwzl5UZBH3T/s8b5r7p0slsxQJvb3HewDAyp+7slwdG6jUWyCLKgG6LxOsiLo0jHnua7QdGWRxlVedNXudFatLF/u1p0jBcvT90FAlp2c/WIq+xkwfCiytY4zvDs1N2jRo3xXE19SZY32CdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=LBNXX+Sq; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 63945601AC;
	Tue, 19 May 2026 10:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1779177826;
	bh=6p3nVOspvUVq4MsOIDjhos66SJaR7KS6XPtW/DR3j7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBNXX+Sq5C9qht9QHy0XZSg0Dbqj1AV2zGboqgy+cHOiF17luPXh8pIUXIGcq7OIp
	 6mxb0xCJ9E90HRY5fBYs3gRVIdQFlosrYa7QHQhkA59Q3HiyWjM1JVJIFxEKY70JUu
	 cuWRx4DXjxPj7ETPH/W2uLmL26XgPN459OI+5uWs+6yjtlrBRe8zYE+Plmot9B2Pgq
	 LzokupsVPc+4psdLBm2EBYFths5it0Ku7Tcv+tu5SqE6tK3hT4ZVR3/zzAPcJ+2JHU
	 2rLPim+To1iFeRmFxrM4adrBJdh/4OLJopUq/p+Dz/PqNR3kRgRKFRpgZLu/n1jyEy
	 zI6rMyAPzCC4A==
Date: Tue, 19 May 2026 10:03:43 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 4/3 nf,v4] netfilter: nf_conntrack_helper: call
 .destroy() when helper is unregistered
Message-ID: <agwZX77SWnd6CzCs@chamomile>
References: <20260518194752.1063189-1-pablo@netfilter.org>
 <aguQFExPbJtWeapP@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aguQFExPbJtWeapP@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12685-lists,netfilter-devel=lfdr.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email,netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Queue-Id: 89DA9579B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:17:56AM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > When the helper is removed, call .destroy to release the pptp binding
> > with gre conntrack entries, otherwise the gre keymap stays with stale
> > list entries.
> > 
> > Fixes: f09943fefe6b ("[NETFILTER]: nf_conntrack/nf_nat: add PPTP helper port")
> > Reported-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  net/netfilter/nf_conntrack_helper.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> > index 9a10b3449957..b226291a5c7f 100644
> > --- a/net/netfilter/nf_conntrack_helper.c
> > +++ b/net/netfilter/nf_conntrack_helper.c
> > @@ -241,9 +241,17 @@ EXPORT_SYMBOL_GPL(__nf_ct_try_assign_helper);
> >  static int unhelp(struct nf_conn *ct, void *me)
> >  {
> >  	struct nf_conn_help *help = nfct_help(ct);
> > +	struct nf_conntrack_helper *helper;
> > +
> > +	if (!help)
> > +		return 0;
> >  
> > -	if (help && rcu_dereference_raw(help->helper) == me) {
> > +	helper = rcu_dereference_raw(help->helper);
> > +	if (helper == me) {
> >  		nf_conntrack_event(IPCT_HELPER, ct);
> > +		if (helper->destroy)
> > +			helper->destroy(ct);
> > +
> 
> There is a nf_ct_helper_destroy() helper that could be used here instead
> of open-coding.  Other than that this looks correct.

Yes, but it is refetching the helper again which seems redundant to
me. I can use it if you prefer though.

