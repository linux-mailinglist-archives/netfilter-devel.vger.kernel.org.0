Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7E2A211F
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Nov 2020 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgKATdU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Nov 2020 14:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKATdT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:33:19 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05594C0617A6
        for <netfilter-devel@vger.kernel.org>; Sun,  1 Nov 2020 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pBLt4b6pZFvd954TiZZbey0mTOyl3tD87wzTiNi7THk=; b=oKpIlNf1KlKss/T+Gjqk9JVv8j
        HulAXfzYqqM7a+lNbrXDjcb1uxMscdN1GrzBOf8U8jcYi1Kcy56iS5FP445BsYQYJc2fVCHZll1Wt
        FNFCPUSmZL7sAVOrxjJGBwxzMKqknjaVuRwjPY4b1xMyLDF9420N2/a9uUYE683tzca7dYuf06CMu
        WFglSso/pXvGQvQorvMT7LqaYmTRbAhPC0yk1THqMarm5r4NScnG9aDrDD70EdBbB0SzijaaZ+UfV
        AU+u49bfPMhtxXmzo360JQ2YunpSOw43eahvXT7WHah8xBC+Z+Hp6xeSHVOWrg7ACzCG/myfyeup3
        +r6ODafg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kZJ6K-000437-FQ; Sun, 01 Nov 2020 19:33:16 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH] doc: correct chain name in example of adding a rule.
Date:   Sun,  1 Nov 2020 19:33:13 +0000
Message-Id: <20201101193313.10879-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The example adds a rule to the `output` chain, not the `input` chain.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 doc/nft.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/nft.txt b/doc/nft.txt
index 5326de167de8..47b55f934de9 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -462,7 +462,7 @@ beginning of the chain or before the specified rule.
 *replace*:: Similar to *add*, but the rule replaces the specified rule.
 *delete*:: Delete the specified rule.
 
-.*add a rule to ip table input chain*
+.*add a rule to ip table output chain*
 -------------
 nft add rule filter output ip daddr 192.168.0.0/24 accept # 'ip filter' is assumed
 # same command, slightly more verbose
-- 
2.28.0

