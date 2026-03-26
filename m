Return-Path: <netfilter-devel+bounces-11465-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMj5D4KexWlqAAUAu9opvQ
	(envelope-from <netfilter-devel+bounces-11465-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 22:00:50 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C933B9E3
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 22:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBA030179CA
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA233EB1A;
	Thu, 26 Mar 2026 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="tCm/V//5"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA01DA23;
	Thu, 26 Mar 2026 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558846; cv=none; b=E/AahyrrOJUfPaGGGhha368cv0nQiiDY3AVrMxD2oVnGqp3Qb7XAAWnP+Ca22uwlVDGAamDz1xoM4X3c7Q/QpBjXSlixOJs6YZkwjUe4sPE8nM6r+DKHfHqyTZmkUk312pI180uMYQE6XZPqTf0yfwb7JWxch7rdBH/9qXHNcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558846; c=relaxed/simple;
	bh=J9NwJDlizt5RFhlNf+xWff0v7TECnJrhMrG1hjnecGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw4PXopt4wlTvsFUrAbTpT5EKUOZjym+JA2DswiuuKgG41FalQP8sp8FTvOOn1ZLVUaOSmpSezPnbhp1zKpGNobv9Vkno386TdEx8T6WPoMuYtPQ9Dh0Re8dafvgudWQBWOFIZESxpEr3QLpNs7IZmCYd2YgJm4R8nk43LunHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=tCm/V//5; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 75AA66017A;
	Thu, 26 Mar 2026 22:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774558843;
	bh=u6xqYsXW9UHSRPe+ut5zht3QwseJFYjIz/8ldm+gK8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCm/V//5v5po8RYeLQimBFeEoi3LzpdoFLYxVS+nADc/LB/jzp1oO8r3kbHKeQJ1w
	 OgMIvJsqVX6MoxlQmXq/gX9gabRA4mMZ4ACgal5d02ItBvtRRhZywT9/u0+UrvkISM
	 W8hxxdlz3UaNrS7j7GSAIF2V6JZ3+11aYLeUlDsgp06k/xCQoQMkdoZ+WHlGswCgqr
	 soxKzAFd5n8gT0Rg69WMj0N0XtZBKEsPsGYtxgHD25xvCBcxOt9BCcAPOqaMi7IYqQ
	 tv1J68MOSaudhvmdDqe9fiW/AQ3/OYFcOZUQcT+B67V9p80LYPBIyE5pKsqK+MQhfA
	 uy9+XdzabHnlw==
Date: Thu, 26 Mar 2026 22:00:39 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: fw@strlen.de, phil@nwl.cc, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: ctnetlink: fix use-after-free of
 exp->master in expectation dump
Message-ID: <acWed9opPZfOIyAs@chamomile>
References: <aaxeXUnPpqLUURrt@v4bel>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaxeXUnPpqLUURrt@v4bel>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11465-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 844C933B9E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 08, 2026 at 02:20:29AM +0900, Hyunwoo Kim wrote:
> ctnetlink_exp_dump_table() iterates the expectation hash table under
> rcu_read_lock and dereferences exp->master to access the master
> conntrack's fields (ct_net, tuplehash, ct->ext).  However, expectations
> do not hold a reference on exp->master.  A concurrent conntrack deletion
> via NFNL_SUBSYS_CTNETLINK (a different nfnetlink subsystem mutex) can
> free the master conntrack while the dump is in progress, leading to
> use-after-free on ct->ext which is freed immediately by kfree().
>
> Fix this by taking a reference on exp->master with
> refcount_inc_not_zero() before accessing it.  If the master conntrack is
> already being destroyed, skip the expectation.

For the record, ctnetlink_exp_dump_expect() does not access ct->ext
anymore since f01794106042 ("netfilter: nf_conntrack_expect: use
expect->helper"). I am archiving this proposed patch.

Thanks for reporting.

