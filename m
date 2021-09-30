Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8400E41DBE6
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Sep 2021 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351739AbhI3OGx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Sep 2021 10:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351734AbhI3OGw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:06:52 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1EC06176A
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Sep 2021 07:05:10 -0700 (PDT)
Received: from localhost ([::1]:51702 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mVwgO-0007Qp-Q2; Thu, 30 Sep 2021 16:05:08 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 10/17] nft-shared: Make nft_check_xt_legacy() family agnostic
Date:   Thu, 30 Sep 2021 16:04:12 +0200
Message-Id: <20210930140419.6170-11-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930140419.6170-1-phil@nwl.cc>
References: <20210930140419.6170-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Of course there is no such thing as *_tables_names for ebtables, so no
legacy tables checking for ebtables-nft.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 4253b08196d29..72727270026ee 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -992,6 +992,7 @@ void nft_check_xt_legacy(int family, bool is_ipt_save)
 {
 	static const char tables6[] = "/proc/net/ip6_tables_names";
 	static const char tables4[] = "/proc/net/ip_tables_names";
+	static const char tablesa[] = "/proc/net/arp_tables_names";
 	const char *prefix = "ip";
 	FILE *fp = NULL;
 	char buf[1024];
@@ -1004,6 +1005,10 @@ void nft_check_xt_legacy(int family, bool is_ipt_save)
 		fp = fopen(tables6, "r");
 		prefix = "ip6";
 		break;
+	case NFPROTO_ARP:
+		fp = fopen(tablesa, "r");
+		prefix = "arp";
+		break;
 	default:
 		break;
 	}
-- 
2.33.0

