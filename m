Return-Path: <netfilter-devel+bounces-9500-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC168C16828
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Oct 2025 19:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EA504B10
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Oct 2025 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DD345727;
	Tue, 28 Oct 2025 18:33:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105A29B793
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Oct 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676402; cv=none; b=puk7GAE+GylL12jRl9K+4XqJkSBsRJPk6fb76q5ZKocQZVAxNpVr7BUE95rM8OYeKlvENmtjUfJtv4CI5BLOXGqic5/Pi4ezXwzr9WGSu2IZ+NSbqSgJArhS4aQoe44F7JeRuerYbMRTgScjr0WMhO8m+eSMRH8ubnwXqXGr218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676402; c=relaxed/simple;
	bh=p6c27DCYAS2xLBcYCoAyVVPJFTUA9fWbMkP+ijVd2Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT2RMJv9MEJi6+01UIUngDIP9km3QpiNbCu/kE5vy8nxmVSeMB11cF8V0JIY+pL/NQfEkx1i5BM6UG/C6J8wmDgFQRyoXj5ds2mLwIcHvn7HR06ohuSDZr8/dP+MsklIn9ueMKmF5H6V8aRn1S5hEQfdWCVMisMCUceByLHS5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0F92B61B21; Tue, 28 Oct 2025 19:33:17 +0100 (CET)
Date: Tue, 28 Oct 2025 19:33:16 +0100
From: Florian Westphal <fw@strlen.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	louis.t42@caramail.com
Subject: Re: [PATCH nf] netfilter: nft_connlimit: fix duplicated tracking of
 a connection
Message-ID: <aQEMbKZUBms2bfuI@strlen.de>
References: <20251027125730.3864-1-fmancera@suse.de>
 <aQD2R1fQSJtMmTJc@calendula>
 <aQD4J7pI-Fz1V3eC@strlen.de>
 <aQD5PUkG7M_sqUAv@calendula>
 <aQD810keSBweNG66@strlen.de>
 <fdaccdd2-fce5-4224-9636-bf3366de2761@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdaccdd2-fce5-4224-9636-bf3366de2761@suse.de>

Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> We need this gc call, it is what fixes the use-case reported by the 
> user. If the user is using this expression without a ct state new check, 
> we must check if some connection closed already and update the 
> connection count properly, then evaluate if the connection count greater 
> than the limit for all the packets.

I don't think so.  AFAICS the NEW/!confirmed check is enough, a
midstream packet (established connection) isn't added anymore so 'ct
count' can't go over the budget.

If last real-add brought us over the budget, then it wasn't added
(we were over budget), so next packet of existing flow will still be
within budget.

Does that make sense to you?

> Otherwise, this change will introduce a change in behavior.. AFAICT

Yes, the existing behaviour is random?  (Due to multiple re-adds).
With NEW/!confirmed check: no multiadd possible, so no need to ad-hoc
gc.

Did I miss anything?

