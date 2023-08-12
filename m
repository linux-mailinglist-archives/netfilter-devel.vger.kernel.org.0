Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DDA77A389
	for <lists+netfilter-devel@lfdr.de>; Sun, 13 Aug 2023 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjHLWIC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Aug 2023 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHLWIB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Aug 2023 18:08:01 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB7911704;
        Sat, 12 Aug 2023 15:08:04 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.10 0/1] netfilter stable fix for 5.10
Date:   Sun, 13 Aug 2023 00:07:57 +0200
Message-Id: <20230812220758.56489-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Greg, Sasha,

This is a backport of:

  1689f25924ad ("netfilter: nf_tables: report use refcount overflow")

for -stable 5.10.

Please, apply.

Pablo Neira Ayuso (1):
  netfilter: nf_tables: report use refcount overflow

 include/net/netfilter/nf_tables.h |  31 +++++-
 net/netfilter/nf_tables_api.c     | 171 ++++++++++++++++++------------
 net/netfilter/nft_flow_offload.c  |   6 +-
 net/netfilter/nft_immediate.c     |   8 +-
 net/netfilter/nft_objref.c        |   8 +-
 5 files changed, 145 insertions(+), 79 deletions(-)

-- 
2.30.2

