Return-Path: <netfilter-devel+bounces-11698-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKjFFDxI1Wk44AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11698-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 20:09:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E29373B2C42
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 20:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B66E1300E3E8
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AAB3B389F;
	Tue,  7 Apr 2026 18:08:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64534EF05
	for <netfilter-devel@vger.kernel.org>; Tue,  7 Apr 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585337; cv=none; b=l2DttbI1J6PwF8LqZ9ZHvLWX2Jgeu4TWS2UJKZAYDG6dmc3dn25BTbrdYW9BaotGxyewQHiNulHd4V26OXP6cmYX4uo/WH+NqFQyqA5pt5LfbpOLbVk/nc/c6hW3n9M47i4OWfnxRWzicY5YM2aDth3RWgtDMvwEIIE5Kjb16Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585337; c=relaxed/simple;
	bh=BgP9YTtKtdp11V1qurfEh6r6WWSsqXAYo4cJFs8lW8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+m1XSybh+XI4Dxg9jTweABP0ioSE8K7AEXLekbmWkCFcSENJo3/LrZ3/kkhojcbQZCOOs5RRdAxmZ1rVkf6oWUU+A/17FIvj09DrvtyNKmv4LwHgfkWaTjeMNTqNPoi7SI1I652v3m6vgppLxWTTPSGSJBOG1xy+hEf3awtbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A388B60660; Tue, 07 Apr 2026 20:08:46 +0200 (CEST)
Date: Tue, 7 Apr 2026 20:08:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
	pablo@netfilter.org
Subject: Re: [PATCH nf] selftests: nft_queue.sh: add a parallel stress test
Message-ID: <adVILlipGGN76rcw@strlen.de>
References: <20260406211831.3758-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406211831.3758-1-fmancera@suse.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11698-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.972];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: E29373B2C42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
> index ea766bdc5d04..1e1949c6a918 100755
> --- a/tools/testing/selftests/net/netfilter/nft_queue.sh
> +++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
> @@ -11,6 +11,7 @@ ret=0
>  timeout=5
>  
>  SCTP_TEST_TIMEOUT=60
> +STRESS_TEST_TIMEOUT=300

I changed this to 30s, I think the full 5m dance is a bit
too long for the selftest.

I know 30s is likely not enough to trigger the bug reliably but given this
test will run may times per day on netdev infra I think 30s is ok.

