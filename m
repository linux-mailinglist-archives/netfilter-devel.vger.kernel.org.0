Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7520748B
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2020 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbgFXNaL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Jun 2020 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391061AbgFXNaK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:30:10 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529EFC061797
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2020 06:30:10 -0700 (PDT)
Received: janet.servers.dxld.at; Wed, 24 Jun 2020 15:30:08 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Subject: [libnf_ct PATCH v2 5/9] Add ARRAY_SIZE() macro
Date:   Wed, 24 Jun 2020 15:30:01 +0200
Message-Id: <20200624133005.22046-5-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624133005.22046-1-dxld@darkboxed.org>
References: <20200624133005.22046-1-dxld@darkboxed.org>
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
index b1fc670..0f59f1a 100644
--- a/include/internal/internal.h
+++ b/include/internal/internal.h
@@ -40,6 +40,8 @@
 #define IPPROTO_DCCP 33
 #endif
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
 #define BUFFER_SIZE(ret, size, len, offset)		\
 	if (ret < 0)					\
 		return -1;				\
-- 
2.20.1

