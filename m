Return-Path: <netfilter-devel+bounces-13611-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RyrDMuJ+R2orZgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13611-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 11:20:34 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E327008E8
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 11:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=pSbTqjBI;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13611-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13611-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01164304E433
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AD39E9DE;
	Fri,  3 Jul 2026 09:14:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556993793AD
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jul 2026 09:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070088; cv=none; b=dDJ60iGiPwLLGpoUjgDin0SFNCH/vGE+scXlFliiVDaw2pswDf6Q0FAbWkTVZYoG1pugl67PyUbndmMyJz7Is5AHj7JojlQgxeaJkm3djT7IkxKsql5phbEf5WjFSBJROTxphPt+eaOt+iF46JNBW8KK/+wWJbAkiPSs3YS+g1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070088; c=relaxed/simple;
	bh=5dO80+DMeb5x+gAz9ge4PaVJ0AlcHfRsW75OgL8yY4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy1CfU88G6z7Dcfp6iXhB0dat87/8XQzjKy271A3I3UaXRsgbR9Scd+vVJfjJsIkRen+9gjbk0L7tQGRYNckl9qTBiOniGstYDADaUWl5QmGM2ZIf0xjfSoLc4iYzmiYS2UGS8iiJlBv1Fs85mYmfe16XpfkSaXmzbUlDDrVpKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=pSbTqjBI; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sUrmmbTO1a0QNlfRiDU8UqHITSX9AYb47Rv35w8jNvs=; b=pSbTqjBIt3TlN8rfgA/gBKF8hb
	AWQPEeFlj76BPlM9fdA8/MMNtcL4Lf7fAtxxPXS98QyUA7hcaw8Uk/BEhX/es5Bm6birU/GeK83Ea
	ix6YM1NP4r8Oytx3TWej5ACnYcjTKgMXeY27uTjL+pDXdlemniKrcdAfIlAnaufnqwQxt++xRBRDU
	pwnFfyuFACSfadeQPsgZYoOfZ/9zdbpU/+JeiCdBIseyR4iMWQVW+9JsD17HuSYbT4XWt2+W+Hi0j
	FA+rgk2SMqM+2TT12nwGMLULuxWCubIGlUE10cFVMxeFzxGV4IoySVq36kklKJVvWfifQzzosEATg
	nKiSrY8Q==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wfZl3-000000005rm-3hDb;
	Fri, 03 Jul 2026 11:00:25 +0200
Date: Fri, 3 Jul 2026 11:00:25 +0200
From: Phil Sutter <phil@nwl.cc>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, yuantan098@gmail.com, dstsmallbird@foxmail.com,
	chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf 1/1] netfilter: xt_time: reject pre-epoch calendar
 matching
Message-ID: <akd6KZo1lwQ719d0@orbyte.nwl.cc>
References: <cover.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <779d223ad31c493cbfc3c483293e435dca89cf90.1782879547.git.chzhengyang2023@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779d223ad31c493cbfc3c483293e435dca89cf90.1782879547.git.chzhengyang2023@lzu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	TAGGED_FROM(0.00)[bounces-13611-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:enjou1224z@gmail.com,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,strlen.de,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foxmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:from_mime,nwl.cc:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29E327008E8

On Fri, Jul 03, 2026 at 03:32:43PM +0800, Ren Wei wrote:
> From: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
> 
> When XT_TIME_CONTIGUOUS handles a cross-day daytime range, packets in
> the post-midnight part of the range are matched against the previous
> calendar day by subtracting SECONDS_PER_DAY from stamp.
> 
> On the first day after the epoch, this backdating can make the signed
> time64_t stamp negative. localtime_2() and localtime_3() then feed the
> value into unsigned division helpers and derive wrapped calendar fields.
> In particular, monthday can become larger than the valid 1..31 range,
> leading time_mt() to evaluate an out-of-range
> 1U << current_time.monthday shift.
> 
> The date_start/date_stop ABI is unsigned and cannot represent pre-epoch
> calendar dates. If contiguous matching backdates stamp before the epoch,
> only rules without weekday and monthday constraints can still be
> evaluated safely; reject calendar-constrained rules before converting
> the timestamp to calendar fields.
> 
> Fixes: 54eb3df3a7d0 ("netfilter: xt_time: add support to ignore day transition")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <dstsmallbird@foxmail.com>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>

Reviewed-by: Phil Sutter <phil@nwl.cc>

