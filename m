Return-Path: <netfilter-devel+bounces-11490-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHRhGLlhymn27gUAu9opvQ
	(envelope-from <netfilter-devel+bounces-11490-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 13:42:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B952935A6D1
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55590300BCB6
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2026 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492423C73D2;
	Mon, 30 Mar 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="T0SddZaz"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28C3C73C8
	for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870881; cv=none; b=GXM2JeFAE/Lgp1EZyi/lMd25XL1CeIdoB8U8yzYlcISUWuX6QbUu/FuUVC7J9j/+7BEjkqxUd5o6tk2nkDaY3Urg+0Gnv7NNzQ3NiKEztHOiFZ7EWp5LqteME2Ct1FvF0KtODHxT4nfNfKKdtCGyjh3LMPZHxtdyuHEURigItuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870881; c=relaxed/simple;
	bh=Yl5XnyOBY32dOSmF9aQXrBaN9y6EoKgGHTrGsxCd0aU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hitqQuK9W3ybU6Z82nqnVve7sCZ8cgDiog4uNThbVrV4QB+mrNMRIxSEJ11tWx7Aq9q5B/p7CGn1OpiIyd6dMwvEox/X6lQJ+Stw15EjZk5N54hnhiWxlUyE3Xs6qUtnWdjOrqaWxY8P0qERFreIi95Lqh6MzBlilKFfjZ00Ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=T0SddZaz; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7A6D5600B5
	for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2026 13:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774870877;
	bh=6rsS5aZALb9BTKQkT0sCLnCjWCfBbE8uU3TaiMw01r8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=T0SddZaz6gAU7g8cwLMlpI2YJMiVK5Q9rUeunTPrtjLPkHojnw3oI2uYxGoKhC4Cu
	 qRPHIf2FphPjruqxPpIlI/vP0+9h0cpYb9pqqFGabZQNfj3D8wpQ3g4iRbHmyKcpIz
	 wrlzMhnsvBE78oImCsL2eA+xIHxDRGNyw2tp4ObCYG56imBMiAn0MVUkXb3oO57+/7
	 xCHKDtFbsoLZVzGK4iItyIv2KSOcT29ETqitVfsxI4pfo7gP5eey3GloyrZfxoKYCJ
	 SjJp8eaTxBM94kaH9y8Lughf9V73nsXeICM14zJ3irNTVYqeyjqUgv/yVufsMdE4vY
	 AeogeyGxPcVeA==
Date: Mon, 30 Mar 2026 13:41:14 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables_offload: add
 nft_flow_action_entry_next() and use it
Message-ID: <acphWsMJrQlyDBhm@chamomile>
References: <20260330090153.809877-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330090153.809877-1-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11490-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B952935A6D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:01:53AM +0200, Pablo Neira Ayuso wrote:
> Add a new helper function to retrieve the next action entry in flow
> rule, check if the maximum number of actions is reached, bail out in
> such case.
> 
> Replace existing opencoded iteration on the action array by this
> helper function.

Same patch as before, apologies for this duplicate.

