Return-Path: <netfilter-devel+bounces-3625-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB03968F32
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2024 23:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D11B2210B
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2024 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C820124A;
	Mon,  2 Sep 2024 21:41:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38471A4E8D;
	Mon,  2 Sep 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725313297; cv=none; b=Ae+ZnXJJzElIW3+Uujl2fHU428FQvxlkG1FCH/lkPoU2/niQjbIuBA6vxz9YsU6iEycIz88w6UP6Hn/qj6fMB/H2XvsgybNk4SC2fU2P0brt6oSZsrzuJFndFJS+1y45ixI0++3LfiYeaXGVWFgkhAITH+AdfMKKBYvzrKVrxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725313297; c=relaxed/simple;
	bh=yaAvMEPuhjkou8PiY5EZZxXR7NdbyPxmpqWzZlDZJ8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxKPYpbR+GvuO22E/b2WkRTbQE/APduPZQnPyTDXStKr1kpfi7rg2p1mHS7jtaiNBoYUDZFvkRpZVRBGVBkPmBvgA3oUz3BRs1yq8pvWEQaGmTK7SyPUOYONl7AeKyTF5uK90FKZwqPs7FiKWoZopHHVuvTSiqkfkkrsS8qOOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1slEng-0004nv-CI; Mon, 02 Sep 2024 23:41:28 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v2 net-next] netlink: specs: nftables: allow decode of default firewalld ruleset
Date: Mon,  2 Sep 2024 23:41:06 +0200
Message-ID: <20240902214112.2549-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This update allows listing default firewalld ruleset on Fedora 40 via
  tools/net/ynl/cli.py --spec \
     Documentation/netlink/specs/nftables.yaml --dump getrule

Default ruleset uses fib, reject and objref expressions which were
missing.

Other missing expressions can be added later.

Improve decoding while at it:
- add bitwise, ct and lookup attributes
- wire up the quota expression
- translate raw verdict codes to a human reable name, e.g.
  'code': 4294967293 becomes 'code': 'jump'.

v2: forgot fib addrtype in enum list (Donald Hunter)

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Documentation/netlink/specs/nftables.yaml | 254 +++++++++++++++++++++-
 1 file changed, 250 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index dff2a18f3d90..4acf30cf8385 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -62,6 +62,13 @@ definitions:
       - sdif
       - sdifname
       - bri-broute
+  -
+    name: bitwise-ops
+    type: enum
+    entries:
+      - bool
+      - lshift
+      - rshift
   -
     name: cmp-ops
     type: enum
@@ -125,6 +132,99 @@ definitions:
       - object
       - concat
       - expr
+  -
+    name: lookup-flags
+    type: flags
+    entries:
+      - invert
+  -
+    name: ct-keys
+    type: enum
+    entries:
+      - state
+      - direction
+      - status
+      - mark
+      - secmark
+      - expiration
+      - helper
+      - l3protocol
+      - src
+      - dst
+      - protocol
+      - proto-src
+      - proto-dst
+      - labels
+      - pkts
+      - bytes
+      - avgpkt
+      - zone
+      - eventmask
+      - src-ip
+      - dst-ip
+      - src-ip6
+      - dst-ip6
+      - ct-id
+  -
+    name: ct-direction
+    type: enum
+    entries:
+      - original
+      - reply
+  -
+    name: quota-flags
+    type: flags
+    entries:
+      - invert
+      - depleted
+  -
+    name: verdict-code
+    type: enum
+    entries:
+      - name: continue
+        value: 0xffffffff
+      - name: break
+        value: 0xfffffffe
+      - name: jump
+        value: 0xfffffffd
+      - name: goto
+        value: 0xfffffffc
+      - name: return
+        value: 0xfffffffb
+      - name: drop
+        value: 0
+      - name: accept
+        value: 1
+      - name: stolen
+        value: 2
+      - name: queue
+        value: 3
+      - name: repeat
+        value: 4
+  -
+    name: fib-result
+    type: enum
+    entries:
+      - oif
+      - oifname
+      - addrtype
+  -
+    name: fib-flags
+    type: flags
+    entries:
+      - saddr
+      - daddr
+      - mark
+      - iif
+      - oif
+      - present
+  -
+    name: reject-types
+    type: enum
+    entries:
+      - icmp-unreach
+      - tcp-rst
+      - icmpx-unreach
 
 attribute-sets:
   -
