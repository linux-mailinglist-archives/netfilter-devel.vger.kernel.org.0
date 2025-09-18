Return-Path: <netfilter-devel+bounces-8432-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F8B2F382
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Aug 2025 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59FA1CC8449
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Aug 2025 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB282EF669;
	Thu, 21 Aug 2025 09:13:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from localhost.localdomain (203.red-83-63-38.staticip.rima-tde.net [83.63.38.203])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF138199385
	for <netfilter-devel@vger.kernel.org>; Thu, 21 Aug 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.63.38.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767605; cv=none; b=Vmz4I+V5u7ATd5M7h2fnBPP8agsH31TzLYr2pCZQcOe9PxMeSReagzLsjO9AA2tBYJC3milBnVFRC7vXeozIQA/+UqnqqJmz81++gdfJqIL8DKkKFW51+76zzzr19/e7ANs16AwJxkckhVphRA8HtsxoTsDA6MMIAi5n/+dEtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767605; c=relaxed/simple;
	bh=KJPQ+VpIk5PJC72yGqwJhHrtFkjFIvyFg2e5AkjSzS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnYe8LnSTF4aUQz78h/8tpS0h1T3GtVfmpqen4zdtLrT7NetWJJjAhGKNe5u0ufFWYz6m+fAqD61rhJcTtHx6g0KnNiNOxmF7DostaqsWFLmgkBO+CBs6FKvn5HcJ27DioHJRhpbxOtoAbqsVFeDWBhf5YkwRZIpkToFaisvwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=83.63.38.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1000)
	id A2AB52165AFF; Thu, 21 Aug 2025 11:13:22 +0200 (CEST)
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 7/7 nft v3] tests: add tunnel shell and python tests
Date: Thu, 21 Aug 2025 11:13:02 +0200
Message-ID: <20250821091302.9032-7-fmancera@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821091302.9032-1-fmancera@suse.de>
References: <20250821091302.9032-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for tunnel statement and object support. Shell and python
tests both cover standard nft output and json.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: rebased and adapted tests for new json src/dst keys
---
 tests/py/netdev/tunnel.t                      |   7 +
 tests/py/netdev/tunnel.t.json                 |  45 +++++
 tests/py/netdev/tunnel.t.payload              |  15 ++
 tests/shell/features/tunnel.nft               |  17 ++
 tests/shell/testcases/sets/0075tunnel_0       |  75 ++++++++
 .../sets/dumps/0075tunnel_0.json-nft          | 171 ++++++++++++++++++
 .../testcases/sets/dumps/0075tunnel_0.nft     |  63 +++++++
 7 files changed, 393 insertions(+)
 create mode 100644 tests/py/netdev/tunnel.t
 create mode 100644 tests/py/netdev/tunnel.t.json
 create mode 100644 tests/py/netdev/tunnel.t.payload
 create mode 100644 tests/shell/features/tunnel.nft
 create mode 100755 tests/shell/testcases/sets/0075tunnel_0
 create mode 100644 tests/shell/testcases/sets/dumps/0075tunnel_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0075tunnel_0.nft

