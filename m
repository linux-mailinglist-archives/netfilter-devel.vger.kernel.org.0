Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7654A66AEBC
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Jan 2023 00:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjANXKz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Jan 2023 18:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjANXKy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Jan 2023 18:10:54 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A47599017
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Jan 2023 15:10:53 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, sbrivio@redhat.com
Subject: [PATCH nf 0/2] nf_tables rbtree fixes
Date:   Sun, 15 Jan 2023 00:10:45 +0100
Message-Id: <20230114231047.948785-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

The following patchset contains two fixes for the rbtree set backend:

1) Switch back to the list walk to detect overlap as proposed by Stefano.
   Use tree descent to locate nearest more than element to speed up
   overlap detection. Perform garbarge collection of expired element
   from the insert path while walking the list to avoid bogus overlap
   reports.

2) Do not interfer with ongoing transaction from garbage collector.
   Skip inactive elements from the garbage collection. Reset annotated
   end element coming before expired start element when it is busy with
   transaction update.

nftables shell test sets/0044interval_overlap_0 passes without errors.
This also passes this test when disabling set_overlap() in userspace nft
which perform overlap detection from userspace for older kernels (< 5.7).

Pablo Neira Ayuso (2):
  netfilter: nft_set_rbtree: Switch to node list walk for overlap detection
  netfilter: nft_set_rbtree: skip elements in transaction from garbage collection

 net/netfilter/nft_set_rbtree.c | 331 ++++++++++++++++++++-------------
 1 file changed, 204 insertions(+), 127 deletions(-)

-- 
2.30.2

