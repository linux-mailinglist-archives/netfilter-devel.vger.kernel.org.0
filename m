Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE492981D6
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Oct 2020 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416154AbgJYNRQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Oct 2020 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894311AbgJYNRP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:17:15 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF2C0613CE
        for <netfilter-devel@vger.kernel.org>; Sun, 25 Oct 2020 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oYxWxmTRcqbw4/TDfY63IlmNvhe0iiD5363WHpE0m2k=; b=mk+AjLW2qrdhOQsboSI21Bfmfe
        zQPs+81GUSmE3/5K0Ai8wfu2/eINLBvdev8bPc7BO312I+bCPFkrI2vjJ/rs6pJE2zrthH7bKD+vc
        QSdYgG+ZN9I0DRh0blFNk3ModSGZO7vzE8mzxf9sEtoju9DsmFAZt+xTK4ZSvBWS1Xbq4Z8I9H2cr
        xc3LOMxpUAKVVNGmxwGx7KVarwwC1OfC+JFpudP11IyFdjZxpF6Z8RUP9L5f9itNh/rzoXjpAPLqD
        +M3C47tjBJOTLt+tjaPOam89WPGSwHHFpE01UsfPmc6C8m4grvq3NDPrO+GpZ0n1GqClAzkyBB9TW
        4gCJrdAw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kWfsW-0001SE-Td; Sun, 25 Oct 2020 13:16:09 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons v2 12/13] pknock: xt_pknock: use `pr_err`.
Date:   Sun, 25 Oct 2020 13:15:58 +0000
Message-Id: <20201025131559.920038-14-jeremy@azazel.net>
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

Replace some instances of `printk(KERN_ERR PKNOCK ...)`.  We define
`pr_fmt`, so `pr_err` is equivalent.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/pknock/xt_pknock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/extensions/pknock/xt_pknock.c b/extensions/pknock/xt_pknock.c
index ae3ab2445c3b..f2c79529e21b 100644
--- a/extensions/pknock/xt_pknock.c
+++ b/extensions/pknock/xt_pknock.c
@@ -1016,7 +1016,7 @@ out:
 	return ret;
 }
 
-#define RETURN_ERR(err) do { printk(KERN_ERR PKNOCK err); return -EINVAL; } while (false)
+#define RETURN_ERR(err) do { pr_err(err); return -EINVAL; } while (false)
 
 static int pknock_mt_check(const struct xt_mtchk_param *par)
 {
@@ -1103,14 +1103,14 @@ static int __init xt_pknock_mt_init(void)
 	if (gc_expir_time < DEFAULT_GC_EXPIRATION_TIME)
 		gc_expir_time = DEFAULT_GC_EXPIRATION_TIME;
 	if (request_module(crypto.algo) < 0) {
-		printk(KERN_ERR PKNOCK "request_module('%s') error.\n",
+		pr_err("request_module('%s') error.\n",
                         crypto.algo);
 		return -ENXIO;
 	}
 
 	crypto.tfm = crypto_alloc_shash(crypto.algo, 0, 0);
 	if (IS_ERR(crypto.tfm)) {
-		printk(KERN_ERR PKNOCK "failed to load transform for %s\n",
+		pr_err("failed to load transform for %s\n",
 						crypto.algo);
 		return PTR_ERR(crypto.tfm);
 	}
@@ -1120,7 +1120,7 @@ static int __init xt_pknock_mt_init(void)
 
 	pde = proc_mkdir("xt_pknock", init_net.proc_net);
 	if (pde == NULL) {
-		printk(KERN_ERR PKNOCK "proc_mkdir() error in _init().\n");
+		pr_err("proc_mkdir() error in _init().\n");
 		return -ENXIO;
 	}
 	return xt_register_match(&xt_pknock_mt_reg);
-- 
2.28.0

