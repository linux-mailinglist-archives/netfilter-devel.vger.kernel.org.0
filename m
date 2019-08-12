Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8778589D6A
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Aug 2019 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfHLL5n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Aug 2019 07:57:43 -0400
Received: from kadath.azazel.net ([81.187.231.250]:42454 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfHLL5n (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HNb1J9wbH5bMeFa6u2LvOTfXcDb7HGJNKPTOEOKC5TA=; b=bz6P4qIOpVruOhK/OM7Q9uM+9i
        sXgc8iU1uZn9LWuJcPEpMb0tdjBN8KlCh4DzOTixwo/pAJ+Nw3G+Rnq+EX5PPEmJuydZPWOeS/nqu
        i1kz2oTIIHaeRGKWM7cco5ntYnTWXftH+gD0HdiHixQIoQoOTRoLQY1O+kV3naSZZpkCbfZncIpMP
        pmhsbczra2uRiLWGa/dsP+ijV7p7kGKWVqfxbNreRipNRORNGS4i4vMWsuE2eXEHRV9si3NYDM6I8
        ROqdI1an7Q5tik8v5ARObqIMPTOFEcwbtonQpXIdNsmohVA/mPelx7GaAnwYaWOvNG/u2EA9B4M3N
        lHgDBuwA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1hx8xK-0002sN-CT; Mon, 12 Aug 2019 12:57:42 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     =?UTF-8?q?Franta=20Hanzl=C3=ADk?= <franta@hanzlici.cz>
Subject: [PATCH xtables-addons v2 1/2] xt_pknock, xt_SYSRQ: don't set shash_desc::flags.
Date:   Mon, 12 Aug 2019 12:57:41 +0100
Message-Id: <20190812115742.21770-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812115742.21770-1-jeremy@azazel.net>
References: <20190811113826.5e594d8f@franta.hanzlici.cz>
 <20190812115742.21770-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

shash_desc::flags was removed from the kernel in 5.1.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/pknock/xt_pknock.c | 1 -
 extensions/xt_SYSRQ.c         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/extensions/pknock/xt_pknock.c b/extensions/pknock/xt_pknock.c
index c76901ac4c1a..8021ea07e1b9 100644
--- a/extensions/pknock/xt_pknock.c
+++ b/extensions/pknock/xt_pknock.c
@@ -1125,7 +1125,6 @@ static int __init xt_pknock_mt_init(void)
 
 	crypto.size = crypto_shash_digestsize(crypto.tfm);
 	crypto.desc.tfm = crypto.tfm;
-	crypto.desc.flags = 0;
 
 	pde = proc_mkdir("xt_pknock", init_net.proc_net);
 	if (pde == NULL) {
diff --git a/extensions/xt_SYSRQ.c b/extensions/xt_SYSRQ.c
index c386c7e2db5d..183692f49489 100644
--- a/extensions/xt_SYSRQ.c
+++ b/extensions/xt_SYSRQ.c
@@ -114,7 +114,6 @@ static unsigned int sysrq_tg(const void *pdata, uint16_t len)
 	}
 
 	desc.tfm   = sysrq_tfm;
-	desc.flags = 0;
 	ret = crypto_shash_init(&desc);
 	if (ret != 0)
 		goto hash_fail;
-- 
2.20.1

