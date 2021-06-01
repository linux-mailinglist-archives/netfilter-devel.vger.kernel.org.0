Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094603940ED
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhE1KcA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbhE1Kb7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 06:31:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5367C061574
        for <netfilter-devel@vger.kernel.org>; Fri, 28 May 2021 03:30:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lmZl1-00007O-EZ; Fri, 28 May 2021 12:30:23 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 2/6] netfilter: reduce size of nf_hook_state on 32bit platforms
Date:   Fri, 28 May 2021 12:30:04 +0200
Message-Id: <20210528103008.17425-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210528103008.17425-1-fw@strlen.de>
References: <20210528103008.17425-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Reduce size from 28 to 24 bytes on 32bit platforms.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index f0f3a8354c3c..f161569fbe2f 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -65,8 +65,8 @@ struct nf_hook_ops;
 struct sock;
 
 struct nf_hook_state {
-	unsigned int hook;
-	u_int8_t pf;
+	u8 hook;
+	u8 pf;
 	struct net_device *in;
 	struct net_device *out;
 	struct sock *sk;
-- 
2.26.3

