Return-Path: <netfilter-devel+bounces-12773-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKpXCJaOEGqIZgYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12773-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 19:12:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB685B800D
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ADDA300D901
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA094418FF;
	Fri, 22 May 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="7YKXerUf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7823BB9F5;
	Fri, 22 May 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469967; cv=none; b=NQrVqatqznmqCjDSfFVbXZWCKQdAlsIIs1CyIWmTphK34yg57Ziy/chlhozS42Ynzgue4lNQQ7ucyjyeOxv/YzNulqWcN53Xl1d47M9G+TNpbfef++lvW0WU8kiIUb0RNagUibXh7umBB8dCQXwryUj86EB8xM4kIYrjf08iR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469967; c=relaxed/simple;
	bh=9TD24qnXKMXs/pwYGcu89Ppk3LT3Qlww+EtwloKv0jc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=czAx0pL8f8VgI/Ij7BXQ/HftW8UjlLuEiivo8Xc0Wac3Yn7JPSjkFi/tEHpnzd69qr3B02tRt84tWkBajr927yMC0yQqGhX7Nk0woWMDWjPRkr9qk7vaT2L9EkQQcgHhKIwfPvUkE+4oRMUHL9g7tgGl3KPu0XY1tOlYSs6fGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=7YKXerUf; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 615EB20FC0;
	Fri, 22 May 2026 20:12:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=TX52SlEc4bVbz/ss6p+x7zupauqWfmmslyf1wMLcJLg=; b=7YKXerUfjbCU
	VDT+Kaw1fiLv/MLa7/F6AHqli/LfcbrmUjQvgCoaVtLuJeKZ1ttnzem6+ls77fn9
	BY0K3NFR5pIcZFYRTBe7rHSUlPv3QdowAXHLLB8v+HRIqc5YRTjkGbMXLm7aCfnE
	O9XFnm1Q8iEhcrOUlLuN7hkZgjUfPaErp+6W29GwzhpToq+s+bPZGXAZUS1cbQmC
	J4t7AsRpGdccHDxU5yfRBhgPAGIXiswtjOZ37LShFVCOM9pYqh2/og3FQYqxL1EU
	cKnILzBBa8Zl9midBNDORa7pv3BfZy6s/oJOT6P3XDoD1aUTSRLK5I8/w8i89An6
	S2xuKpWEKzZmIdGRxfiKDNInaUz7gOVhjNPT043atWhcYe2nmW38QsOzPjanumvr
	STXEQ7evJqysHVXk5I6aoUVeUtk6RTlzHyVnjksompsXRJAhMqu0Bu8UI7Y4qEgJ
	pglvCcJYtLHeUMLJrFK2Veat1u3wPyU/S+Y8PX8CqH0trDEWjdNvB4KHrZzmRJEz
	VZzE5qChc+UeGqijDgREvAjtipVp8DmKZgFF8+gkp3hubcfmBxxnR2RhWmXQ0Ca3
	3+GKvR5U20rua/2DQC1QV6PKRfZre1O2PF9frvBUBGBtJFWuVxFVRaqfqxOEEIGj
	wE5+BUh02F8NTMmUZ1X7d7IpRE1rCj4=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 22 May 2026 20:12:40 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 3482F60400;
	Fri, 22 May 2026 20:12:38 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.1) with ESMTP id 64MHCW9P042584;
	Fri, 22 May 2026 20:12:32 +0300
Date: Fri, 22 May 2026 20:12:31 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Rosen Penev <rosenp@gmail.com>
cc: netfilter-devel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:IPVS" <netdev@vger.kernel.org>,
        "open list:IPVS" <lvs-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipvs: Use flexible array for MH lookup table
In-Reply-To: <20260519015506.634185-1-rosenp@gmail.com>
Message-ID: <ae2ed619-0562-afd8-1141-56116e9da68d@ssi.bg>
References: <20260519015506.634185-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12773-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CCB685B800D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


	Hello,

On Mon, 18 May 2026, Rosen Penev wrote:

> Store the Maglev hash lookup table in the scheduler state
> allocation instead of allocating it separately.
> 
> This keeps the lookup table tied to the RCU-freed state lifetime and
> simplifies the allocation and cleanup paths.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

	Thanks for the efforts but it is better to keep the table 
allocated separately. As Sashiko [1] points out, the table size is
properly selected and we risk double-sized allocations if we apply
this patch.

	As for the problem in ip_vs_edit_service(), I have to
provide separate bugfix...

[1]:
https://sashiko.dev/#/patchset/20260519015506.634185-1-rosenp%40gmail.com

Regards

--
Julian Anastasov <ja@ssi.bg>


