Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C043CBE714
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfIYV07 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:26:59 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45836 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIYV07 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:26:59 -0400
Received: from localhost ([::1]:58926 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEoM-0005Ei-02; Wed, 25 Sep 2019 23:26:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 18/24] xtables-restore: Use xt_params->program_name
Date:   Wed, 25 Sep 2019 23:25:59 +0200
Message-Id: <20190925212605.1005-19-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925212605.1005-1-phil@nwl.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of setting newargv[0] to argv[0]'s value, just use whatever
xt_params->program_name contains. The latter is arbitrarily defined, but
may still be more correct than real argv[0] which may simply be for
instance xtables-nft-multi. Either way, there is no practical
significance since newargv[0] is used exclusively in debug output.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.h        |  3 +--
 iptables/xtables-restore.c   | 11 +++++------
 iptables/xtables-translate.c |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index facad6d02a7ec..f1efab80ff621 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -263,8 +263,7 @@ struct nft_xt_restore_cb {
 
 void xtables_restore_parse(struct nft_handle *h,
 			   struct nft_xt_restore_parse *p,
-			   struct nft_xt_restore_cb *cb,
-			   int argc, char *argv[]);
+			   struct nft_xt_restore_cb *cb);
 
 void nft_check_xt_legacy(int family, bool is_ipt_save);
 #endif
diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index 2519005590ff1..48999d1ec8a27 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -86,8 +86,7 @@ static const struct xtc_ops xtc_ops = {
 
 void xtables_restore_parse(struct nft_handle *h,
 			   struct nft_xt_restore_parse *p,
-			   struct nft_xt_restore_cb *cb,
-			   int argc, char *argv[])
+			   struct nft_xt_restore_cb *cb)
 {
 	const struct builtin_table *curtable = NULL;
 	char buffer[10240];
@@ -234,7 +233,7 @@ void xtables_restore_parse(struct nft_handle *h,
 			/* reset the newargv */
 			newargc = 0;
 
-			add_argv(argv[0], 0);
+			add_argv(xt_params->program_name, 0);
 			add_argv("-t", 0);
 			add_argv(curtable->name, 0);
 
@@ -405,7 +404,7 @@ xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	xtables_restore_parse(&h, &p, &restore_cb, argc, argv);
+	xtables_restore_parse(&h, &p, &restore_cb);
 
 	nft_fini(&h);
 	fclose(p.in);
@@ -471,7 +470,7 @@ int xtables_eb_restore_main(int argc, char *argv[])
 
 	nft_init_eb(&h, "ebtables-restore");
 	h.noflush = noflush;
-	xtables_restore_parse(&h, &p, &ebt_restore_cb, argc, argv);
+	xtables_restore_parse(&h, &p, &ebt_restore_cb);
 	nft_fini(&h);
 
 	return 0;
@@ -495,7 +494,7 @@ int xtables_arp_restore_main(int argc, char *argv[])
 	struct nft_handle h;
 
 	nft_init_arp(&h, "arptables-restore");
-	xtables_restore_parse(&h, &p, &arp_restore_cb, argc, argv);
+	xtables_restore_parse(&h, &p, &arp_restore_cb);
 	nft_fini(&h);
 
 	return 0;
diff --git a/iptables/xtables-translate.c b/iptables/xtables-translate.c
index 4ae9ff57c0eb3..64e7667a253e7 100644
--- a/iptables/xtables-translate.c
+++ b/iptables/xtables-translate.c
@@ -535,7 +535,7 @@ static int xtables_restore_xlate_main(int family, const char *progname,
 
 	printf("# Translated by %s v%s on %s",
 	       argv[0], PACKAGE_VERSION, ctime(&now));
-	xtables_restore_parse(&h, &p, &cb_xlate, argc, argv);
+	xtables_restore_parse(&h, &p, &cb_xlate);
 	printf("# Completed on %s", ctime(&now));
 
 	nft_fini(&h);
-- 
2.23.0

