Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCF78C79A
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Aug 2023 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjH2OdU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Aug 2023 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjH2OdR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:33:17 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F22F7
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Aug 2023 07:33:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qazmJ-00024P-TM; Tue, 29 Aug 2023 16:33:11 +0200
Date:   Tue, 29 Aug 2023 16:33:11 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Victor Julien <victor@inliniac.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] doc: fix example of xt_cpu
Message-ID: <20230829143311.GB2029@breakpoint.cc>
References: <20230829125932.31735-1-victor@inliniac.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829125932.31735-1-victor@inliniac.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Victor Julien <victor@inliniac.net> wrote:
> REDIRECT uses --to-ports instead of --to-port.

Applied, thanks Victor!