diff --git a/tests/py/netdev/tunnel.t b/tests/py/netdev/tunnel.t
new file mode 100644
index 00000000..920d21ff
--- /dev/null
+++ b/tests/py/netdev/tunnel.t
@@ -0,0 +1,7 @@
+:tunnelchain;type filter hook ingress device lo priority 0
+
+*netdev;test-netdev;tunnelchain
+
+tunnel path exists;ok
+tunnel path missing;ok
+tunnel id 10;ok
diff --git a/tests/py/netdev/tunnel.t.json b/tests/py/netdev/tunnel.t.json
new file mode 100644
index 00000000..3ca877d9
--- /dev/null
+++ b/tests/py/netdev/tunnel.t.json
@@ -0,0 +1,45 @@
+# tunnel path exists
+[
+    {
+        "match": {
+            "left": {
+                "tunnel": {
+                    "key": "path"
+                }
+            },
+            "op": "==",
+            "right": true
+        }
+    }
+]
+
+# tunnel path missing
+[
+    {
+        "match": {
+            "left": {
+                "tunnel": {
+                    "key": "path"
+                }
+            },
+            "op": "==",
+            "right": false
+        }
+    }
+]
+
+# tunnel id 10
+[
+    {
+        "match": {
+            "left": {
+                "tunnel": {
+                    "key": "id"
+                }
+            },
+            "op": "==",
+            "right": 10
+        }
+    }
+]
+
diff --git a/tests/py/netdev/tunnel.t.payload b/tests/py/netdev/tunnel.t.payload
new file mode 100644
index 00000000..9148d0e5
--- /dev/null
+++ b/tests/py/netdev/tunnel.t.payload
@@ -0,0 +1,15 @@
+# tunnel path exists
+netdev test-netdev tunnelchain
+  [ tunnel load path => reg 1 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# tunnel path missing
+netdev test-netdev tunnelchain
+  [ tunnel load path => reg 1 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# tunnel id 10
+netdev test-netdev tunnelchain
+  [ tunnel load id => reg 1 ]
+  [ cmp eq reg 1 0x0000000a ]
+
diff --git a/tests/shell/features/tunnel.nft b/tests/shell/features/tunnel.nft
new file mode 100644
index 00000000..64b2f70b
--- /dev/null
+++ b/tests/shell/features/tunnel.nft
@@ -0,0 +1,17 @@
+# v5.7-rc1~146^2~137^2~26
+# 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts")
+table netdev x {
+        tunnel y {
+                id 10
+                ip saddr 192.168.2.10
+                ip daddr 192.168.2.11
+                sport 10
+                dport 20
+                ttl 10
+                geneve {
+                        class 0x1010 opt-type 0x1 data "0x12345678"
+                        class 0x2010 opt-type 0x2 data "0x87654321"
+                        class 0x2020 opt-type 0x3 data "0x87654321abcdeffe"
+                }
+        }
+}
diff --git a/tests/shell/testcases/sets/0075tunnel_0 b/tests/shell/testcases/sets/0075tunnel_0
new file mode 100755
index 00000000..f8a8cf00
--- /dev/null
+++ b/tests/shell/testcases/sets/0075tunnel_0
@@ -0,0 +1,75 @@
+#!/bin/bash
+
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_tunnel)
+
+# * creating valid named objects
+# * referencing them from a valid rule
+
+RULESET="
+table netdev x {
+	tunnel geneve-t {
+		id 10
+		ip saddr 192.168.2.10
+		ip daddr 192.168.2.11
+		sport 10
+		dport 10
+		ttl 10
+		tos 10
+		geneve {
+			class 0x1 opt-type 0x1 data \"0x12345678\"
+			class 0x1010 opt-type 0x2 data \"0x87654321\"
+			class 0x2020 opt-type 0x3 data \"0x87654321abcdeffe\"
+		}
+	}
+
+	tunnel vxlan-t {
+		id 20
+		ip saddr 192.168.2.20
+		ip daddr 192.168.2.21
+		sport 20
+		dport 20
+		ttl 10
+		tos 10
+		vxlan {
+			gbp 200
+		}
+	}
+
+	tunnel erspan-tv1 {
+		id 30
+		ip saddr 192.168.2.30
+		ip daddr 192.168.2.31
+		sport 30
+		dport 30
+		ttl 10
+		tos 10
+		erspan {
+			version 1
+			index 5
+		}
+	}
+
+	tunnel erspan-tv2 {
+		id 40
+		ip saddr 192.168.2.40
+		ip daddr 192.168.2.41
+		sport 40
+		dport 40
+		ttl 10
+		tos 10
+		erspan {
+			version 2
+			direction ingress
+			id 10
+		}
+	}
+
+	chain x {
+		type filter hook ingress priority 0; policy accept;
+		tunnel name ip saddr map { 10.141.10.123 : "geneve-t", 10.141.10.124 : "vxlan-t", 10.141.10.125 : "erspan-tv1", 10.141.10.126 : "erspan-tv2" } counter
+	}
+}
+"
+
+set -e
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/sets/dumps/0075tunnel_0.json-nft b/tests/shell/testcases/sets/dumps/0075tunnel_0.json-nft
new file mode 100644
index 00000000..7cd58268
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/0075tunnel_0.json-nft
@@ -0,0 +1,171 @@
+{
+  "nftables": [
+    {
+      "metainfo": {
+        "version": "VERSION",
+        "release_name": "RELEASE_NAME",
+        "json_schema_version": 1
+      }
+    },
+    {
+      "table": {
+        "family": "netdev",
+        "name": "x",
+        "handle": 0
+      }
+    },
+    {
+      "chain": {
+        "family": "netdev",
+        "table": "x",
+        "name": "x",
+        "handle": 0,
+        "type": "filter",
+        "hook": "ingress",
+        "prio": 0,
+        "policy": "accept"
+      }
+    },
+    {
+      "tunnel": {
+        "family": "netdev",
+        "name": "geneve-t",
+        "table": "x",
+        "handle": 0,
+        "id": 10,
+        "src-ipv4": "192.168.2.10",
+        "dst-ipv4": "192.168.2.11",
+        "sport": 10,
+        "dport": 10,
+        "tos": 10,
+        "ttl": 10,
+        "type": "geneve",
+        "tunnel": [
+          {
+            "class": 1,
+            "opt-type": 1,
+            "data": "0x12345678"
+          },
+          {
+            "class": 4112,
+            "opt-type": 2,
+            "data": "0x87654321"
+          },
+          {
+            "class": 8224,
+            "opt-type": 3,
+            "data": "0x87654321abcdeffe"
+          }
+        ]
+      }
+    },
+    {
+      "tunnel": {
+        "family": "netdev",
+        "name": "vxlan-t",
+        "table": "x",
+        "handle": 0,
+        "id": 20,
+        "src-ipv4": "192.168.2.20",
+        "dst-ipv4": "192.168.2.21",
+        "sport": 20,
+        "dport": 20,
+        "tos": 10,
+        "ttl": 10,
+        "type": "vxlan",
+        "tunnel": {
+          "gbp": 200
+        }
+      }
+    },
+    {
+      "tunnel": {
+        "family": "netdev",
+        "name": "erspan-tv1",
+        "table": "x",
+        "handle": 0,
+        "id": 30,
+        "src-ipv4": "192.168.2.30",
+        "dst-ipv4": "192.168.2.31",
+        "sport": 30,
+        "dport": 30,
+        "tos": 10,
+        "ttl": 10,
+        "type": "erspan",
+        "tunnel": {
+          "version": 1,
+          "index": 5
+        }
+      }
+    },
+    {
+      "tunnel": {
+        "family": "netdev",
+        "name": "erspan-tv2",
+        "table": "x",
+        "handle": 0,
+        "id": 40,
+        "src-ipv4": "192.168.2.40",
+        "dst-ipv4": "192.168.2.41",
+        "sport": 40,
+        "dport": 40,
+        "tos": 10,
+        "ttl": 10,
+        "type": "erspan",
+        "tunnel": {
+          "version": 2,
+          "dir": "ingress",
+          "hwid": 10
+        }
+      }
+    },
+    {
+      "rule": {
+        "family": "netdev",
+        "table": "x",
+        "chain": "x",
+        "handle": 0,
+        "expr": [
+          {
+            "tunnel": {
+              "map": {
+                "key": {
+                  "payload": {
+                    "protocol": "ip",
+                    "field": "saddr"
+                  }
+                },
+                "data": {
+                  "set": [
+                    [
+                      "10.141.10.123",
+                      "geneve-t"
+                    ],
+                    [
+                      "10.141.10.124",
+                      "vxlan-t"
+                    ],
+                    [
+                      "10.141.10.125",
+                      "erspan-tv1"
+                    ],
+                    [
+                      "10.141.10.126",
+                      "erspan-tv2"
+                    ]
+                  ]
+                }
+              }
+            }
+          },
+          {
+            "counter": {
+              "packets": 0,
+              "bytes": 0
+            }
+          }
+        ]
+      }
+    }
+  ]
+}
diff --git a/tests/shell/testcases/sets/dumps/0075tunnel_0.nft b/tests/shell/testcases/sets/dumps/0075tunnel_0.nft
new file mode 100644
index 00000000..9969124d
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/0075tunnel_0.nft
@@ -0,0 +1,63 @@
+table netdev x {
+	tunnel geneve-t {
+		id 10
+		ip saddr 192.168.2.10
+		ip daddr 192.168.2.11
+		sport 10
+		dport 10
+		tos 10
+		ttl 10
+		geneve {
+			class 0x1 opt-type 0x1 data "0x12345678"
+			class 0x1010 opt-type 0x2 data "0x87654321"
+			class 0x2020 opt-type 0x3 data "0x87654321abcdeffe"
+		}
+	}
+
+	tunnel vxlan-t {
+		id 20
+		ip saddr 192.168.2.20
+		ip daddr 192.168.2.21
+		sport 20
+		dport 20
+		tos 10
+		ttl 10
+		vxlan {
+			gbp 200
+		}
+	}
+
+	tunnel erspan-tv1 {
+		id 30
+		ip saddr 192.168.2.30
+		ip daddr 192.168.2.31
+		sport 30
+		dport 30
+		tos 10
+		ttl 10
+		erspan {
+			version 1
+			index 5
+		}
+	}
+
+	tunnel erspan-tv2 {
+		id 40
+		ip saddr 192.168.2.40
+		ip daddr 192.168.2.41
+		sport 40
+		dport 40
+		tos 10
+		ttl 10
+		erspan {
+			version 2
+			direction ingress
+			id 10
+		}
+	}
+
+	chain x {
+		type filter hook ingress priority filter; policy accept;
+		tunnel name ip saddr map { 10.141.10.123 : "geneve-t", 10.141.10.124 : "vxlan-t", 10.141.10.125 : "erspan-tv1", 10.141.10.126 : "erspan-tv2" } counter packets 0 bytes 0
+	}
+}
-- 
2.50.1


