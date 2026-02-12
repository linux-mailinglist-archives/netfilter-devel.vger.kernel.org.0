Return-Path: <netfilter-devel+bounces-10745-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DkvFzWMjWnq3wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10745-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 09:15:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A493012B283
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 09:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676AC30FD55F
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57ED2D29C2;
	Thu, 12 Feb 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cbygj7hN"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC062C08CC
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884112; cv=none; b=S1SaLvzVUduyxVOQ6wAMoKMfKz48LYaPf1NC1tbe7DtlSitmZngZgrThgWYKPX60JEVvtlMnxLf+ebgCkedyJ2q3oSea/u5C7xVGXE7OLAmUYoU/gsSoOb1BZ0Kg5svOUt9pvBxlFgL9DdMv9bnQ+0u/hPIGHDAxmm5e4V4TV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884112; c=relaxed/simple;
	bh=FN4A2yY0+xoW17KhwSyoMZPJzAXwEZFTcnFUvKsLxMQ=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=GMd3x/O0HGrxYIBVw4ijAkZDWBqHdfe0361QGYHrSVIIciP/uapwRjJVNunBoQGM/DCsWsWGIlhTjGaRDtZy9F4/ilxj0rXNWvXxEXeBhHa1wweID4FpAhzyYWkXO4lTJcsH818RNo7yzKyAKQ46lKRp/22hSpLqqQh+cgjMiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cbygj7hN; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260212081502epoutp02e05fb57e0ce4ff1956321b3d2c83d384~TcbVsOQw03264932649epoutp02_
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 08:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260212081502epoutp02e05fb57e0ce4ff1956321b3d2c83d384~TcbVsOQw03264932649epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770884102;
	bh=FN4A2yY0+xoW17KhwSyoMZPJzAXwEZFTcnFUvKsLxMQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=cbygj7hNvj+KSp1QZ2wnh3PQYby3QKY8UVbK47MEeM1npd3MSWbJb9fJby1urCwz1
	 xdXRJW8Y+bqkdOyCIgnAO28asL9lHnDEH4Qii6KCmPi+PC5gELxGZJMtBVnwKDdTNU
	 uxTv6h/H1lmPi8T2HnSP4uydRDTZ/CnXTltA6fGE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20260212081501epcas1p2db76ea9c7dbd41e7d757278f8f46718b~TcbU9cdIe0524405244epcas1p2d;
	Thu, 12 Feb 2026 08:15:01 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.194]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fBSlT4VHmz3hhTB; Thu, 12 Feb
	2026 08:15:01 +0000 (GMT)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(4) [net-next,v3] ipv6: shorten reassembly timeout under
 fragment memory pressure
Reply-To: soukjin.bae@samsung.com
Sender: =?UTF-8?B?67Cw7ISd7KeE?= <soukjin.bae@samsung.com>
From: =?UTF-8?B?67Cw7ISd7KeE?= <soukjin.bae@samsung.com>
To: Eric Dumazet <edumazet@google.com>
CC: Fernando Fernandez Mancera <fmancera@suse.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>, "phil@nwl.cc"
	<phil@nwl.cc>, "coreteam@netfilter.org" <coreteam@netfilter.org>,
	"fw@strlen.de" <fw@strlen.de>, "pablo@netfilter.org" <pablo@netfilter.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANn89iJ6MJxh7BFjVdBMBLYeopgJ52Sbg7jEfQbQeQ-n0MUOTw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260212081501epcms1p199584f85bafe3711791c419be09cb8d6@epcms1p1>
Date: Thu, 12 Feb 2026 17:15:01 +0900
X-CMS-MailID: 20260212081501epcms1p199584f85bafe3711791c419be09cb8d6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211030048epcms1p54c6ed78458f57def8e3163032498ca00
References: <CANn89iJ6MJxh7BFjVdBMBLYeopgJ52Sbg7jEfQbQeQ-n0MUOTw@mail.gmail.com>
	<20260211103243epcms1p2dd304fd11b28df04f4e680e8c90a7fc5@epcms1p2>
	<207b2879-e022-4b50-837b-d536f8fcabcd@suse.de>
	<CANn89i+mNojd9mUL_dt_=D+7nZ9xcV96CYJG_LYFmBZDOYUMFQ@mail.gmail.com>
	<20260212002207epcms1p7a1c19ed12038cf74f8632e5a305bd7ec@epcms1p7>
	<CGME20260211030048epcms1p54c6ed78458f57def8e3163032498ca00@epcms1p1>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10745-lists,netfilter-devel=lfdr.de];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[soukjin.bae@samsung.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	HAS_REPLYTO(0.00)[soukjin.bae@samsung.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A493012B283
X-Rspamd-Action: no action

Hello,

Thank you for the detailed explanation and I understand your concerns.
Given your feedback, we will reconsider this approach and rely on
the existing sysctl tunables instead.

Thank you for the guidance.