@@ -611,9 +711,10 @@ attribute-sets:
         type: u64
         byte-order: big-endian
       -
-        name: flags # TODO
+        name: flags
         type: u32
         byte-order: big-endian
+        enum: quota-flags
       -
         name: pad
         type: pad
@@ -664,6 +765,38 @@ attribute-sets:
         name: devs
         type: nest
         nested-attributes: hook-dev-attrs
+  -
+    name: expr-bitwise-attrs
+    attributes:
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: len
+        type: u32
+        byte-order: big-endian
+      -
+        name: mask
+        type: nest
+        nested-attributes: data-attrs
+      -
+        name: xor
+        type: nest
+        nested-attributes: data-attrs
+      -
+        name: op
+        type: u32
+        byte-order: big-endian
+        enum: bitwise-ops
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
   -
     name: expr-cmp-attrs
     attributes:
@@ -698,6 +831,7 @@ attribute-sets:
         name: code
         type: u32
         byte-order: big-endian
+        enum: verdict-code
       -
         name: chain
         type: string
@@ -718,6 +852,43 @@ attribute-sets:
       -
         name: pad
         type: pad
+  -
+    name: expr-fib-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: result
+        type: u32
+        byte-order: big-endian
+        enum: fib-result
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: fib-flags
+  -
+    name: expr-ct-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: key
+        type: u32
+        byte-order: big-endian
+        enum: ct-keys
+      -
+        name: direction
+        type: u8
+        enum: ct-direction
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
   -
     name: expr-flow-offload-attrs
     attributes:
@@ -736,6 +907,31 @@ attribute-sets:
         name: data
         type: nest
         nested-attributes: data-attrs
+  -
+    name: expr-lookup-attrs
+    attributes:
+      -
+        name: set
+        type: string
+        doc: Name of set to use
+      -
+        name: set id
+        type: u32
+        byte-order: big-endian
+        doc: ID of set to use
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: lookup-flags
   -
     name: expr-meta-attrs
     attributes:
@@ -820,6 +1016,17 @@ attribute-sets:
         name: csum-flags
         type: u32
         byte-order: big-endian
+  -
+    name: expr-reject-attrs
+    attributes:
+      -
+        name: type
+        type: u32
+        byte-order: big-endian
+        enum: reject-types
+      -
+        name: icmp-code
+        type: u8
   -
     name: expr-tproxy-attrs
     attributes:
@@ -835,13 +1042,38 @@ attribute-sets:
         name: reg-port
         type: u32
         byte-order: big-endian
+  -
+    name: expr-objref-attrs
+    attributes:
+      -
+        name: imm-type
+        type: u32
+        byte-order: big-endian
+      -
+        name: imm-name
+        type: string
+        doc: object name
+      -
+        name: set-sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: set-name
+        type: string
+        doc: name of object map
+      -
+        name: set-id
+        type: u32
+        byte-order: big-endian
+        doc: id of object map
 
 sub-messages:
   -
     name: expr-ops
     formats:
       -
-        value: bitwise # TODO
+        value: bitwise
+        attribute-set: expr-bitwise-attrs
       -
         value: cmp
         attribute-set: expr-cmp-attrs
@@ -849,7 +1081,11 @@ sub-messages:
         value: counter
         attribute-set: expr-counter-attrs
       -
-        value: ct # TODO
+        value: ct
+        attribute-set: expr-ct-attrs
+      -
+        value: fib
+        attribute-set: expr-fib-attrs
       -
         value: flow_offload
         attribute-set: expr-flow-offload-attrs
@@ -857,16 +1093,26 @@ sub-messages:
         value: immediate
         attribute-set: expr-immediate-attrs
       -
-        value: lookup # TODO
+        value: lookup
+        attribute-set: expr-lookup-attrs
       -
         value: meta
         attribute-set: expr-meta-attrs
       -
         value: nat
         attribute-set: expr-nat-attrs
+      -
+        value: objref
+        attribute-set: expr-objref-attrs
       -
         value: payload
         attribute-set: expr-payload-attrs
+      -
+        value: quota
+        attribute-set: quota-attrs
+      -
+        value: reject
+        attribute-set: expr-reject-attrs
       -
         value: tproxy
         attribute-set: expr-tproxy-attrs
-- 
2.44.2


