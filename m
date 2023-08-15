Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED377CAC3
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Aug 2023 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjHOJxH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Aug 2023 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbjHOJw4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:52:56 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C336E3
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Aug 2023 02:52:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qVqjK-0004yw-Mo; Tue, 15 Aug 2023 11:52:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/2] netfilter: nf_nat: fix yet another bizarre early demux corner case
Date:   Tue, 15 Aug 2023 11:52:39 +0200
Message-ID: <20230815095245.9386-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There is another corner case where early demux can end up assigning
the wrong socket to skb->sk.

This extends the existing workaround in nf_nat and the test case
to demonstrate the problem.

Florian Westphal (2):
  netfilter: nf_nat: undo erroneous tcp edemux lookup after port clash
  selftests: netfilter: test nat source port clash resolution
    interaction with tcp early demux

 net/netfilter/nf_nat_proto.c                  | 63 ++++++++++++++++++-
 .../selftests/netfilter/nf_nat_edemux.sh      | 46 +++++++++++---
 2 files changed, 97 insertions(+), 12 deletions(-)

-- 
2.41.0

