Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB07E010F
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 11:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjKCK0a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjKCK03 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:26:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C6013E
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 03:26:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qyrNd-00056D-UM; Fri, 03 Nov 2023 11:26:21 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH iptables 4/4] arptables-txlate: add test cases
Date:   Fri,  3 Nov 2023 11:23:26 +0100
Message-ID: <20231103102330.27578-5-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103102330.27578-1-fw@strlen.de>
References: <20231103102330.27578-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add test cases for libarpt_mangle and extend the generic
tests to cover basic arptables matches.

Note that there are several historic artefacts that could be revised.
For example, arptables-legacy and arptables-nft both ignore "-p"
instead of returning an error about an unsupported option.

The ptype could be hard-wired to 0x800 and set unconditionally.
OTOH, this should always match for ethernet arp packets anyway.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 extensions/generic.txlate        | 6 ++++++
 extensions/libarpt_mangle.txlate | 6 ++++++
 xlate-test.py                    | 4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 extensions/libarpt_mangle.txlate

diff --git a/extensions/generic.txlate b/extensions/generic.txlate
index c24ed1568884..b79239f1a063 100644
--- a/extensions/generic.txlate
+++ b/extensions/generic.txlate
@@ -1,3 +1,9 @@
+arptables-translate -A OUTPUT --proto-type ipv4 -s 1.2.3.4 -j ACCEPT
+nft 'add rule arp filter OUTPUT arp htype 1 arp hlen 6 arp plen 4 arp ptype 0x800 arp saddr ip 1.2.3.4 counter accept'
+
+arptables-translate -I OUTPUT -o oifname
+nft 'insert rule arp filter OUTPUT oifname "oifname" arp htype 1 arp hlen 6 arp plen 4 counter'
+
 iptables-translate -I OUTPUT -p udp -d 8.8.8.8 -j ACCEPT
 nft 'insert rule ip filter OUTPUT ip protocol udp ip daddr 8.8.8.8 counter accept'
 
diff --git a/extensions/libarpt_mangle.txlate b/extensions/libarpt_mangle.txlate
new file mode 100644
index 000000000000..e884d3289a76
--- /dev/null
+++ b/extensions/libarpt_mangle.txlate
@@ -0,0 +1,6 @@
+arptables-translate -A OUTPUT -d 10.21.22.129 -j mangle --mangle-ip-s 10.21.22.161
+nft 'add rule arp filter OUTPUT arp htype 1 arp hlen 6 arp plen 4 arp daddr ip 10.21.22.129 counter arp saddr ip set 10.21.22.161 accept'
+arptables-translate -A OUTPUT -d 10.2.22.129/24 -j mangle --mangle-ip-d 10.2.22.1 --mangle-target CONTINUE
+nft 'add rule arp filter OUTPUT arp htype 1 arp hlen 6 arp plen 4 arp daddr ip 10.2.22.0/24 counter arp daddr ip set 10.2.22.1'
+arptables-translate -A OUTPUT -d 10.2.22.129/24 -j mangle --mangle-ip-d 10.2.22.1 --mangle-mac-d a:b:c:d:e:f
+nft 'add rule arp filter OUTPUT arp htype 1 arp hlen 6 arp plen 4 arp daddr ip 10.2.22.0/24 counter arp daddr ip set 10.2.22.1 arp daddr ether set 0a:0b:0c:0d:0e:0f accept'
diff --git a/xlate-test.py b/xlate-test.py
index 6a1165986847..ddd68b91d3a7 100755
--- a/xlate-test.py
+++ b/xlate-test.py
@@ -14,7 +14,7 @@ def run_proc(args, shell = False, input = None):
     output, error = process.communicate(input)
     return (process.returncode, output, error)
 
-keywords = ("iptables-translate", "ip6tables-translate", "ebtables-translate")
+keywords = ("iptables-translate", "ip6tables-translate", "arptables-translate", "ebtables-translate")
 xtables_nft_multi = 'xtables-nft-multi'
 
 if sys.stdout.isatty():
@@ -95,6 +95,8 @@ def test_one_replay(name, sourceline, expected, result):
     fam = ""
     if srccmd.startswith("ip6"):
         fam = "ip6 "
+    elif srccmd.startswith("arp"):
+        fam = "arp "
     elif srccmd.startswith("ebt"):
         fam = "bridge "
 
-- 
2.41.0

