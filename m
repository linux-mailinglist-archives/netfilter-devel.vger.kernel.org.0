Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B214C4D4F78
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Mar 2022 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiCJQlb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Mar 2022 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbiCJQl2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:41:28 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C9191426
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 08:40:27 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nSLpx-0005TV-6G; Thu, 10 Mar 2022 17:40:25 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     kadlec@netfilter.org, Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/4] netfilter: conntrack: ignore overly delayed tcp packets
Date:   Thu, 10 Mar 2022 17:40:13 +0100
Message-Id: <20220310164017.7317-1-fw@strlen.de>
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

If 'nf_conntrack_tcp_loose' is off (the default), tcp packets that are
outside of the current window are marked as INVALID.

nf/iptables rulesets often drop such packets via 'ct state invalid' or
similar checks.

For overly delayed acks, this can be a nuisance if such 'invalid' packets
are also logged.

Since they are not invalid in a strict sense, just ignore them, i.e.
conntrack won't extend timeout or change state so that they do not match
invalid state rules anymore.

This also avoids unwantend connection stalls in case conntrack considers
retransmission (of data that did not reach the peer) as too old.

Florian Westphal (4):
  netfilter: conntrack: remove pr_debug callsites from tcp tracker
  netfilter: conntrack: prepare tcp_in_window for tristate return value
  netfilter: conntrack: ignore overly delayed tcp packets
  netfilter: conntrack: remove unneeded indent level

 net/netfilter/nf_conntrack_proto_tcp.c | 257 ++++++++++++-------------
 1 file changed, 119 insertions(+), 138 deletions(-)

-- 
2.34.1

