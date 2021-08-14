Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583C3EC4F8
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Aug 2021 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhHNUT2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Aug 2021 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhHNUT1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:19:27 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C87C061764
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Aug 2021 13:18:55 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id A447C5872FA6C; Sat, 14 Aug 2021 22:18:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 9850460DA1E1A;
        Sat, 14 Aug 2021 22:18:53 +0200 (CEST)
Date:   Sat, 14 Aug 2021 22:18:53 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Florian Westphal <fw@strlen.de>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptabes-nft] iptables-nft: allow removal of empty builtin
 chains
In-Reply-To: <20210814174643.130760-1-fw@strlen.de>
Message-ID: <84q02320-o5pp-8q8q-q646-473ssq92n552@vanv.qr>
References: <20210814174643.130760-1-fw@strlen.de>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Saturday 2021-08-14 19:46, Florian Westphal wrote:
> Conservative change:
> iptables-nft -X will not remove empty builtin chains.
> OTOH, maybe it would be better to auto-remove those too, if empty.
> Comments?

How are chain policies expressed in nft, as a property on the
chain (like legacy), or as a separate rule?
That is significant when removing "empty" chains.
