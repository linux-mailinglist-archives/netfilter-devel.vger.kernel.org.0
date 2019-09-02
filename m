Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF0A5DF5
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 01:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfIBXGz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 19:06:55 -0400
Received: from kadath.azazel.net ([81.187.231.250]:43568 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfIBXGz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ow0VQ3Qxeba+a5FlDO/JYMJvhbDHmTWeUsr4FoqzOiQ=; b=fYZ22w3ginROVfpo9+L+BZNTVY
        LN05J/Nk9gs9NgVPkLoPNLr/AqsjNTxEtsozOsmYw6VBWWF11iMgDG4VfcjLoqvYuo35+U4ztw2XE
        nRzS4Go4tDKOaubV+pubJ8Czu24pamSFurtqDHHd62rAtHALSvuRPCWETo1B5X4aokS77Kqu9jDgS
        gRxpj86aZSj58cCvf3wpN3JS0BukQqBiILAryNwFkwpfcN2hoylEYBA1TliumVzIB/IM2L23mzOg0
        NK/vmayzRzOw6VBKASxo0yMacxHTonq+HxwzzJqLi1HM3Hxzn8TVdoMcDFvw8MjrRtLcZ6gHssbD/
        Ac5+fl4Q==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4vPO-0004la-VC; Tue, 03 Sep 2019 00:06:51 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 03/30] netfilter: fix include guard comment.
Date:   Tue,  3 Sep 2019 00:06:23 +0100
Message-Id: <20190902230650.14621-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190902230650.14621-1-jeremy@azazel.net>
References: <20190902230650.14621-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The comment following the #endif in the nf_flow_table.h include guard
referred to the wrong macro.  Fix it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_flow_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 609df33b1209..d875be62cdf0 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -127,4 +127,4 @@ unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 #define MODULE_ALIAS_NF_FLOWTABLE(family)	\
 	MODULE_ALIAS("nf-flowtable-" __stringify(family))
 
-#endif /* _FLOW_OFFLOAD_H */
+#endif /* _NF_FLOW_TABLE_H */
-- 
2.23.0.rc1

