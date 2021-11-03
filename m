Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1A4448AB
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Nov 2021 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCS4g (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Nov 2021 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCS4f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:56:35 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C0C061714
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Nov 2021 11:53:59 -0700 (PDT)
Received: from localhost ([::1]:51434 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1miLOX-0005nL-GB; Wed, 03 Nov 2021 19:53:57 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nf PATCH 0/2] Review port shadow selftest
Date:   Wed,  3 Nov 2021 19:53:41 +0100
Message-Id: <20211103185343.28421-1-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Trying the test on a local VM I noticed spurious errors from nc,
complaining about an address being already in use. Patch 1 fixes this.
Validating the notrack workaround led to the minor simplifications in
patch 2.

Phil Sutter (2):
  selftests: nft_nat: Improve port shadow test stability
  selftests: nft_nat: Simplify port shadow notrack test

 tools/testing/selftests/netfilter/nft_nat.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.33.0

