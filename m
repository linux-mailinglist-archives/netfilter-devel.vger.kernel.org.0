Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F5446EE0
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Nov 2021 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhKFQUx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Nov 2021 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhKFQUx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Nov 2021 12:20:53 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28994C061746
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Nov 2021 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o4Kd5I0g7pNJwPThSMEr9+yiFt5qT8Cq3e+Y/2nvbZg=; b=V8/6Ex+2Z6r3rqyPVSnQCyUxAC
        pCM+UwDV45fe6Wm1Fip45HpQ+H4z+oodzNbRDhcrv1g3yGJsGgzcqKQQL6MbQDo3X0AoUJvrve/kU
        M73RE2QVa4El+UhbE4vFTw1a8IN14NervdzD+y5tNL17SZwpHbLY3s7tTZFk079PnASs1sDyggpIa
        +oVa5uYDqIeRaKy8bPk06yGpYNUBe89X91g/3WQjxpaVELGI4pYLyaejUOpjksR+R5qeKNTrIpEUb
        Ac7n1cn72joFydK2QQlHTK1PxrCaCcMQBKYixLX61KUXWfCMev1MWwIsptujthF2FMHG8SUwgQoZV
        RyloX52Q==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mjOOQ-004loO-Ha
        for netfilter-devel@vger.kernel.org; Sat, 06 Nov 2021 16:18:10 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v2 02/12] gitignore: ignore .dirstamp
Date:   Sat,  6 Nov 2021 16:17:49 +0000
Message-Id: <20211106161759.128364-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211106161759.128364-1-jeremy@azazel.net>
References: <20211106161759.128364-1-jeremy@azazel.net>
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
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3f218218dfc9..3eb592245c0d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,6 +6,7 @@
 *.lo
 *.o
 .deps/
+.dirstamp
 .libs/
 Makefile
 Makefile.in
-- 
2.33.0

