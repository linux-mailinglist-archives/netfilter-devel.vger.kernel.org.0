Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D1F63CAA5
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Nov 2022 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiK2VsC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Nov 2022 16:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiK2Vr6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:47:58 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FB64A29
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Nov 2022 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VY4spOVdFUfIAYFKe7SARH6l+1dR3E9paCZN4GoHPM0=; b=dkYU8PkSotu7GAXx8GmVz88o0A
        UxK/T4IU9ctte9o922/y1Utde3nmPsn+Q9nlgD8PIOtONUmG7iy6OuxGnrEZfJ1YcxNXnoEoacmuy
        6qIaUZnpQlZSDaQiuOHMuwwnJxgBfR34r+J8Q+qs7KApfFgt0K/6bvip+it3GcuVO8JZs6bazevw1
        SdQhkpFSfbd0XjYBnmh4ve4ahSxH64wJmS1QJU41EmdifREE5Iv7qYjwbZnGiDp5Ynx+jX66M/sYo
        Xesc6TYuesMmB6IChiQ++ipRp/JzHdHuiSd4RkFHLUuNi600Rp0+ON0WP3K2x5kQSbW+1sRxaSaZ3
        JaV5yLjw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1p08SJ-00DjQp-IR
        for netfilter-devel@vger.kernel.org; Tue, 29 Nov 2022 21:47:55 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH ulogd2 v2 v2 09/34] src: define constructors and destructors consistently
Date:   Tue, 29 Nov 2022 21:47:24 +0000
Message-Id: <20221129214749.247878-10-jeremy@azazel.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129214749.247878-1-jeremy@azazel.net>
References: <20221129214749.247878-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove separate declarations and declare the functions static.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 filter/raw2packet/ulogd_raw2packet_BASE.c |  4 +---
 filter/ulogd_filter_HWHDR.c               |  4 +---
 filter/ulogd_filter_IFINDEX.c             |  4 +---
 filter/ulogd_filter_IP2BIN.c              |  4 +---
 filter/ulogd_filter_IP2HBIN.c             |  4 +---
 filter/ulogd_filter_IP2STR.c              |  4 +---
 filter/ulogd_filter_MARK.c                |  4 +---
 filter/ulogd_filter_PRINTFLOW.c           |  4 +---
 filter/ulogd_filter_PRINTPKT.c            |  4 +---
 filter/ulogd_filter_PWSNIFF.c             |  2 +-
 input/flow/ulogd_inpflow_NFCT.c           |  5 +----
 input/packet/ulogd_inppkt_NFLOG.c         |  4 +---
 input/packet/ulogd_inppkt_ULOG.c          | 11 ++++++-----
 input/sum/ulogd_inpflow_NFACCT.c          |  4 +---
 output/dbi/ulogd_output_DBI.c             |  4 ++--
 output/ipfix/ulogd_output_IPFIX.c         |  4 +---
 output/mysql/ulogd_output_MYSQL.c         |  4 +---
 output/pcap/ulogd_output_PCAP.c           |  4 +---
 output/pgsql/ulogd_output_PGSQL.c         |  4 +---
 output/sqlite3/ulogd_output_SQLITE3.c     |  5 +----
 20 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/filter/raw2packet/ulogd_raw2packet_BASE.c b/filter/raw2packet/ulogd_raw2packet_BASE.c
index 9117d27da09a..71ef006c90fb 100644
--- a/filter/raw2packet/ulogd_raw2packet_BASE.c
+++ b/filter/raw2packet/ulogd_raw2packet_BASE.c
@@ -1002,9 +1002,7 @@ static struct ulogd_plugin base_plugin = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&base_plugin);
 }
diff --git a/filter/ulogd_filter_HWHDR.c b/filter/ulogd_filter_HWHDR.c
index a5ee60dea44b..08a84fc49d75 100644
--- a/filter/ulogd_filter_HWHDR.c
+++ b/filter/ulogd_filter_HWHDR.c
@@ -236,9 +236,7 @@ static struct ulogd_plugin mac2str_pluging = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&mac2str_pluging);
 }
diff --git a/filter/ulogd_filter_IFINDEX.c b/filter/ulogd_filter_IFINDEX.c
index 3ca57955190c..2205e0025ca1 100644
--- a/filter/ulogd_filter_IFINDEX.c
+++ b/filter/ulogd_filter_IFINDEX.c
@@ -149,9 +149,7 @@ static struct ulogd_plugin ifindex_plugin = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&ifindex_plugin);
 }
