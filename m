Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F263528A99D
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Oct 2020 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJKTXq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Oct 2020 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgJKTXq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Oct 2020 15:23:46 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD8C0613D0
        for <netfilter-devel@vger.kernel.org>; Sun, 11 Oct 2020 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7u8iXxJ9+9henjRFOxeqEjK6xpQC58xRrEoFMsNCV08=; b=Avbzq7C4tveItYMPJaXeHENbfa
        b3U/zGDxpD9s1VHxiQwd4vhexy15Tvt09WGo0PA6lTsDDg/zzLJpgwyA46VZoMXPAA6/9pvrOEmpp
        yycwON8GPWLfqCge7Nejim1jGZhxGACi1tba2Vz707K/lGLhIa0tdSKMM9LDnf8l5zKURs5wiQpZ2
        m5m0t5zcbj0/z5q997Uyj4yrZJ+MZV1n53RSrpYxuuRAv/va2Difdyalet7L9HKMzKdkkdA8rh9vn
        uhntoPUSAWXZkVDxywJ66CVPFp6Z2eKM3wHW8erxm/YftwjkPXDK8YlDx75XQ9mG+ndq6LI2C+Kek
        0spRgANA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kRgwX-00016N-LL; Sun, 11 Oct 2020 20:23:41 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 1/3] tests: py: add missing JSON output for ct test.
Date:   Sun, 11 Oct 2020 20:23:22 +0100
Message-Id: <20201011192324.209237-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011192324.209237-1-jeremy@azazel.net>
References: <20201011192324.209237-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: dcec7d57559a ("ct: Add support for the 'id' key")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 tests/py/any/ct.t.json | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/py/any/ct.t.json b/tests/py/any/ct.t.json
index 59ac27c3055c..c5c15b9c8b94 100644
--- a/tests/py/any/ct.t.json
+++ b/tests/py/any/ct.t.json
@@ -1449,6 +1449,21 @@
     }
 ]
 
+# ct id 12345
+[
+    {
+        "match": {
+            "left": {
+                "ct": {
+                    "key": "id"
+                }
+            },
+            "op": "==",
+            "right": 12345
+        }
+    }
+]
+
 # ct zone set mark map { 1 : 1,  2 : 2 }
 [
     {
-- 
2.28.0

