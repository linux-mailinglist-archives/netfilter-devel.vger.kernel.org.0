Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3D4C7F19
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Mar 2022 01:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiCAAV6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Feb 2022 19:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCAAV5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:21:57 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DA3245A1
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Feb 2022 16:21:18 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nOqGP-0005ZK-IH; Tue, 01 Mar 2022 01:21:14 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 nf 0/2] netfilter: nf_queue: be more careful with sk refcounts
Date:   Tue,  1 Mar 2022 01:21:06 +0100
Message-Id: <20220301002108.28338-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
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

This is a resend of v1 patch, split into two distinct patches
to ease backport work.

Florian Westphal (2):
  netfilter: nf_queue: fix possible use-after-free
  netfilter: nf_queue: handle socket prefetch

 include/net/netfilter/nf_queue.h |  2 +-
 net/netfilter/nf_queue.c         | 25 +++++++++++++++++++++----
 net/netfilter/nfnetlink_queue.c  | 12 +++++++++---
 3 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.34.1