diff --git a/filter/ulogd_filter_IP2BIN.c b/filter/ulogd_filter_IP2BIN.c
index 42bcd7c15f1b..ca6d3abae884 100644
--- a/filter/ulogd_filter_IP2BIN.c
+++ b/filter/ulogd_filter_IP2BIN.c
@@ -234,9 +234,7 @@ static struct ulogd_plugin ip2bin_pluging = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&ip2bin_pluging);
 }
diff --git a/filter/ulogd_filter_IP2HBIN.c b/filter/ulogd_filter_IP2HBIN.c
index 2711f9c3e12a..2d003a6335db 100644
--- a/filter/ulogd_filter_IP2HBIN.c
+++ b/filter/ulogd_filter_IP2HBIN.c
@@ -190,9 +190,7 @@ static struct ulogd_plugin ip2hbin_pluging = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&ip2hbin_pluging);
 }
diff --git a/filter/ulogd_filter_IP2STR.c b/filter/ulogd_filter_IP2STR.c
index 4d0536817b6c..177107fa8707 100644
--- a/filter/ulogd_filter_IP2STR.c
+++ b/filter/ulogd_filter_IP2STR.c
@@ -224,9 +224,7 @@ static struct ulogd_plugin ip2str_pluging = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&ip2str_pluging);
 }
diff --git a/filter/ulogd_filter_MARK.c b/filter/ulogd_filter_MARK.c
index 94343a2b6b5b..61b4d9a7eaea 100644
--- a/filter/ulogd_filter_MARK.c
+++ b/filter/ulogd_filter_MARK.c
@@ -111,9 +111,7 @@ static struct ulogd_plugin mark_pluging = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&mark_pluging);
 }
diff --git a/filter/ulogd_filter_PRINTFLOW.c b/filter/ulogd_filter_PRINTFLOW.c
index 95351f881c54..618b18b445c5 100644
--- a/filter/ulogd_filter_PRINTFLOW.c
+++ b/filter/ulogd_filter_PRINTFLOW.c
@@ -57,9 +57,7 @@ static struct ulogd_plugin printflow_plugin = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&printflow_plugin);
 }
diff --git a/filter/ulogd_filter_PRINTPKT.c b/filter/ulogd_filter_PRINTPKT.c
index de5c4688a4f1..7199e3cada07 100644
--- a/filter/ulogd_filter_PRINTPKT.c
+++ b/filter/ulogd_filter_PRINTPKT.c
@@ -57,9 +57,7 @@ static struct ulogd_plugin printpkt_plugin = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static __attribute__ ((constructor)) void init(void)
 {
 	ulogd_register_plugin(&printpkt_plugin);
 }
diff --git a/filter/ulogd_filter_PWSNIFF.c b/filter/ulogd_filter_PWSNIFF.c
index ef9e02115d84..6f4a04fc8329 100644
--- a/filter/ulogd_filter_PWSNIFF.c
+++ b/filter/ulogd_filter_PWSNIFF.c
@@ -170,7 +170,7 @@ static struct ulogd_plugin pwsniff_plugin = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&pwsniff_plugin);
 }
diff --git a/input/flow/ulogd_inpflow_NFCT.c b/input/flow/ulogd_inpflow_NFCT.c
index 04910601fb8c..6209cdbd5dc1 100644
--- a/input/flow/ulogd_inpflow_NFCT.c
+++ b/input/flow/ulogd_inpflow_NFCT.c
@@ -1545,10 +1545,7 @@ static struct ulogd_plugin nfct_plugin = {
 	.version	= VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&nfct_plugin);
 }
-
diff --git a/input/packet/ulogd_inppkt_NFLOG.c b/input/packet/ulogd_inppkt_NFLOG.c
index 4cbae69fee20..191716b6e2d7 100644
--- a/input/packet/ulogd_inppkt_NFLOG.c
+++ b/input/packet/ulogd_inppkt_NFLOG.c
@@ -712,9 +712,7 @@ struct ulogd_plugin libulog_plugin = {
 	.version	= VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&libulog_plugin);
 }
