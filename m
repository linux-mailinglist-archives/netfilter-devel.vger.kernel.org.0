Return-Path: <netfilter-devel+bounces-10728-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPI7NBC3jGnlsQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10728-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 18:06:24 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615D12668F
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D90A300D92E
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A43451AA;
	Wed, 11 Feb 2026 17:06:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EC340A76
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829580; cv=none; b=noOW+n0lmBN/Fg2bvgoiVCWir7HB3LNKc8l/5HcL3EFZYHA13TEH0coD7VWSio5sI3dTbcg4k34z0R6B4V8wFRDcjm2Ujt4dZreNAy+6oSr4rHn5AmDcGXNCU/C9VkgArnEE5OFmdRvACIGFRm6uAF9EVMdpZQGVb+W3ZUWGpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829580; c=relaxed/simple;
	bh=uyfLjCyrF2aHnH9ZiTe/QBTVqmNGgKJ/tccDZRO0CM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t09lAns7ALPpeqbbyWfa4XTxpmJzDOBNaHD5bRhTzHREVZQCeTmnqp4DrOcc4RjyeYiqxCfyQgM70rWFtuX0FsZjA6evoQmrXjtJUJNWSsagnbNaDcifwWJ8w9azOhr5cNQrYgZ6Xo5MUejhUrWnaWlusborzGSnIVUSYe6zmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 57E89605E7; Wed, 11 Feb 2026 18:06:10 +0100 (CET)
Date: Wed, 11 Feb 2026 18:06:10 +0100
From: Florian Westphal <fw@strlen.de>
To: Alan Ross <alan@sleuthco.ai>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] security: use secure_getenv() to prevent env-var
 privilege escalation
Message-ID: <aYy3ApR8MskC805m@strlen.de>
References: <CAKgz23Gtsg4HGV8qqk7OovcK21ZdpwNzEnzoPzqrW=5eE6jV_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgz23Gtsg4HGV8qqk7OovcK21ZdpwNzEnzoPzqrW=5eE6jV_w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,sleuthco.ai:email];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10728-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6615D12668F
X-Rspamd-Action: no action

Alan Ross <alan@sleuthco.ai> wrote:
> Hi netfilter team,
> 
>   iptables uses getenv() to read XTABLES_LIBDIR, IPTABLES_LIB_DIR,
>   IP6TABLES_LIB_DIR, XTABLES_LOCKFILE, and EBTABLES_SAVE_COUNTER. Since
>   iptables runs as root, these become local privilege escalation vectors:

If someone can set up your environment they can also set up
LD_PRELOAD and PATH.

>   This patch replaces getenv() with secure_getenv() for all 5 variables.
>   secure_getenv() returns NULL when AT_SECURE is set by the kernel (for
>   setuid, setgid, or capability-elevated binaries), blocking env-var
>   injection without affecting normal unprivileged usage.

iptables requires CAP_NET_ADMIN to work and it was never designed to work
with setuid-to-root.

What kind of scenario/setup needs this patch?

