Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD75F1E3F34
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2020 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgE0KhX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 May 2020 06:37:23 -0400
Received: from correo.us.es ([193.147.175.20]:49988 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbgE0KhX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 May 2020 06:37:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 171C0121083
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 12:37:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F09F9DA715
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 12:37:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EC0D9DA711; Wed, 27 May 2020 12:37:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C061BDA711
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 12:37:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 27 May 2020 12:37:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id ABC2842EF4E2
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 12:37:18 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_conntrack_pptp: fix compilation warning with W=1 build
Date:   Wed, 27 May 2020 12:37:16 +0200
Message-Id: <20200527103716.7393-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

>> include/linux/netfilter/nf_conntrack_pptp.h:13:20: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
extern const char *const pptp_msg_name(u_int16_t msg);
^~~~~~

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 4c559f15efcc ("netfilter: nf_conntrack_pptp: prevent buffer overflows in debug code")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/nf_conntrack_pptp.h | 2 +-
 net/netfilter/nf_conntrack_pptp.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_pptp.h b/include/linux/netfilter/nf_conntrack_pptp.h
index 6a4ff6d5ebc2..a28aa289afdc 100644
--- a/include/linux/netfilter/nf_conntrack_pptp.h
+++ b/include/linux/netfilter/nf_conntrack_pptp.h
@@ -10,7 +10,7 @@
 #include <net/netfilter/nf_conntrack_expect.h>
 #include <uapi/linux/netfilter/nf_conntrack_tuple_common.h>
 
-extern const char *const pptp_msg_name(u_int16_t msg);
+const char *pptp_msg_name(u_int16_t msg);
 
 /* state of the control session */
 enum pptp_ctrlsess_state {
diff --git a/net/netfilter/nf_conntrack_pptp.c b/net/netfilter/nf_conntrack_pptp.c
index 7ad247784cfa..1f44d523b512 100644
--- a/net/netfilter/nf_conntrack_pptp.c
+++ b/net/netfilter/nf_conntrack_pptp.c
@@ -91,7 +91,7 @@ static const char *const pptp_msg_name_array[PPTP_MSG_MAX + 1] = {
 	[PPTP_SET_LINK_INFO]		= "SET_LINK_INFO"
 };
 
-const char *const pptp_msg_name(u_int16_t msg)
+const char *pptp_msg_name(u_int16_t msg)
 {
 	if (msg > PPTP_MSG_MAX)
 		return pptp_msg_name_array[0];
-- 
2.20.1