diff --git a/input/packet/ulogd_inppkt_ULOG.c b/input/packet/ulogd_inppkt_ULOG.c
index bc271dbfd0b1..fd4f5693cab2 100644
--- a/input/packet/ulogd_inppkt_ULOG.c
+++ b/input/packet/ulogd_inppkt_ULOG.c
@@ -265,7 +265,8 @@ static int configure(struct ulogd_pluginstance *upi,
 {
 	return config_parse_file(upi->id, upi->config_kset);
 }
-static int init(struct ulogd_pluginstance *upi)
+
+static int start(struct ulogd_pluginstance *upi)
 {
 	struct ulog_input *ui = (struct ulog_input *) &upi->private;
 
@@ -298,7 +299,7 @@ out_buf:
 	return -1;
 }
 
-static int fini(struct ulogd_pluginstance *pi)
+static int stop(struct ulogd_pluginstance *pi)
 {
 	struct ulog_input *ui = (struct ulog_input *)pi->private;
 
@@ -320,13 +321,13 @@ struct ulogd_plugin libulog_plugin = {
 		.num_keys = ARRAY_SIZE(output_keys),
 	},
 	.configure = &configure,
-	.start = &init,
-	.stop = &fini,
+	.start = &start,
+	.stop = &stop,
 	.config_kset = &libulog_kset,
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) initializer(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&libulog_plugin);
 }
diff --git a/input/sum/ulogd_inpflow_NFACCT.c b/input/sum/ulogd_inpflow_NFACCT.c
index c680a52a80e8..9a1991e7aef7 100644
--- a/input/sum/ulogd_inpflow_NFACCT.c
+++ b/input/sum/ulogd_inpflow_NFACCT.c
@@ -300,9 +300,7 @@ static struct ulogd_plugin nfacct_plugin = {
 	.version	= VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&nfacct_plugin);
 }
diff --git a/output/dbi/ulogd_output_DBI.c b/output/dbi/ulogd_output_DBI.c
index 95bd35789c08..7f42c08efc2b 100644
--- a/output/dbi/ulogd_output_DBI.c
+++ b/output/dbi/ulogd_output_DBI.c
@@ -307,14 +307,14 @@ static struct ulogd_plugin dbi_plugin = {
 	.version	= VERSION,
 };
 
-void __attribute__ ((constructor)) init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	dbi_initialize_r(NULL, &libdbi_instance);
 
 	ulogd_register_plugin(&dbi_plugin);
 }
 
-void __attribute__ ((destructor)) fini(void)
+static void __attribute__ ((destructor)) fini(void)
 {
 	dbi_shutdown_r(libdbi_instance);
 }
diff --git a/output/ipfix/ulogd_output_IPFIX.c b/output/ipfix/ulogd_output_IPFIX.c
index 745d30a163b2..45fd36bc271c 100644
--- a/output/ipfix/ulogd_output_IPFIX.c
+++ b/output/ipfix/ulogd_output_IPFIX.c
@@ -504,9 +504,7 @@ static struct ulogd_plugin ipfix_plugin = {
 	.version = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&ipfix_plugin);
 }
diff --git a/output/mysql/ulogd_output_MYSQL.c b/output/mysql/ulogd_output_MYSQL.c
index 0b79a9cd270c..c98b98284748 100644
--- a/output/mysql/ulogd_output_MYSQL.c
+++ b/output/mysql/ulogd_output_MYSQL.c
@@ -278,9 +278,7 @@ static struct ulogd_plugin plugin_mysql = {
 	.version   = VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&plugin_mysql);
 }
diff --git a/output/pcap/ulogd_output_PCAP.c b/output/pcap/ulogd_output_PCAP.c
index c125ffcd2a8f..5f9fde3c48ed 100644
--- a/output/pcap/ulogd_output_PCAP.c
+++ b/output/pcap/ulogd_output_PCAP.c
@@ -307,9 +307,7 @@ static struct ulogd_plugin pcap_plugin = {
 	.version	= VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&pcap_plugin);
 }
diff --git a/output/pgsql/ulogd_output_PGSQL.c b/output/pgsql/ulogd_output_PGSQL.c
index 7f215f0fee4c..a508f9cf75a1 100644
--- a/output/pgsql/ulogd_output_PGSQL.c
+++ b/output/pgsql/ulogd_output_PGSQL.c
@@ -357,9 +357,7 @@ static struct ulogd_plugin pgsql_plugin = {
 	.version	= VERSION,
 };
 
-void __attribute__ ((constructor)) init(void);
-
-void init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&pgsql_plugin);
 }
diff --git a/output/sqlite3/ulogd_output_SQLITE3.c b/output/sqlite3/ulogd_output_SQLITE3.c
index 8dd7cec586cf..40d99ca3b249 100644
--- a/output/sqlite3/ulogd_output_SQLITE3.c
+++ b/output/sqlite3/ulogd_output_SQLITE3.c
@@ -435,10 +435,7 @@ static struct ulogd_plugin sqlite3_plugin = {
 	.version = VERSION,
 };
 
-static void init(void) __attribute__((constructor));
-
-static void
-init(void)
+static void __attribute__ ((constructor)) init(void)
 {
 	ulogd_register_plugin(&sqlite3_plugin);
 }
-- 
2.35.1

