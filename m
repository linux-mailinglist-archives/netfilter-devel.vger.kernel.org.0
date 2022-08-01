Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC0586F6C
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiHARQG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiHARPq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:46 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E06E0E
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 10:15:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oIZ14-0001hM-VW; Mon, 01 Aug 2022 19:15:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/2] netfilter: nf_tables: fix nf_trace related crash
Date:   Mon,  1 Aug 2022 19:15:34 +0200
Message-Id: <20220801171536.21372-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
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

The commit e34b9ed96ce3 ("netfilter: nf_tables: avoid skb access on nf_stolen")
is broken, it adds read-access to a structure that might contain
garbage.

Fix this and extend the existing nft_trans_stress.sh script to
cover this.

Florian Westphal (2):
  netfilter: nf_tables: fix crash when nf_trace is enabled
  selftests: netfilter: add test case for nf trace infrastructure

 net/netfilter/nf_tables_core.c                | 21 +++--
 .../selftests/netfilter/nft_trans_stress.sh   | 78 ++++++++++++++++++-
 2 files changed, 86 insertions(+), 13 deletions(-)
-- 
2.35.1

