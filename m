Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993866E10BD
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Apr 2023 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDMPOD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Apr 2023 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjDMPNy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:13:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7319027
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Apr 2023 08:13:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pmydf-0001rM-K9; Thu, 13 Apr 2023 17:13:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: nf_tables: move ruleset validation state to table
Date:   Thu, 13 Apr 2023 17:13:18 +0200
Message-Id: <20230413151320.16683-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

At this time nf_tables will valiate all tables before committing the new
rules.

Unfortunately this has two drawbacks:
1. Since addition of the transaction mutex pernet state gets written to
   outside of the locked section from the cleanup callback, this is
   wrong so do this cleanup directly after table has passed all checks.

2. We revalidate tables that saw no changes.
   This can be avoided by keeping the validation state per table, not
   per net.

Florian Westphal (2):
  netfilter: nf_tables: don't write table validation state without mutex
  netfilter: nf_tables: make validation state per table

 include/linux/netfilter/nfnetlink.h |  1 -
 include/net/netfilter/nf_tables.h   |  3 +-
 net/netfilter/nf_tables_api.c       | 44 +++++++++++++----------------
 net/netfilter/nfnetlink.c           |  2 --
 4 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.39.2

