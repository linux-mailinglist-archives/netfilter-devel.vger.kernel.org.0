Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B6D91E39
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfHSHon (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 03:44:43 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:38864 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHSHon (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:44:43 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-08.nifty.com with ESMTP id x7J7eBZ6016229
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Aug 2019 16:40:11 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x7J7dc7c023792;
        Mon, 19 Aug 2019 16:39:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x7J7dc7c023792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566200379;
        bh=c+9Vkcft9Ze779qh4taIS5mX7dhxMYtBPJmqfP71LWo=;
        h=From:To:Cc:Subject:Date:From;
        b=KUbmCRN2q9VVAJddqck0kPQln6Ux8KdEBZ1xaDe/X/Nz2YdsiAboPveH1hS/X6KKC
         WtX/Qu90IypYmNBChAI/RGLvaiabPSAvqa6LWZndzOeFcTkPtDXn+0cxfm/4FvCnMs
         fo4S+PKpC09bQ5YhYQkNXWyZXtas3xP9NE/TwL6xWef62Zn0B9sVow88uKiQcvlNum
         929oqAw9lIYEdjNyyDyh/rgc5chT971U8ftCUI8wleGWCfU32ufzlbQi+bEiKJ959X
         vmSglsnjJLCUaghJXIn4wmlbpwnWafnsVMTJ0hnjcOYvvNYPoJKXCJsmQW5O8HYRny
         Dign3vmd6vtjg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org
Subject: [PATCH] netfilter: add include guard to nf_conntrack_h323_types.h
Date:   Mon, 19 Aug 2019 16:39:27 +0900
Message-Id: <20190819073927.12296-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/netfilter/nf_conntrack_h323_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/netfilter/nf_conntrack_h323_types.h b/include/linux/netfilter/nf_conntrack_h323_types.h
index 7a6871ac8784..74c6f9241944 100644
--- a/include/linux/netfilter/nf_conntrack_h323_types.h
+++ b/include/linux/netfilter/nf_conntrack_h323_types.h
@@ -4,6 +4,9 @@
  * Copyright (c) 2006 Jing Min Zhao <zhaojingmin@users.sourceforge.net>
  */
 
+#ifndef _NF_CONNTRACK_H323_TYPES_H
+#define _NF_CONNTRACK_H323_TYPES_H
+
 typedef struct TransportAddress_ipAddress {	/* SEQUENCE */
 	int options;		/* No use */
 	unsigned int ip;
@@ -931,3 +934,5 @@ typedef struct RasMessage {	/* CHOICE */
 		InfoRequestResponse infoRequestResponse;
 	};
 } RasMessage;
+
+#endif /* _NF_CONNTRACK_H323_TYPES_H */
-- 
2.17.1

