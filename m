Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702487B6F6F
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Oct 2023 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjJCRSE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Oct 2023 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRSD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:18:03 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC4995;
        Tue,  3 Oct 2023 10:18:00 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65af75a0209so6703596d6.3;
        Tue, 03 Oct 2023 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696353479; x=1696958279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJkfxt4q2AP/w4lULOTHHgnPDTiStPcqvjVtJCMMeZY=;
        b=XHhyRVk0qWVOEYBXh4Ld1WL6ORVPDoZEREMR1HgCNi9FwBpc11JZyNiT2MPuiXjM6H
         Ic7GKNmV+U57sM/TonPrrsmVTsR9bNXOxRP0kbfZHRiEStL4oIMdG0rrI2dz0U+YLxWj
         wy2MGjLSWuW13e+S8xCoHyrlgDiBK8LK6wQQYoa7JczpiYs5Eyp+LNssHTqQzqiQNBMk
         pjsKXChEEEleIutJrck1KyfdxShyvqdmnPIfQ+wfHq2LTbKznjTJIQ6TNEaHAXQO8RnL
         4Fo9jV3yCfTARCb/DkEB0hTQDrl3gWEC9y/blE4dZ4IwHa6QeQs6YdVwoFKfdHDqcBBR
         vkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353479; x=1696958279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJkfxt4q2AP/w4lULOTHHgnPDTiStPcqvjVtJCMMeZY=;
        b=qqPdvn26I8mqz7UjDXB0iVCCJncaV8KHAugaEI02jFqZ9HBeb4Q7RWQrFBjJ/jaSj7
         SGETYowXbfljYNWcFeL8v0cDnO1u2IQP568oqTXu2oOfhLBlG5HuW9GGXdzIr6/fWRYu
         9tjJbdiW6wseqc4MZ33ZNDP5eBO000K3eWEC7e/O12nlq608ahKKKubdKFSsBAfLHtGw
         DGo+tyog4wffSFCs+wOm87OFsMdBkEc/BdZ4Yb77cRUMly5uz10MUotaVUxPcTWEAtky
         h+C7zhcjlpOEz/Jm85N7Vmtf6NClElzz4qK2OvqfAMlKNK7LlH3LlPKkcJHnnamx353s
         IDQQ==
X-Gm-Message-State: AOJu0YxTVTg/jnD1BLpvAR3+DI5uUQRrS+om2TVWP7CtiHu7T7OUs0yC
        fSKT++/BlEEVsVTLpA56N58BZlko4+/l2Q==
X-Google-Smtp-Source: AGHT+IGPdQN5BCM7UTAyjcBOoBx2OgeKUtQDj8EiWYX6VLinJ2b8jCn/GFuaJSaPdgHe3k57Q8Hhnw==
X-Received: by 2002:a05:6214:398a:b0:659:abd1:8d37 with SMTP id ny10-20020a056214398a00b00659abd18d37mr10218qvb.4.1696353479028;
        Tue, 03 Oct 2023 10:17:59 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h1-20020a0cf401000000b0065d0dcc28e3sm633041qvl.73.2023.10.03.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:17:58 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCHv2 nf 2/2] selftests: netfilter: test for sctp collision processing in nf_conntrack
Date:   Tue,  3 Oct 2023 13:17:54 -0400
Message-Id: <89aafa3f9d05967c6a2f4f86b94c6ab80ab948c8.1696353375.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1696353375.git.lucien.xin@gmail.com>
References: <cover.1696353375.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds a test case to reproduce the SCTP DATA chunk retransmission
timeout issue caused by the improper SCTP collision processing in netfilter
nf_conntrack_proto_sctp.

In this test, client sends a INIT chunk, but the INIT_ACK replied from
server is delayed until the server sends a INIT chunk to start a new
connection from its side. After the connection is complete from server
side, the delayed INIT_ACK arrives in nf_conntrack_proto_sctp.

