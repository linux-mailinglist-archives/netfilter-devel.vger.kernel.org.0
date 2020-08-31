Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C432E257A18
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Aug 2020 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHaNJs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Aug 2020 09:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgHaNJk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:09:40 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50AC061575
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Aug 2020 06:09:39 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id C4F455872C74C; Mon, 31 Aug 2020 15:09:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id C075E60FA16EF;
        Mon, 31 Aug 2020 15:09:33 +0200 (CEST)
Date:   Mon, 31 Aug 2020 15:09:33 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH 2/2] build: bump supported kernel version to 5.9.
In-Reply-To: <20200831125948.22891-2-jeremy@azazel.net>
Message-ID: <nycvar.YFH.7.77.849.2008311509210.12716@n3.vanv.qr>
References: <20200831125948.22891-1-jeremy@azazel.net> <20200831125948.22891-2-jeremy@azazel.net>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2020-08-31 14:59, Jeremy Sowden wrote:
>diff --git a/configure.ac b/configure.ac
>index 7d779964f77d..3e4755db3542 100644
>--- a/configure.ac
>+++ b/configure.ac
>@@ -57,7 +57,7 @@ if test -n "$kbuilddir"; then
> 		echo "WARNING: Version detection did not succeed. Continue at own luck.";
> 	else
> 		echo "$kmajor.$kminor.$kmicro.$kstable in $kbuilddir";
>-		if test "$kmajor" -gt 5 -o "$kmajor" -eq 5 -a "$kminor" -gt 8; then
>+		if test "$kmajor" -gt 5 -o "$kmajor" -eq 5 -a "$kminor" -gt 9; then

Both processed.
