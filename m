Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE006E742F
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Apr 2023 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDSHlw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Apr 2023 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjDSHlL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:41:11 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E95B9010
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Apr 2023 00:40:44 -0700 (PDT)
Date:   Wed, 19 Apr 2023 09:40:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        jiejiang@chromium.org, jasongustaman@chromium.org,
        garrick@chromium.org
Subject: Re: [PATCH v3] netfilter: conntrack: fix wrong ct->timeout value
Message-ID: <ZD+a+R6+OgXm4QFZ@calendula>
References: <20230419051526.3170053-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419051526.3170053-1-tzungbi@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 19, 2023 at 01:15:26PM +0800, Tzung-Bi Shih wrote:
> (struct nf_conn)->timeout is an interval before the conntrack
> confirmed.  After confirmed, it becomes a timestamp[1].
> 
> It is observed that timeout of an unconfirmed conntrack:
> - Set by calling ctnetlink_change_timeout().  As a result,
>   `nfct_time_stamp` was wrongly added to `ct->timeout` twice[2].
> - Get by calling ctnetlink_dump_timeout().  As a result,
>   `nfct_time_stamp` was wrongly subtracted[3].
> 
> Separate the 2 cases in:
> - Setting `ct->timeout` in __nf_ct_set_timeout().
> - Getting `ct->timeout` in ctnetlink_dump_timeout().

Applied, thanks
