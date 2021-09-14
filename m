Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8810E40B052
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Sep 2021 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhINOOv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Sep 2021 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhINOOu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:14:50 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958ACC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Sep 2021 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xzDmQKdMYiLSgjwgdJP2VbRGBrJfPjK2k8I8CBsQ1CI=; b=ocY8Rg211nRgPLXcbea+V2307c
        28noEutbcxX/MPCOIFwB3lQgM1r0TN0kCpTH4eXuWjECTrqWfCIIBHTMkZxHt0SuMva5bqXaQjoqN
        yZ7cUKvBG+JywWdrBkKfTz6BOq0CND3BUTPdjtpT2Kqysvp/dWDOmBcSlIyllPTjC+HoeNeMqRNA9
        C8KDYK9aUuQywSTJDjn6aJ6f0F4SiTZjBDfjocNw6QSmbNEA0K8WCeFXMYUfRkIdtKm0rDDHuKaPd
        uLZyP5ByPdpgPd99fr2+9IqwoPOMoZqJif1JyoaPVqLhbsKm8ZjKVfxcFAvHxD5Za/fQ8Ork6aqzO
        PO12Y5Yw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mQ9Bi-0002ql-Fr; Tue, 14 Sep 2021 15:13:30 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>, kaskada@email.cz
Subject: [xtables-addons] xt_ipp2p: add ipv6 module alias
Date:   Tue, 14 Sep 2021 15:09:34 +0100
Message-Id: <20210914140934.190397-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/xt_ipp2p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/extensions/xt_ipp2p.c b/extensions/xt_ipp2p.c
index c2f7ee7e5585..af61ff4fb9ca 100644
--- a/extensions/xt_ipp2p.c
+++ b/extensions/xt_ipp2p.c
@@ -1065,3 +1065,4 @@ static void __exit ipp2p_mt_exit(void)
 module_init(ipp2p_mt_init);
 module_exit(ipp2p_mt_exit);
 MODULE_ALIAS("ipt_ipp2p");
+MODULE_ALIAS("ip6t_ipp2p");
-- 
2.33.0

