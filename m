Return-Path: <netfilter-devel+bounces-13165-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c3LILUd7KGouFQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13165-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 22:44:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A56641DC
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 22:44:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=pLIe1PYo;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13165-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13165-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87DA7304606B
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556A3DB337;
	Tue,  9 Jun 2026 20:44:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891B40D581;
	Tue,  9 Jun 2026 20:44:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037892; cv=none; b=bjo/GO9JXrOjnIcw9wrkKJzw2H1HLhSyb4WbOPvpqpGKvQBLfSxcz+XA36Tu4gRET4uMi57/Zxxz3WXcnMHBe3+hK3imb3tc8qRspGbUNjnuLnBLc3TZVrB4ClwVq6MBoVGv9ALt+7vE9oaL/nMytCCxEdCXKrLPIUVYpYkPPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037892; c=relaxed/simple;
	bh=LruAFwnl9IzeFmjN9T1TBRP9TLejxxC/9JIDivm25W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv702+F8LbyAe5AatPE4MQrOn4GIygD5/RzmURJ8NIP7dXA7eR7pCS/qvmEbp15YLyaR7KYDDZjZXSUHbEjgxx0azYhBMSPCzkvD2BSKen4vkdKFRLCZqH5pja00QVgjXacsM1ZPiKdVHV86B1pAWDaZlHmvTqG27mBWOy+Vr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pLIe1PYo; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0537060190;
	Tue,  9 Jun 2026 22:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781037889;
	bh=XJegGKvD19n7Qjs9LBr/MLKvK/0Bu2AAOfkrTaY9FyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLIe1PYo7ULOsQseeoCo4f/bOb7g66OG6RrjTc7ZVOZndtZQpFxMJW/RQz59q2E18
	 92WT6p19Ao2isackMhWDMPj9SzL6eykJjB9xt2onSkK3vLugRhObKL8LlpjEIo8X9k
	 jiN2F5gqBwINdPXsKdTWxvogl6ukoLFqTQ7FR4dlQ+dNQB7LFsRXCggptOnRNk+7pr
	 3iA92HiFWEpyaUDw4U4948bglWuWSZqU02bdrDJr8kNpK+plypp8IChlvrku7brzLn
	 6bqUBJ1xayBxRhd9d4vwLoEbkuppZH7FPiwEcLyIRa9br7z7lKqdqMkaNKfhfvfLfn
	 7gb/1+YmGj/+g==
Date: Tue, 9 Jun 2026 22:44:46 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: task hung in xt_find_table
Message-ID: <aih7PqPryonzP7cI@chamomile>
References: <CAHPqNmyfm4j0Vy--8rpYMEY1wOP-TgmnRWYd=7ragj1Z29=F7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHPqNmyfm4j0Vy--8rpYMEY1wOP-TgmnRWYd=7ragj1Z29=F7g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:coregee2000@gmail.com,m:syzkaller@googlegroups.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13165-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 083A56641DC

Hi,

On Tue, Jun 09, 2026 at 07:55:34PM +0800, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. INFO: task
> hung in xt_find_table. Details are as follows.
> 
> Kernel commit: v7.0.6
> Kernel config: see attachment
> report: see attachment
> 
> We are currently analyzing the root cause and  working on a
> reproducible PoC. We will provide further updates in this thread as
> soon as we have more information.

No links to external web, please, inline in plain text to this email
the description of what you found.

Thanks.

