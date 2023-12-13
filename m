Return-Path: <netfilter-devel+bounces-333-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6500812373
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Dec 2023 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239241C21473
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5579E09;
	Wed, 13 Dec 2023 23:42:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from pepin.polanet.pl (pepin.polanet.pl [193.34.52.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DB18E
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Dec 2023 15:42:24 -0800 (PST)
Date: Thu, 14 Dec 2023 00:42:21 +0100
From: Tomasz Pala <gotar@polanet.pl>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH ulogd] log NAT events using IPFIX
Message-ID: <20231213234220.GA12442@polanet.pl>
References: <20231210201705.GA16025@polanet.pl>
 <ZXhkbfE9ju7uiFNN@calendula>
 <20231212184413.GA2168@polanet.pl>
 <20231213122708.GD18912@polanet.pl>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20231213122708.GD18912@polanet.pl>
User-Agent: Mutt/1.5.20 (2009-06-14)

On Wed, Dec 13, 2023 at 13:27:08 +0100, Tomasz Pala wrote:

> It's not clear whether "last packet" should be read as "final/closing packet",
> but with this field carrying a value of 0 the nfdump doesn't handle the
> flowStartMilliseconds value as well.

The fix below should address this issue:

https://github.com/phaag/nfdump/pull/489

- nevertheless, it needs to be confirmed, pulled and released to take effect.

Besides, with flow.end = 0 the connection duration is off (calculated to
be some huge negative numher), while flow.end==flow.start makes this
implicitly equal to 0. Your call.

-- 
Tomasz Pala <gotar@pld-linux.org>

