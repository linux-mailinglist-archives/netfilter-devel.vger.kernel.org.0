Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7238C0F3
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHMSn7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 14:43:59 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57252 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfHMSn6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:43:58 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hxbm0-0003gL-Ad; Tue, 13 Aug 2019 20:43:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nftables 3/4] src: mnl: fix setting rcvbuffer size
Date:   Tue, 13 Aug 2019 20:44:08 +0200
Message-Id: <20190813184409.10757-4-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813184409.10757-1-fw@strlen.de>
References: <20190813184409.10757-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Kernel expects socklen_t (int).
Using size_t causes kernel to read upper 0-bits.

This caused tests/shell/testcases/transactions/0049huge_0
to fail on s390x -- it uses 'echo' mode and will quickly
overrun the tiny buffer size set due to this bug.

Fixes: 89c82c261bb5 ("mnl: estimate receiver buffer size")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/mnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mnl.c b/src/mnl.c
index f24d2ce0c56a..97a2e0765189 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -240,7 +240,7 @@ static void mnl_set_sndbuffer(const struct mnl_socket *nl,
 
 static unsigned int nlsndbufsiz;
 
-static int mnl_set_rcvbuffer(const struct mnl_socket *nl, size_t bufsiz)
+static int mnl_set_rcvbuffer(const struct mnl_socket *nl, socklen_t bufsiz)
 {
 	socklen_t len = sizeof(nlsndbufsiz);
 	int ret;
-- 
2.21.0

