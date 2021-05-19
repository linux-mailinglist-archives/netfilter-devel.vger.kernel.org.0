Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DED389865
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 May 2021 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhESVJC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 May 2021 17:09:02 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46788 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhESVJC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 May 2021 17:09:02 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id D11EC6417E
        for <netfilter-devel@vger.kernel.org>; Wed, 19 May 2021 23:06:45 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables] cmd: typo in chain fuzzy lookup
Date:   Wed, 19 May 2021 23:07:37 +0200
Message-Id: <20210519210737.264773-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Refer to chain, not table.

Error: No such file or directory; did you mean table ‘z’ in family ip?
add chain x y { type filter nat prerouting priority dstnat; }
            ^

It should say instead:

Error: No such file or directory; did you mean chain ‘z’ in family ip?

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cmd.c b/src/cmd.c
index f9716fccd513..1f7e0fa39f4a 100644
--- a/src/cmd.c
+++ b/src/cmd.c
@@ -40,7 +40,7 @@ static int nft_cmd_enoent_chain(struct netlink_ctx *ctx, const struct cmd *cmd,
 	if (!chain)
 		return 0;
 
-	netlink_io_error(ctx, loc, "%s; did you mean table ‘%s’ in family %s?",
+	netlink_io_error(ctx, loc, "%s; did you mean chain ‘%s’ in family %s?",
 			 strerror(ENOENT), chain->handle.chain.name,
 			 family2str(table->handle.family),
 			 table->handle.table.name);
-- 
2.30.2

