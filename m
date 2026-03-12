Return-Path: <netfilter-devel+bounces-11171-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEtZMzJHs2luUAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11171-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 00:07:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2B427B283
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 00:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3AF1302496E
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB643CCFA4;
	Thu, 12 Mar 2026 23:07:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308EA2FBDFD
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773356846; cv=none; b=P+WiJ77Wgekc36R/SKYT62S5SRbPD/LEWYGH3vNGsmaSQDK5jkQ0uQaWzfXZgvnC6UHiBapfWVFFhsKQqPIgR+ribLYEBvizRe9BHDpFT4r4ThK4auO+xX3YHSky4yA/Jxh72Ln5s71kyKVhpHbm6BjcuYKsDt3dIV9s9MZlZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773356846; c=relaxed/simple;
	bh=vafehKGs/13JZFM1/JFwOlVW6zEpKJ7SNj6ZGqArONs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY9C3mPWyjEImzVw+hacqqoyqum0ltZvh0/jxwlYgQCpQSQdXBdabMWQcodG+BzthGySmj0E/+8pYTdXSmO+THYptDFPvhD0RI45yqHb/ezwu8I+6neQSvusQpDuOQAtmhTgmTFGJYtW8bWuQu14JAbztjPd1jGsdyeqUcdq1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 26C6160470; Fri, 13 Mar 2026 00:07:23 +0100 (CET)
Date: Fri, 13 Mar 2026 00:07:19 +0100
From: Florian Westphal <fw@strlen.de>
To: Guanni Qu <qguanni@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org, klaudia@vidocsecurity.com,
	dawid@vidocsecurity.com
Subject: Re: [PATCH] netfilter: nf_conntrack_sip: fix OOB read in SIP URI
 port parsing
Message-ID: <abNHJ2kxObiQjdz3@strlen.de>
References: <20260312145506.2192682-1-qguanni@gmail.com>
 <abLdnHeh8lEKqqB-@strlen.de>
 <CAFzOa17VwKpnyLjejeBbAJ9XnbuykDVzb0-5HLsPDSdW9aG_JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFzOa17VwKpnyLjejeBbAJ9XnbuykDVzb0-5HLsPDSdW9aG_JQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11171-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C2B427B283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guanni Qu <qguanni@gmail.com> wrote:
> You're right, the minimal bounds check isn't enough. The simple_strtoul()
> call assumes a NUL-terminated string, and the SIP packet data in the skb
> is not guaranteed to be NUL-terminated. The current code relies on
> incidental zero bytes in skb_shinfo.
> 
> I like your sip_parse_port() approach. I'll take it, wire it into
> both call sites, and send a v2. While I'm in there I'll audit the
> rest of nf_conntrack_sip for similar limit violations and send
> anything I find as part of the same series.

Thats great, thanks a lot!

