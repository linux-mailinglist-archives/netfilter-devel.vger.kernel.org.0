Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35882F3F7D
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Jan 2021 01:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391619AbhALWWa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Jan 2021 17:22:30 -0500
Received: from correo.us.es ([193.147.175.20]:49902 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404790AbhALWV1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:21:27 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CFD7AD28CA
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Jan 2021 23:19:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C11D5DA78D
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Jan 2021 23:19:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B6C5EDA78B; Tue, 12 Jan 2021 23:19:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.7 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        LOTS_OF_MONEY,SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7C5BDDA722;
        Tue, 12 Jan 2021 23:19:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 12 Jan 2021 23:19:57 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.lan (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 3D71442EF528;
        Tue, 12 Jan 2021 23:19:57 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 1/3] selftests: netfilter: Pass family parameter "-f" to conntrack tool
Date:   Tue, 12 Jan 2021 23:20:31 +0100
Message-Id: <20210112222033.9732-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112222033.9732-1-pablo@netfilter.org>
References: <20210112222033.9732-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Chen Yi <yiche@redhat.com>

Fix nft_conntrack_helper.sh false fail report:

1) Conntrack tool need "-f ipv6" parameter to show out ipv6 traffic items.

2) Sleep 1 second after background nc send packet, to make sure check
is after this statement executed.

False report:
FAIL: ns1-lkjUemYw did not show attached helper ip set via ruleset
PASS: ns1-lkjUemYw connection on port 2121 has ftp helper attached
...

After fix:
PASS: ns1-2hUniwU2 connection on port 2121 has ftp helper attached
PASS: ns2-2hUniwU2 connection on port 2121 has ftp helper attached
...

Fixes: 619ae8e0697a6 ("selftests: netfilter: add test case for conntrack helper assignment")
Signed-off-by: Chen Yi <yiche@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../selftests/netfilter/nft_conntrack_helper.sh      | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh b/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
index edf0a48da6bf..bf6b9626c7dd 100755
--- a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
+++ b/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
@@ -94,7 +94,13 @@ check_for_helper()
 	local message=$2
 	local port=$3
 
-	ip netns exec ${netns} conntrack -L -p tcp --dport $port 2> /dev/null |grep -q 'helper=ftp'
+	if echo $message |grep -q 'ipv6';then
+		local family="ipv6"
+	else
+		local family="ipv4"
+	fi
+
+	ip netns exec ${netns} conntrack -L -f $family -p tcp --dport $port 2> /dev/null |grep -q 'helper=ftp'
 	if [ $? -ne 0 ] ; then
 		echo "FAIL: ${netns} did not show attached helper $message" 1>&2
 		ret=1
@@ -111,8 +117,8 @@ test_helper()
 
 	sleep 3 | ip netns exec ${ns2} nc -w 2 -l -p $port > /dev/null &
 
-	sleep 1
 	sleep 1 | ip netns exec ${ns1} nc -w 2 10.0.1.2 $port > /dev/null &
+	sleep 1
 
 	check_for_helper "$ns1" "ip $msg" $port
 	check_for_helper "$ns2" "ip $msg" $port
@@ -128,8 +134,8 @@ test_helper()
 
 	sleep 3 | ip netns exec ${ns2} nc -w 2 -6 -l -p $port > /dev/null &
 
-	sleep 1
 	sleep 1 | ip netns exec ${ns1} nc -w 2 -6 dead:1::2 $port > /dev/null &
+	sleep 1
 
 	check_for_helper "$ns1" "ipv6 $msg" $port
 	check_for_helper "$ns2" "ipv6 $msg" $port
-- 
2.20.1

