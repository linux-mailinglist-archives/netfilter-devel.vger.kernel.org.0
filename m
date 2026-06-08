Return-Path: <netfilter-devel+bounces-13134-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEjwEOFIJ2qJuQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13134-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 00:57:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6365B1AB
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 00:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HtywLgFX;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13134-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13134-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 683693017CC5
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 22:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF93B42D2;
	Mon,  8 Jun 2026 22:57:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8D37267A;
	Mon,  8 Jun 2026 22:57:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959450; cv=none; b=QI5jo5uQVst1vJDf89wO08sS5rwIIfb1b551o2nBeAtHl7uckDDyPNcKk/Jf8QQu8+KBqZhilBpDYmW41rA9fWp5n2BWPbskP6jmZmcV06vV39k7RZ1CeDo7ry3L/0KFDoueGU+Qb8nW6I54g/1WejlCXH+lYHOupG91jvE3mCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959450; c=relaxed/simple;
	bh=I4vjKhm8M4XGlXfDUE7y3HrcXx64qVUMCFFB606+NsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAgB4oSFun3Df01WsO7VrRJNoj3jNzXTSHEwJz0UXOcdNgOFCTHk7nnqajZVPe4bGUld+cC3V6rPf+HC2FZgGXlJmGRG8fz2qYPCmlVTxO8/BmT4J0NmGS29lJ8XbF3+y3gJ79nj29zHUgc59urO876fxD8KaTkF1Qd6zFdeK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtywLgFX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E7D1F00893;
	Mon,  8 Jun 2026 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780959449;
	bh=SbKVxKadHqsLto4owcZ6NerkNyI/k/yx/RpKcfTaMD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HtywLgFXN/BCvMTI7H3m89/ovXyRb5TZDqKbYBIMKRfgXiBk3mhen9w/Z0nKh0nj9
	 TDrNwP6n2KZQDAMbg+78mrHwGBnsxjDFjs1EttPe+1Wz/YLRsqbI2KkpVmXXk7r7fz
	 MkhD7sbsQ2DQjDCiDV868ayq0u9CzIUy9c3nboqW88DCwQlsNdunmK6xYjHny1NaBC
	 I1kH8b+t380T0Q4zFJr0Wg9zr0nDvvzCK6d4GigMLPawcU3Hzx36sGJ6EHjvSya2Yg
	 +mxn/BsiYWfLEnnzCX+WjcNQRn6jDfO1+Sq3dGsTwVmZpXHRlS6ISdHVOP5wFd6ohk
	 sujhVN1ssviqg==
Date: Mon, 8 Jun 2026 15:57:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 fw@strlen.de, horms@kernel.org, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH net-next 08/15] netfilter: cttimeout: detach dataplane
 timeout policy and repurpose refcount
Message-ID: <20260608155728.2b332bce@kernel.org>
In-Reply-To: <aidCgrrmFJGNF-Th@chamomile>
References: <20260607094954.48892-1-pablo@netfilter.org>
	<20260607094954.48892-9-pablo@netfilter.org>
	<aidCgrrmFJGNF-Th@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13134-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,m:ja@ssi.bg,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ED6365B1AB

On Tue, 9 Jun 2026 00:30:26 +0200 Pablo Neira Ayuso wrote:
> On Sun, Jun 07, 2026 at 11:49:47AM +0200, Pablo Neira Ayuso wrote:
> > @@ -56,8 +73,14 @@ struct nf_conn_timeout *nf_ct_timeout_ext_add(struct nf_conn *ct,
> >  #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
> >  	struct nf_conn_timeout *timeout_ext;
> >  
> > +	if (!timeout)
> > +		return NULL;
> > +
> >  	timeout_ext = nf_ct_ext_add(ct, NF_CT_EXT_TIMEOUT, gfp);
> > -	if (timeout_ext == NULL)
> > +	if (!timeout_ext || timeout_ext->timeout)  
>                          ^^^^^^^^^^^^^^^^^^^^^^^
> This check is useless, it is always going to be null.
> 
> 
> There is also Julian Anastasov issue with documentation.
> 
> >> Documentation/networking/ipvs-sysctl.rst:76: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]  
>    Documentation/networking/ipvs-sysctl.rst:76: ERROR: Unexpected section title or transition.
> 
> And regarding:
> 
>   netfilter: synproxy: fix unaligned memory access in timestamp adjustment
> 
> it is fixing the unaligned access, but inet_proto_csum_replace4()
> wants 16-bit words starting from an even offset, sashiko reports that
> this still would not work in uneven. I don't think this is worth, but
> at least it is possible to add a note in the patch description.
> 
> I can post a v2 for this PR.

Bad timing :( Please send follow ups

