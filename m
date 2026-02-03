Return-Path: <netfilter-devel+bounces-10589-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOdfG0v9gWk7NQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10589-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 14:51:07 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B0DA246
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11222304A894
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Feb 2026 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4E396B81;
	Tue,  3 Feb 2026 13:50:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C839C637;
	Tue,  3 Feb 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126625; cv=none; b=GERgpFHcPCHeiRdGfzkYibjh24xOEjf9kHklYXhrGfUrHhh7UWij9wbmGTB2Fm/GbZIGysK2+CSxvLHHtqjnTqG7+trcknq5y5krQKq42xDhn5ab43z4z2xe5VN2vjd0lMtQXdB2Vw0uGKy4SzQS2SjMcfTSmk51QOqHcK2szME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126625; c=relaxed/simple;
	bh=Sba4kZl7eH4t/9pFUoriJ52rE4wlXNhh+3gMWig0PhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQfc72ElwwRyuVABCOSyzjFcYFH1qBNY1eWfI9u6ZdqKaIiHY+3PeIdV+qF5jWknlHfYH2v5ZgWp/SsjjboEVv8ez5r4L8QpeyZdnHYqHK5WvsFPpn6VZM1kf/cZ8xNtzitJETlJt1ifuIgp9AoofYRxMGvypMsmGS/4y3gfeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 88EB76033F; Tue, 03 Feb 2026 14:50:15 +0100 (CET)
Date: Tue, 3 Feb 2026 14:50:15 +0100
From: Florian Westphal <fw@strlen.de>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: amanda: fix RCU pointer typing for
 nf_nat_amanda_hook
Message-ID: <aYH9FwwOTD28Gn04@strlen.de>
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10589-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: E19B0DA246
X-Rspamd-Action: no action

Sun Jian <sun.jian.kdev@gmail.com> wrote:
> The nf_nat_amanda_hook pointer is accessed via rcu_dereference(), but
> it lacks the __rcu annotation in its declaration and definition. Sparse
> reports "incompatible types in comparison expression (different
> address spaces)" errors in nf_conntrack_amanda.c.
> 
> Fix this by:
> 1. Adding __rcu and __read_mostly to the global nf_nat_amanda_hook
>    declaration.
> 2. Adding __rcu to the global nf_nat_amanda_hook definition.
> 3. Explicitly declaring the local nf_nat_amanda function pointer
>    without __rcu to store the dereferenced pointer.
> 4. Using rcu_dereference_raw() to fetch the hook address, which
>    satisfies sparse's type checking for function pointers.

This doesn't look right, esp. step 4.  Why not:

diff --git a/include/linux/netfilter/nf_conntrack_amanda.h b/include/linux/netfilter/nf_conntrack_amanda.h
--- a/include/linux/netfilter/nf_conntrack_amanda.h
+++ b/include/linux/netfilter/nf_conntrack_amanda.h
@@ -7,7 +7,7 @@
 #include <linux/skbuff.h>
 #include <net/netfilter/nf_conntrack_expect.h>

-extern unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
+extern unsigned int (__rcu *nf_nat_amanda_hook)(struct sk_buff *skb,
                                          enum ip_conntrack_info ctinfo,
                                          unsigned int protoff,
                                          unsigned int matchoff,
diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_conntrack_amanda.c
--- a/net/netfilter/nf_conntrack_amanda.c
+++ b/net/netfilter/nf_conntrack_amanda.c
@@ -37,7 +37,7 @@ MODULE_PARM_DESC(master_timeout, "timeout for the master connection");
 module_param(ts_algo, charp, 0400);
 MODULE_PARM_DESC(ts_algo, "textsearch algorithm to use (default kmp)");

-unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
+unsigned int (__rcu *nf_nat_amanda_hook)(struct sk_buff *skb,
                                   enum ip_conntrack_info ctinfo,
                                   unsigned int protoff,
                                   unsigned int matchoff,
?

