Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69E7D4A48
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjJXIeW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjJXIeH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:34:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7ECF10D4
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:04 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5] nf_tables set updates
Date:   Tue, 24 Oct 2023 10:33:54 +0200
Message-Id: <20231024083359.24742-1-pablo@netfilter.org>
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

This is a first batch of nf_tables set updates:

1) Use nft_set_ext already accesible as parameter via .flush(), no
   need for pipapo_deactivate() call.

2) Turn .flush into void, this never fails.

3) Add and use struct nft_elem_priv placeholder, suggested by Florian.

4) Shrink memory usage for set elements in transactions, as well as
   stack usage.

5) Use struct nft_elem_priv in .insert, in preparation for set timeout
   updates, this will come in a later patch.

This batch has survived hours of 30s-stress runs and tests/shell,
I am still stress testing the set element updates, that will come in
a follow up batch.

Thanks

Pablo Neira Ayuso (5):
  netfilter: nft_set_pipapo: no need to call pipapo_deactivate() from flush
  netfilter: nf_tables: set backend .flush always succeeds
  netfilter: nf_tables: expose opaque set element as struct nft_elem_priv
  netfilter: nf_tables: shrink memory consumption of set elements
  netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST

 include/net/netfilter/nf_tables.h |  60 +++++----
 net/netfilter/nf_tables_api.c     | 217 ++++++++++++++----------------
 net/netfilter/nft_dynset.c        |  23 ++--
 net/netfilter/nft_set_bitmap.c    |  53 ++++----
 net/netfilter/nft_set_hash.c      | 109 +++++++--------
 net/netfilter/nft_set_pipapo.c    |  73 +++++-----
 net/netfilter/nft_set_pipapo.h    |   4 +-
 net/netfilter/nft_set_rbtree.c    |  71 +++++-----
 8 files changed, 305 insertions(+), 305 deletions(-)

-- 
2.30.2

