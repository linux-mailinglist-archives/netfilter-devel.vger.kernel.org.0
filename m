Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1950218912
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 May 2019 13:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfEILfp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 May 2019 07:35:45 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35020 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEILfp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 May 2019 07:35:45 -0400
Received: from localhost ([::1]:48110 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hOhKw-0000bB-QL; Thu, 09 May 2019 13:35:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/9] parser_json: Fix igmp support
Date:   Thu,  9 May 2019 13:35:38 +0200
Message-Id: <20190509113545.4017-3-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509113545.4017-1-phil@nwl.cc>
References: <20190509113545.4017-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Parser didn't know about that protocol, also testsuite bits were
missing.

Fixes: bad27ca386276 ("src: add igmp support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/parser_json.c       |   1 +
 tests/py/ip/igmp.t.json | 323 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 324 insertions(+)
 create mode 100644 tests/py/ip/igmp.t.json

diff --git a/src/parser_json.c b/src/parser_json.c
index 0c4f5d913813a..3a78f8860aaca 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -492,6 +492,7 @@ static const struct proto_desc *proto_lookup_byname(const char *name)
 		&proto_arp,
 		&proto_ip,
 		&proto_icmp,
+		&proto_igmp,
 		&proto_ip6,
 		&proto_icmp6,
 		&proto_ah,
diff --git a/tests/py/ip/igmp.t.json b/tests/py/ip/igmp.t.json
new file mode 100644
index 0000000000000..66dd3bb70c5b9
--- /dev/null
+++ b/tests/py/ip/igmp.t.json
@@ -0,0 +1,323 @@
+# igmp type membership-query
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": "membership-query"
+        }
+    }
+]
+
+# igmp type membership-report-v1
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": "membership-report-v1"
+        }
+    }
+]
+
+# igmp type membership-report-v2
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": "membership-report-v2"
+        }
+    }
+]
+
+# igmp type membership-report-v3
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": "membership-report-v3"
+        }
+    }
+]
+
+# igmp type leave-group
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": "leave-group"
+        }
+    }
+]
+
+# igmp type { membership-report-v1, membership-report-v2, membership-report-v3}
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": {
+                "set": [
+                    "membership-report-v1",
+                    "membership-report-v2",
+                    "membership-report-v3"
+                ]
+            }
+        }
+    }
+]
+
+# igmp type != { membership-report-v1, membership-report-v2, membership-report-v3}
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "!=",
+            "right": {
+                "set": [
+                    "membership-report-v1",
+                    "membership-report-v2",
+                    "membership-report-v3"
+                ]
+            }
+        }
+    }
+]
+
+# igmp checksum 12343
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": 12343
+        }
+    }
+]
+
+# igmp checksum != 12343
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "!=",
+            "right": 12343
+        }
+    }
+]
+
+# igmp checksum 11-343
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": {
+                "range": [
+                    11,
+                    343
+                ]
+            }
+        }
+    }
+]
+
+# igmp checksum != 11-343
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "!=",
+            "right": {
+                "range": [
+                    11,
+                    343
+                ]
+            }
+        }
+    }
+]
+
+# igmp checksum { 11-343}
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": {
+                "set": [
+                    {
+                        "range": [
+                            11,
+                            343
+                        ]
+                    }
+                ]
+            }
+        }
+    }
+]
+
+# igmp checksum != { 11-343}
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "!=",
+            "right": {
+                "set": [
+                    {
+                        "range": [
+                            11,
+                            343
+                        ]
+                    }
+                ]
+            }
+        }
+    }
+]
+
+# igmp checksum { 1111, 222, 343}
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": {
+                "set": [
+                    222,
+                    343,
+                    1111
+                ]
+            }
+        }
+    }
+]
+
+# igmp checksum != { 1111, 222, 343}
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "checksum",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "!=",
+            "right": {
+                "set": [
+                    222,
+                    343,
+                    1111
+                ]
+            }
+        }
+    }
+]
+
+# igmp mrt 10
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "mrt",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "==",
+            "right": 10
+        }
+    }
+]
+
+# igmp mrt != 10
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "mrt",
+                    "protocol": "igmp"
+                }
+            },
+            "op": "!=",
+            "right": 10
+        }
+    }
+]
-- 
2.21.0

