Return-Path: <netfilter-devel+bounces-11586-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFjALIJozmmpngYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11586-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Apr 2026 15:00:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F5238956A
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Apr 2026 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD6230A8C0B
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Apr 2026 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7F185B48;
	Thu,  2 Apr 2026 12:52:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623121D3F3
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Apr 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134374; cv=none; b=lIRDCH6o6QS2ypxesr2h+nF6azEKV1C3vLq5ueopMRDYSZqyUYkWgq39kVE3Nf0fZbFwae0EF0SKwn+UmLop6MwO5v0J+f3/ZZURpBrzrTK4isqqH8+YZZcmIepOTvDu33UfTycQtYvKly96ak75XSsaO4EF91AnegiqpPqkUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134374; c=relaxed/simple;
	bh=m8fT22bK4jZgmMtklo5Uitcr2mST6ljKcQuDRf/wBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNwXbCiALIRd8hMao9xTQZ8N3TP2a923x2EFRrx0cvfBYEVqVrTYX25pbNU9VqxVtDLFuuqtNzJrjglkcrYjsi2skUyNJKO+UkkpUNtG19nxC+5cmC5OotFIZdU2Hsy8psw3vNH9kpJ3cNPf3OjJ6wBTDn/+cbBPzNn+NWVXXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 265DA6047A; Thu, 02 Apr 2026 14:52:46 +0200 (CEST)
Date: Thu, 2 Apr 2026 14:52:48 +0200
From: Florian Westphal <fw@strlen.de>
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org, klaudia@vidocsecurity.com,
	dawid@vidocsecurity.com
Subject: Re: [PATCH v2] netfilter: nf_conntrack_sip: add bounds-checked port
 parsing helper
Message-ID: <ac5moJzDjXNUSXKI@strlen.de>
References: <20260313195256.2783257-1-qguanni@gmail.com>
 <abSfgVpCQcFWwNEs@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abSfgVpCQcFWwNEs@strlen.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RSPAMD_URIBL_FAIL(0.00)[strlen.de:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11586-lists,netfilter-devel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: 74F5238956A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Florian Westphal <fw@strlen.de> wrote:
> Jenny Guanni Qu <qguanni@gmail.com> wrote:
> > +	/* reached limit while parsing port */
> > +	if (dptr >= limit)
> > +		return false;
> > +
> > +	if (port) {
> > +		if (p < 1024 || p > 65535)
> > +			return false;
> > +		*port = htons(p);
> > +	}
> 
> I like the port range check, but should we make this universal?
> 
> 	if (p < 1024 || p > 65535)
> 		return false;
> 	if (port)
> 		*port = htons(p);

Ping, will you send a v3 or do you expect us to take over from here?

