Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860684EC2A
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jun 2019 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFUPh4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jun 2019 11:37:56 -0400
Received: from mail.us.es ([193.147.175.20]:52606 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfFUPhz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:37:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EF11FEDB01
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jun 2019 17:37:53 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E1042DA707
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jun 2019 17:37:53 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D5CC8DA702; Fri, 21 Jun 2019 17:37:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C5336DA703;
        Fri, 21 Jun 2019 17:37:51 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 21 Jun 2019 17:37:51 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A48414265A32;
        Fri, 21 Jun 2019 17:37:51 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ffmancera@riseup.net
Subject: [PATCH nf-next] netfilter: rename nf_SYNPROXY.h to nf_synproxy.h
Date:   Fri, 21 Jun 2019 17:37:48 +0200
Message-Id: <20190621153748.19042-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Uppercase is a reminiscence from the iptables infrastructure, rename
this header before this is included in stable kernels.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/{nf_SYNPROXY.h => nf_synproxy.h} | 0
 include/uapi/linux/netfilter/xt_SYNPROXY.h                    | 2 +-
 net/netfilter/nf_synproxy_core.c                              | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/uapi/linux/netfilter/{nf_SYNPROXY.h => nf_synproxy.h} (100%)

diff --git a/include/uapi/linux/netfilter/nf_SYNPROXY.h b/include/uapi/linux/netfilter/nf_synproxy.h
similarity index 100%
rename from include/uapi/linux/netfilter/nf_SYNPROXY.h
rename to include/uapi/linux/netfilter/nf_synproxy.h
diff --git a/include/uapi/linux/netfilter/xt_SYNPROXY.h b/include/uapi/linux/netfilter/xt_SYNPROXY.h
index 4d5611d647df..19c04ed86172 100644
--- a/include/uapi/linux/netfilter/xt_SYNPROXY.h
+++ b/include/uapi/linux/netfilter/xt_SYNPROXY.h
@@ -2,7 +2,7 @@
 #ifndef _XT_SYNPROXY_H
 #define _XT_SYNPROXY_H
 
-#include <linux/netfilter/nf_SYNPROXY.h>
+#include <linux/netfilter/nf_synproxy.h>
 
 #define XT_SYNPROXY_OPT_MSS		NF_SYNPROXY_OPT_MSS
 #define XT_SYNPROXY_OPT_WSCALE		NF_SYNPROXY_OPT_WSCALE
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 24d3e564403f..1fccde0c19c5 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -14,7 +14,7 @@
 #include <linux/proc_fs.h>
 
 #include <linux/netfilter_ipv6.h>
-#include <linux/netfilter/nf_SYNPROXY.h>
+#include <linux/netfilter/nf_synproxy.h>
 
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_ecache.h>
-- 
2.11.0

