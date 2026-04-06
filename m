Return-Path: <netfilter-devel+bounces-11639-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNtXHTvp02n/ngcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11639-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Apr 2026 19:11:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C43A5986
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Apr 2026 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42E853010B94
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Apr 2026 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A4390238;
	Mon,  6 Apr 2026 17:10:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34138E5E6
	for <netfilter-devel@vger.kernel.org>; Mon,  6 Apr 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495442; cv=none; b=kg8PgDF88cwseABsoY3qgnxlwJJg68K+vGOiO6o4t3YcpUQGLnYw1KrbPQvE96i7VO9/gmVqRgQq47hB/XQxx1YEvYo262ihs0Cv58Netqnki917Y0zQnlaJ0K99HHfJl07lUJscgOH7W5HW+kWA2LTZsVFuLFk6opJs3lH3tbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495442; c=relaxed/simple;
	bh=hy758M1SMaZPHBQSWazJ1NGFIrxN86oFewL4Jk4UyQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPRwwTo6k6+E8Ud71sl293a5j6P9ILPiAi6fk90K7C4aUafFasl9tcmNOEBfu8pKwCJzoR6AlhxL/pOz6cLEF3TxD3YRmv9lfeUflJ3v46m8ujRXnW+E/Sh9nw8Tja0jwrXbB7DVi0keIHCSAMR+uzMXTFw+7n9xKdfGsnWbIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B0A2E60636; Mon, 06 Apr 2026 19:10:31 +0200 (CEST)
Date: Mon, 6 Apr 2026 19:10:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>,
	netfilter-devel@vger.kernel.org
Subject: Re: nfnetlink_queue crashes kernel
Message-ID: <adPpAPURumLBRrp8@strlen.de>
References: <ac-w6e33txkgTRJj@strlen.de>
 <ac_EY9ciqt5yQ6wr@strlen.de>
 <b0c495e4-2137-443b-986e-ed0c10251d0c@suse.de>
 <adDccAnxkl4to_ta@strlen.de>
 <867c1ae1-66b4-4584-985a-38a4f7d55925@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867c1ae1-66b4-4584-985a-38a4f7d55925@suse.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11639-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.620];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 221C43A5986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> On 4/4/26 11:40 AM, Florian Westphal wrote:
> > I had a go at adding a stress test but its not
> > triggering for me even if i run it for 10m.
> 
> Bingo! I modified the test you attached a bit to include your 
> suggestions and I got the splat on virtme-ng when running the test. See 
> the whole splat attached below.
> I am going to test your proposed patch and check out the results. In 
> addition I will do some cleanup and send this as a formal nf-next patch.

Thanks Fernando, this helps a lot.

Given the revert isn't clean and the per-queue ht fix isn't larger
than the (modified...) revert I am still considering to apply the fix
to nf instead of revert + nf-next defer.

