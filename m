Return-Path: <netfilter-devel+bounces-10631-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIgdGor0g2kMwQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10631-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 02:38:18 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA01EDB53
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 02:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7EE3016C9E
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5B288C27;
	Thu,  5 Feb 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WqSVz2xu"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474B2147E5
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255362; cv=none; b=maemui6+1dZR41VCdNpZ1Z7nb/9FOdFEamDvW85rxh8dEuE59dNqLWlzsOcXJAudxOirze33ANGIIJuR+KOWrXkG1M4WbCVL2UG7pIJwM+Zni75J4KEQ4yQrO4wRUc0bpKPw+PAIrFKfxO+XWkWPQ7/NaVj70t/OHfyXBRhtDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255362; c=relaxed/simple;
	bh=lHAVpfsp+h7deGGbmZDS5MIH7cPkAZMImmXy6cm6kfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpjdobwWlJUk3Fsh4IhMg4/WDJzVBZVlRauLVb3/bkFVwNlDwxOtNJWAcmW6KyRc/uCQ/3BMeO/Obkl3d/GmUvPqrlAVsA0S2pUdUY7TaVwDMLZ/GufUbCHHsz/voo47Ix4tZuWtzWYm7RYXqWBi5S9CVtZhWUcFrCWd67bd0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WqSVz2xu; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0389C60883;
	Thu,  5 Feb 2026 02:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770255360;
	bh=wbuXz6uKbjII2EL0eyhDlYXClgRG/wtlgwIPBa9nR+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqSVz2xud9tEfohPPCFfGss7IYfvnRTOYAYuyr4yrJGRPbUAzeEyWFWuj1qCmcYGy
	 qeIDnA6y+1vgKxdpDeJ/W6uSYrYrGlcfroSKXvvRVOXBJQMHKi6s0O20mD2HFECOj/
	 BrcOA6qIVIEBt7rM9ez2Ez/DbMQ2dO2IzBG7jCxVwavnX02MH9KNE8pHFuvAmPhSrJ
	 9DNwlpLBFHXF2f16L17e5sxo6BJHOIPoALMSw3NP1X3WSboLqi0ZRUMv/XB8ca7JYy
	 6Z09tSKP4mT3nVCYYGHZ0IQoaa7406pSCMIoiv9vT5eO/EqaiyuuJFSbx6+BMJTZQa
	 x/hlJ5wZh97Cw==
Date: Thu, 5 Feb 2026 02:35:57 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 0/4] Inspect and improve test suite code coverage
Message-ID: <aYPz_fmbjh5qjM30@chamomile>
References: <20260127222916.31806-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127222916.31806-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10631-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAA01EDB53
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:29:12PM +0100, Phil Sutter wrote:
> While inspecting the test suites' code coverage using --coverage gcc
> option and gcov(r) for analysis, I noticed that 'nft monitor' processes
> did not influence the stats at all. It appears that a process receiving
> SIGTERM or SIGINT (via kill or ctrl-c) does not dump profiling data at
> exit. Installing a signal handler for those signals which calls exit()
> resolves this, so patch 1 of this series implements --enable-profiling
> into configure which also conditionally enables said signal handler.
> 
> Patches 2 and 4 fix for zero test coverage of src/nftrace.c and
> src/xt.c, bumping stats to ~90% for both.
> 
> Patch 3 fixes for ignored comment matches in translated iptables-nft
> rules. This is required for patch 4 which uses a comment match to check
> whether nft is built with translation support.

Apart from the aforementioned nitpick, series LGTM.

> Phil Sutter (4):
>   configure: Implement --enable-profiling option
>   tests: shell: Add a simple test for nftrace
>   xt: Print comment match data as well
>   tests: shell: Add a basic test for src/xt.c
> 
>  .gitignore                                 |   5 +
>  Makefile.am                                |  16 +++
>  configure.ac                               |   7 ++
>  src/main.c                                 |  30 +++++
>  src/xt.c                                   |   6 +-
>  tests/shell/features/xtables_xlate.sh      |  21 ++++
>  tests/shell/testcases/parsing/compat_xlate | 135 +++++++++++++++++++++
>  tests/shell/testcases/trace/0001simple     |  85 +++++++++++++
>  8 files changed, 304 insertions(+), 1 deletion(-)
>  create mode 100755 tests/shell/features/xtables_xlate.sh
>  create mode 100755 tests/shell/testcases/parsing/compat_xlate
>  create mode 100755 tests/shell/testcases/trace/0001simple
> 
> -- 
> 2.51.0
> 

