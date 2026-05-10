Return-Path: <netfilter-devel+bounces-12524-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC0IMhH8AGrCPQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12524-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 May 2026 23:43:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0975068AA
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 May 2026 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80A1D3001593
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 May 2026 21:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CD343D83;
	Sun, 10 May 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="v6T8l9ou"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A5346769
	for <netfilter-devel@vger.kernel.org>; Sun, 10 May 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449420; cv=none; b=LuVmhHDyW7WnSTJR9kX+6sAlnkhien+ql+0ApZSXP+o3tCjDXMlM8DUlJ0WDqnddsSGugYPE1iazRdT8jHs6FMX0uc6Q9oTPimKMaHPevc2jXs4/lY5LkCIm7SSW1g0u/X/bbiRQB+NlGdY7hx1uOa8GJVYw/A/QUMeQqJRaHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449420; c=relaxed/simple;
	bh=e6QLVY/ygljFB2CoCiKzN5NUU0E1YfCNJO6WTTpSblQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXaaM63/PjhUXNCsiDhLgdPDLQ3c3fBREeQJBsQnRDcRS4bv716OiX4WQtWP3E16spLionBJ7lTfRmc7MG8vRflXPf1zOmOHXeqOtqlDMiFJb6V182aQPY+phSwgXgQUJDSOZPU+Ka2YAe3RkoRIGg6Gp6zNw1wCP1QD3OR7nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=v6T8l9ou; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id EF18760177;
	Sun, 10 May 2026 23:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778449410;
	bh=SC3z/yO2zohxkJUb8g+Hs2JV+obUQ79fYv5nyTHP0q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v6T8l9ou22Kn89pV0rCyFcANEJ4rxE0lNVExYWnIWNkx604Z1zOY7F5k3quFWGXZC
	 2nOFOc1Tb3Z3GVKcUkr7O03qGsIwp24hNb5ST+k7uH0gscwbfWJRml5Z+eIyGWwcgx
	 SJlAobTPhnpvcOJAFsV/74eZzg6dwviLOyFqHyiYozmLnlka78vb0Hg8DPYCbGFl4j
	 wzKJJPUzOpTUUTh5TkttVrra0FyTIzl42VdSEjd7fUPSiJixw1WFpfAZ0JeOUd4AxG
	 rBozZDovzZH9WWHaZ3wVIzWIBV2Dh862tHh+vBraVmNAaVphRFjUfOJidNCaJje4KA
	 eg4Fuf5Ro0k8g==
Date: Sun, 10 May 2026 23:43:27 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] netfilter: ipset fixes
Message-ID: <agD7_1W1G6aYuXPI@chamomile>
References: <20260508205903.10238-1-kadlec@netfilter.org>
 <af7rnaoD7TlglbhL@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af7rnaoD7TlglbhL@strlen.de>
X-Rspamd-Queue-Id: BD0975068AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12524-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 10:09:01AM +0200, Florian Westphal wrote:
> Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> > Hi Pablo,
> > 
> > Here follows the new revision of the fixes for the current list
> > of ipset related issues. If sashiko won't find any issues in 
> > the patches themselves, then please consider applying them.
> 
> I think it would make sense to start taking the first 4 patches so we
> make some progress here and Jozsef doesn't have to respin all patches.
> 
> What do you think?

Agreed.

