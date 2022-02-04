Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FDA4A98CF
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Feb 2022 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiBDL7w (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Feb 2022 06:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbiBDL7r (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:59:47 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361FC061714;
        Fri,  4 Feb 2022 03:59:47 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nFxFf-0007YN-Ox; Fri, 04 Feb 2022 12:59:43 +0100
Date:   Fri, 4 Feb 2022 12:59:43 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     pablo@netfilter.org, fw@strlen.de, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH nf-next] nfqueue: enable to set skb->priority
Message-ID: <20220204115943.GA15954@breakpoint.cc>
References: <Yfy2qiiYEeWLe8sI@salvia>
 <20220204102143.4010-1-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204102143.4010-1-nicolas.dichtel@6wind.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> This is a follow up of the previous patch that enables to get
> skb->priority. It's now posssible to set it also.

Seems reasonable.

Acked-by: Florian Westphal <fw@strlen.de>
