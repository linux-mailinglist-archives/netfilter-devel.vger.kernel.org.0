Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7229820B
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Oct 2020 15:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416518AbgJYOTA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Oct 2020 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416511AbgJYOTA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:19:00 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA143C0613CE
        for <netfilter-devel@vger.kernel.org>; Sun, 25 Oct 2020 07:18:59 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8F59B588AA95B; Sun, 25 Oct 2020 15:18:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8DB6460EB5244;
        Sun, 25 Oct 2020 15:18:55 +0100 (CET)
Date:   Sun, 25 Oct 2020 15:18:55 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons v2 00/13] pknlusr improvements
In-Reply-To: <20201025131559.920038-1-jeremy@azazel.net>
Message-ID: <5468o978-1q51-3n81-9o93-3ss33os2570@vanv.qr>
References: <20201025131559.920038-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Sunday 2020-10-25 14:15, Jeremy Sowden wrote:

>Since pknlusr is now installed, here are some improvements.  There's one
>automake change related to the new man-page, a number of new patches
>tidying up the source of pknlusr.c, before a new version of the patch to
>remove the hard-coded group ID.  The last four patches do a bit of
>tiding of the pknock kernel module.

So applied. I removed the periods from the summaries, 
and then some whitespace.

>Jeremy Sowden (13):
>  pknock: pknlusr: ensure man-page is included by `make dist`.
>  pknock: pknlusr: remove dest_addr and rename src_addr.
>  pknock: pknlusr: tighten up variable scopes.
>  pknock: pknlusr: tidy up initialization of local address.
>  pknock: pknlusr: use NLMSG macros and proper types, rather than
>    arithmetic on char pointers.
>  pknock: pknlusr: use macro to define inet_ntop buffer size.
>  pknock: pknlusr: don't treat recv return value of zero as an error.
>  pknock: pknlusr: always close socket.
>  pknock: pknlusr: fix hard-coded netlink multicast group ID.
>  pknock: xt_pknock: use IS_ENABLED.
>  pknock: xt_pknock: use kzalloc.
>  pknock: xt_pknock: use pr_err.
>  pknock: xt_pknock: remove DEBUG definition.
