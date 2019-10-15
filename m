Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7388D7832
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfJOORI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 10:17:08 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:36876 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfJOORI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:17:08 -0400
Received: from localhost ([::1]:49966 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKNdK-00036a-Q9; Tue, 15 Oct 2019 16:17:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 3/6] set_elem: Validate nftnl_set_elem_set() parameters
Date:   Tue, 15 Oct 2019 16:16:55 +0200
Message-Id: <20191015141658.11325-4-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015141658.11325-1-phil@nwl.cc>
References: <20191015141658.11325-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Copying from nftnl_table_set_data(), validate input to
nftnl_set_elem_set() as well. Given that for some attributes the
function assumes passed data size, this seems necessary.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/libnftnl/set.h |  2 ++
 src/set_elem.c         | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/libnftnl/set.h b/include/libnftnl/set.h
index 6640ad929f346..2ea2e9a56ce4f 100644
--- a/include/libnftnl/set.h
+++ b/include/libnftnl/set.h
@@ -104,7 +104,9 @@ enum {
 	NFTNL_SET_ELEM_USERDATA,
 	NFTNL_SET_ELEM_EXPR,
 	NFTNL_SET_ELEM_OBJREF,
+	__NFTNL_SET_ELEM_MAX
 };
+#define NFTNL_SET_ELEM_MAX (__NFTNL_SET_ELEM_MAX - 1)
 
 struct nftnl_set_elem;
 
diff --git a/src/set_elem.c b/src/set_elem.c
index 3794f12594079..4225a96ee5a0a 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -96,10 +96,20 @@ void nftnl_set_elem_unset(struct nftnl_set_elem *s, uint16_t attr)
 	s->flags &= ~(1 << attr);
 }
 
+static uint32_t nftnl_set_elem_validate[NFTNL_SET_ELEM_MAX + 1] = {
+	[NFTNL_SET_ELEM_FLAGS]		= sizeof(uint32_t),
+	[NFTNL_SET_ELEM_VERDICT]	= sizeof(int), /* FIXME: data.verdict is int?! */
+	[NFTNL_SET_ELEM_TIMEOUT]	= sizeof(uint64_t),
+	[NFTNL_SET_ELEM_EXPIRATION]	= sizeof(uint64_t),
+};
+
 EXPORT_SYMBOL(nftnl_set_elem_set);
 int nftnl_set_elem_set(struct nftnl_set_elem *s, uint16_t attr,
 		       const void *data, uint32_t data_len)
 {
+	nftnl_assert_attr_exists(attr, NFTNL_SET_ELEM_MAX);
+	nftnl_assert_validate(data, nftnl_set_elem_validate, attr, data_len);
+
 	switch(attr) {
 	case NFTNL_SET_ELEM_FLAGS:
 		memcpy(&s->set_elem_flags, data, sizeof(s->set_elem_flags));
-- 
2.23.0

