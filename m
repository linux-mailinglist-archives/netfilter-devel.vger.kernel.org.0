Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517BA6523C7
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Dec 2022 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLTPjF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Dec 2022 10:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTPjD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:39:03 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256E186E5
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Dec 2022 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4dNmJIX5YINu/YdTBRfDWPmp8i/DtYR+0OfaCCgoQH8=; b=Z8LTgY9xLDu01v4CaY6r3Xa2jT
        qjpgVYaIHZfQh2fOpPSXqLbuSWwy+mCGaJKp0JFKrHYq/k6kSP4VEqXe83OMtiTutRHEu3O/aWH7j
        bGZCnaOmHb7vMi8JE8oOp4rC8oLEooByO/VeiTbtRb6KT+g0GVj1Aulmo2WLDNz+n7PxqakXcvwRx
        Qq4YlNEXUhrNKxEg5QSDvQpJCpH+GoFYJXbo2A/8Dy8R9fm3ery9pAlTlxLTq9/LGx3vvcmf9Yg8w
        wLt9PUfGuo7/OWEdoGNt3ymhI8Q1uBCIO852cehUNGQHWH+lComk6y6I4QSTHrlVORUonHin5usmM
        P6JjWcjQ==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1p7ehp-0000FW-C5; Tue, 20 Dec 2022 16:39:01 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [conntrack-tools PATCH 1/4] conntrack: Fix potential array out of bounds access
Date:   Tue, 20 Dec 2022 16:38:44 +0100
Message-Id: <20221220153847.24152-2-phil@nwl.cc>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221220153847.24152-1-phil@nwl.cc>
References: <20221220153847.24152-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the link target length exceeds 'sizeof(tmp)' bytes, readlink() will
return 'sizeof(tmp)'. Using this value as index is illegal.

Fixes: b031cd2102d9b ("conntrack: pretty-print the portid")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index 859a4835580b0..aa6323dfbd1b1 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -1769,7 +1769,7 @@ static char *portid2name(pid_t pid, uint32_t portid, unsigned long inode)
 			continue;
 
 		rl = readlink(procname, tmp, sizeof(tmp));
-		if (rl <= 0 || rl > (ssize_t)sizeof(tmp))
+		if (rl <= 0 || rl >= (ssize_t)sizeof(tmp))
 			continue;
 
 		tmp[rl] = 0;
-- 
2.38.0

