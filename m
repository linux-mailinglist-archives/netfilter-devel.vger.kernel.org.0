Return-Path: <netfilter-devel+bounces-228-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E4B8073BE
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE1428196C
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C868405F5;
	Wed,  6 Dec 2023 15:33:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7368D46
	for <netfilter-devel@vger.kernel.org>; Wed,  6 Dec 2023 07:33:20 -0800 (PST)
Received: from [78.30.43.141] (port=43172 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rAtti-003obc-S5; Wed, 06 Dec 2023 16:33:16 +0100
Date: Wed, 6 Dec 2023 16:33:14 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Duncan Roe <duncan_roe@optusnet.com.au>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v5 1/1] src: Add nfq_nlmsg_put2() -
 user specifies header flags
Message-ID: <ZXCUOZapyqFtNZDc@calendula>
References: <ZWBhH235ou6RhYFn@calendula>
 <20231126015352.17136-2-duncan_roe@optusnet.com.au>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231126015352.17136-2-duncan_roe@optusnet.com.au>
X-Spam-Score: -1.9 (-)

On Sun, Nov 26, 2023 at 12:53:52PM +1100, Duncan Roe wrote:
> Enable mnl programs to check whether a config request was accepted.
> (nfnl programs do this already).

Applied, thanks

