Return-Path: <netfilter-devel+bounces-11833-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMiiMnjf22lNIAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11833-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 20:07:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F033E554E
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 20:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C340B30125D9
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DFB363C57;
	Sun, 12 Apr 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="O71YxBrf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB72D238A;
	Sun, 12 Apr 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017253; cv=none; b=FQf3y1gFk92VsdkFw+cwMl5KPGN/oYu/P74PzY/gzwplhxbavPY+tzn2NL8KMWvVhrlvGpaQSXGqv46J7WCmsN4MEodKxOdm2BIQA1AfVsMebWt/i01pXN1jZ47P+DRplAoif8vtyE0eKNRl/cZRDaO+wRMtIzv5Qqxi4C0nbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017253; c=relaxed/simple;
	bh=BlImpXzU1+FypWFY2NS5LdLFajvyLK5G2mmgfJe81H4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R/5A9fJDeMBzmGQZhPIFefnc2ByQT8OyjBq1dCXlwyEYsJiE/bjhLSvY8RiXpMdiejuQvieAF3t7M4A7ofhWAU2FJPE/WQwDP6qQuHipSvec/gtWdz0v16QoMl5Xqn5KJKOvxkfyYNWv7ZfbY5Mh2xfvq64JQLOY3Lucz38wOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=O71YxBrf; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 4547D210DD;
	Sun, 12 Apr 2026 21:07:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=7NuE3eIiaPEDL2WpXu4zuQg1p1lC9om6LlQ2mQwVTzU=; b=O71YxBrfWMD1
	WkHs1ML3CmhTrr7fYbCk72w1Md9kGjrLOoJggD7RWKCTEs+WaoSrlzsdIx0B/DfX
	bl91rx4GzQRgTT6G3njw7G9TbhfDYl68D7aHW6l3j5a30+qKyXrFJ0Mwo4XJs6/j
	z/1pyK/Z5V3fJqjO9EDb5TwvCwBiLIGCvPUn1w4cnEmWhnnvj8CCJNuM+rAShF9n
	JyElF79djQlcxKqi1FFmR2p38jQ76WWCBWHW3LkuapAbAGYpgazYRo9IazR1N2zv
	90skRi4eA6MsOhEHN0n/YNc/saGj4qsDR/Ywup1dwl2NbD17oHLwHIfZxyg10yBf
	p0dWclBa3XZ9uX3U07TJv+W8lqZh1ytuUjUhW0TiINCRwOsV32FxFSE1uTHPJrxN
	N/gp/z+7eYouUZ1QJ/+dqU5OZZxqClqv331HBzUHHNIZda8Luc4G/HNkRU8y8ine
	2hxatOMZpvDAJcafYIiTA2tHHhZOnTJh+EtRdHCI9Gj2EApJmkjOYmc7vaADqP5J
	HRBCsZMnfrhQeBk4lOMrwTZiG9UNrK6vzJOQzI5XsLb3SA1ZpeVc9ByNOTg84xEG
	4F/f1kCUoxDTSTfTgIASB7/PkQ6cov/RY6XXOkQlxOIRIOsa/6p31dMiX/FQVHQ6
	xtnRk7FjsiUe39i4+3IzekfsIYXpnp8=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Sun, 12 Apr 2026 21:07:19 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 7D10B6071C;
	Sun, 12 Apr 2026 21:07:17 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 63CI7FVS027800;
	Sun, 12 Apr 2026 21:07:15 +0300
Date: Sun, 12 Apr 2026 21:07:15 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Jakub Kicinski <kuba@kernel.org>
cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org
Subject: Re: [PATCH net-next 00/11] netfilter: updates for net-next
In-Reply-To: <20260412105344.5e14fe70@kernel.org>
Message-ID: <ac54646b-a857-9aeb-058a-49647298f8a8@ssi.bg>
References: <20260410112352.23599-1-fw@strlen.de> <20260412094049.7b01dd7b@kernel.org> <advOUl92VLlqaiCJ@strlen.de> <20260412105344.5e14fe70@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ssi.bg:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11833-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 30F033E554E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


	Hello,

On Sun, 12 Apr 2026, Jakub Kicinski wrote:

> On Sun, 12 Apr 2026 18:54:49 +0200 Florian Westphal wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Fri, 10 Apr 2026 13:23:41 +0200 Florian Westphal wrote:  
> > > > 1-3) IPVS updates from Julian Anastasov to enhance visibility into
> > > >      IPVS internal state by exposing hash size, load factor etc and
> > > >      allows userspace to tune the load factor used for resizing hash
> > > >      tables.  
> > > 
> > > Someone should take a look at the Sashiko reports for those, please?  
> > 
> > https://sashiko.dev/#/patchset/20260410112352.23599-1-fw%40strlen.de
> > 
> > Sorry Pablo I am dumping this on you.  Already wasted 3h on saturday
> > on LLM crap 8-(
> 
> Sorry, I was quoting the IPVS section of the PR because I meant that
> someone should look at the IPVS portion. The rest looked like a waste
> of time, indeed. The netns dismantle vs ipvs smelled like it could be
> legit.

	I'll check the IPVS part, there are probably
some problems to fix...

Regards

--
Julian Anastasov <ja@ssi.bg>


