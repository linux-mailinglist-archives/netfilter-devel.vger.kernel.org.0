Return-Path: <netfilter-devel+bounces-10608-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAxMIcljg2nAmAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10608-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 16:20:41 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D570E853F
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E70F30B3EFB
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C25425CED;
	Wed,  4 Feb 2026 15:06:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9F425CD9
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Feb 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217576; cv=none; b=NXIKv1iYHWKc36NTSJKrfXAWy2Zg/jrv5icC9Xsj0V2kDsgGHEIQ/w4jsEUD37ZgXgNcofcc41vv3m6A5zNuMS6M8lmgU0wZUnKgDXb2RgeIJi3agTEYqtBq1u9daGiGuwO5y2XUtpbr52IQAZuaZ3PHN2dEo091vUjW2dOexHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217576; c=relaxed/simple;
	bh=JgLaK1tcCXmrtPJKcF9BMrUBdVPil6YAR1Xo0P/h+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxs3LEpH9idJ8XOFK9TZ3hlrfCR0F8RGahxT6r08gFxbF+7BNOkKPuNj8RO3lNp7OytW9ESjC9QkWcGYgFODPqdX+K4yM+Ul5Ou9H5J6l3CT7Ux9wa4C9bKCLG7ibmf6GNyeIK1/eZaqmrBQOj/f0I5HaHkw97ETowQ/JAosirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 322E96033F; Wed, 04 Feb 2026 16:06:08 +0100 (CET)
Date: Wed, 4 Feb 2026 16:06:07 +0100
From: Florian Westphal <fw@strlen.de>
To: Yi Chen <yiche@redhat.com>
Cc: pablo@netfilter.org, phil@nwl.cc, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] test: shell: run-test.sh: introduce NFT_TEST_EXCLUDES
Message-ID: <aYNgX-nh04sAQdU8@strlen.de>
References: <20260204144940.63422-1-yiche@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204144940.63422-1-yiche@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10608-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,run-test.sh:url]
X-Rspamd-Queue-Id: 3D570E853F
X-Rspamd-Action: no action

Yi Chen <yiche@redhat.com> wrote:
> Introduce the NFT_TEST_EXCLUDES environment variable to allow excluding
> one or more specific test cases.
> This is useful for some releases where certain tests are not yet supported.
> allowing them to be skipped directly in the test script
> without modifying the run-test.sh itself.

Wouldn't it make more sense to add a feature test for those?
Or is this about test cases that fail because of a real bug that
where the fix wasn't backported yet?

