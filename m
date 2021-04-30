Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8613736F2F4
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Apr 2021 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhD2Xnt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 19:43:49 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59522 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhD2Xnt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:43:49 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6811A64133
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Apr 2021 01:42:22 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 01/18] tests: shell: remove missing modules
Date:   Fri, 30 Apr 2021 01:42:38 +0200
Message-Id: <20210429234255.16840-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429234255.16840-1-pablo@netfilter.org>
References: <20210429234255.16840-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Update run-tests.sh to remove the following modules:

- nft_reject_netdev
- nft_xfrm
- nft_synproxy

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/run-tests.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index 943f88776fda..349ec6cb1b16 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -90,10 +90,11 @@ kernel_cleanup() {
 	nft_chain_nat \
 	nft_chain_route_ipv4 nft_chain_route_ipv6 \
 	nft_dup_netdev nft_fwd_netdev \
-	nft_reject nft_reject_inet \
+	nft_reject nft_reject_inet nft_reject_netdev \
 	nf_tables_set nf_tables \
 	nf_flow_table nf_flow_table_ipv4 nf_flow_tables_ipv6 \
-	nf_flow_table_inet nft_flow_offload
+	nf_flow_table_inet nft_flow_offload \
+	nft_xfrm
 }
 
 find_tests() {
-- 
2.20.1

