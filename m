Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450F79F286
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Sep 2023 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjIMUCu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 13 Sep 2023 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMUCt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:02:49 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0130173C
        for <netfilter-devel@vger.kernel.org>; Wed, 13 Sep 2023 13:02:45 -0700 (PDT)
Received: from [37.29.152.45] (port=2136 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qgW4I-002I9e-Ku; Wed, 13 Sep 2023 22:02:41 +0200
Date:   Wed, 13 Sep 2023 22:02:31 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: fix extension size table
Message-ID: <ZQIVVyCUFOrsgi5I@calendula>
References: <20230912085615.89333-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912085615.89333-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:56:07AM +0200, Florian Westphal wrote:
> The size table is incorrect due to copypaste error,
> this reserves more size than needed.
> 
> TSTAMP reserved 32 instead of 16 bytes.
> TIMEOUT reserved 16 instead of 8 bytes.

Applied to nf, thanks
