Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3153E203788
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2020 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgFVNKO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jun 2020 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFVNKO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:10:14 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2CDC061794
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 06:10:14 -0700 (PDT)
Received: from localhost ([::1]:43108 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1jnMDD-0002fm-Gj; Mon, 22 Jun 2020 15:10:11 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] doc: Document notrack statement
Date:   Mon, 22 Jun 2020 15:10:13 +0200
Message-Id: <20200622131013.25157-1-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Merely a stub, but better to mention it explicitly instead of having it
appear in synproxy examples and letting users guess as to what it does.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 doc/statements.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/statements.txt b/doc/statements.txt
index ced311cb8d175..607aee133a993 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -263,6 +263,20 @@ table inet raw {
 ct event set new,related,destroy
 --------------------------------------
 
+NOTRACK STATEMENT
+~~~~~~~~~~~~~~~~~
+The notrack statement allows to disable connection tracking for certain
+packets.
+
+[verse]
+*notrack*
+
+Note that for this statement to be effective, it has to be applied to packets
+before a conntrack lookup happens. Therefore, it needs to sit in a chain with
+either prerouting or output hook and a hook priority of -300 or less.
+
+See SYNPROXY STATEMENT for an example usage.
+
 META STATEMENT
 ~~~~~~~~~~~~~~
 A meta statement sets the value of a meta expression. The existing meta fields
-- 
2.27.0

