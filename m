Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402DD8C841
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfHNCXa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 22:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729837AbfHNCX3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0CB20679;
        Wed, 14 Aug 2019 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749408;
        bh=WB7QRxAz9d9wS0CZe73ecjeyFOskFfMmJJwHo0Z+GrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjB8JyuAt7ovpXK8SUTUTubMoLJnGiHfV4dKNaUkcQK+IOsamr/BOmjEnqI7eOwDt
         gyf5McjW6xIUg91g2x37wv/tNi7Qoej+5zu+4Olw4kCmY05GzA5xwr1FqHvEoZLTRD
         E3fkXlC1mq3OVsag24U15E3ZsAtivO2vBT5sxvEM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 03/33] netfilter: ebtables: fix a memory leak bug in compat
Date:   Tue, 13 Aug 2019 22:22:53 -0400
Message-Id: <20190814022323.17111-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022323.17111-1-sashal@kernel.org>
References: <20190814022323.17111-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 15a78ba1844a8e052c1226f930133de4cef4e7ad ]

In compat_do_replace(), a temporary buffer is allocated through vmalloc()
to hold entries copied from the user space. The buffer address is firstly
saved to 'newinfo->entries', and later on assigned to 'entries_tmp'. Then
the entries in this temporary buffer is copied to the internal kernel
structure through compat_copy_entries(). If this copy process fails,
compat_do_replace() should be terminated. However, the allocated temporary
buffer is not freed on this path, leading to a memory leak.

To fix the bug, free the buffer before returning from compat_do_replace().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 142ccaae9c7b6..4a47918b504f8 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2288,8 +2288,10 @@ static int compat_do_replace(struct net *net, void __user *user,
 	state.buf_kern_len = size64;
 
 	ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
-	if (WARN_ON(ret < 0))
+	if (WARN_ON(ret < 0)) {
+		vfree(entries_tmp);
 		goto out_unlock;
+	}
 
 	vfree(entries_tmp);
 	tmp.entries_size = size64;
-- 
2.20.1

