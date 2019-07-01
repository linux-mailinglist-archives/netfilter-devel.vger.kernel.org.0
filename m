Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57652B34F
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfE0LhB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 07:37:01 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:34822 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfE0LhB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 07:37:01 -0400
Received: from localhost ([::1]:47908 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hVDw3-0005oZ-8y; Mon, 27 May 2019 13:36:59 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: [nft PATCH v4 1/2] py: Implement JSON validation in nftables module
Date:   Mon, 27 May 2019 13:36:41 +0200
Message-Id: <20190527113642.8434-2-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527113642.8434-1-phil@nwl.cc>
References: <20190527113642.8434-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Using jsonschema it is possible to validate any JSON input to make sure
it formally conforms with libnftables JSON API requirements.

Implement a simple validator class for use within a new Nftables class
method 'json_validate' and ship a minimal schema definition along with
the package.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v3:
- Drop "id" property in schema.json for now.

Changes since v2:
- Replace file() as that is not supported by python3, instead use open()
  and that fancy 'with' statement.
---
 py/Makefile.am |  2 +-
 py/nftables.py | 29 +++++++++++++++++++++++++++++
 py/schema.json | 16 ++++++++++++++++
 py/setup.py    |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 py/schema.json

diff --git a/py/Makefile.am b/py/Makefile.am
index 0963535d068dc..9fce7c9e54c38 100644
--- a/py/Makefile.am
+++ b/py/Makefile.am
@@ -1,4 +1,4 @@
-EXTRA_DIST = setup.py __init__.py nftables.py
+EXTRA_DIST = setup.py __init__.py nftables.py schema.json
 
 if HAVE_PYTHON
 
diff --git a/py/nftables.py b/py/nftables.py
index 33cd2dfd736d4..81e57567c8024 100644
--- a/py/nftables.py
+++ b/py/nftables.py
@@ -17,9 +17,23 @@
 import json
 from ctypes import *
 import sys
+import os
 
 NFTABLES_VERSION = "0.1"
 
+class SchemaValidator:
+    """Libnftables JSON validator using jsonschema"""
+
+    def __init__(self):
+        schema_path = os.path.join(os.path.dirname(__file__), "schema.json")
+        with open(schema_path, 'r') as schema_file:
+            self.schema = json.load(schema_file)
+        import jsonschema
+        self.jsonschema = jsonschema
+
+    def validate(self, json):
+        self.jsonschema.validate(instance=json, schema=self.schema)
+
 class Nftables:
     """A class representing libnftables interface"""
 
@@ -46,6 +60,8 @@ class Nftables:
         "numeric_symbol": (1 << 9),
     }
 
+    validator = None
+
     def __init__(self, sofile="libnftables.so"):
         """Instantiate a new Nftables class object.
 
@@ -382,3 +398,16 @@ class Nftables:
         if len(output):
             output = json.loads(output)
         return (rc, output, error)
+
+    def json_validate(self, json_root):
+        """Validate JSON object against libnftables schema.
+
+        Accepts a hash object as input.
+
+        Returns True if JSON is valid, raises an exception otherwise.
+        """
+        if not self.validator:
+            self.validator = SchemaValidator()
+
+        self.validator.validate(json_root)
+        return True
diff --git a/py/schema.json b/py/schema.json
new file mode 100644
index 0000000000000..460e21568f4ba
--- /dev/null
+++ b/py/schema.json
@@ -0,0 +1,16 @@
+{
+	"$schema": "http://json-schema.org/schema#",
+	"description": "libnftables JSON API schema",
+
+	"type": "object",
+        "properties": {
+		"nftables": {
+			"type": "array",
+			"minitems": 0,
+			"items": {
+				"type": "object"
+			}
+		}
+	},
+	"required": [ "nftables" ]
+}
diff --git a/py/setup.py b/py/setup.py
index ef143c42a21b0..72fc8fd98b269 100755
--- a/py/setup.py
+++ b/py/setup.py
@@ -11,6 +11,7 @@ setup(name='nftables',
       packages=['nftables'],
       provides=['nftables'],
       package_dir={'nftables':'.'},
+      package_data={'nftables':['schema.json']},
       classifiers=[
           'Development Status :: 4 - Beta',
           'Environment :: Console',
-- 
2.21.0

