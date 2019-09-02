Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF69DA5B7F
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2019 18:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfIBQol (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 12:44:41 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:46130 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfIBQol (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:44:41 -0400
Received: from localhost ([::1]:59220 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i4pRY-0001LU-D4; Mon, 02 Sep 2019 18:44:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [conntrack-tools PATCH] conntrack: Fix CIDR to mask conversion on Big Endian
Date:   Mon,  2 Sep 2019 18:44:31 +0200
Message-Id: <20190902164431.18398-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Code assumed host architecture to be Little Endian. Instead produce a
proper mask by pushing the set bits into most significant position and
apply htonl() on the result.

Fixes: 3f6a2e90936bb ("conntrack: add support for CIDR notation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index c980a13f33d2c..baafcbd869c12 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -2210,7 +2210,7 @@ nfct_build_netmask(uint32_t *dst, int b, int n)
 			dst[i] = 0xffffffff;
 			b -= 32;
 		} else if (b > 0) {
-			dst[i] = (1 << b) - 1;
+			dst[i] = htonl(((1 << b) - 1) << (32 - b));
 			b = 0;
 		} else {
 			dst[i] = 0;
-- 
2.22.0

