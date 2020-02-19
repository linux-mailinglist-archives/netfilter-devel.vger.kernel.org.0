Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C6164214
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Feb 2020 11:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSK2c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Feb 2020 05:28:32 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:51722 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSK2c (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:28:32 -0500
Received: from localhost ([::1]:36580 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1j4Mak-0001mw-Vj; Wed, 19 Feb 2020 11:28:31 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH] src: Fix for reading garbage in nftnl_chain getters
Date:   Wed, 19 Feb 2020 11:28:25 +0100
Message-Id: <20200219102825.11519-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In {s,u}{32,64} type getters nftnl_assert() is called to make sure
returned data length matches expectations. Therefore all attributes must
set data_len, which NFTNL_CHAIN_DEVICES didn't.

While being at it, do the same change for NFTNL_FLOWTABLE_DEVICES as
well to make code a bit more consistent although the problem was fixed
for flowtables with commit f8eed54150fd4 ("flowtable: Fix for reading
garbage") already (but in the other direction).

Fixes: e3ac19b5ec162 ("chain: multi-device support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/chain.c     | 1 +
 src/flowtable.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/chain.c b/src/chain.c
index b4066e4d4e888..94a9e43a17548 100644
--- a/src/chain.c
+++ b/src/chain.c
@@ -364,6 +364,7 @@ const void *nftnl_chain_get_data(const struct nftnl_chain *c, uint16_t attr,
 		*data_len = strlen(c->dev) + 1;
 		return c->dev;
 	case NFTNL_CHAIN_DEVICES:
+		*data_len = 0;
 		return &c->dev_array[0];
 	}
 	return NULL;
diff --git a/src/flowtable.c b/src/flowtable.c
index 1e235d0ba50fa..635322d7fa563 100644
--- a/src/flowtable.c
+++ b/src/flowtable.c
@@ -230,6 +230,7 @@ const void *nftnl_flowtable_get_data(const struct nftnl_flowtable *c,
 		*data_len = sizeof(int32_t);
 		return &c->family;
 	case NFTNL_FLOWTABLE_DEVICES:
+		*data_len = 0;
 		return &c->dev_array[0];
 	case NFTNL_FLOWTABLE_SIZE:
 		*data_len = sizeof(int32_t);
-- 
2.24.1

