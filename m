Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B622CA5BD
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Dec 2020 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391373AbgLAOcG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Dec 2020 09:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgLAOcG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:32:06 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBDC0613CF
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Dec 2020 06:31:26 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8F8F45872F79B; Tue,  1 Dec 2020 15:31:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8E7D060C4E829;
        Tue,  1 Dec 2020 15:31:23 +0100 (CET)
Date:   Tue, 1 Dec 2020 15:31:23 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: use actual socket sk for REJECT action
In-Reply-To: <20201201133639.GA1323@salvia>
Message-ID: <p29153p-n7p1-pp87-r66-p73031248o86@vanv.qr>
References: <20201121111151.15960-1-jengelh@inai.de> <20201201084955.GC26468@salvia> <3s5q4s74-7q3n-69po-1q26-5qr718np489@vanv.qr> <20201201133639.GA1323@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2020-12-01 14:36, Pablo Neira Ayuso wrote:
>I see, it does not apply via:
>
>        git am netfilter-use-actual-socket-sk-for-REJECT-action.patch
>
>because patch shows:
>
>--- include/net/netfilter/ipv4/nf_reject.h
>
>instead of:
>
>--- a/include/net/netfilter/ipv4/nf_reject.h

Ooxh! ~/.gitconfig:

	[diff]                                                                                                                  
        	algorithm = histogram
		noprefix = true

diff.noprefix has an effect on `git diff`, but not `git add -p`,
but then again does on `git send-email`.
That's real intuitive. Not. :-/
