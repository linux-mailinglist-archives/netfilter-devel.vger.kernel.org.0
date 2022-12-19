Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7959F651348
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Dec 2022 20:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiLST3U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Dec 2022 14:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiLST2u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:28:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A2AF1581E
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Dec 2022 11:28:49 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf,v2 0/4] nf_tables: set updates type check
Date:   Mon, 19 Dec 2022 20:28:40 +0100
Message-Id: <20221219192844.212253-1-pablo@netfilter.org>
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

Patch #1 and #2 are preparation work to consolidate set description
fields and to add a function that can be reused from the set update
path in the control plane.

Patch #3 add the set update type check compatibility,

Patch #4 allow to update set timeout and garbage collection interval
         which are the only fields that are not immutable in sets at
         this stage.

Pablo Neira Ayuso (4):
  netfilter: nf_tables: consolidate set description
  netfilter: nf_tables: add function to create set stateful expressions
  netfilter: nf_tables: perform type checking for existing sets
  netfilter: nf_tables: honor set timeout and garbage collection updates

 include/net/netfilter/nf_tables.h |  25 +++-
 net/netfilter/nf_tables_api.c     | 239 +++++++++++++++++++-----------
 2 files changed, 179 insertions(+), 85 deletions(-)

-- 
2.30.2

