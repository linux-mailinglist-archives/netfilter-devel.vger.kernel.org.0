Return-Path: <netfilter-devel+bounces-4378-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343699B51C
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Oct 2024 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB73F28306B
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Oct 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0ED1552FD;
	Sat, 12 Oct 2024 13:42:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD21E511
	for <netfilter-devel@vger.kernel.org>; Sat, 12 Oct 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740544; cv=none; b=FVEzTVoqQfTGxC+s7Rwc6LG5jP3Osl529v0aPvy471DRksQQWZOzTsc7hfbzd7CCNSzQxdO+a5H/TJ6xEEpbR8x5UcZEG87vzqA3T6xq1Z51t3VhvWm86HqyvgKwLao/qKb+RLZerWMwB1bZQFQaUjufgM2dm4QvCZ+ZpDRDSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740544; c=relaxed/simple;
	bh=l0m/tcuGayZo0t/we876R6Aew/Bdgg84ORR0PMK0p9s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPnpN0PnfzPXeCStATj8ynbmd8+qCQ3E6pQOrFW/MpQU4tV8Ayn4n67mYEzhFuFFFiLuq+HvYz7I1vB5Xb8fUGy0bgaiEBzL8gpH4qpjSbMe18CtMomg8OM6bQyOPpuVk6Hv2mEWvJB0UR8Pf2d5tCxVqmKJ6aWR6dzU51OuipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=38130 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1szcNi-001HPg-EB
	for netfilter-devel@vger.kernel.org; Sat, 12 Oct 2024 15:42:08 +0200
Date: Sat, 12 Oct 2024 15:42:05 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Building libnetfilter_queue has required kernel headers for some
 time
Message-ID: <Zwp8rQz-HKZPz9co@calendula>
References: <ZwnRJreuOMiQqU0A@slk15.local.net>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwnRJreuOMiQqU0A@slk15.local.net>
X-Spam-Score: -1.9 (-)

On Sat, Oct 12, 2024 at 12:30:14PM +1100, Duncan Roe wrote:
> Hi Pablo,
> 
> Just to clear up a misconception:
> 
> On Tue, Aug 10, 2021 at 06:09:06PM +0200, Pablo Neira Ayuso wrote:
> > To ensure that a project compiles standalone (without the need for the
> > system kernel header files), you can cache a copy of the header in
> > your software tree (we use this trick for a while in userspace
> > netfilter software).
> 
> The concept of a standalone build without kernel headers might have been valid
> once, but is invalid nowadays.

I am referring to netlink uapi files...

