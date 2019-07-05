Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707526013D
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfGEHEm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 03:04:42 -0400
Received: from a3.inai.de ([88.198.85.195]:59286 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfGEHEm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:04:42 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id 357C4765DC5; Fri,  5 Jul 2019 09:04:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 2359D3BB696A;
        Fri,  5 Jul 2019 09:04:40 +0200 (CEST)
Date:   Fri, 5 Jul 2019 09:04:40 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Baruch Siach <baruch@tkos.co.il>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH libnftnl] Add Libs.private field to libnftnl.pc
In-Reply-To: <b121a93e89d0b9478d4e57430e98c04d490d5af2.1562297544.git.baruch@tkos.co.il>
Message-ID: <nycvar.YFH.7.76.1907050904180.25743@n3.vanv.qr>
References: <b121a93e89d0b9478d4e57430e98c04d490d5af2.1562297544.git.baruch@tkos.co.il>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Friday 2019-07-05 05:32, Baruch Siach wrote:

>diff --git a/libnftnl.pc.in b/libnftnl.pc.in
>index fd5cc6ac5ca4..7fef9215c888 100644
>--- a/libnftnl.pc.in
>+++ b/libnftnl.pc.in
>@@ -12,4 +12,5 @@ Version: @VERSION@
> Requires:
> Conflicts:
> Libs: -L${libdir} -lnftnl
>+Libs.private: @LIBMNL_LIBS@
> Cflags: -I${includedir}

This is incorrect. What should be used is

Requires.private: libmnl.
