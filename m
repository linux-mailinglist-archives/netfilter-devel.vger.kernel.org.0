Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3009F4B093C
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Feb 2022 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiBJJMD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Feb 2022 04:12:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiBJJMB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:12:01 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76DE910E9
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Feb 2022 01:11:56 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id A6403601BA;
        Thu, 10 Feb 2022 10:11:41 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf] selftests: netfilter: synproxy test requires nf_conntrack
Date:   Thu, 10 Feb 2022 10:11:52 +0100
Message-Id: <20220210091152.174933-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

Otherwise, this test does not find the sysctl entry in place:

 sysctl: cannot stat /proc/sys/net/netfilter/nf_conntrack_tcp_loose: No existe el fichero o el di
 iperf3: error - unable to send control message: Bad file descriptor
 FAIL: iperf3 returned an error

Fixes: 7152303cbec4 ("selftests: netfilter: add synproxy test")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tools/testing/selftests/netfilter/nft_synproxy.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/netfilter/nft_synproxy.sh b/tools/testing/selftests/netfilter/nft_synproxy.sh
index 09bb95c87198..b62933b680d6 100755
--- a/tools/testing/selftests/netfilter/nft_synproxy.sh
+++ b/tools/testing/selftests/netfilter/nft_synproxy.sh
@@ -23,6 +23,8 @@ checktool "ip -Version" "run test without ip tool"
 checktool "iperf3 --version" "run test without iperf3"
 checktool "ip netns add $nsr" "create net namespace"
 
+modprobe -q nf_conntrack
+
 ip netns add $ns1
 ip netns add $ns2
 
-- 
2.30.2

