Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBE54C7F5
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jun 2022 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiFOLzn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jun 2022 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbiFOLzn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:55:43 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCC95B6
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jun 2022 04:55:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1o1RcZ-0007TN-Bt; Wed, 15 Jun 2022 13:55:39 +0200
Date:   Wed, 15 Jun 2022 13:55:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Nicholas Vinson <nvinson234@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] build: fix clang+glibc snprintf substitution error
Message-ID: <20220615115539.GB10902@breakpoint.cc>
References: <3ee0b1d20d315ea8bbd865a1779fbf5342d01763.1655292884.git.nvinson234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee0b1d20d315ea8bbd865a1779fbf5342d01763.1655292884.git.nvinson234@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Nicholas Vinson <nvinson234@gmail.com> wrote:
> When building with clang and glibc and -D_FORTIFY_SOURCE=2 is passed to
> clang, the snprintf member of the expr_ops and obj_ops structures will
> be incorrectly replaced with __builtin_snprintf_chk() which results in
> "error: no member named '__builtin___snprintf_chk'" errors at build
> time.

Applied, thanks.
