Return-Path: <netfilter-devel+bounces-13224-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hGX7JusbK2o22wMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13224-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 22:34:51 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D7675315
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 22:34:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pc3ZJeox;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13224-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13224-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4EC333A361
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3448033E;
	Thu, 11 Jun 2026 20:34:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E716481244;
	Thu, 11 Jun 2026 20:34:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210057; cv=none; b=j76M3S5l9sJX9lZ7QuSXwdWesPfA792VNReHEodEtIsoDr5ufFbCrISYSmGsw7PFA7CQO7mv3okYogmDnb8D/IpH+V1U1OQ6Jd/rgeKkPMl0L8XVTk6vC4380lpNLtWsHZF7ytxVMZwtzI/pQZUA10RZSLjmH2k3yNSZHmYEI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210057; c=relaxed/simple;
	bh=FU48NCNE9sYQz18bFtiD3LWJevD8xsYZ/bTNmProL/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLt55ZTX16qLNATMt9DRqxsFQmGF8egKlrgmVVZXxMF18emYVnzhv7xxWkMbphwKXf8WWH0OJ4sCNbK/3vQoatyahn3BKHpNsl7iqbYjpf66KHELC3BSpt/bW8JVazhM4UxLsSou+tceo0dngYZemfOy7kn7JKcX4hhU7vFg+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc3ZJeox; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19381F000E9;
	Thu, 11 Jun 2026 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781210051;
	bh=nH/aLoa3AEqO6ONv7VWO2PSeTYf+vJbVrVpAdygpMxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pc3ZJeoxH3OmzlOHcFJbmzraUUUqa2I+240mrHUlr1rFjAX1DQbZQ4NN46UEaMDBw
	 qZFS/CbYCFGB00X+tzCRSLaHiZEJGmA/2wfCn6WNkZl90QbbW8RFF8m/qru05dry6g
	 QLvzvQUVBDFoEv2A2BWG2tfurazDhCqcJZkkdtuO67hR9+++J10VDmJWXjoTMg524+
	 YkVu6iMVnNIInJ0eIz/1SCnDGDA5qcy8NTSHPA/vxv/1+Nzm4ldSFuBUJsLSeTEvFH
	 9+YFU9wBeUFdK1Xj/EwFPfeJAgOTBJoApGzilNMtaqik4tm0YxLYkpqm8fSVWxRn7l
	 RnTi2tWWoZezQ==
Date: Thu, 11 Jun 2026 13:34:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: netfilter: add phony
 nft_offload test
Message-ID: <20260611133410.1c0396b1@kernel.org>
In-Reply-To: <20260610175906.1767-3-fw@strlen.de>
References: <20260610175906.1767-1-fw@strlen.de>
	<20260610175906.1767-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13224-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A4D7675315

On Wed, 10 Jun 2026 19:58:44 +0200 Florian Westphal wrote:
> ... "phony", because its not testing offloads, it tests the control
> plane code.  Also test error unwind via fault injection framework.
> 
> For a proper test, real hardware would be required given we'd have
> check if 'previously handed off to hardware' offload commands are
> properly removed again on failure or rule flush.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Validation errors in tools/testing/selftests/net/netfilter/config:
Lines 36-37 invalid order, CONFIG_FAIL_FUNCTION=y should be before CONFIG_IP_VS_RR=m

Shellcheck also has some comments FWIW 

