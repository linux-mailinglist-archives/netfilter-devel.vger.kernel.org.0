Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60862981CC
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Oct 2020 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416223AbgJYNQJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Oct 2020 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416215AbgJYNQH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:16:07 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23317C0613D6
        for <netfilter-devel@vger.kernel.org>; Sun, 25 Oct 2020 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rWtAwLsHZlbt+7ru4uruwoqfR8VbpKWfFs2d6OBm67o=; b=NxVBWlBZnK7KR9BhtV7MtZlnyO
        RVVVep8BQhyQBnzlJKVc2g23BLB8g3vSCSqNBqmepAvg8h7hF6UbuAua5xI/aCSxnh9CbzYhvaRWB
        CekASZMnOI6lGEY+A9rNpect3XmwII5YjtQhLTfdhOOw9or7YDD//v9jMW/ym0tq3UxbNPFF5cGht
        T9rSitxwruuNO2shEbP7Kik5V1/lDiCxVQduotJOVecYzUk+mvmOan34n/UJwKWgJwvd70VAfbA1J
        fHPDqr5TXKWIgkh59T60zrUIUypeISll7BafjtGkWsMbYeiGjhrwE3D99p40fPtHBJiiW3EqsvAiV
        J9uzIeLA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kWfsT-0001SE-Kk; Sun, 25 Oct 2020 13:16:05 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons v2 04/13] pknock: pknlusr: tidy up initialization of local address.
Date:   Sun, 25 Oct 2020 13:15:50 +0000
Message-Id: <20201025131559.920038-6-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025131559.920038-1-jeremy@azazel.net>
References: <20201025131559.920038-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use struct initialization and drop memset.  We don't need to set the port
ID, since the kernel will do it for us.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/pknock/pknlusr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/extensions/pknock/pknlusr.c b/extensions/pknock/pknlusr.c
index 808b737f1db2..ed741599558b 100644
--- a/extensions/pknock/pknlusr.c
+++ b/extensions/pknock/pknlusr.c
@@ -17,7 +17,7 @@ int main(void)
 	int status;
 	int group = GROUP;
 
-	struct sockaddr_nl local_addr;
+	struct sockaddr_nl local_addr = { .nl_family = AF_NETLINK };
 	int sock_fd;
 
 	int buf_size;
@@ -30,9 +30,6 @@ int main(void)
 		return 1;
 	}
 
-	memset(&local_addr, 0, sizeof(local_addr));
-	local_addr.nl_family = AF_NETLINK;
-	local_addr.nl_pid = getpid();
 	local_addr.nl_groups = group;
 
 	status = bind(sock_fd, (struct sockaddr*)&local_addr, sizeof(local_addr));
-- 
2.28.0

