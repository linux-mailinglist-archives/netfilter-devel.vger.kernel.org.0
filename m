Return-Path: <netfilter-devel+bounces-11596-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFDhJNeBz2mwwwYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11596-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 11:01:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 080073927C5
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439CB300DD57
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Apr 2026 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929637B019;
	Fri,  3 Apr 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlH3tOv0"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560232DB795
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Apr 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206741; cv=none; b=knDy+Ik5D5phv67SdNMKX44J+n2lZZJ8awTjUyA2qc+SZJ6+3XohvFzTC12wg4ynaxsja49RKisCMpGq1S7COHC2pYIeszbnwFX6I/kWv5jJvESSQWX88uPneimznVwXI8KjaLNP26HdPrPtk8Obj3K/P9Us8hcsNNWhNA9ku1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206741; c=relaxed/simple;
	bh=YevojrKCNL1XCJXq1Tjl5LLvxg4HtMIGNaTJzEBturk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElypMXvczcGOKn44ApLTpMyXA7RPS6AMrPq9/pUiwVKbmcD1LJmjlM0hpBF03ghhPgniTs+HB+BQ9CF8FZKoCRVilFkwpba/GjESlQWu4yy/spQVEGkYiQdjfuugdNpv0bLcfYwZF3WhOPgEdxlvsrtE8QZNEExtz9lT4N1wnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlH3tOv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5070C4CEF7;
	Fri,  3 Apr 2026 08:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775206741;
	bh=YevojrKCNL1XCJXq1Tjl5LLvxg4HtMIGNaTJzEBturk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlH3tOv0UdzbMho1r7jOGg8F5MdZoukDDe5pxdj/XNygEAWHNuUZZg+u4WHLZ4l5T
	 8zo3IpCSh4fJIO0QwmO1ztzBN11mYcBFsDesns4n6kjo5oH0sMxr+1YQKaEcS57AtN
	 gXqpmKW2GtmLCJ1UOVZZc9qK8yoXMmlQ2WdA+RcY=
Date: Fri, 3 Apr 2026 10:58:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tuan Do <tuan@calif.io>
Cc: security@kernel.org, fw@strlen.de, coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: nft_ct: fix use-after-free in timeout
 object destroy
Message-ID: <2026040320-karate-grunge-40e5@gregkh>
References: <69cf6d3d.630a0220.341f20.e8f2@mx.google.com>
 <2026040319-transport-grumbly-f884@gregkh>
 <CAH2O9gwyyD1WDN3AVbX8ZWB6TSG+s9s6C1vh1jERMVH-Osdu+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2O9gwyyD1WDN3AVbX8ZWB6TSG+s9s6C1vh1jERMVH-Osdu+g@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11596-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 080073927C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:46:44PM +0700, Tuan Do wrote:
> Hi,
> 
> Sorry I forgot to update my script for sending patch. Removing those mail
> addresses is fine, no worries.

You dropped security@kernel.org for some reason, so I've added that
back, and you top-posted as I asked not to in the future, and the
message was in html format (perhaps consider a different email client?)

> Regarding about the patch, the only difference is now I call
> "kfree_rcu(priv->timeout, rcu);" instead of "kfree_rcu(priv->timeout);"

Great, please always document that below the --- line for when doing new
patch versions so we know what is going on.  Remember, some of us get
1000+ emails a day to deal with.

thanks,

greg k-h

