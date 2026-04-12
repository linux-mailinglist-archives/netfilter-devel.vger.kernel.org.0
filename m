Return-Path: <netfilter-devel+bounces-11831-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hw4My/c22lMHgkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11831-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 19:53:51 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CCB3E53EC
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AAA530071E3
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33D32F749;
	Sun, 12 Apr 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDAHeH4f"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE129A31C;
	Sun, 12 Apr 2026 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016426; cv=none; b=jcDAET69AB7NnfcA6sn5RD/khKBsZPWerVcrMDVWp9KekOVYKZDEPp3siMPklrwLoF7NM9ah1ZLpvAn4b5/lJtx1T1qLf1jmoVS+Djzr4ZicN2ul23hS7srU/asFx4iDF/ztE/Z8ExY/T+BGhNgqzNEtDCEw2OMf57GUi5NOz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016426; c=relaxed/simple;
	bh=FRke6uFOzqmVr6CV9Wltmx8AT2pOkPD4BOcGv3qORn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0w5pqLm/HugspK7EOFZ+roaKqVwqvMzPC/PMYDvF6d2HBOwg7fuS4zAbOXx6xwvlnI9ttGhCy1GzZXFmOZQlxk6IBWjqIUyUPAyZceBAF8EERLlYzV/AjQiVC+CF0Tz0kpiW8jlQ78UuxtNyjGjiZw+pvZOeElNz5pzZT5O2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDAHeH4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774F7C19424;
	Sun, 12 Apr 2026 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016425;
	bh=FRke6uFOzqmVr6CV9Wltmx8AT2pOkPD4BOcGv3qORn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YDAHeH4fE9/7Ktt2ugNcmV12dxHxP1QZSEd5xsSaUQJm0JHpNuiHY349xM/TpBCXu
	 1y0JBKUjMFPHpa5sk+qJRI6zGpfqTi/5opvdKbUQ2h03xeVR6ZGCHMZCR/rt1MY2yv
	 IbUTetsAjBioYnXY282zWmTRnPFIt/8bqsbzva4cRDs9eCg7Umgt1LeQbwEq+Wxyg6
	 zZMk0UaupV4XCn2HfoYBGG2OzjFfLby/YcQlcckrtaWTy/jt6Zqg50yTv74H5YbIUV
	 k6zmJsmPLwGZGnSWTgTw+M+X6OR6BSephh3ueDjKt4c7Mdv2vzHiLJ7JnUqUgt3WX/
	 QNUjfn32L20jw==
Date: Sun, 12 Apr 2026 10:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH net-next 00/11] netfilter: updates for net-next
Message-ID: <20260412105344.5e14fe70@kernel.org>
In-Reply-To: <advOUl92VLlqaiCJ@strlen.de>
References: <20260410112352.23599-1-fw@strlen.de>
	<20260412094049.7b01dd7b@kernel.org>
	<advOUl92VLlqaiCJ@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11831-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 30CCB3E53EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 18:54:49 +0200 Florian Westphal wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri, 10 Apr 2026 13:23:41 +0200 Florian Westphal wrote:  
> > > 1-3) IPVS updates from Julian Anastasov to enhance visibility into
> > >      IPVS internal state by exposing hash size, load factor etc and
> > >      allows userspace to tune the load factor used for resizing hash
> > >      tables.  
> > 
> > Someone should take a look at the Sashiko reports for those, please?  
> 
> https://sashiko.dev/#/patchset/20260410112352.23599-1-fw%40strlen.de
> 
> Sorry Pablo I am dumping this on you.  Already wasted 3h on saturday
> on LLM crap 8-(

Sorry, I was quoting the IPVS section of the PR because I meant that
someone should look at the IPVS portion. The rest looked like a waste
of time, indeed. The netns dismantle vs ipvs smelled like it could be
legit.

