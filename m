Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E541730E05F
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhBCQ77 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhBCQ5x (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:57:53 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A4C0613D6
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 08:57:13 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1l7LSq-0005LE-1P; Wed, 03 Feb 2021 17:57:12 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/3] nft: fix ct zone handling in sets and maps
Date:   Wed,  3 Feb 2021 17:57:03 +0100
Message-Id: <20210203165707.21781-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

'ct zone' (and other expressions w. host byte order and integer dtype)
are not handled correctly on little endian platforms.

First patch adds a test case that demonstrates the problem,
patch 2 and 3 resolve this for the mapping and set key cases.

Florian Westphal (3):
  tests: extend dtype test case to cover expression with integer type
  evaluate: pick data element byte order, not dtype one
  evaluate: set evaluation context for set elements

 src/evaluate.c                                | 13 ++++--
 .../testcases/sets/0029named_ifname_dtype_0   | 41 +++++++++++++++++
 .../sets/dumps/0029named_ifname_dtype_0.nft   | 44 ++++++++++++++++++-
 3 files changed, 93 insertions(+), 5 deletions(-)

-- 
2.26.2

