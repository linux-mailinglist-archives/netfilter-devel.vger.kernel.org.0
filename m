Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4073331252
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 16:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCHPeh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 10:34:37 -0500
Received: from correo.us.es ([193.147.175.20]:33036 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhCHPeK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:34:10 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6DF8BDA7B3
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 16:34:05 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1637E1D5D2D
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 16:34:05 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 822FEFEFDA; Mon,  8 Mar 2021 16:32:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06F09EB0A2
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 16:32:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 08 Mar 2021 16:32:45 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 20EE642DC6E6
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 16:32:57 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack-tools] conntrackd: set default hashtable buckets and max entries if not specified
Date:   Mon,  8 Mar 2021 16:32:54 +0100
Message-Id: <20210308153254.15678-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fall back to 65536 buckets and 262144 entries.

It would be probably good to add code to autoadjust by reading
/proc/sys/net/netfilter/nf_conntrack_buckets and
/proc/sys/net/nf_conntrack_max.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1491
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/read_config_yy.y | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/read_config_yy.y b/src/read_config_yy.y
index 31109c4de042..b215a729b716 100644
--- a/src/read_config_yy.y
+++ b/src/read_config_yy.y
@@ -1780,5 +1780,11 @@ init_config(char *filename)
 					 NF_NETLINK_CONNTRACK_DESTROY;
 	}
 
+	/* default hashtable buckets and maximum number of entries */
+	if (!CONFIG(hashsize))
+		CONFIG(hashsize) = 65536;
+	if (!CONFIG(limit))
+		CONFIG(limit) = 262144;
+
 	return 0;
 }
-- 
2.20.1

