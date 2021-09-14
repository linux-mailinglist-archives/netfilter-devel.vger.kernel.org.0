Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095BA40B28F
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Sep 2021 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhINPJy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Sep 2021 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhINPJy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:09:54 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41B4C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Sep 2021 08:08:36 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8A081586A3A49; Tue, 14 Sep 2021 17:08:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 85C5160E57516;
        Tue, 14 Sep 2021 17:08:35 +0200 (CEST)
Date:   Tue, 14 Sep 2021 17:08:35 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>, kaskada@email.cz
Subject: Re: [xtables-addons] xt_ipp2p: add ipv6 module alias
In-Reply-To: <20210914140934.190397-1-jeremy@azazel.net>
Message-ID: <8256o629-qr34-3994-pqs2-9o2sn8r66s2@vanv.qr>
References: <20210914140934.190397-1-jeremy@azazel.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tuesday 2021-09-14 16:09, Jeremy Sowden wrote:
>
> extensions/xt_ipp2p.c | 1 +
> 1 file changed, 1 insertion(+)

Added
