Return-Path: <netfilter-devel+bounces-10431-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGi1BgIXeWmyvAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10431-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 20:50:26 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC369A1F1
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 20:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4C42300908C
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C1329360;
	Tue, 27 Jan 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="iIJO9QMJ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61F155757
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543423; cv=none; b=eEQfpd3YmHsdVdxyQQh7cXlj+CabEWZ/dvrSD4QHDt/BaBmqqYVVPPzY9KQSQtnegO/SpfX/lkWNt3fcXI5AQIxd655vToOVoEv/sY2Fu9S/NG/vensIlpTnw1gpuC7G0ItH1WA/NkRak9cNG3yrExbUKPLBl3Os2cAaTTq+Syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543423; c=relaxed/simple;
	bh=E9zQXlI7kH0Zogt0Kxq4KilMoewti/C/vrcgDwzsDPA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn2ZZe/hTDsStAq/Uq+CE+UBdBM65MVdOkRrOGG8bWFit9zYpGgo23GtrTu7voUnVAL6HgrZElXK20XPEMi5w6vMWErkIpjY9USPDsOlv+uPgiATmsNGIfeqWXjdDK6pTHH+B2thaZ3aSkEvuWPuPJfhonbwpZzcbckvQkEYaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=iIJO9QMJ; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5HW/icgO7gHUScNFqzC+rY+yQeqdHUeUYCcPZJExprs=; b=iIJO9QMJCSgS27WMA4kNi9Xq31
	ICL2UP/paGHV1+b3enw6gPmfky8r8pAB2kZBeBqDgKcqefCM8i611Dd3tBQlKfaVI/d4wYqVzhcyA
	BgCXbCejfMIIfn319RNET+t1sBQMKcrrQKuCQx9yCtvJDI/2staJEYBPQZQ/0HZW5CVLzKAVrM5sp
	IgaBX+E3uzIle93PEGAxPGMtsywrj4nvGPOUWFROvoOujL3AijDk/8/930CU1okvYCMYWFm/rPG88
	eztvORA2+P95e9FfXPRHehmzm8/3n9V6FAgN81Q1BV5awW9ugXt2SVoWltIigH3AZyxls4HTm+KQx
	SvDvNH6A==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vkp4n-000000008Q9-1cp2
	for netfilter-devel@vger.kernel.org;
	Tue, 27 Jan 2026 20:50:13 +0100
Date: Tue, 27 Jan 2026 20:50:13 +0100
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] libxtables: Store all requested target types
Message-ID: <aXkW9V0my7urtb2e@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org
References: <20260123115837.11177-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123115837.11177-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10431-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 8FC369A1F1
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:58:37PM +0100, Phil Sutter wrote:
> Repeat the change in commit 1a696c99d278c ("libxtables: store all
> requested match types") for target registration. An obvious use-case
> affected as described in that commit is an 'nft list ruleset' process
> translating different families' extensions in one go. If the same
> extension is used in multiple families, only the first one is being
> found.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.

