Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22F77F2CDE
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Nov 2023 13:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjKUMO4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Nov 2023 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjKUMO4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:14:56 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D726185;
        Tue, 21 Nov 2023 04:14:52 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r5PeT-00055o-VD; Tue, 21 Nov 2023 13:14:49 +0100
From:   Florian Westphal <fw@strlen.de>
To:     stable@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.6.y 0/2] netfilter: fix catchall element double-free
Date:   Tue, 21 Nov 2023 13:14:20 +0100
Message-ID: <20231121121431.8612-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

This series contains the backports of two related changes to fix
removal of timed-out catchall elements.

As-is, removed element remains on the list and will be collected
again.

The adjustments are needed because of missing commit
0e1ea651c971 ("netfilter: nf_tables: shrink memory consumption of set elements"),
so we need to pass set_elem container struct instead of "elem_priv".

Pablo Neira Ayuso (2):
  netfilter: nf_tables: remove catchall element in GC sync path
  netfilter: nf_tables: split async and sync catchall in two functions

 net/netfilter/nf_tables_api.c | 53 ++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 17 deletions(-)

-- 
2.41.0

