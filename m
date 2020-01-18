Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0B1419CF
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 22:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgARVXU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 16:23:20 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55186 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgARVXU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4UgfGNOvAnEkVa1oYgfDMZ+bKSypTjVKKOInNkEErvs=; b=IaI8m1LqxKjevw3KMU9g5pTlyj
        CKFVmkwDOA9GrHH4X/3mFeKx7lLxrVLWInu8UGn/m3nzsU4VtZK8QkJRUnfZnX0/IY5wDNXmR5erO
        kRZhyVX2c9ZXZ2lz6e59kU7FgqalML/8EkX1k3Xaw+sDIGQzyzeIemyWkfhLQm7Fka4qsmFEG/Dcy
        QCTMyhQxL6NRZlkXUg/w5sbXwE1HLe1X5JdwPBKWOrD6rGT4rBn6KD66/EUvk+b3M2xiwuWb/rv9s
        vFia0fj8LMrctIsBVaJ6BJ0s9BSt9uDaGbRH8nt5zb8m/E5bTbB0jIApu74war5GlcR610I8N5noS
        fVUuXs+Q==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1isvYt-0006Ji-I0
        for netfilter-devel@vger.kernel.org; Sat, 18 Jan 2020 21:23:19 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 3/9] netlink_delinearize: fix typo.
Date:   Sat, 18 Jan 2020 21:23:13 +0000
Message-Id: <20200118212319.253112-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118212319.253112-1-jeremy@azazel.net>
References: <20200118212319.253112-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

s/Of/If/ in comment describing function.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/netlink_delinearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 387e4b046c6b..8b9b5c808384 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2352,7 +2352,7 @@ static void stmt_payload_binop_pp(struct rule_pp_ctx *ctx, struct expr *binop)
  * the original payload expression because it has an odd size or
  * a non-byte divisible offset/length.
  *
- * Of that was the case, the 'value' expression is not a value but
+ * If that was the case, the 'value' expression is not a value but
  * a binop expression with a munged payload expression on the left
  * and a mask to clear the real payload offset/length.
  *
-- 
2.24.1

