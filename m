Return-Path: <netfilter-devel+bounces-13554-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XsC1MOY3RGrYqgoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13554-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 23:40:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F36E82E3
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 23:40:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b=VT59Lh7U;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13554-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13554-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ssi.bg;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C0FB301D964
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514452FE057;
	Tue, 30 Jun 2026 21:40:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691F26F288;
	Tue, 30 Jun 2026 21:40:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855636; cv=none; b=WgRvlap0kRz8i0iPuBjvkIDNubHtdnA2o2mWmm0xmVhtiwhmuTmZVsJIchlMCUdcP8QZhSgTgnYZx1rAJBHwzx3ZR7t8mMF3YPWMJ4bihT0l0Vj2Bjz4W+T2+GlAFNH2ODdsfTNjNV8o36fXM3yzI/7GTwN0t7hOioBu05jQA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855636; c=relaxed/simple;
	bh=cidPpSmRw86dmcsShktHuuN/gqdJP0/6w73Q/wKl0Eg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ooYBgzx9hfSAmpKZRW3zGT4maGcwzfP/VNba/albOGIUvDI6mj2XVVrMWhAXaQo5ZzwAu35pWxrPn0hA8RQh37WOOLiOc+BQF9vd3Bjnt/ao9Qt8CSfDsxPlzGsD0tbmuId7LUt9FsLRdQCS5yHd5UaGoXS0nyFtE7l4FA0DoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=VT59Lh7U; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 118C9229BC;
	Wed, 01 Jul 2026 00:40:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=LfVzUtj7t2pFA4EZlPfYp3eYCTmQyOUUd24ILbKanLs=; b=VT59Lh7UkP7q
	BUKxNQj7KQ6nNnuuR/4suPGY3hunVoUQNzFg/a31k9vVEAnxHpmkG8jpJWxcicTf
	atPVGhX7Y5FLFx17TBZ09zj91PQafW2KER0DTE5FlouXiejCaUTz/c5ae0wRdorK
	lObZPN+vZ5+X9LJC7fscQkmeCJp/rQIpY2ZGZyRpeUJ7yI1uE9BNYD+tpT3UYwv2
	VPk+6NOxOKABiWi8ELP1AdZett/iN2gFI52Pa+WRwQ/nBIsty0AnY2kIjm1CUxU1
	JD082MfefoqtJ+Ec/rQx+55CqVd91RWuSWE6HUwS0RxpVRDO1tpL61mOOuu8MZQu
	Y/DDkTE+XiEtKs5uD1TMkWJKP4rqUJsDgda7yrZ2opnzLCezMZ50m0iYH8LS9NvV
	3sS5X87bZmOz+o/MUug8+6MgN4LQ/cwROK8LnVRr4GiNQ+vdc8LRtKR/cNVAxiDQ
	Lu2w0ZFL49PqbknQszCJwH6X2VUER7dPh0fuyZ2fmx7vWIX3tNMOx9x/NxW/EzXK
	RkdkmppgTm+aAWT/swId2R8YJhZ5wbv+Rb+RSUdXNzNIwfWmZ8irVxtC59lYI7/c
	BKNf9Ib8rKAfNhNE5rZtW3hCZ95m879RQtHOqktZVboBnAOQ8X2VMJ3qDjvGdz+u
	/sSFQP9kyoQU0Hfxy1Te44nRCBX1Yho=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Wed, 01 Jul 2026 00:40:27 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 22551607C6;
	Wed,  1 Jul 2026 00:40:28 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 65ULeO8m137212;
	Wed, 1 Jul 2026 00:40:24 +0300
Date: Wed, 1 Jul 2026 00:40:24 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: tt roxy <roxy520tt@gmail.com>
cc: Ren Wei <n05ec@lzu.edu.cn>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yuantan098@gmail.com,
        yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
Subject: Re: [PATCH RFC nf 2/2] ipvs: adjust double hashing when fwd method
 changes
In-Reply-To: <20260630193647.125280-2-ja@ssi.bg>
Message-ID: <1a1ae0df-15bf-2827-cb23-a144a8591783@ssi.bg>
References: <CALMqdkR704S2BG_QD_bgHTFp2+1QCi7n0T4zoZyTo8mDZevYSA@mail.gmail.com> <20260630193647.125280-1-ja@ssi.bg> <20260630193647.125280-2-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13554-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ssi.bg:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E6F36E82E3


	Hello,

On Tue, 30 Jun 2026, Julian Anastasov wrote:

> Synced conns can be created with one forwarding method
> and later updated with different one after the dest
> server is configured. This needs adjusting the hashing
> for node hn1 because only MASQ supports double hashing.
> 
> Modify conn_tab_lock() to support seeking for hash node
> hn0 together with adding for hn1. By this way we can
> safely modify the forwarding method and hn1.hash_key
> under bucket lock for the first node hn0. The forwarding
> method is also protected by cp->lock as it is part of
> cp->flags.
> 
> Reported-by: Zhiling Zou <roxy520tt@gmail.com>
> Link: https://lore.kernel.org/lvs-devel/1b914f41d725bc064c9ba9830dc8169329737270.1782540466.git.roxy520tt@gmail.com/
> Fixes: f20c73b0460d ("ipvs: use more keys for connection hashing")
> Signed-off-by: Julian Anastasov <ja@ssi.bg>

	Ignore this patch, it has many issues to fix,
I'll send v2 after 24 hours.

Regards

--
Julian Anastasov <ja@ssi.bg>


