Return-Path: <netfilter-devel+bounces-13695-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgcDO7sXTWrouwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13695-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 17:14:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9F71D1E6
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 17:14:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13695-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13695-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA54F306FEA9
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDEF3DCD9F;
	Tue,  7 Jul 2026 14:58:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D833749F1;
	Tue,  7 Jul 2026 14:58:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436307; cv=none; b=UwuI5oe1vVbwX4TlWPPu+rgS5RNVJCTRRlF1Y9uOfZ3OVt/jFFhNCcgUIN42Cy0Y0E1y1Y3CZMVWA4u8ZHpzgSduOqWvrCqWR6okddnv5YarBr7JcVsMPz6SVHxTDdTu8kHpewt0Uwyy65+/xef/1CN1cW3PVfk1pNfDYWP8wIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436307; c=relaxed/simple;
	bh=gkT4fBpYj7Wq2Ei/WmCz0J1IQbcqQSzsmjcTji6ZxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7sjKa35MNPNbNkDy6ySvrTKMVEjCfokWIHkO24OT0X2+o5PUFoaG6lg7tqLWhI98OFFnnAKyBhIexLV9NOST9n35JRHJ7We3PGp83Q+I8CBZjRZqSPYu9UO5L6oC73Jse8dKazFkz7Re2YtErSrHZgM0TmWdlkYdlwmj2qej+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A06D16032C; Tue, 07 Jul 2026 16:58:22 +0200 (CEST)
Date: Tue, 7 Jul 2026 16:58:21 +0200
From: Florian Westphal <fw@strlen.de>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_conncount: fix zone comparison in tuple
 dedup
Message-ID: <ak0UDVc4gZbfzrtM@strlen.de>
References: <20260706114820.74006-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706114820.74006-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-13695-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFB9F71D1E6

Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn> wrote:
> The "already exists" dedup logic in __nf_conncount_add() decides
> whether a connection has already been counted and can be skipped instead
> of incrementing the connlimit count.  It compares the conntrack zone of a
> list entry with the zone of the connection being added using
> nf_ct_zone_id() and nf_ct_zone_equal(), passing conn->zone.dir or
> zone->dir as the direction argument.

Right, thats bogus.

> @@ -211,8 +220,10 @@ static int __nf_conncount_add(struct net *net,
>  			/* Not found, but might be about to be confirmed */
>  			if (PTR_ERR(found) == -EAGAIN) {
>  				if (nf_ct_tuple_equal(&conn->tuple, &tuple) &&
> -				    nf_ct_zone_id(&conn->zone, conn->zone.dir) ==
> -				    nf_ct_zone_id(zone, zone->dir))
> +				    nf_ct_zone_id(&conn->zone,
> +						  nf_conncount_zone_dir(&conn->zone)) ==
> +				    nf_ct_zone_id(zone,
> +						  nf_conncount_zone_dir(zone)))

Should this be a simpler:

                                if (nf_ct_tuple_equal(&conn->tuple, &tuple) &&
-                                   nf_ct_zone_id(&conn->zone, conn->zone.dir) ==
-                                   nf_ct_zone_id(zone, zone->dir))
+                                   nf_ct_zone_equal(&conn->zone, &zone), IP_CT_DIR_ORIGINAL)

?

The tuple is always the 'original' direction, so it would follow that
we should not care about reply zone dir.

Also see:
https://sashiko.dev/#/patchset/20260706114820.74006-1-zhaoyz24%40mails.tsinghua.edu.cn


