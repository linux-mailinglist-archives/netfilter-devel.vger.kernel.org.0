Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55DCEAD3F
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJaKPM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 06:15:12 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:57057 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfJaKPM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:15:12 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 06:15:11 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2193328009358;
        Thu, 31 Oct 2019 11:06:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EBB522C0; Thu, 31 Oct 2019 11:06:42 +0100 (CET)
Message-Id: <cd8564ffa3d8254cce8995c95c218a56a6bd8797.1572516054.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 31 Oct 2019 11:06:24 +0100
Subject: [PATCH nf] netfilter: nf_tables: Align nft_expr private data to
 64-bit
To:     "Pablo Neira Ayuso" <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Invoking the following commands on a 32-bit architecture with strict
alignment requirements (such as an ARMv7-based Raspberry Pi) results
in an alignment exception:

Alignment trap: not handling instruction e1b26f9f at [<7f4473f8>]
Unhandled fault: alignment exception (0x001) at 0xb832e824
Internal error: : 1 [#1] PREEMPT SMP ARM
Hardware name: BCM2835
[<7f4473fc>] (nft_quota_do_init [nft_quota])
[<7f447448>] (nft_quota_init [nft_quota])
[<7f4260d0>] (nf_tables_newrule [nf_tables])
[<7f4168dc>] (nfnetlink_rcv_batch [nfnetlink])
[<7f416bd0>] (nfnetlink_rcv [nfnetlink])
[<8078b334>] (netlink_unicast)
[<8078b664>] (netlink_sendmsg)
[<8071b47c>] (sock_sendmsg)
[<8071bd18>] (___sys_sendmsg)
[<8071ce3c>] (__sys_sendmsg)
[<8071ce94>] (sys_sendmsg)

The reason is that nft_quota_do_init() calls atomic64_set() on an
atomic64_t which is only aligned to 32-bit, not 64-bit, because it
succeeds struct nft_expr in memory which only contains a 32-bit pointer.
Fix by aligning the nft_expr private data to 64-bit.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.13+
---
 include/net/netfilter/nf_tables.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 001d294..2d0275f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -820,7 +820,8 @@ struct nft_expr_ops {
  */
 struct nft_expr {
 	const struct nft_expr_ops	*ops;
-	unsigned char			data[];
+	unsigned char			data[]
+		__attribute__((aligned(__alignof__(u64))));
 };
 
 static inline void *nft_expr_priv(const struct nft_expr *expr)
-- 
2.20.1

