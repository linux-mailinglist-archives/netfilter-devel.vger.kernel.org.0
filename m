Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1551F6FF636
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 May 2023 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbjEKPmF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 May 2023 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbjEKPmC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 May 2023 11:42:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5612A2130;
        Thu, 11 May 2023 08:41:59 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH netfilter -stable,4.14 0/6] stable fixes for 4.14
Date:   Thu, 11 May 2023 17:41:37 +0200
Message-Id: <20230511154143.52469-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Greg, Sasha,

This is a backport of c1592a89942e ("netfilter: nf_tables: deactivate anonymous
set from preparation phase") which fixes CVE-2023-32233. This patch requires
dependency fixes which are not currently in the 4.14 branch.

The following list shows the backported patches, I am using original commit IDs
for reference:

1) cd5125d8f518 ("netfilter: nf_tables: split set destruction in deactivate and destroy phase")

2) f6ac85858976 ("netfilter: nf_tables: unbind set in rule from commit path")

3) 7f4dae2d7f03 ("netfilter: nft_hash: fix nft_hash_deactivate")

4) 6a0a8d10a366 ("netfilter: nf_tables: use-after-free in failing rule with bound set")

5) 273fe3f1006e ("netfilter: nf_tables: bogus EBUSY when deleting set after flush")

6) c1592a89942e ("netfilter: nf_tables: deactivate anonymous set from preparation phase")

Please apply to 4.14-stable.

Thanks.

Florian Westphal (1):
  netfilter: nf_tables: split set destruction in deactivate and destroy phase

Pablo Neira Ayuso (5):
  netfilter: nf_tables: unbind set in rule from commit path
  netfilter: nft_hash: fix nft_hash_deactivate
  netfilter: nf_tables: use-after-free in failing rule with bound set
  netfilter: nf_tables: bogus EBUSY when deleting set after flush
  netfilter: nf_tables: deactivate anonymous set from preparation phase

 include/net/netfilter/nf_tables.h |  30 ++++++-
 net/netfilter/nf_tables_api.c     | 139 +++++++++++++++++++++---------
 net/netfilter/nft_dynset.c        |  22 ++++-
 net/netfilter/nft_immediate.c     |   6 +-
 net/netfilter/nft_lookup.c        |  21 ++++-
 net/netfilter/nft_objref.c        |  21 ++++-
 net/netfilter/nft_set_hash.c      |   2 +-
 7 files changed, 194 insertions(+), 47 deletions(-)

-- 
2.30.2

