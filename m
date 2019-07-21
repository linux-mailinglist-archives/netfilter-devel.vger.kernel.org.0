Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1956F2AB
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfGUKrG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Jul 2019 06:47:06 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49300 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfGUKrG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:47:06 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hp9Mv-0004fO-62; Sun, 21 Jul 2019 12:47:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] doc: fib: explain example in more detail
Date:   Sun, 21 Jul 2019 12:43:05 +0200
Message-Id: <20190721104305.29594-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

As noted by Felix Dreissig, fib documentation is quite terse, so explain
the 'saddr . iif' example with a few more words.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1220
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 doc/primary-expression.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
index 6eb9583ac9e9..124193626aa7 100644
--- a/doc/primary-expression.txt
+++ b/doc/primary-expression.txt
@@ -274,6 +274,12 @@ fib_addrtype
 # drop packets without a reverse path
 filter prerouting fib saddr . iif oif missing drop
 
+In this example, 'saddr . iif' lookups up routing information based on the source address and the input interface.
+oif picks the output interface index from the routing information.
+If no route was found for the source address/input interface combination, the output interface index is zero.
+In case the input interface is specified as part of the input key, the output interface index is always the same as the input interface index or zero.
+If only 'saddr oif' is given, then oif can be any interface index or zero.
+
 # drop packets to address not configured on ininterface
 filter prerouting fib daddr . iif type != { local, broadcast, multicast } drop
 
-- 
2.21.0

