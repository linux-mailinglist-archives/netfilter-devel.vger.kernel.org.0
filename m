Return-Path: <netfilter-devel+bounces-12599-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM4wHsKiBWroZAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12599-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 12:24:02 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0955405A3
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 12:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BD9530144FA
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECA38E100;
	Thu, 14 May 2026 10:23:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C9367298
	for <netfilter-devel@vger.kernel.org>; Thu, 14 May 2026 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754239; cv=none; b=sBa9yLqoyDEx7DqwX48Z3Kmbd7Z1n+0gJw0ExNB1RhCWcwHEWRkg+m8Qb/e5w7rGV6uKYK/srLjtQfGjzftwTe4KHXWPRsrvnEvZtfVRphn64VrOW/NuvkNtrlxG5uUsioaSDR5KebNBz2w3nWb5w2f4PyXyT6XJ9fp/15IEqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754239; c=relaxed/simple;
	bh=yGYpu2Et1dPvI7HYRxf/Z0bQqMUkfcUrnmr2qle4p+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=actIYhrulYXQcbrK7MyNEeg7UyFYaJvhdQvg3y2+YpS3wbHuLw0M3Fy0er+Eizjf7Jvr+L5ShCLo7je7vF4t1EwZXx6WPEjDmhmKjqBgtNrZ8VwftzkTPZLlFHJ1hkWjWJIKWeDbCiozvc3SJDvI6G2baE4IdfnItYdaFkjFBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 291C06099C; Thu, 14 May 2026 12:17:54 +0200 (CEST)
Date: Thu, 14 May 2026 12:17:53 +0200
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
	luciano.coelho@nokia.com, kaber@trash.net, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	royenheart@gmail.com
Subject: Re: [PATCH nf 1/1] netfilter: xt_IDLETIMER: scope timer reuse to the
 owning netns
Message-ID: <agWhUUyIy4JZlVlq@strlen.de>
References: <cover.1775353240.git.royenheart@gmail.com>
 <9c5661fad291777d8e998e23f3cb27cac37aa607.1775353240.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5661fad291777d8e998e23f3cb27cac37aa607.1775353240.git.royenheart@gmail.com>
X-Rspamd-Queue-Id: 1C0955405A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,nokia.com,trash.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-12599-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Action: no action

Ren Wei <n05ec@lzu.edu.cn> wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> IDLETIMER keeps timers in a module-global list and reuses them
> solely by label text.
> 
> The existing rev0 ALARM guard avoids the panic when rev0 reuses
> a rev1 ALARM timer from another netns, but it still lets same
> labels in different netns share the same timer object and the
> same sysfs entry.

Isn't that by design?

> Track the owning netns in struct idletimer_tg and only reuse
> timers when both the label and netns match. For non-init_net
> timers, derive a namespace-scoped sysfs name from the netns
> inode so non-init namespaces no longer collide in the global
> xt_idletimer sysfs directory.

How can that work?  How would userspace daemon relize that the
name has changed?

> This keeps init_net sysfs paths unchanged for ABI compatibility
> and preserves same-netns label reuse, while preventing the
> cross-netns timer-object aliasing that caused refcount, expiry,
> and teardown interference.

I don't think there is a bug here.  Two netns using same
files having same sysfs mount should naturally "conflict".

Maybe one could make a patch to force-detach an idletime
in a non-init userns if init userns asks for "foo" that
is already claimed by different userns (to avoid the "Dos"
angle).

But I'm not sure its worth it.

