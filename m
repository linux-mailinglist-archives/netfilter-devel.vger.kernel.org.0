Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0184574A7A4
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jul 2023 01:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGFX0e (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Jul 2023 19:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGFX0b (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:26:31 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C791BD3;
        Thu,  6 Jul 2023 16:26:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 97D465C007B;
        Thu,  6 Jul 2023 19:26:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jul 2023 19:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688685986; x=
        1688772386; bh=KYTx8/AVmAwctDU/Q4rV3rnsQa0jrAaUVq9C4p0inNo=; b=D
        iBHk893NEkIOu3wlM1n1X+qyvWxeAwxeHGAvlHQFLBqHggSE48ytufP/HZTQhP8d
        4Dyb1lKXC+WC+iNRC4sFPThm46If6qjNl0OHQeXk6zWDeiO711C9clbKkKZ3rRQ4
        RdFVvqcjdeFNf4wtDaBBWa98JUqCheaWAbk8GkbGsTcfQpzBOSXJeadtOYrTwPOL
        CXer175IcBM0zFsWZujlGi0PovLO4cG/Kmwwkrctc++G+rXE6zWTqNXQDNHemKTx
        EKKCc0d//jdF2sLWZrAkXaAJvY3WftJ4AkbQxgzBuukWzvnC8lVBLp5bQoaCA1BJ
        lDSEXtCRerzay9URnZ0pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688685986; x=
        1688772386; bh=KYTx8/AVmAwctDU/Q4rV3rnsQa0jrAaUVq9C4p0inNo=; b=j
        RhNOt1tY2/0GE3uFixkdkc/g0MISb/pZXcDEDzSl8piepW951PzVsTv9NKdeXvsl
        Aa2GoHOlAJhzlDLA5V2koDVu00gytNl6pUtxztpf0tw343A3qbSKZCZZXPbKRTDJ
        IRcN55CV1IMXQBK5ZodR6RL6Z2/Yn/tOtv6pZblZPdPtL0QhZbVP6CPvlBi6k/c9
        3HgvaAjKVJ4bX6gmUw1ImiTDnd728h5cDMoC5Yi20DjqrG0hkJ7siJlayv3R2sf8
        del8EWJAv2RxkUfQ4yD0+h0Y+xc+6xFBSkL0vy4RXfU2yRfgHV3WqjFD3Oa1VYgF
        lHgzcBI2jMHVmAlm7JYZw==
X-ME-Sender: <xms:ok2nZGWHaTMzzWRt0c2V3jWTTPVZWPXBq81yNeTd9-AKeC1AvkrpLg>
    <xme:ok2nZCmApWKIMseal43pJsdX3giC0pvlfj04Rxn3MkJIl-o5YSHtd2EJyDFGUNxPT
    o_Y6RhyWcq6uBNlDg>
X-ME-Received: <xmr:ok2nZKa_yFwHZP6jXiPgSHNFVvL-0lzIhOqI69vvSJAcSAoA3l9f9RqNJ3d1vKyaUSh33ZxzPo3Bb5F3CfHnUWzM9SdXvYj_9JO79d7LN6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ok2nZNUplMPzBoM4uSt9dqnnoWwwHcWSwROCHfr0QJk81hHGisVSnQ>
    <xmx:ok2nZAnySuY_N9DVWook74cNCqBxHQsee4LRFE38aRSE-ItOmYPu_A>
    <xmx:ok2nZCfAj9JF4MZ9ARvn3K7SRLxh0wgYzs9cSfmVVwyyPQDePM60wQ>
    <xmx:ok2nZHooADuCLZpZ_8qdsF7mPev2TazRP6dewbrhIMadWVDbuQVWRQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:25 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v2 6/6] bpf: selftests: Add defrag selftests
Date:   Thu,  6 Jul 2023 17:25:53 -0600
Message-ID: <deb1c4c5003892997dfb6f628e185b124e590472.1688685338.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688685338.git.dxu@dxuuu.xyz>
References: <cover.1688685338.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These selftests tests 2 major scenarios: the BPF based defragmentation
can successfully be done and that packet pointers are invalidated after
calls to the kfunc. The logic is similar for both ipv4 and ipv6.

In the first scenario, we create a UDP client and UDP echo server. The
the server side is fairly straightforward: we attach the prog and simply
echo back the message.

The on the client side, we send fragmented packets to and expect the
reassembled message back from the server.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 ++++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 ++++
 .../bpf/prog_tests/ip_check_defrag.c          | 282 ++++++++++++++++++
 .../selftests/bpf/progs/ip_check_defrag.c     | 104 +++++++
 5 files changed, 535 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 882be03b179f..619df497fce5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -565,8 +565,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
 			 cap_helpers.c test_loader.c xsk.c disasm.c	\
-			 json_writer.c unpriv_helpers.c
-
+			 json_writer.c unpriv_helpers.c 		\
+			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/generate_udp_fragments.py b/tools/testing/selftests/bpf/generate_udp_fragments.py
new file mode 100755
index 000000000000..2b8a1187991c
--- /dev/null
+++ b/tools/testing/selftests/bpf/generate_udp_fragments.py
@@ -0,0 +1,90 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+This script helps generate fragmented UDP packets.
+
+While it is technically possible to dynamically generate
+fragmented packets in C, it is much harder to read and write
+said code. `scapy` is relatively industry standard and really
+easy to read / write.
+
+So we choose to write this script that generates a valid C
+header. Rerun script and commit generated file after any
+modifications.
+"""
+
+import argparse
+import os
+
+from scapy.all import *
+
+
+# These constants must stay in sync with `ip_check_defrag.c`
+VETH1_ADDR = "172.16.1.200"
+VETH0_ADDR6 = "fc00::100"
+VETH1_ADDR6 = "fc00::200"
+CLIENT_PORT = 48878
+SERVER_PORT = 48879
+MAGIC_MESSAGE = "THIS IS THE ORIGINAL MESSAGE, PLEASE REASSEMBLE ME"
+
+
+def print_header(f):
+    f.write("// SPDX-License-Identifier: GPL-2.0\n")
+    f.write("/* DO NOT EDIT -- this file is generated */\n")
+    f.write("\n")
+    f.write("#ifndef _IP_CHECK_DEFRAG_FRAGS_H\n")
+    f.write("#define _IP_CHECK_DEFRAG_FRAGS_H\n")
+    f.write("\n")
+    f.write("#include <stdint.h>\n")
+    f.write("\n")
+
+
+def print_frags(f, frags, v6):
+    for idx, frag in enumerate(frags):
+        # 10 bytes per line to keep width in check
+        chunks = [frag[i : i + 10] for i in range(0, len(frag), 10)]
+        chunks_fmted = [", ".join([str(hex(b)) for b in chunk]) for chunk in chunks]
+        suffix = "6" if v6 else ""
+
+        f.write(f"static uint8_t frag{suffix}_{idx}[] = {{\n")
+        for chunk in chunks_fmted:
+            f.write(f"\t{chunk},\n")
+        f.write(f"}};\n")
+
+
+def print_trailer(f):
+    f.write("\n")
+    f.write("#endif /* _IP_CHECK_DEFRAG_FRAGS_H */\n")
+
+
+def main(f):
+    # srcip of 0 is filled in by IP_HDRINCL
+    sip = "0.0.0.0"
+    sip6 = VETH0_ADDR6
+    dip = VETH1_ADDR
+    dip6 = VETH1_ADDR6
+    sport = CLIENT_PORT
+    dport = SERVER_PORT
+    payload = MAGIC_MESSAGE.encode()
+
+    # Disable UDPv4 checksums to keep code simpler
+    pkt = IP(src=sip,dst=dip) / UDP(sport=sport,dport=dport,chksum=0) / Raw(load=payload)
+    # UDPv6 requires a checksum
+    # Also pin the ipv6 fragment header ID, otherwise it's a random value
+    pkt6 = IPv6(src=sip6,dst=dip6) / IPv6ExtHdrFragment(id=0xBEEF) / UDP(sport=sport,dport=dport) / Raw(load=payload)
+
+    frags = [f.build() for f in pkt.fragment(24)]
+    frags6 = [f.build() for f in fragment6(pkt6, 72)]
+
+    print_header(f)
+    print_frags(f, frags, False)
+    print_frags(f, frags6, True)
+    print_trailer(f)
+
+
+if __name__ == "__main__":
+    dir = os.path.dirname(os.path.realpath(__file__))
+    header = f"{dir}/ip_check_defrag_frags.h"
+    with open(header, "w") as f:
+        main(f)
diff --git a/tools/testing/selftests/bpf/ip_check_defrag_frags.h b/tools/testing/selftests/bpf/ip_check_defrag_frags.h
new file mode 100644
index 000000000000..70ab7e9fa22b
--- /dev/null
+++ b/tools/testing/selftests/bpf/ip_check_defrag_frags.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* DO NOT EDIT -- this file is generated */
+
+#ifndef _IP_CHECK_DEFRAG_FRAGS_H
+#define _IP_CHECK_DEFRAG_FRAGS_H
+
+#include <stdint.h>
+
+static uint8_t frag_0[] = {
+	0x45, 0x0, 0x0, 0x2c, 0x0, 0x1, 0x20, 0x0, 0x40, 0x11,
+	0xac, 0xe8, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+	0xbe, 0xee, 0xbe, 0xef, 0x0, 0x3a, 0x0, 0x0, 0x54, 0x48,
+	0x49, 0x53, 0x20, 0x49, 0x53, 0x20, 0x54, 0x48, 0x45, 0x20,
+	0x4f, 0x52, 0x49, 0x47,
+};
+static uint8_t frag_1[] = {
+	0x45, 0x0, 0x0, 0x2c, 0x0, 0x1, 0x20, 0x3, 0x40, 0x11,
+	0xac, 0xe5, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+	0x49, 0x4e, 0x41, 0x4c, 0x20, 0x4d, 0x45, 0x53, 0x53, 0x41,
+	0x47, 0x45, 0x2c, 0x20, 0x50, 0x4c, 0x45, 0x41, 0x53, 0x45,
+	0x20, 0x52, 0x45, 0x41,
+};
+static uint8_t frag_2[] = {
+	0x45, 0x0, 0x0, 0x1e, 0x0, 0x1, 0x0, 0x6, 0x40, 0x11,
+	0xcc, 0xf0, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+	0x53, 0x53, 0x45, 0x4d, 0x42, 0x4c, 0x45, 0x20, 0x4d, 0x45,
+};
+static uint8_t frag6_0[] = {
+	0x60, 0x0, 0x0, 0x0, 0x0, 0x20, 0x2c, 0x40, 0xfc, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x1, 0x0, 0xfc, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0,
+	0x11, 0x0, 0x0, 0x1, 0x0, 0x0, 0xbe, 0xef, 0xbe, 0xee,
+	0xbe, 0xef, 0x0, 0x3a, 0xd0, 0xf8, 0x54, 0x48, 0x49, 0x53,
+	0x20, 0x49, 0x53, 0x20, 0x54, 0x48, 0x45, 0x20, 0x4f, 0x52,
+	0x49, 0x47,
+};
+static uint8_t frag6_1[] = {
+	0x60, 0x0, 0x0, 0x0, 0x0, 0x20, 0x2c, 0x40, 0xfc, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x1, 0x0, 0xfc, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0,
+	0x11, 0x0, 0x0, 0x19, 0x0, 0x0, 0xbe, 0xef, 0x49, 0x4e,
+	0x41, 0x4c, 0x20, 0x4d, 0x45, 0x53, 0x53, 0x41, 0x47, 0x45,
+	0x2c, 0x20, 0x50, 0x4c, 0x45, 0x41, 0x53, 0x45, 0x20, 0x52,
+	0x45, 0x41,
+};
+static uint8_t frag6_2[] = {
+	0x60, 0x0, 0x0, 0x0, 0x0, 0x12, 0x2c, 0x40, 0xfc, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x1, 0x0, 0xfc, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0,
+	0x11, 0x0, 0x0, 0x30, 0x0, 0x0, 0xbe, 0xef, 0x53, 0x53,
+	0x45, 0x4d, 0x42, 0x4c, 0x45, 0x20, 0x4d, 0x45,
+};
+
+#endif /* _IP_CHECK_DEFRAG_FRAGS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
new file mode 100644
index 000000000000..5cd08d6e0ebc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <net/if.h>
+#include <linux/netfilter.h>
+#include <network_helpers.h>
+#include "ip_check_defrag.skel.h"
+#include "ip_check_defrag_frags.h"
+
+/*
+ * This selftest spins up a client and an echo server, each in their own
+ * network namespace. The client will send a fragmented message to the server.
+ * The prog attached to the server will shoot down any fragments. Thus, if
+ * the server is able to correctly echo back the message to the client, we will
+ * have verified that netfilter is reassembling packets for us.
+ *
+ * Topology:
+ * =========
+ *           NS0         |         NS1
+ *                       |
+ *         client        |       server
+ *       ----------      |     ----------
+ *       |  veth0  | --------- |  veth1  |
+ *       ----------    peer    ----------
+ *                       |
+ *                       |       with bpf
+ */
+
+#define NS0		"defrag_ns0"
+#define NS1		"defrag_ns1"
+#define VETH0		"veth0"
+#define VETH1		"veth1"
+#define VETH0_ADDR	"172.16.1.100"
+#define VETH0_ADDR6	"fc00::100"
+/* The following constants must stay in sync with `generate_udp_fragments.py` */
+#define VETH1_ADDR	"172.16.1.200"
+#define VETH1_ADDR6	"fc00::200"
+#define CLIENT_PORT	48878
+#define SERVER_PORT	48879
+#define MAGIC_MESSAGE	"THIS IS THE ORIGINAL MESSAGE, PLEASE REASSEMBLE ME"
+
+static int setup_topology(bool ipv6)
+{
+	bool up;
+	int i;
+
+	SYS(fail, "ip netns add " NS0);
+	SYS(fail, "ip netns add " NS1);
+	SYS(fail, "ip link add " VETH0 " netns " NS0 " type veth peer name " VETH1 " netns " NS1);
+	if (ipv6) {
+		SYS(fail, "ip -6 -net " NS0 " addr add " VETH0_ADDR6 "/64 dev " VETH0 " nodad");
+		SYS(fail, "ip -6 -net " NS1 " addr add " VETH1_ADDR6 "/64 dev " VETH1 " nodad");
+	} else {
+		SYS(fail, "ip -net " NS0 " addr add " VETH0_ADDR "/24 dev " VETH0);
+		SYS(fail, "ip -net " NS1 " addr add " VETH1_ADDR "/24 dev " VETH1);
+	}
+	SYS(fail, "ip -net " NS0 " link set dev " VETH0 " up");
+	SYS(fail, "ip -net " NS1 " link set dev " VETH1 " up");
+
+	/* Wait for up to 5s for links to come up */
+	for (i = 0; i < 5; ++i) {
+		if (ipv6)
+			up = !system("ip netns exec " NS0 " ping -6 -c 1 -W 1 " VETH1_ADDR6 " &>/dev/null");
+		else
+			up = !system("ip netns exec " NS0 " ping -c 1 -W 1 " VETH1_ADDR " &>/dev/null");
+
+		if (up)
+			break;
+	}
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void cleanup_topology(void)
+{
+	SYS_NOFAIL("test -f /var/run/netns/" NS0 " && ip netns delete " NS0);
+	SYS_NOFAIL("test -f /var/run/netns/" NS1 " && ip netns delete " NS1);
+}
+
+static int attach(struct ip_check_defrag *skel, bool ipv6)
+{
+	LIBBPF_OPTS(bpf_netfilter_opts, opts,
+		    .pf = ipv6 ? NFPROTO_IPV6 : NFPROTO_IPV4,
+		    .priority = 42,
+		    .flags = BPF_F_NETFILTER_IP_DEFRAG);
+	struct nstoken *nstoken;
+	int err = -1;
+
+	nstoken = open_netns(NS1);
+
+	skel->links.defrag = bpf_program__attach_netfilter(skel->progs.defrag, &opts);
+	if (!ASSERT_OK_PTR(skel->links.defrag, "program attach"))
+		goto out;
+
+	err = 0;
+out:
+	close_netns(nstoken);
+	return err;
+}
+
+static int send_frags(int client)
+{
+	struct sockaddr_storage saddr;
+	struct sockaddr *saddr_p;
+	socklen_t saddr_len;
+	int err;
+
+	saddr_p = (struct sockaddr *)&saddr;
+	err = make_sockaddr(AF_INET, VETH1_ADDR, SERVER_PORT, &saddr, &saddr_len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		return -1;
+
+	err = sendto(client, frag_0, sizeof(frag_0), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag_0"))
+		return -1;
+
+	err = sendto(client, frag_1, sizeof(frag_1), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag_1"))
+		return -1;
+
+	err = sendto(client, frag_2, sizeof(frag_2), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag_2"))
+		return -1;
+
+	return 0;
+}
+
+static int send_frags6(int client)
+{
+	struct sockaddr_storage saddr;
+	struct sockaddr *saddr_p;
+	socklen_t saddr_len;
+	int err;
+
+	saddr_p = (struct sockaddr *)&saddr;
+	/* Port needs to be set to 0 for raw ipv6 socket for some reason */
+	err = make_sockaddr(AF_INET6, VETH1_ADDR6, 0, &saddr, &saddr_len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		return -1;
+
+	err = sendto(client, frag6_0, sizeof(frag6_0), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag6_0"))
+		return -1;
+
+	err = sendto(client, frag6_1, sizeof(frag6_1), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag6_1"))
+		return -1;
+
+	err = sendto(client, frag6_2, sizeof(frag6_2), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag6_2"))
+		return -1;
+
+	return 0;
+}
+
+void test_bpf_ip_check_defrag_ok(bool ipv6)
+{
+	struct network_helper_opts rx_opts = {
+		.timeout_ms = 1000,
+		.noconnect = true,
+	};
+	struct network_helper_opts tx_ops = {
+		.timeout_ms = 1000,
+		.type = SOCK_RAW,
+		.proto = IPPROTO_RAW,
+		.noconnect = true,
+	};
+	struct sockaddr_storage caddr;
+	struct ip_check_defrag *skel;
+	struct nstoken *nstoken;
+	int client_tx_fd = -1;
+	int client_rx_fd = -1;
+	socklen_t caddr_len;
+	int srv_fd = -1;
+	char buf[1024];
+	int len, err;
+
+	skel = ip_check_defrag__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!ASSERT_OK(setup_topology(ipv6), "setup_topology"))
+		goto out;
+
+	if (!ASSERT_OK(attach(skel, ipv6), "attach"))
+		goto out;
+
+	/* Start server in ns1 */
+	nstoken = open_netns(NS1);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns1"))
+		goto out;
+	srv_fd = start_server(ipv6 ? AF_INET6 : AF_INET, SOCK_DGRAM, NULL, SERVER_PORT, 0);
+	close_netns(nstoken);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		goto out;
+
+	/* Open tx raw socket in ns0 */
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
+		goto out;
+	client_tx_fd = connect_to_fd_opts(srv_fd, &tx_ops);
+	close_netns(nstoken);
+	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
+		goto out;
+
+	/* Open rx socket in ns0 */
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
+		goto out;
+	client_rx_fd = connect_to_fd_opts(srv_fd, &rx_opts);
+	close_netns(nstoken);
+	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
+		goto out;
+
+	/* Bind rx socket to a premeditated port */
+	memset(&caddr, 0, sizeof(caddr));
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
+		goto out;
+	if (ipv6) {
+		struct sockaddr_in6 *c = (struct sockaddr_in6 *)&caddr;
+
+		c->sin6_family = AF_INET6;
+		inet_pton(AF_INET6, VETH0_ADDR6, &c->sin6_addr);
+		c->sin6_port = htons(CLIENT_PORT);
+		err = bind(client_rx_fd, (struct sockaddr *)c, sizeof(*c));
+	} else {
+		struct sockaddr_in *c = (struct sockaddr_in *)&caddr;
+
+		c->sin_family = AF_INET;
+		inet_pton(AF_INET, VETH0_ADDR, &c->sin_addr);
+		c->sin_port = htons(CLIENT_PORT);
+		err = bind(client_rx_fd, (struct sockaddr *)c, sizeof(*c));
+	}
+	close_netns(nstoken);
+	if (!ASSERT_OK(err, "bind"))
+		goto out;
+
+	/* Send message in fragments */
+	if (ipv6) {
+		if (!ASSERT_OK(send_frags6(client_tx_fd), "send_frags6"))
+			goto out;
+	} else {
+		if (!ASSERT_OK(send_frags(client_tx_fd), "send_frags"))
+			goto out;
+	}
+
+	if (!ASSERT_EQ(skel->bss->shootdowns, 0, "shootdowns"))
+		goto out;
+
+	/* Receive reassembled msg on server and echo back to client */
+	len = recvfrom(srv_fd, buf, sizeof(buf), 0, (struct sockaddr *)&caddr, &caddr_len);
+	if (!ASSERT_GE(len, 0, "server recvfrom"))
+		goto out;
+	len = sendto(srv_fd, buf, len, 0, (struct sockaddr *)&caddr, caddr_len);
+	if (!ASSERT_GE(len, 0, "server sendto"))
+		goto out;
+
+	/* Expect reassembed message to be echoed back */
+	len = recvfrom(client_rx_fd, buf, sizeof(buf), 0, NULL, NULL);
+	if (!ASSERT_EQ(len, sizeof(MAGIC_MESSAGE) - 1, "client short read"))
+		goto out;
+
+out:
+	if (client_rx_fd != -1)
+		close(client_rx_fd);
+	if (client_tx_fd != -1)
+		close(client_tx_fd);
+	if (srv_fd != -1)
+		close(srv_fd);
+	cleanup_topology();
+	ip_check_defrag__destroy(skel);
+}
+
+void test_bpf_ip_check_defrag(void)
+{
+	if (test__start_subtest("v4"))
+		test_bpf_ip_check_defrag_ok(false);
+	if (test__start_subtest("v6"))
+		test_bpf_ip_check_defrag_ok(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/ip_check_defrag.c b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
new file mode 100644
index 000000000000..4259c6d59968
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+
+#define NF_DROP			0
+#define NF_ACCEPT		1
+#define ETH_P_IP		0x0800
+#define ETH_P_IPV6		0x86DD
+#define IP_MF			0x2000
+#define IP_OFFSET		0x1FFF
+#define NEXTHDR_FRAGMENT	44
+
+extern int bpf_dynptr_from_skb(struct sk_buff *skb, __u64 flags,
+                               struct bpf_dynptr *ptr__uninit) __ksym;
+extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
+			      void *buffer, uint32_t buffer__sz) __ksym;
+
+volatile int shootdowns = 0;
+
+static bool is_frag_v4(struct iphdr *iph)
+{
+	int offset;
+	int flags;
+
+	offset = bpf_ntohs(iph->frag_off);
+	flags = offset & ~IP_OFFSET;
+	offset &= IP_OFFSET;
+	offset <<= 3;
+
+	return (flags & IP_MF) || offset;
+}
+
+static bool is_frag_v6(struct ipv6hdr *ip6h)
+{
+	/* Simplifying assumption that there are no extension headers
+	 * between fixed header and fragmentation header. This assumption
+	 * is only valid in this test case. It saves us the hassle of
+	 * searching all potential extension headers.
+	 */
+	return ip6h->nexthdr == NEXTHDR_FRAGMENT;
+}
+
+static int handle_v4(struct sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	u8 iph_buf[20] = {};
+	struct iphdr *iph;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return NF_DROP;
+
+	iph = bpf_dynptr_slice(&ptr, 0, iph_buf, sizeof(iph_buf));
+	if (!iph)
+		return NF_DROP;
+
+	/* Shootdown any frags */
+	if (is_frag_v4(iph)) {
+		shootdowns++;
+		return NF_DROP;
+	}
+
+	return NF_ACCEPT;
+}
+
+static int handle_v6(struct sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	struct ipv6hdr *ip6h;
+	u8 ip6h_buf[40] = {};
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return NF_DROP;
+
+	ip6h = bpf_dynptr_slice(&ptr, 0, ip6h_buf, sizeof(ip6h_buf));
+	if (!ip6h)
+		return NF_DROP;
+
+	/* Shootdown any frags */
+	if (is_frag_v6(ip6h)) {
+		shootdowns++;
+		return NF_DROP;
+	}
+
+	return NF_ACCEPT;
+}
+
+SEC("netfilter")
+int defrag(struct bpf_nf_ctx *ctx)
+{
+	struct sk_buff *skb = ctx->skb;
+
+	switch (bpf_ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		return handle_v4(skb);
+	case ETH_P_IPV6:
+		return handle_v6(skb);
+	default:
+		return NF_ACCEPT;
+	}
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0

