Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC810AFD8
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Nov 2019 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0M7q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Nov 2019 07:59:46 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:38700 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0M7p (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:59:45 -0500
Received: from localhost ([::1]:51788 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iZwv1-0008AU-Uu; Wed, 27 Nov 2019 13:59:43 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nft PATCH] nft.8: Fix nat family spec position
Date:   Wed, 27 Nov 2019 13:59:36 +0100
Message-Id: <20191127125936.23007-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In inet family nat statements, ip/ip6 keyword must come before 'to'
keyword, not after.

Fixes: fbe27464dee45 ("src: add nat support for the inet family")
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 doc/statements.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/statements.txt b/doc/statements.txt
index e17068a8a04be..07bf09c5e4395 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -324,10 +324,10 @@ NAT STATEMENTS
 ____
 *snat to* 'address' [*:*'port'] ['PRF_FLAGS']
 *snat to* 'address' *-* 'address' [*:*'port' *-* 'port'] ['PRF_FLAGS']
-*snat to* { *ip* | *ip6* } 'address' *-* 'address' [*:*'port' *-* 'port'] ['PR_FLAGS']
+*snat* { *ip* | *ip6* } *to* 'address' *-* 'address' [*:*'port' *-* 'port'] ['PR_FLAGS']
 *dnat to* 'address' [*:*'port'] ['PRF_FLAGS']
 *dnat to* 'address' [*:*'port' *-* 'port'] ['PR_FLAGS']
-*dnat to* { *ip* | *ip6* } 'address' [*:*'port' *-* 'port'] ['PR_FLAGS']
+*dnat* { *ip* | *ip6* } *to* 'address' [*:*'port' *-* 'port'] ['PR_FLAGS']
 *masquerade to* [*:*'port'] ['PRF_FLAGS']
 *masquerade to* [*:*'port' *-* 'port'] ['PRF_FLAGS']
 *redirect to* [*:*'port'] ['PRF_FLAGS']
-- 
2.24.0

