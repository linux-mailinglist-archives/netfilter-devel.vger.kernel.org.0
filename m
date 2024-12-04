Return-Path: <netfilter-devel+bounces-5393-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8A9E46A4
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2024 22:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE680B2E8FF
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2024 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7E1C3C17;
	Wed,  4 Dec 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BkCq5gqR"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490413D246
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Dec 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340998; cv=none; b=L6jbgz3lxfHEyAAc3wsnGayCmz9wPVvp7zkHhLkRxQ099O4EkNrqk8ICfeX4rZVxVQnvm4j5xmfQfGLnyk32/TUXcreRPgzxpfk1oSPD+yYWkgp4LTiWR2lO5pTJ9M6FgUfQxPkg5Y3TeykoBR1zDmRYyBgBghuWSspS22NL+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340998; c=relaxed/simple;
	bh=LcDk5KO2Oc82UySI5qieVXpafwd2XawQaaqaN2L3wkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnzVO9TAAtt3v2BJHc6lJFLarRWBtfGjZJEPSdn5CLwInPx3/UF7dz78Wwnm05mAjfkPy63AC1o8DuANacNczyoLzC2jEO9kDI6tH70bzsT8ggNNjBZ5K16aFfKOM3aDjJG48346bYiWde+r7vHFwUjWWlIcVo8MFqc3Rv1FGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BkCq5gqR; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3SK44jjMzbQB;
	Wed,  4 Dec 2024 20:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733340600;
	bh=0GUHqg8GRL6pMGjl2BkgeJR/txAYeha7tu4vGhGYsAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkCq5gqRTNaKQozPGyXhmNdzDIHJm9EMl92rYK8iEe2pl2/PWN0s5U7S8uiufIW8r
	 Tzzyc9tyY2elm36ow9kIi98YiFTpNTlA/tStDIDLOGefPOcpkS3AcrVSK++3EteSUs
	 ryYOYPU64cwkad6bauYVseIx22hrz9YyvnnUMu/U=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3SK417hgz1Rv;
	Wed,  4 Dec 2024 20:30:00 +0100 (CET)
Date: Wed, 4 Dec 2024 20:29:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: David Laight <David.Laight@aculab.com>
Cc: 'Mikhail Ivanov' <ivanov.mikhail1@huawei-partners.com>, 
	Matthieu Baerts <matttbe@kernel.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, 
	"gnoack@google.com" <gnoack@google.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, "matthieu@buffet.re" <matthieu@buffet.re>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "yusongping@huawei.com" <yusongping@huawei.com>, 
	"artem.kuzin@huawei.com" <artem.kuzin@huawei.com>, 
	"konstantin.meskhidze@huawei.com" <konstantin.meskhidze@huawei.com>, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Message-ID: <20241204.ipheevic6eeB@digikod.net>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
 <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
 <20241018.Kahdeik0aaCh@digikod.net>
 <62336067-18c2-3493-d0ec-6dd6a6d3a1b5@huawei-partners.com>
 <ed94e1e51c4545a7b4be6a756dcdc44d@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed94e1e51c4545a7b4be6a756dcdc44d@AcuMS.aculab.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 08, 2024 at 05:16:50PM +0000, David Laight wrote:
> From: Mikhail Ivanov
> > Sent: 31 October 2024 16:22
> > 
> > On 10/18/2024 9:08 PM, Mickaël Salaün wrote:
> > > On Thu, Oct 17, 2024 at 02:59:48PM +0200, Matthieu Baerts wrote:
> > >> Hi Mikhail and Landlock maintainers,
> > >>
> > >> +cc MPTCP list.
> > >
> > > Thanks, we should include this list in the next series.
> > >
> > >>
> > >> On 17/10/2024 13:04, Mikhail Ivanov wrote:
> > >>> Do not check TCP access right if socket protocol is not IPPROTO_TCP.
> > >>> LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP
> > >>> should not restrict bind(2) and connect(2) for non-TCP protocols
> > >>> (SCTP, MPTCP, SMC).
> 
> I suspect you should check all IP protocols.
> After all if TCP is banned why should SCTP be allowed?
> Maybe you should have a different (probably more severe) restriction on SCTP.
> You'd also need to look at the socket options used to add additional
> local and remote IP addresses to a connect attempt.

Indeed, setsockopt()'s SCTP_SOCKOPT_BINDX_ADD and SCTP_SOCKOPT_CONNECTX
don't go through the socket_bind() nor socket_connect() LSM hooks bu the
security_sctp_bind_connect() hook instead.  This SCTP-specific hook is
not implemented for Landlock and the current implementation only
partially control such operations for SCTP.  This also make it clear
that we really need to stick to TCP-only for the TCP access rights.

It would be nice to add support for SCTP but we'll need to implement
security_sctp_bind_connect() and new tests with the setsockopt()
commands.

