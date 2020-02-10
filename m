Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7109A157344
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Feb 2020 12:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgBJLOc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 06:14:32 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:58804 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJLOb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:14:31 -0500
Received: from localhost ([::1]:43662 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1j171K-00037y-9E; Mon, 10 Feb 2020 12:14:30 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH v2 1/2] doc: nft.8: Mention wildcard interface matching
Date:   Mon, 10 Feb 2020 12:14:22 +0100
Message-Id: <20200210111423.18122-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Special meaning of asterisk in interface names wasn't described
anywhere.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Generalize sentence about escaping for literal asterisk character.
---
 doc/primary-expression.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
index 94eccc20241a2..b5488790360dc 100644
--- a/doc/primary-expression.txt
+++ b/doc/primary-expression.txt
@@ -36,6 +36,13 @@ add such a rule, it will stop matching if the interface gets renamed and it
 will match again in case interface gets deleted and later a new interface
 with the same name is created.
 
+Like with iptables, wildcard matching on interface name prefixes is available for
+*iifname* and *oifname* matches by appending an asterisk (*) character. Note
+however that unlike iptables, nftables does not accept interface names
+consisting of the wildcard character only - users are supposed to just skip
+those always matching expressions. In order to match on literal asterisk
+character, one may escape it using backslash (\).
+
 .Meta expression types
 [options="header"]
 |==================
-- 
2.24.1

