Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57EED7837
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfJOORe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 10:17:34 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:36906 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfJOORe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:17:34 -0400
Received: from localhost ([::1]:49996 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKNdl-00039Y-7x; Tue, 15 Oct 2019 16:17:33 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 2/6] set_elem: Fix return code of nftnl_set_elem_set()
Date:   Tue, 15 Oct 2019 16:16:54 +0200
Message-Id: <20191015141658.11325-3-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015141658.11325-1-phil@nwl.cc>
References: <20191015141658.11325-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The function returned -1 on success.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/set_elem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/set_elem.c b/src/set_elem.c
index 47965249691dd..3794f12594079 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -149,7 +149,7 @@ int nftnl_set_elem_set(struct nftnl_set_elem *s, uint16_t attr,
 		break;
 	}
 	s->flags |= (1 << attr);
-	return -1;
+	return 0;
 }
 
 EXPORT_SYMBOL(nftnl_set_elem_set_u32);
-- 
2.23.0

