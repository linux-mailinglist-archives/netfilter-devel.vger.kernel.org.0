Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7903FA60E
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhH1Nkc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhH1Nkb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 09:40:31 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FFC061756
        for <netfilter-devel@vger.kernel.org>; Sat, 28 Aug 2021 06:39:41 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 1721159B99809; Sat, 28 Aug 2021 15:39:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 1428260C442F7;
        Sat, 28 Aug 2021 15:39:38 +0200 (CEST)
Date:   Sat, 28 Aug 2021 15:39:38 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Duncan Roe <duncan_roe@optusnet.com.au>, pablo@netfilter.org,
        netfilter-devel@vger.kernel.org
Subject: Re: libnetfilter_queue: automake portability warning
In-Reply-To: <YSlUpg5zfcwNiS50@azazel.net>
Message-ID: <7n261qsp-or96-6559-5orp-srp285p4p6q@vanv.qr>
References: <YSlUpg5zfcwNiS50@azazel.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Friday 2021-08-27 23:09, Jeremy Sowden wrote:

>Running autogen.sh gives the following output when it gets to
>doxygen/Makefile.am:
>
>  doxygen/Makefile.am:3: warning: shell find $(top_srcdir: non-POSIX variable name
>  doxygen/Makefile.am:3: (probably a GNU make extension)
>
>Automake doesn't understand the GNU make $(shell ...) [...]

Or, third option, ditch the wildcarding and just name the sources. If going for
a single Makefile (ditching recursive make), that will also be beneficial for
parallel building, and the repo is not too large for such undertaking to be
infeasible.

