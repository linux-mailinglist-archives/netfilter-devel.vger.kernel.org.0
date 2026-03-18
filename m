Return-Path: <netfilter-devel+bounces-11274-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAYdDVfZumkycgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11274-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 17:56:55 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727A2BFBA9
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4793338E546
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4F3D649D;
	Wed, 18 Mar 2026 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Cq0poo8Z"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0E3D333D
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851003; cv=none; b=To5pjPgEEz4EU8Re+fra4gZlcXZrO/LS8FjWUya/G1HYieO4bC2l10O04gcrunq1FOY8otGGvPaC+Yt8NbXErK/UYgyxnqHNEg1r87UC/Na4iVwV85daZWkVw+zEHYVnXoHsdCOSQZOJes8S/QFDy9X+jkzF64nTNHzaWYp+6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851003; c=relaxed/simple;
	bh=p1F8Sn20b3QxUsuCFzfi80nxEWRheD8p+QZAcFqTKOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMRIy23Kby+DV/uXj50iCCutOPHXdrHWPwONOKwe66PStQy1ZjF0Lb5ULmzpMwYmtwycZHXnIT0hKZbtYOcOtj7TPlPK0iOA3ffSMtF1hpSSlgIR01XP6Uf8YpFYsTzO1dj1HS76zp15k19Lm/ZDUx27+X9YwVL41aaPISkDA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Cq0poo8Z; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GuTYUyLS6U4U+/UVZBLW5YXCUKGvwXKeJpOsg1rNfdQ=; b=Cq0poo8Z1pUqqsiok4fjkaJk/p
	z1+nHcqXZfV5uFCAZm3Zcw5XpU0JpYUbWZ+c+IWwJ8pQXuZPsEwmEc+xqSmfz+ERxdDgUxhAsYYUi
	nZ6rfGwacfOgtcHqrYTTw7YlpBj/kFfDWN0bn4GIA0c2NOGiD9jfklFeXmK6AwMTVg+iY+/P19Xyq
	RFIsHi1tpCXnC1ovJHjUto7tUa0MKPxIkhjH4c+t+K5RcPWurBQvlGJp22MGaHy5Ed5OT2/uDsS1E
	VW+yZGvFXf0Wh5R4IKdZtvH4touemt5QtqRuJFHh4Whw5gAsMtGW6KUJXwdP2x0r3Ftcafwo4owPu
	Wk/HQHvw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w2tfw-000000002y3-48jR;
	Wed, 18 Mar 2026 17:23:17 +0100
Date: Wed, 18 Mar 2026 17:23:16 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
Subject: Re: [nft PATCH 0/5] Enhance cache filter for list commands
Message-ID: <abrRdC2OXLyj6xnt@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
References: <20260310231115.25638-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310231115.25638-1-phil@nwl.cc>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11274-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.153];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: 9727A2BFBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:11:10AM +0100, Phil Sutter wrote:
> Reducing the amount of data fetched from kernel improves performance
> with large rule sets but also reduces adverse side-effects if multiple
> versions of nftables access the same kernel rule set. Being able to
> ignore parts of the rule set one is not interested in allows for (more or
> less) safe coexistence if each tool is operating on the data it created
> itself only.
> 
> This series reduces caching for list commands which specify a family
> and/or table. To help testing this, patch 1 extends netlink debug output
> to include chains, flowtables and objects so a test case may check if
> they are fetched or not.
> 
> The remaining patches actually increase filter use.
> 
> Phil Sutter (5):
>   cache: Include chains, flowtables and objects in netlink debug output
>   cache: Respect family in all list commands
>   cache: Relax chain_cache_dump filter application
>   cache: Filter for table when listing sets or maps
>   cache: Filter for table when listing flowtables

Series applied after inserting suggested Fixes: tags.

