Return-Path: <netfilter-devel+bounces-10751-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FI/JR7/jWm0+AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10751-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 17:26:06 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A312F616
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 17:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C98563054304
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865ED35FF62;
	Thu, 12 Feb 2026 16:24:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C035EDD7
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913455; cv=none; b=pp0irfCtv1ieP1NKbQBD7GgxvTwCVKyQMC6D8eCNanPAg0T8lWnwiMw2qWehFUiyrL7JvPLEVr/L6rbb7YxyGSHaKUORxnB/mw4cGhFLlapVnssHRIgCAlM4+wGmw46dVL9VGKDHDu5uFZCC2jESP4aFSyc9dDa1KZhLiss9pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913455; c=relaxed/simple;
	bh=OdDHysFbFD3a/Lf3j9LGjm8B/5TcBkKC682xIC1XPjs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MplTpfB4sGrWXIeoyr5Z7cOcR6kiFpVKBZ3r1pbElMogkRuiMx0Trdwg9LwI1V2GnAhVZksLEOKJoSxTssMqru31n5aIk1yLwnUcFg7a5sEsjFESBSfRA4/jbjiT49szmYq+1nwWUGOgX+MLZ/yd5Pbatq9RUoVVOcax5t5AsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 2F5F11003D93F5; Thu, 12 Feb 2026 17:15:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 2F15011009FAC6;
	Thu, 12 Feb 2026 17:15:30 +0100 (CET)
Date: Thu, 12 Feb 2026 17:15:30 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Florian Westphal <fw@strlen.de>
cc: Alan Ross <alan@sleuthco.ai>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] libxtables: refuse to run under file capabilities
In-Reply-To: <aY3aAChfNI3LWvfO@strlen.de>
Message-ID: <qq4or008-331o-628q-rr32-409p846r02o9@vanv.qr>
References: <CAKgz23F8EKsc2vhVAPyuZgUNA7Zohm0zS6-So+jPJTvCiNikig@mail.gmail.com> <aY3aAChfNI3LWvfO@strlen.de>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[inai.de];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ej@inai.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10751-lists,netfilter-devel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 307A312F616
X-Rspamd-Action: no action


On Thursday 2026-02-12 14:47, Florian Westphal wrote:
>Alan Ross <alan@sleuthco.ai> wrote:
>>
>>Attacker-controlled env vars (XTABLES_LIBDIR, IPTABLES_LIB_DIR,
>>IP6TABLES_LIB_DIR) still reach dlopen(), allowing arbitrary code
>>execution as the capability-elevated user.
>>
>>Extend the existing setuid guard in xtables_init() to also detect
>>file capabilities via getauxval(AT_SECURE).
>
>I'll apply this tomorrow unless anyone else has any objections.

Ah, but we can test for `#ifdef NO_SHARED_LIBS` to see when dlopen
is not used, in which case setuid/fscap-enabled program binaries
might be tolerable.

