Return-Path: <netfilter-devel+bounces-12771-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mr4IYhtEGqgXAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12771-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 16:51:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E234F5B67DE
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 348633085D33
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7444CAC6;
	Fri, 22 May 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="TnWwjdVh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25F3FF8BE;
	Fri, 22 May 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460978; cv=none; b=HdkVphdXeGAD/j/OZE9vvmO6fKK3D3PB0HQCGgfDBg9B+toXo+9BjJb2ohy+0LjgyHWsaCVbjLw6nv1849FW/jBZbwDsNCe2m31NU9dmW5VJdAUZZB/8X9/jg52miFYvlURMBAxpuJkbdQCwH3DVJ1wAxqOL3otinbZZomLmMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460978; c=relaxed/simple;
	bh=LyoQ/CRdl05KZo+U/T2cF41Siz+Vd/fFm2KAr4cghDw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mKstOXGS4X6xxfvJnwK2uvDb5dedbcDV7FcIuVigXxGCCkH8QEZ9BUEbVeOkC3Ukyj6jxpAU0OJE1hdQ+evok2AWtanqJTLa48ZwJ4ws9YSpT/dR0o2Pj8XHJt54VuC0GcKK7eHcXp9HhfuGKyUj4yijT8RDumDSpcE8O9hMW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=TnWwjdVh; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 442BE20FC0;
	Fri, 22 May 2026 17:42:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=JJwVPK8XFtl90BFUrb2sR3i9TQfYYnBs+DoB/thQTTA=; b=TnWwjdVhQTdS
	lU9JoHzZg16vy+d0ZuIh9EKvDdY1Mx13A2QIjo5ch0Bi9NWEns9h+KW/ooVp+JEy
	hw79HcZQnhq3if7n7j25tWZwGVOwGVBQxPzcHxLqVCJ8eDeTLjS2ucyTloP1sklp
	aPZr6Wygy0x/GxO6xkTSrPA78o8TcE5u6mwjtgjoMOvMYuaMzfISnOqyEHQQvISN
	bUvQGGq1sc5/BBTP+UHwIiYl/+Kvuil76sxzmS0dK1Q/qEhIQ0ZQI5+S6jriyLKL
	cZfO+I4K9eWPcwy/7uptzonwnlzKzeywH8/tSoonass8/3cbYDtBwnLIJzPqAFPM
	8mj8t3wuSj1gPOlsR1VYM6sa5eb5+tp5CkuJcMmRLrJe3KEtkkOajrsVDsdP3LON
	CDl24Q1Zd1IIG7T5RsjIhvCBiozoscRRJuJKc62g2I4Z2UwAHgEnXxme+kqPz4uk
	W75RwrFcE64i0vpNsiLs6r/4wgzeQtPOo1eYP9WANQRgGvAlbOhq6DX5rGujJP6D
	7F4J9T2FS99FEgtPSxMikx6P4EvRElBC/p0NIfrJJlyZrhd7dgmSxqunLnTiukX6
	LvbK8NMk9waInM20MdsE84lkf+Xh0UhtD5z/kF/BvpQAoxZHyKPl4U7Uou3a5Qxz
	5qR1eymmaT5GPrN9TccVw09rjU27+7Y=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 22 May 2026 17:42:50 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 651C361B43;
	Fri, 22 May 2026 17:42:49 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.1) with ESMTP id 64MEgk32032329;
	Fri, 22 May 2026 17:42:47 +0300
Date: Fri, 22 May 2026 17:42:46 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] ipvs: add conn_max sysctl to limit connections
In-Reply-To: <20260522105546.13732-1-ja@ssi.bg>
Message-ID: <625b823f-a97b-8be4-c3df-bb8a46506efd@ssi.bg>
References: <20260522105546.13732-1-ja@ssi.bg>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ssi.bg:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12771-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E234F5B67DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


	Hello,

On Fri, 22 May 2026, Julian Anastasov wrote:

> Currently, we are using atomic_t to track the number of
> connections. On 64-bit setups with large memory there is
> a risk this counter to overflow. Also, setups with many
> containers may need to tune the limit for connections.
> 
> Add sysctl control to limit the number of connections to
> 1,073,741,824 (64-bit) and 16,777,216 (32-bit).
> Depending on the admin's privilege, the value is
> used to change a soft or hard limit allowing
> unprivileged admins to change the soft limit in
> range determined by privileged admins.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>

	Will send v2 to address the feedback by Sashiko.

https://sashiko.dev/#/patchset/20260522105546.13732-1-ja%40ssi.bg

pw-bot: changes-requested

Regards

--
Julian Anastasov <ja@ssi.bg>


