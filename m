Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8571BFFDA
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 17:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD3PO3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgD3PO3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:14:29 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36924C035494
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 08:14:29 -0700 (PDT)
Received: from localhost ([::1]:43938 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jUAtP-0008Al-Vg; Thu, 30 Apr 2020 17:14:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/4] Two bugfixes around prefixes in sets
Date:   Thu, 30 Apr 2020 17:14:04 +0200
Message-Id: <20200430151408.32283-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Patch 1 fixes a pretty obvious typo, leading to prefixes not showing
their expiry time.

The remaining patches deal with wrong behaviour of 'get element' command
when looking up prefixes. This could have been simple, 'get element'
would return the prefix address but prefix length was missing.

While digging through the code, I eventually found out that
get_set_interval_find() and get_set_interval_end() didn't respect prefix
elements but cared about range elements only.

I am still not entirely sure how the code really works and why
everything is needed, but the test case added in patch 4 and some debug
output showed that things could be simplified quite a bit. Since this
also streamlined adding prefix support, I went ahead with it.

Phil Sutter (4):
  segtree: Fix missing expires value in prefixes
  segtree: Use expr_clone in get_set_interval_*()
  segtree: Merge get_set_interval_find() and get_set_interval_end()
  segtree: Fix get element command with prefixes

 src/segtree.c                                | 70 +++++---------------
 tests/shell/testcases/sets/0034get_element_0 | 51 +++++++++-----
 2 files changed, 51 insertions(+), 70 deletions(-)

-- 
2.25.1

