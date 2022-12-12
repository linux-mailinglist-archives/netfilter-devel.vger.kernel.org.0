Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4CC649BAC
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Dec 2022 11:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiLLKIi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Dec 2022 05:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiLLKIh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:08:37 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC52D9
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Dec 2022 02:08:35 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1p4fjd-0000ed-Bs; Mon, 12 Dec 2022 11:08:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/3] fix map update with concatenation and timeouts
Date:   Mon, 12 Dec 2022 11:04:33 +0100
Message-Id: <20221212100436.84116-1-fw@strlen.de>
X-Mailer: git-send-email 2.38.1
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

When "update" is used with a map, nft will ignore a given timeout.
Futhermore, listing is broken, only the first data expression
gets decoded:

in:
 meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr . ct original proto-dst timeout 90s }
out:
 meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr }

Missing timeout is input bug (never passed to kernel), mussing
"proto-dst" is output bug.

Also add a test case.

Florian Westphal (3):
  netlink_delinearize: fix decoding of concat data element
  netlink_linearize: fix timeout with map updates
  tests: add a test case for map update from packet path with concat

 src/netlink_delinearize.c                      |  8 ++++++++
 src/netlink_linearize.c                        |  7 +++++++
 .../maps/dumps/typeof_maps_concat_update_0.nft | 12 ++++++++++++
 .../testcases/maps/typeof_maps_concat_update_0 | 18 ++++++++++++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 tests/shell/testcases/maps/dumps/typeof_maps_concat_update_0.nft
 create mode 100755 tests/shell/testcases/maps/typeof_maps_concat_update_0

-- 
2.38.1

