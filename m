Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F55AD6AC
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Sep 2022 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIEPiV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Sep 2022 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiIEPiV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:38:21 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15C419A9
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Sep 2022 08:38:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oVEAz-0005Sn-Mw; Mon, 05 Sep 2022 17:38:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] selftests: nft_concat_range: add socat support
Date:   Mon,  5 Sep 2022 17:38:12 +0200
Message-Id: <20220905153812.15048-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There are different flavors of 'nc' around, this script fails on
my test vm because 'nc' is 'nmap-ncat' which isn't 100% compatible.

Add socat support and use it if available.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/netfilter/nft_concat_range.sh   | 65 +++++++++++++++----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/netfilter/nft_concat_range.sh b/tools/testing/selftests/netfilter/nft_concat_range.sh
index a6991877e50c..e908009576c7 100755
--- a/tools/testing/selftests/netfilter/nft_concat_range.sh
+++ b/tools/testing/selftests/netfilter/nft_concat_range.sh
@@ -91,7 +91,7 @@ src
 start		1
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	3
@@ -116,7 +116,7 @@ src
 start		10
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp6
 
 race_repeat	3
@@ -141,7 +141,7 @@ src
 start		1
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	0
@@ -163,7 +163,7 @@ src		mac
 start		10
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp6
 
 race_repeat	0
@@ -185,7 +185,7 @@ src		mac proto
 start		10
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp6
 
 race_repeat	0
@@ -207,7 +207,7 @@ src		addr4
 start		1
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	3
@@ -227,7 +227,7 @@ src		addr6 port
 start		10
 count		5
 src_delta	2000
-tools		sendip nc
+tools		sendip socat nc
 proto		udp6
 
 race_repeat	3
@@ -247,7 +247,7 @@ src		mac proto addr4
 start		1
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	0
@@ -264,7 +264,7 @@ src		mac
 start		1
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	0
@@ -286,7 +286,7 @@ src		mac addr4
 start		1
 count		5
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	0
@@ -337,7 +337,7 @@ src		addr4
 start		1
 count		5
 src_delta	2000
-tools		sendip nc
+tools		sendip socat nc
 proto		udp
 
 race_repeat	3
@@ -363,7 +363,7 @@ src		mac
 start		1
 count		1
 src_delta	2000
-tools		sendip nc bash
+tools		sendip socat nc bash
 proto		udp
 
 race_repeat	0
@@ -541,6 +541,24 @@ setup_send_udp() {
 			dst_port=
 			src_addr4=
 		}
+	elif command -v socat -v >/dev/null; then
+		send_udp() {
+			if [ -n "${src_addr4}" ]; then
+				B ip addr add "${src_addr4}" dev veth_b
+				__socatbind=",bind=${src_addr4}"
+				if [ -n "${src_port}" ];then
+					__socatbind="${__socatbind}:${src_port}"
+				fi
+			fi
+
+			ip addr add "${dst_addr4}" dev veth_a 2>/dev/null
+			[ -z "${dst_port}" ] && dst_port=12345
+
+			echo "test4" | B socat -t 0.01 STDIN UDP4-DATAGRAM:${dst_addr4}:${dst_port}"${__socatbind}"
+
+			src_addr4=
+			src_port=
+		}
 	elif command -v nc >/dev/null; then
 		if nc -u -w0 1.1.1.1 1 2>/dev/null; then
 			# OpenBSD netcat
@@ -606,6 +624,29 @@ setup_send_udp6() {
 			dst_port=
 			src_addr6=
 		}
+	elif command -v socat -v >/dev/null; then
+		send_udp6() {
+			ip -6 addr add "${dst_addr6}" dev veth_a nodad \
+				2>/dev/null
+
+			__socatbind6=
+
+			if [ -n "${src_addr6}" ]; then
+				if [ -n "${src_addr6} != "${src_addr6_added} ]; then
+					B ip addr add "${src_addr6}" dev veth_b nodad
+
+					src_addr6_added=${src_addr6}
+				fi
+
+				__socatbind6=",bind=[${src_addr6}]"
+
+				if [ -n "${src_port}" ] ;then
+					__socatbind6="${__socatbind6}:${src_port}"
+				fi
+			fi
+
+			echo "test6" | B socat -t 0.01 STDIN UDP6-DATAGRAM:[${dst_addr6}]:${dst_port}"${__socatbind6}"
+		}
 	elif command -v nc >/dev/null && nc -u -w0 1.1.1.1 1 2>/dev/null; then
 		# GNU netcat might not work with IPv6, try next tool
 		send_udp6() {
-- 
2.35.1

