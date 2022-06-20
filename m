Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D124D5512D7
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiFTIci (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbiFTIcb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C052912A81
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:29 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 14/18] tests: shell: run -c -o on ruleset
Date:   Mon, 20 Jun 2022 10:32:11 +0200
Message-Id: <20220620083215.1021238-15-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620083215.1021238-1-pablo@netfilter.org>
References: <20220620083215.1021238-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Just run -o/--optimize on a ruleset.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/optimizations/ruleset | 168 ++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100755 tests/shell/testcases/optimizations/ruleset

diff --git a/tests/shell/testcases/optimizations/ruleset b/tests/shell/testcases/optimizations/ruleset
new file mode 100755
index 000000000000..ef2652dbeae8
--- /dev/null
+++ b/tests/shell/testcases/optimizations/ruleset
@@ -0,0 +1,168 @@
+#!/bin/bash
+
+RULESET="table inet uni {
+	chain gtfo {
+		reject with icmpx type host-unreachable
+		drop
+	}
+
+	chain filter_in_tcp {
+		tcp dport vmap {
+			   80 : accept,
+			   81 : accept,
+			  443 : accept,
+			  931 : accept,
+			 5001 : accept,
+			 5201 : accept,
+		}
+		tcp dport vmap {
+			 6800-6999  : accept,
+			33434-33499 : accept,
+		}
+
+		drop
+	}
+
+	chain filter_in_udp {
+		udp dport vmap {
+			   53 : accept,
+			  123 : accept,
+			  846 : accept,
+			  849 : accept,
+			 5001 : accept,
+			 5201 : accept,
+		}
+		udp dport vmap {
+			 5300-5399  : accept,
+			 6800-6999  : accept,
+			33434-33499 : accept,
+		}
+
+		drop
+	}
+
+	chain filter_in {
+		type filter hook input priority 0; policy drop;
+
+		ct state vmap {
+			invalid     : drop,
+			established : accept,
+			related     : accept,
+			untracked   : accept,
+		}
+
+		ct status vmap {
+			dnat : accept,
+			snat : accept,
+		}
+
+		iif lo  accept
+
+		meta iifgroup {100-199}  accept
+
+		meta l4proto tcp  goto filter_in_tcp
+		meta l4proto udp  goto filter_in_udp
+
+		icmp type vmap {
+			echo-request : accept,
+		}
+		ip6 nexthdr icmpv6 icmpv6 type vmap {
+			echo-request : accept,
+		}
+	}
+
+	chain filter_fwd_ifgroup {
+		meta iifgroup . oifgroup vmap {
+		          100 .  10 : accept,
+		          100 . 100 : accept,
+		          100 . 101 : accept,
+		          101 . 101 : accept,
+		}
+		goto gtfo
+	}
+
+	chain filter_fwd {
+		type filter hook forward priority 0; policy drop;
+
+		fib daddr type broadcast  drop
+
+		ct state vmap {
+			invalid     : drop,
+			established : accept,
+			related     : accept,
+			untracked   : accept,
+		}
+
+		ct status vmap {
+			dnat : accept,
+			snat : accept,
+		}
+
+		meta iifgroup {100-199}  goto filter_fwd_ifgroup
+	}
+
+	chain nat_fwd_tun {
+		meta l4proto tcp redirect to :15
+		udp dport 53 redirect to :13
+		goto gtfo
+	}
+
+	chain nat_dns_dnstc     { meta l4proto udp redirect to :5300 ; drop ; }
+	chain nat_dns_this_5301 { meta l4proto udp redirect to :5301 ; drop ; }
+	chain nat_dns_moon_5301  { meta nfproto ipv4 meta l4proto udp dnat to 240.0.1.2:5301 ; drop ; }
+	chain nat_dns_moon_5302  { meta nfproto ipv4 meta l4proto udp dnat to 240.0.1.2:5302 ; drop ; }
+	chain nat_dns_moon_5303  { meta nfproto ipv4 meta l4proto udp dnat to 240.0.1.2:5303 ; drop ; }
+
+	chain nat_dns_acme {
+		udp length 47-63 @th,160,128 0x0e373135363130333131303735353203 \
+			goto nat_dns_dnstc
+
+		udp length 62-78 @th,160,128 0x0e31393032383939353831343037320e \
+			goto nat_dns_this_5301
+
+		udp length 62-78 @th,160,128 0x0e31363436323733373931323934300e \
+			goto nat_dns_moon_5301
+
+		udp length 62-78 @th,160,128 0x0e32393535373539353636383732310e \
+			goto nat_dns_moon_5302
+
+		udp length 62-78 @th,160,128 0x0e38353439353637323038363633390e \
+			goto nat_dns_moon_5303
+
+		drop
+	}
+
+	chain nat_prerouting {
+		type nat hook prerouting priority -100; policy accept;
+
+		iifgroup 10 udp dport 53 goto nat_dns_acme
+		iifgroup 10 accept
+
+		ip  daddr 198.19.0.0/16  goto nat_fwd_tun
+		ip6 daddr fc00::/8       goto nat_fwd_tun
+
+		tcp dport 53 redirect to :25302
+		udp dport 53 redirect to :25302
+	}
+
+	chain nat_output {
+		type nat hook output priority -100; policy accept;
+
+		ip  daddr 198.19.0.0/16  goto nat_fwd_tun
+		ip6 daddr fc00::/8       goto nat_fwd_tun
+	}
+
+	chain nat_postrouting {
+		type nat hook postrouting priority 100; policy accept;
+
+		oif != lo masquerade
+	}
+
+	chain mangle_forward {
+		type filter hook forward priority -150; policy accept;
+
+		tcp flags & (syn | rst) == syn tcp option maxseg size set rt mtu
+	}
+}"
+
+$NFT -o -c -f - <<< $RULESET
-- 
2.30.2

