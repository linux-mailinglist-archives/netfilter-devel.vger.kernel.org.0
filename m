Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6738D7EBFA2
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjKOJll (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 04:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOJll (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:41:41 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC889E5
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 01:41:37 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r3COt-0006AH-6W; Wed, 15 Nov 2023 10:41:35 +0100
Date:   Wed, 15 Nov 2023 10:41:35 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 3/3] parser: use size_t type for strlen() results
Message-ID: <20231115094135.GA23632@breakpoint.cc>
References: <20231109190032.669575-1-thaller@redhat.com>
 <20231109190032.669575-3-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109190032.669575-3-thaller@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> strlen() has a "size_t" as result. Use the correct type.

I've applied this one, but seriously, seems quite a bit of
bikeshedding.
