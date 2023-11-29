Return-Path: <netfilter-devel+bounces-123-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604FE7FDFC1
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Nov 2023 19:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921B71C208F4
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Nov 2023 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EF5C3D6;
	Wed, 29 Nov 2023 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFEE99
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Nov 2023 10:55:43 -0800 (PST)
Received: from [78.30.43.141] (port=40754 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1r8Pij-00CF7o-Gm; Wed, 29 Nov 2023 19:55:39 +0100
Date: Wed, 29 Nov 2023 19:55:36 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Thomas Haller <thaller@redhat.com>
Cc: NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 0/2] tests/shell: workaround for bash
Message-ID: <ZWeJKDOvIMXQhcrJ@calendula>
References: <20231127191713.3528973-1-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127191713.3528973-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)

On Mon, Nov 27, 2023 at 08:15:34PM +0100, Thomas Haller wrote:
> RHEL8 has bash 4.4. Make some adjustments so that the test script works
> there.

Applied, thanks.