The delayed INIT_ACK should be dropped in nf_conntrack_proto_sctp instead
of updating the vtag with the out-of-date init_tag, otherwise, the vtag
in DATA chunks later sent by client don't match the vtag in the conntrack
entry and the DATA chunks get dropped.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 tools/testing/selftests/netfilter/Makefile    |  5 +-
 .../netfilter/conntrack_sctp_collision.sh     | 89 +++++++++++++++++
 .../selftests/netfilter/sctp_collision.c      | 99 +++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
 create mode 100644 tools/testing/selftests/netfilter/sctp_collision.c

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 321db8850da0..ef90aca4cc96 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -6,13 +6,14 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	nft_concat_range.sh nft_conntrack_helper.sh \
 	nft_queue.sh nft_meta.sh nf_nat_edemux.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
-	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh
+	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh \
+	conntrack_sctp_collision.sh
 
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
 LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
-TEST_GEN_FILES =  nf-queue connect_close audit_logread
+TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision
 
 include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh b/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
new file mode 100755
index 000000000000..a924e595cfd8
--- /dev/null
+++ b/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
@@ -0,0 +1,89 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing For SCTP COLLISION SCENARIO as Below:
+#
+#   14:35:47.655279 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT] [init tag: 2017837359]
+#   14:35:48.353250 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT] [init tag: 1187206187]
+#   14:35:48.353275 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT ACK] [init tag: 2017837359]
+#   14:35:48.353283 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [COOKIE ECHO]
+#   14:35:48.353977 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [COOKIE ACK]
+#   14:35:48.855335 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT ACK] [init tag: 164579970]
+#
+# TOPO: SERVER_NS (link0)<--->(link1) ROUTER_NS (link2)<--->(link3) CLIENT_NS
+
+CLIENT_NS=$(mktemp -u client-XXXXXXXX)
+CLIENT_IP="198.51.200.1"
+CLIENT_PORT=1234
+
+SERVER_NS=$(mktemp -u server-XXXXXXXX)
+SERVER_IP="198.51.100.1"
+SERVER_PORT=1234
+
+ROUTER_NS=$(mktemp -u router-XXXXXXXX)
+CLIENT_GW="198.51.200.2"
+SERVER_GW="198.51.100.2"
+
+# setup the topo
+setup() {
+	ip net add $CLIENT_NS
+	ip net add $SERVER_NS
+	ip net add $ROUTER_NS
+	ip -n $SERVER_NS link add link0 type veth peer name link1 netns $ROUTER_NS
+	ip -n $CLIENT_NS link add link3 type veth peer name link2 netns $ROUTER_NS
+
+	ip -n $SERVER_NS link set link0 up
+	ip -n $SERVER_NS addr add $SERVER_IP/24 dev link0
+	ip -n $SERVER_NS route add $CLIENT_IP dev link0 via $SERVER_GW
+
+	ip -n $ROUTER_NS link set link1 up
+	ip -n $ROUTER_NS link set link2 up
+	ip -n $ROUTER_NS addr add $SERVER_GW/24 dev link1
+	ip -n $ROUTER_NS addr add $CLIENT_GW/24 dev link2
+	ip net exec $ROUTER_NS sysctl -wq net.ipv4.ip_forward=1
+
+	ip -n $CLIENT_NS link set link3 up
+	ip -n $CLIENT_NS addr add $CLIENT_IP/24 dev link3
+	ip -n $CLIENT_NS route add $SERVER_IP dev link3 via $CLIENT_GW
+
+	# simulate the delay on OVS upcall by setting up a delay for INIT_ACK with
+	# tc on $SERVER_NS side
+	tc -n $SERVER_NS qdisc add dev link0 root handle 1: htb
+	tc -n $SERVER_NS class add dev link0 parent 1: classid 1:1 htb rate 100mbit
+	tc -n $SERVER_NS filter add dev link0 parent 1: protocol ip u32 match ip protocol 132 \
+		0xff match u8 2 0xff at 32 flowid 1:1
+	tc -n $SERVER_NS qdisc add dev link0 parent 1:1 handle 10: netem delay 1200ms
+
+	# simulate the ctstate check on OVS nf_conntrack
+	ip net exec $ROUTER_NS iptables -A FORWARD -m state --state INVALID,UNTRACKED -j DROP
+	ip net exec $ROUTER_NS iptables -A INPUT -p sctp -j DROP
+
+	# use a smaller number for assoc's max_retrans to reproduce the issue
+	modprobe sctp
+	ip net exec $CLIENT_NS sysctl -wq net.sctp.association_max_retrans=3
+}
+
+cleanup() {
+	ip net exec $CLIENT_NS pkill sctp_collision 2>&1 >/dev/null
+	ip net exec $SERVER_NS pkill sctp_collision 2>&1 >/dev/null
+	ip net del "$CLIENT_NS"
+	ip net del "$SERVER_NS"
+	ip net del "$ROUTER_NS"
+}
+
+do_test() {
+	ip net exec $SERVER_NS ./sctp_collision server \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT &
+	ip net exec $CLIENT_NS ./sctp_collision client \
+		$CLIENT_IP $CLIENT_PORT $SERVER_IP $SERVER_PORT
+}
+
+# NOTE: one way to work around the issue is set a smaller hb_interval
+# ip net exec $CLIENT_NS sysctl -wq net.sctp.hb_interval=3500
+
+# run the test case
+trap cleanup EXIT
+setup && \
+echo "Test for SCTP Collision in nf_conntrack:" && \
+do_test && echo "PASS!"
+exit $?
diff --git a/tools/testing/selftests/netfilter/sctp_collision.c b/tools/testing/selftests/netfilter/sctp_collision.c
new file mode 100644
index 000000000000..21bb1cfd8a85
--- /dev/null
+++ b/tools/testing/selftests/netfilter/sctp_collision.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in saddr = {}, daddr = {};
+	int sd, ret, len = sizeof(daddr);
+	struct timeval tv = {25, 0};
+	char buf[] = "hello";
+
+	if (argc != 6 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		printf("%s <server|client> <LOCAL_IP> <LOCAL_PORT> <REMOTE_IP> <REMOTE_PORT>\n",
+		       argv[0]);
+		return -1;
+	}
+
+	sd = socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP);
+	if (sd < 0) {
+		printf("Failed to create sd\n");
+		return -1;
+	}
+
+	saddr.sin_family = AF_INET;
+	saddr.sin_addr.s_addr = inet_addr(argv[2]);
+	saddr.sin_port = htons(atoi(argv[3]));
+
+	ret = bind(sd, (struct sockaddr *)&saddr, sizeof(saddr));
+	if (ret < 0) {
+		printf("Failed to bind to address\n");
+		goto out;
+	}
+
+	ret = listen(sd, 5);
+	if (ret < 0) {
+		printf("Failed to listen on port\n");
+		goto out;
+	}
+
+	daddr.sin_family = AF_INET;
+	daddr.sin_addr.s_addr = inet_addr(argv[4]);
+	daddr.sin_port = htons(atoi(argv[5]));
+
+	/* make test shorter than 25s */
+	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (ret < 0) {
+		printf("Failed to setsockopt SO_RCVTIMEO\n");
+		goto out;
+	}
+
+	if (!strcmp(argv[1], "server")) {
+		sleep(1); /* wait a bit for client's INIT */
+		ret = connect(sd, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to connect to peer\n");
+			goto out;
+		}
+		ret = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&daddr, &len);
+		if (ret < 0) {
+			printf("Failed to recv msg %d\n", ret);
+			goto out;
+		}
+		ret = sendto(sd, buf, strlen(buf) + 1, 0, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to send msg %d\n", ret);
+			goto out;
+		}
+		printf("Server: sent! %d\n", ret);
+	}
+
+	if (!strcmp(argv[1], "client")) {
+		usleep(300000); /* wait a bit for server's listening */
+		ret = connect(sd, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to connect to peer\n");
+			goto out;
+		}
+		sleep(1); /* wait a bit for server's delayed INIT_ACK to reproduce the issue */
+		ret = sendto(sd, buf, strlen(buf) + 1, 0, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to send msg %d\n", ret);
+			goto out;
+		}
+		ret = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&daddr, &len);
+		if (ret < 0) {
+			printf("Failed to recv msg %d\n", ret);
+			goto out;
+		}
+		printf("Client: rcvd! %d\n", ret);
+	}
+	ret = 0;
+out:
+	close(sd);
+	return ret;
+}
-- 
2.39.1

