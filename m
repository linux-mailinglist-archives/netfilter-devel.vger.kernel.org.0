Return-Path: <netfilter-devel+bounces-13880-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /QN9JY4hVGqnigMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13880-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 01:21:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAC7463CD
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 01:21:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=Ht9G2O1u;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13880-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13880-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4AA8300C010
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A738C412;
	Sun, 12 Jul 2026 23:21:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B31F09A5
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 23:21:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783898508; cv=none; b=lMu3t0jWz1TTpYTIkaAG5CvqjJXyZYSR6/Hd3AZAXDlsMeCkJ/yipi6MBPwpPttuOKYvBCOs5LCkNzrwQw+J8GJx4PD0yrO6rfBn9wN6RG77e67Prcntmp5W3dlozcex0q7vWYxNAzwwFukp7tzxnktMuXBKgUFFUk5KYQPVWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783898508; c=relaxed/simple;
	bh=/t0rPP4ru2cwY7957MECbk3+cER8JhjQQMY03bOFnl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcoOE6yLf1C/czhIkk9RW2W3kstF/9DVXmgvcjziae8BxiM0Jj3y97mLiWCep4/s14Pg+IhIKBhpWrdiBiGPbEH6pQNgHOq9ImtSBQpL2mVLfIS8L02MLtpuG5JBsrwSp4NYQKlZYmWN1n+V04BzcepuZfFK/yyxPQdAw+74XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Ht9G2O1u; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0847E60577;
	Mon, 13 Jul 2026 01:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783898505;
	bh=/t0rPP4ru2cwY7957MECbk3+cER8JhjQQMY03bOFnl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht9G2O1uI4TnfHuWtrIuZL0DoUxBV0IPwRt8LY4T0RB0KLgt2/H4s9kXbQa9mF7du
	 RgwpjVu6fZalJjqgcSevi4i8HCI4nXLQGvAQqJCy3px13F5rjaauhQkTv+Ht4omb9k
	 /hn9yWWmnc2IrDVllO0YmmIlIwJCqhGfpe0zywDqe+Qknml8Do2/DxrdhboUKgLxf2
	 JFkQmSWz6NCYSVo0VeuMQahaIJt+Xt8rHepHovEVER3Uib4Ynt74xFOwNA7WjUrK2a
	 j8rtZsyAvoDBQykyUvVyB/KBByOJq9gwQjbiVDt80XjWQF3VyHfhmh5unJ09s5pnfY
	 5dibMPMMYiVgA==
Date: Mon, 13 Jul 2026 01:21:41 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: ericwouds@gmail.com, fw@strlen.de
Subject: Re: [PATCH nf,v3] netfilter: flowtable: initial bridge support
Message-ID: <alQhhbb4HVI0Sliq@chamomile>
References: <20260712231935.1573912-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712231935.1573912-1-pablo@netfilter.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13880-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:ericwouds@gmail.com,m:fw@strlen.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,strlen.de];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13FAC7463CD

Apologies, I reposted this for the nf-next tree, which is the right
target for this content.

