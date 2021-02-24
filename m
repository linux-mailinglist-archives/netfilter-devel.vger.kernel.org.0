Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2CE323515
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Feb 2021 02:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBXBPu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Feb 2021 20:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhBXAkf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Feb 2021 19:40:35 -0500
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Feb 2021 16:28:33 PST
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312BC061794
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Feb 2021 16:28:33 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id E7E5A58725FDB; Wed, 24 Feb 2021 01:19:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id E30C160DF0687;
        Wed, 24 Feb 2021 01:19:08 +0100 (CET)
Date:   Wed, 24 Feb 2021 01:19:08 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     andy@asjohnson.com
cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] xtables-addons 3.15 doesn't compile on 32-bit x86
In-Reply-To: <20210221075050.fcdaf64278890662106b299d41e0899d.756e4ddcc3.wbe@email05.godaddy.com>
Message-ID: <4rsrpo-65s8-n83p-67nq-17q75nprq2p5@vanv.qr>
References: <20210221075050.fcdaf64278890662106b299d41e0899d.756e4ddcc3.wbe@email05.godaddy.com>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Sunday 2021-02-21 15:50, andy@asjohnson.com wrote:

>Xtables-addons 3.15 doesn't compile with 32-bit x86 kernel:
>
>ERROR: "__divdi3"
>[/mnt/sdb1/lamp32-11/build/xtables-addons-3.15/extensions/pknock/xt_pknock.ko]
>undefined!
> 
>Replace long integer division with do_div().
>
>This patch fixes it:

Applied.
