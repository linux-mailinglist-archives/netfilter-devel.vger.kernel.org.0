Return-Path: <netfilter-devel+bounces-587-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38DC829E37
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C2B1C2225A
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE314C3BA;
	Wed, 10 Jan 2024 16:11:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAB4B5DE
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jan 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=53820 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rNbAC-003POq-HQ; Wed, 10 Jan 2024 17:10:46 +0100
Date: Wed, 10 Jan 2024 17:10:43 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Quan Tian <tianquan23@gmail.com>
Cc: netfilter-devel@vger.kernel.org, Dan Winship <danwinship@redhat.com>
Subject: Re: [PATCH nftables] doc: clarify reject is supported at prerouting
 stage
Message-ID: <ZZ7Bg9QtyCR5mo/4@calendula>
References: <20240110043059.2977387-1-tianquan23@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110043059.2977387-1-tianquan23@gmail.com>
X-Spam-Score: -1.9 (-)

On Wed, Jan 10, 2024 at 04:30:59AM +0000, Quan Tian wrote:
> It's supported since kernel commit f53b9b0bdc59 ("netfilter: introduce
> support for reject at prerouting stage").

Applied, thanks

