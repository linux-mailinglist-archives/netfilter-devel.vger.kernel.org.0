Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCE4E3D98
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Mar 2022 12:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiCVLbe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Mar 2022 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiCVLbd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:31:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453E7EB2B
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Mar 2022 04:30:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nWciD-00035V-4P; Tue, 22 Mar 2022 12:30:05 +0100
Date:   Tue, 22 Mar 2022 12:30:05 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: nf_tables: replace unnecessary use of
 list_for_each_entry_continue()
Message-ID: <20220322113005.GE24574@breakpoint.cc>
References: <20220322105645.3667322-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322105645.3667322-1-jakobkoschel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jakob Koschel <jakobkoschel@gmail.com> wrote:

[ trimmed CC ]

> Since there is no way for list_for_each_entry_continue() to start
> interating in the middle of the list they can be replaced with a call
> to list_for_each_entry().
> 
> In preparation to limit the scope of the list iterator to the list
> traversal loop, the list iterator variable 'rule' should not be used
> past the loop.

Reviewed-by: Florian Westphal <fw@strlen.de>
