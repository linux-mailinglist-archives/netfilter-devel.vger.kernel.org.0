Return-Path: <netfilter-devel+bounces-13131-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iVb3GYxCJ2pJuAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13131-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 00:30:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F74E65AF89
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 00:30:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="pd3a6/Eb";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13131-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13131-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB1473012D5D
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA4C32694F;
	Mon,  8 Jun 2026 22:30:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17045039;
	Mon,  8 Jun 2026 22:30:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957832; cv=none; b=GWKhtoo/QsPL6NvtihN65X9uD7yO0L28FCSOfDv0zcPRt9W2cxpeUOUmWw7kZIUUOT5TSePFBRZCApe5ETMG9dA9hVFWvNDJd0MLccfirZYicT7WJVqKzhyMbsUFyM6pya8e4w1nEnmCpHya7x7ulVbE1rnFIY0JqmmiwxtFkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957832; c=relaxed/simple;
	bh=+U/ad3F/SwbcI0smRQz6Zy4vts/dRkjKbEiBAsj7WGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt7DavhFC6kpnk4TpOxP+H7/8HLW3bIsCPsvhN1A04sZIjvS1WTxmlbpmXlLWWt/5zVZARv76vAh7WXQuYK436biXd6YW2cXHRQcOHTF/V4fLbfEqkGLtw1fzlCKhk7yEQBTxPOCVBGk6/0MN/vS/QGqSd9QkPFXuj8Ivtjb668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pd3a6/Eb; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id EA79560177;
	Tue,  9 Jun 2026 00:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780957829;
	bh=8HixyEbDqEKu4zD6QtLGD2nk6dGuDyLSJANkkz2fXTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pd3a6/EbEJpesnW/g9D1igU6YZgKBQH/UGVEmTSsQb7n1ivfOogx9pua03ELL6mtt
	 H8eQ3vQ5dXVofNo+OhYpYll8Vd/YbhThM6JkJ5TUvzu0qR+i7Lzo4KVIe3D1Vb9b7u
	 IaEQ3Za2Y1uD1EPnLhQWWWpzxOR9+xe3EJtfhelnx/0w0B78Q1IX5ZDGXoz4vR41bn
	 cZqKKsnSqyEbAEr+60Hqpv4vEB8qdZHJmH1TTghT7+4We+5vH4QHYlM5ZvXqRjmKkn
	 YiH2gEEtzQF04OS9yh4tZLUJujFP4F9ryt9vEdb9TMKHqGPppqFmL5JtLo5/UIhNs5
	 Y0r8Z1aPom/tQ==
Date: Tue, 9 Jun 2026 00:30:26 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de,
	horms@kernel.org, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH net-next 08/15] netfilter: cttimeout: detach dataplane
 timeout policy and repurpose refcount
Message-ID: <aidCgrrmFJGNF-Th@chamomile>
References: <20260607094954.48892-1-pablo@netfilter.org>
 <20260607094954.48892-9-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260607094954.48892-9-pablo@netfilter.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,m:ja@ssi.bg,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13131-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F74E65AF89

Hi,

On Sun, Jun 07, 2026 at 11:49:47AM +0200, Pablo Neira Ayuso wrote:
> @@ -56,8 +73,14 @@ struct nf_conn_timeout *nf_ct_timeout_ext_add(struct nf_conn *ct,
>  #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
>  	struct nf_conn_timeout *timeout_ext;
>  
> +	if (!timeout)
> +		return NULL;
> +
>  	timeout_ext = nf_ct_ext_add(ct, NF_CT_EXT_TIMEOUT, gfp);
> -	if (timeout_ext == NULL)
> +	if (!timeout_ext || timeout_ext->timeout)
                         ^^^^^^^^^^^^^^^^^^^^^^^
This check is useless, it is always going to be null.


There is also Julian Anastasov issue with documentation.

>> Documentation/networking/ipvs-sysctl.rst:76: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/networking/ipvs-sysctl.rst:76: ERROR: Unexpected section title or transition.

And regarding:

  netfilter: synproxy: fix unaligned memory access in timestamp adjustment

it is fixing the unaligned access, but inet_proto_csum_replace4()
wants 16-bit words starting from an even offset, sashiko reports that
this still would not work in uneven. I don't think this is worth, but
at least it is possible to add a note in the patch description.

I can post a v2 for this PR.

