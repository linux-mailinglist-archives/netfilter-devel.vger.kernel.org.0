Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC395D910D
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Oct 2019 14:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391219AbfJPMel (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 08:34:41 -0400
Received: from correo.us.es ([193.147.175.20]:51000 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391265AbfJPMel (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:34:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2030818CDCE
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:37 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 136FDA7E0F
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 09184A7E1F; Wed, 16 Oct 2019 14:34:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 25E2DA7E1A
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 16 Oct 2019 14:34:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0361742EE38F
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:34 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 4/4] netfilter: nf_tables: increase maximum devices number per flowtable
Date:   Wed, 16 Oct 2019 14:34:31 +0200
Message-Id: <20191016123431.9072-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016123431.9072-1-pablo@netfilter.org>
References: <20191016123431.9072-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rise the maximum limit of devices per flowtable up to 256. Rename
NFT_FLOWTABLE_DEVICE_MAX to NFT_NETDEVICE_MAX in preparation to reuse
the netdev hook parser for ingress basechain.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 2 +-
 net/netfilter/nf_tables_api.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 7a2ac82ee0ad..3d71070e747a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1152,7 +1152,7 @@ struct nft_object_ops {
 int nft_register_obj(struct nft_object_type *obj_type);
 void nft_unregister_obj(struct nft_object_type *obj_type);
 
-#define NFT_FLOWTABLE_DEVICE_MAX	8
+#define NFT_NETDEVICE_MAX	256
 
 /**
  *	struct nft_flowtable - nf_tables flow table
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 80ded807d529..d736a0cd056c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1577,7 +1577,7 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 		list_add_tail(&hook->list, hook_list);
 		n++;
 
-		if (n == NFT_FLOWTABLE_DEVICE_MAX) {
+		if (n == NFT_NETDEVICE_MAX) {
 			err = -EFBIG;
 			goto err_hook;
 		}
-- 
2.11.0

