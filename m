Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16172205295
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgFWMe4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732553AbgFWMeq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:34:46 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CDEC061755
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2020 05:34:46 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 14:34:44 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [libnf_ct resend PATCH 5/8] Add asizeof() macro
Date:   Tue, 23 Jun 2020 14:34:00 +0200
Message-Id: <20200623123403.31676-6-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623123403.31676-1-dxld@darkboxed.org>
References: <20200623123403.31676-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-score: -0.0
X-Spam-bar: /
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
 include/internal/internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/internal/internal.h b/include/internal/internal.h
index 859724b..68c5ef0 100644
--- a/include/internal/internal.h
+++ b/include/internal/internal.h
@@ -40,6 +40,8 @@
 #define IPPROTO_DCCP 33
 #endif
 
+#define asizeof(x) (sizeof(x) / sizeof(*x))
+
 #define BUFFER_SIZE(ret, size, len, offset)		\
 	if(ret < 0)					\
 		return -1;				\
-- 
2.20.1

