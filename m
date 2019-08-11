Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1989140
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Aug 2019 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfHKKW1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Aug 2019 06:22:27 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:17615 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfHKKW1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Aug 2019 06:22:27 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 06:22:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565518945;
        s=strato-dkim-0002; d=fami-braun.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Phnkk2vrY/nvqK1enfwbjdRE+lkLqb0WqiW+7RHu9PQ=;
        b=gsauvabuwAr1NPJXO+/FsW88iwDYzLn+MVERX7Kv4EA2A+fTqcoLdkU/jQ7TcQb+9A
        X0oBYMsEYSjbxa9dAChSyKCvbNgtIRRKkX6Sa5PrLycvEA1AeluzjuRt60rchU+PCVc4
        JChPoIiSpNogQSyUQKR7v6dqn+/DJXQuGr9QR5K5fWgPnqcjHcAbgYTBXO75VOsuJP72
        gREcx9Hd5dgCdtFxYWLUl1K2vG6lQkBRcfnlQMxvxzrfPBsDP1CNe5uR7rfdEsZd0Cvr
        CPlrKFg2SOvm56kyuWO70CMKG6GOnZ3n+vKPi0VtKZiYdvqXxlTR49EPJKzdsGYN3a4G
        51Kw==
X-RZG-AUTH: ":P20JeEWkefDI1ODZs1HHtgV3eF0OpFsRaGIBEm4ljegySSvO7VhbcRIBGrxpew95lCZXlpXYMu1vNQ=="
X-RZG-CLASS-ID: mo00
Received: from dynamic.fami-braun.de
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id R034b8v7BAG7SRW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 11 Aug 2019 12:16:07 +0200 (CEST)
Received: from dynamic.fami-braun.de (localhost [127.0.0.1])
        by dynamic.fami-braun.de (fami-braun.de) with ESMTP id AD2D2154015;
        Sun, 11 Aug 2019 12:16:06 +0200 (CEST)
Received: by dynamic.fami-braun.de (fami-braun.de, from userid 1001)
        id 7F445158234; Sun, 11 Aug 2019 12:16:06 +0200 (CEST)
From:   michael-dev@fami-braun.de
To:     netfilter-devel@vger.kernel.org
Cc:     michael-dev@fami-braun.de, pablo@netfilter.org
Subject: [PATCH] tests: add json test for vlan rule fix
Date:   Sun, 11 Aug 2019 12:16:03 +0200
Message-Id: <20190811101603.2892-1-michael-dev@fami-braun.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: "M. Braun" <michael-dev@fami-braun.de>

This fixes

ERROR: did not find JSON equivalent for rule 'ether type vlan ip
protocol 1 accept'

when running

./nft-test.py -j bridge/vlan.t

Reported-by: pablo@netfilter.org
Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
---
 tests/py/bridge/vlan.t.json        | 31 ++++++++++++++++++++++++++++++
 tests/py/bridge/vlan.t.json.output | 31 ++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tests/py/bridge/vlan.t.json.output

diff --git a/tests/py/bridge/vlan.t.json b/tests/py/bridge/vlan.t.json
index 1a65464..3fb2e4f 100644
--- a/tests/py/bridge/vlan.t.json
+++ b/tests/py/bridge/vlan.t.json
@@ -499,3 +499,34 @@
     }
 ]
 
+# ether type vlan ip protocol 1 accept
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "ether"
+                }
+            },
+            "op": "==",
+            "right": "vlan"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "protocol",
+                    "protocol": "ip"
+                }
+            },
+            "op": "==",
+            "right": "icmp"
+        }
+    },
+    {
+        "accept": null
+    }
+]
+
diff --git a/tests/py/bridge/vlan.t.json.output b/tests/py/bridge/vlan.t.json.output
new file mode 100644
index 0000000..8f27ec0
--- /dev/null
+++ b/tests/py/bridge/vlan.t.json.output
@@ -0,0 +1,31 @@
+# ether type vlan ip protocol 1 accept
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "ether"
+                }
+            },
+            "op": "==",
+            "right": "vlan"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "protocol",
+                    "protocol": "ip"
+                }
+            },
+            "op": "==",
+            "right": 1
+        }
+    },
+    {
+        "accept": null
+    }
+]
+
-- 
2.20.1

