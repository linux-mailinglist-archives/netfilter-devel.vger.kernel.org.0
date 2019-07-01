Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3EA1A110
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 May 2019 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfEJQOG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 May 2019 12:14:06 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40798 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJQOG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 May 2019 12:14:06 -0400
Received: by mail-ed1-f46.google.com with SMTP id j12so5083087eds.7
        for <netfilter-devel@vger.kernel.org>; Fri, 10 May 2019 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPt1RnS65tAZ2F3WD8+1hjB3s1RjJv2bbkUnCuVkTNg=;
        b=cjpJr5SKOYYWXt10IQxSiccnwNYxM7XvA9R2ORkwp2fq/ec2sGl+2EeLVU3LEKlgm0
         Vb1faOEB3TzGSzjcDKGSZjh+3eDkn1BdYyopN6cp7J7SZHQy+MzIYGRyVjUhmcW7+lax
         RI1LsaciZP83UdReH471035uirX2uO6d6UvP2A3VZ4G8+IZG7UbH0OkAWFYA5VQdcXwA
         khTwAwTvbafN3nbvZd7hTvnZSPmcF28cQA0NO1KR1hh3TiSoEibu5ypDuD/U/IkuOpxe
         jaDdYC+K1mf5ei4lYkOVVMb7Ntl7fNeOUG+0pyx58/DJ6gvzKYFU9ZkPamSjag8IG/jr
         /sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPt1RnS65tAZ2F3WD8+1hjB3s1RjJv2bbkUnCuVkTNg=;
        b=hzShW/o9e9TgsWBl4bq5IJSQ7o6wOQAY50XQQGEiMSF5of+TobVaCVKgRXSoe0rtXW
         MAwAU+3iajIz+rSSaB/IV6GNaMcqB91cnM1wimwgEZyuz/36pd1XNMN1Dhlk/AIBgcWe
         IOI88GHj3j5rEU+uXOwGlKJ+MF1Mw++DH/I/HCRxm/Y6wCdqCXZchP2yqx+s/TjAUgCp
         zO2+3jONZEmdhQgrtBGWwrhMnyAVJhhaWHEJznTiV3FagvViGtTjlmaqeeVQh6nUSq2e
         7sb1K8Ku0kPHLf4fVhxIBtDCN/IRqGhFZ7/aKzTzOaafaoDdbpuvvIe56qOKHCXToySL
         TvHQ==
X-Gm-Message-State: APjAAAXMt4hTqO1s5SjLToRZyaxxrE38quXUHYjQVUuKlSMomKOYCn77
        /aLYBLZhrMIP29z6+xzYEVx8UTsP
X-Google-Smtp-Source: APXvYqz78eJbyRqnuJJNgnzs2BBgJiFOZnRzj+w49uO4Ln51YtHi0yC4yclX5/ZKnLxrVKOM7WNegg==
X-Received: by 2002:a17:906:2db2:: with SMTP id g18mr3002106eji.79.1557504842488;
        Fri, 10 May 2019 09:14:02 -0700 (PDT)
Received: from VGer.neptura.lan (neptura.org. [88.174.209.153])
        by smtp.gmail.com with ESMTPSA id o47sm1564220edc.37.2019.05.10.09.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 09:14:01 -0700 (PDT)
From:   =?UTF-8?q?St=C3=A9phane=20Veyret?= <sveyret@gmail.com>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?St=C3=A9phane=20Veyret?= <sveyret@gmail.com>
Subject: [PATCH libnftnl,v1 2/2] examples: add ct expectation examples
Date:   Fri, 10 May 2019 18:11:46 +0200
Message-Id: <20190510161146.10518-2-sveyret@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510161146.10518-1-sveyret@gmail.com>
References: <20190510161146.10518-1-sveyret@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add examples for ct expectations.

Add, list and delete ct expectation objects from specified table.
Add expectation object to rule.

Signed-off-by: Stéphane Veyret <sveyret@gmail.com>
---
 examples/Makefile.am                   |  16 +++
 examples/nft-ct-expectation-add.c      | 154 +++++++++++++++++++++++
 examples/nft-ct-expectation-del.c      | 128 +++++++++++++++++++
 examples/nft-ct-expectation-get.c      | 144 ++++++++++++++++++++++
 examples/nft-rule-ct-expectation-add.c | 163 +++++++++++++++++++++++++
 5 files changed, 605 insertions(+)
 create mode 100644 examples/nft-ct-expectation-add.c
 create mode 100644 examples/nft-ct-expectation-del.c
 create mode 100644 examples/nft-ct-expectation-get.c
 create mode 100644 examples/nft-rule-ct-expectation-add.c

diff --git a/examples/Makefile.am b/examples/Makefile.am
index d044b90..db9164d 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -29,10 +29,14 @@ check_PROGRAMS = nft-table-add		\
 		 nft-flowtable-get	\
 		 nft-ruleset-get	\
 		 nft-compat-get 	\
+		 nft-ct-expectation-add \
+		 nft-ct-expectation-del \
+		 nft-ct-expectation-get \
 		 nft-ct-helper-add	\
 		 nft-ct-helper-get	\
 		 nft-ct-helper-del	\
 		 nft-rule-ct-helper-add \
+		 nft-rule-ct-expectation-add \
 		 nft-rule-ct-timeout-add
 
 nft_table_add_SOURCES = nft-table-add.c
@@ -122,6 +126,15 @@ nft_ruleset_get_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
 nft_compat_get_SOURCES = nft-compat-get.c
 nft_compat_get_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
 
+nft_ct_expectation_add_SOURCES = nft-ct-expectation-add.c
+nft_ct_expectation_add_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
+
+nft_ct_expectation_del_SOURCES = nft-ct-expectation-del.c
+nft_ct_expectation_del_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
+
+nft_ct_expectation_get_SOURCES = nft-ct-expectation-get.c
+nft_ct_expectation_get_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
+
 nft_ct_helper_add_SOURCES = nft-ct-helper-add.c
 nft_ct_helper_add_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
 
@@ -134,5 +147,8 @@ nft_ct_helper_del_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
 nft_rule_ct_helper_add_SOURCES = nft-rule-ct-helper-add.c
 nft_rule_ct_helper_add_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
 
+nft_rule_ct_expectation_add_SOURCES = nft-rule-ct-expectation-add.c
+nft_rule_ct_expectation_add_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
+
 nft_rule_ct_timeout_add_SOURCES = nft-rule-ct-timeout-add.c
 nft_rule_ct_timeout_add_LDADD = ../src/libnftnl.la ${LIBMNL_LIBS}
diff --git a/examples/nft-ct-expectation-add.c b/examples/nft-ct-expectation-add.c
new file mode 100644
index 0000000..eb46418
--- /dev/null
+++ b/examples/nft-ct-expectation-add.c
@@ -0,0 +1,154 @@
+/*
+ * (C) 2019 by Stéphane Veyret <sveyret@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <time.h>
+#include <string.h>
+#include <netinet/in.h>
+
+#include <linux/netfilter.h>
+
+#include <obj.h>
+#include <libmnl/libmnl.h>
+
+static uint16_t parse_family(char *str, const char *option)
+{
+	if (strcmp(str, "ip") == 0)
+		return NFPROTO_IPV4;
+	else if (strcmp(str, "ip6") == 0)
+		return NFPROTO_IPV6;
+	else if (strcmp(str, "inet") == 0)
+		return NFPROTO_INET;
+	else if (strcmp(str, "arp") == 0)
+		return NFPROTO_INET;
+	else {
+		fprintf(stderr, "Unknown %s: ip, ip6, inet, arp\n", option);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static uint8_t parse_l4proto(char *str)
+{
+	if (strcmp(str, "udp") == 0)
+		return IPPROTO_UDP;
+	else if (strcmp(str, "tcp") == 0)
+		return IPPROTO_TCP;
+	else {
+		fprintf(stderr, "Unknown l4proto: tcp, udp\n");
+		exit(EXIT_FAILURE);
+	}
+	return IPPROTO_TCP;
+}
+
+static struct nftnl_obj *obj_parse(int argc, char *argv[])
+{
+	struct nftnl_obj *t;
+	uint16_t family, l3proto, dport;
+	uint8_t l4proto;
+	uint32_t timeout;
+
+	t = nftnl_obj_alloc();
+	if (t == NULL) {
+			perror("OOM");
+			return NULL;
+	}
+
+	family = parse_family(argv[1], "family");
+	nftnl_obj_set_u32(t, NFTNL_OBJ_FAMILY, family);
+	nftnl_obj_set_u32(t, NFTNL_OBJ_TYPE, NFT_OBJECT_CT_EXPECT);
+	nftnl_obj_set_str(t, NFTNL_OBJ_TABLE, argv[2]);
+	nftnl_obj_set_str(t, NFTNL_OBJ_NAME, argv[3]);
+
+	if (argc > 6) {
+		l3proto = parse_family(argv[6], "l3proto");
+		nftnl_obj_set_u16(t, NFTNL_OBJ_CT_EXPECT_L3PROTO, l3proto);
+	}
+	l4proto = parse_l4proto(argv[4]);
+	nftnl_obj_set_u8(t, NFTNL_OBJ_CT_EXPECT_L4PROTO, l4proto);
+	dport = strtol(argv[5], NULL, 10);
+	nftnl_obj_set_u16(t, NFTNL_OBJ_CT_EXPECT_DPORT, dport);
+	if (argc > 7) {
+		timeout = strtol(argv[7], NULL, 10);
+		nftnl_obj_set_u32(t, NFTNL_OBJ_CT_EXPECT_TIMEOUT, timeout);
+	}
+
+	return t;
+}
+
+int main(int argc, char *argv[])
+{
+	struct mnl_socket *nl;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	uint32_t portid, seq, obj_seq, family;
+	struct nftnl_obj *t;
+	struct mnl_nlmsg_batch *batch;
+	int ret;
+
+	if (argc < 6 || argc > 8) {
+		fprintf(stderr, "%s <family> <table> <name> <l4proto> <dport> [l3proto [timeout]]\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	t = obj_parse(argc, argv);
+	if (t == NULL) {
+		exit(EXIT_FAILURE);
+	}
+
+	seq = time(NULL);
+	batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
+
+	nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+
+	obj_seq = seq;
+	family = nftnl_obj_get_u32(t, NFTNL_OBJ_FAMILY);
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+					NFT_MSG_NEWOBJ, family, NLM_F_ACK | NLM_F_CREATE, seq++);
+	nftnl_obj_nlmsg_build_payload(nlh, t);
+	nftnl_obj_free(t);
+	mnl_nlmsg_batch_next(batch);
+
+	nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+
+	nl = mnl_socket_open(NETLINK_NETFILTER);
+	if (nl == NULL) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+	portid = mnl_socket_get_portid(nl);
+
+	if (mnl_socket_sendto(nl, mnl_nlmsg_batch_head(batch),
+				  mnl_nlmsg_batch_size(batch)) < 0) {
+		perror("mnl_socket_send");
+		exit(EXIT_FAILURE);
+	}
+
+	mnl_nlmsg_batch_stop(batch);
+
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	while (ret > 0) {
+		ret = mnl_cb_run(buf, ret, obj_seq, portid, NULL, NULL);
+		if (ret <= 0)
+			break;
+		ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	}
+	if (ret == -1) {
+		perror("error");
+		exit(EXIT_FAILURE);
+	}
+	mnl_socket_close(nl);
+
+	return EXIT_SUCCESS;
+}
diff --git a/examples/nft-ct-expectation-del.c b/examples/nft-ct-expectation-del.c
new file mode 100644
index 0000000..e38b8bd
--- /dev/null
+++ b/examples/nft-ct-expectation-del.c
@@ -0,0 +1,128 @@
+/*
+ * (C) 2019 by Stéphane Veyret <sveyret@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <stdlib.h>
+#include <time.h>
+#include <string.h>
+#include <netinet/in.h>
+
+#include <linux/netfilter.h>
+#include <linux/netfilter/nf_tables.h>
+
+#include <libmnl/libmnl.h>
+#include <libnftnl/object.h>
+
+static uint16_t parse_family(char *str, const char *option)
+{
+	if (strcmp(str, "ip") == 0)
+		return NFPROTO_IPV4;
+	else if (strcmp(str, "ip6") == 0)
+		return NFPROTO_IPV6;
+	else if (strcmp(str, "inet") == 0)
+		return NFPROTO_INET;
+	else if (strcmp(str, "arp") == 0)
+		return NFPROTO_INET;
+	else {
+		fprintf(stderr, "Unknown %s: ip, ip6, inet, arp\n", option);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static struct nftnl_obj *obj_parse(int argc, char *argv[])
+{
+	struct nftnl_obj *t;
+	uint16_t family;
+
+	t = nftnl_obj_alloc();
+	if (t == NULL) {
+		perror("OOM");
+		return NULL;
+	}
+
+	family = parse_family(argv[1], "family");
+	nftnl_obj_set_u32(t, NFTNL_OBJ_FAMILY, family);
+	nftnl_obj_set_u32(t, NFTNL_OBJ_TYPE, NFT_OBJECT_CT_EXPECT);
+	nftnl_obj_set_str(t, NFTNL_OBJ_TABLE, argv[2]);
+	nftnl_obj_set_str(t, NFTNL_OBJ_NAME, argv[3]);
+
+	return t;
+}
+
+int main(int argc, char *argv[])
+{
+	struct mnl_socket *nl;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	uint32_t portid, seq, obj_seq, family;
+	struct nftnl_obj *t;
+	struct mnl_nlmsg_batch *batch;
+	int ret;
+
+	if (argc != 4) {
+		fprintf(stderr, "%s <family> <table> <name>\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	t = obj_parse(argc, argv);
+	if (t == NULL)
+		exit(EXIT_FAILURE);
+
+	seq = time(NULL);
+	batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
+
+	nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+
+	obj_seq = seq;
+	family = nftnl_obj_get_u32(t, NFTNL_OBJ_FAMILY);
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+				    NFT_MSG_DELOBJ, family, NLM_F_ACK,
+				    seq++);
+	nftnl_obj_nlmsg_build_payload(nlh, t);
+	mnl_nlmsg_batch_next(batch);
+	nftnl_obj_free(t);
+
+	nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+
+	nl = mnl_socket_open(NETLINK_NETFILTER);
+	if (nl == NULL) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+	portid = mnl_socket_get_portid(nl);
+
+	if (mnl_socket_sendto(nl, mnl_nlmsg_batch_head(batch),
+			      mnl_nlmsg_batch_size(batch)) < 0) {
+		perror("mnl_socket_send");
+		exit(EXIT_FAILURE);
+	}
+
+	mnl_nlmsg_batch_stop(batch);
+
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	while (ret > 0) {
+		ret = mnl_cb_run(buf, ret, obj_seq, portid, NULL, NULL);
+		if (ret <= 0)
+			break;
+		ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	}
+	if (ret == -1) {
+		perror("error");
+		exit(EXIT_FAILURE);
+	}
+	mnl_socket_close(nl);
+
+	return EXIT_SUCCESS;
+}
diff --git a/examples/nft-ct-expectation-get.c b/examples/nft-ct-expectation-get.c
new file mode 100644
index 0000000..405ba9a
--- /dev/null
+++ b/examples/nft-ct-expectation-get.c
@@ -0,0 +1,144 @@
+/*
+ * (C) 2019 by Stéphane Veyret <sveyret@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <stdlib.h>
+#include <time.h>
+#include <string.h>
+#include <netinet/in.h>
+
+#include <linux/netfilter.h>
+#include <linux/netfilter/nf_tables.h>
+
+#include <libmnl/libmnl.h>
+#include <libnftnl/object.h>
+
+static uint16_t parse_family(char *str, const char *option)
+{
+	if (strcmp(str, "ip") == 0)
+		return NFPROTO_IPV4;
+	else if (strcmp(str, "ip6") == 0)
+		return NFPROTO_IPV6;
+	else if (strcmp(str, "inet") == 0)
+		return NFPROTO_INET;
+	else if (strcmp(str, "arp") == 0)
+		return NFPROTO_INET;
+	else {
+		fprintf(stderr, "Unknown %s: ip, ip6, inet, arp\n", option);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static struct nftnl_obj *obj_parse(int argc, char *argv[])
+{
+	struct nftnl_obj *t;
+	uint16_t family;
+
+	t = nftnl_obj_alloc();
+	if (t == NULL) {
+		perror("OOM");
+		return NULL;
+	}
+
+	family = parse_family(argv[1], "family");
+	nftnl_obj_set_u32(t, NFTNL_OBJ_FAMILY, family);
+	nftnl_obj_set_u32(t, NFTNL_OBJ_TYPE, NFT_OBJECT_CT_EXPECT);
+	nftnl_obj_set_str(t, NFTNL_OBJ_TABLE, argv[2]);
+
+	if (argc > 3)
+		nftnl_obj_set_str(t, NFTNL_OBJ_NAME, argv[3]);
+
+	return t;
+}
+
+static int obj_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nftnl_obj *t;
+	char buf[4096];
+	uint32_t *type = data;
+
+	t = nftnl_obj_alloc();
+	if (t == NULL) {
+		perror("OOM");
+		goto err;
+	}
+
+	if (nftnl_obj_nlmsg_parse(nlh, t) < 0) {
+		perror("nftnl_obj_nlmsg_parse");
+		goto err_free;
+	}
+
+	nftnl_obj_snprintf(buf, sizeof(buf), t, *type, 0);
+	printf("%s\n", buf);
+
+err_free:
+	nftnl_obj_free(t);
+err:
+	return MNL_CB_OK;
+}
+
+int main(int argc, char *argv[])
+{
+	struct mnl_socket *nl;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	uint32_t portid, seq, family;
+	struct nftnl_obj *t;
+	int ret;
+	uint32_t type = NFTNL_OUTPUT_DEFAULT;
+	uint16_t flags = NLM_F_ACK;
+
+	if (argc < 3 || argc > 4) {
+		fprintf(stderr, "%s <family> <table> [<name>]\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	t = obj_parse(argc, argv);
+	if (t == NULL)
+		exit(EXIT_FAILURE);
+	family = nftnl_obj_get_u32(t, NFTNL_OBJ_FAMILY);
+
+	seq = time(NULL);
+	if (argc < 4)
+		flags = NLM_F_DUMP;
+	nlh = nftnl_nlmsg_build_hdr(buf, NFT_MSG_GETOBJ, family, flags, seq);
+	nftnl_obj_nlmsg_build_payload(nlh, t);
+	nftnl_obj_free(t);
+
+	nl = mnl_socket_open(NETLINK_NETFILTER);
+	if (nl == NULL) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+	portid = mnl_socket_get_portid(nl);
+
+	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
+		perror("mnl_socket_send");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	while (ret > 0) {
+		ret = mnl_cb_run(buf, ret, seq, portid, obj_cb, &type);
+		if (ret <= 0)
+			break;
+		ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	}
+	if (ret == -1) {
+		perror("error");
+		exit(EXIT_FAILURE);
+	}
+	mnl_socket_close(nl);
+
+	return EXIT_SUCCESS;
+}
diff --git a/examples/nft-rule-ct-expectation-add.c b/examples/nft-rule-ct-expectation-add.c
new file mode 100644
index 0000000..794bb2c
--- /dev/null
+++ b/examples/nft-rule-ct-expectation-add.c
@@ -0,0 +1,163 @@
+/*
+ * (C) 2019 by Stéphane Veyret <sveyret@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <stdlib.h>
+#include <time.h>
+#include <string.h>
+#include <stddef.h>	/* for offsetof */
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <errno.h>
+
+#include <linux/netfilter.h>
+#include <linux/netfilter/nfnetlink.h>
+#include <linux/netfilter/nf_tables.h>
+
+#include <libmnl/libmnl.h>
+#include <libnftnl/rule.h>
+#include <libnftnl/expr.h>
+
+static uint16_t parse_family(char *str, const char *option)
+{
+	if (strcmp(str, "ip") == 0)
+		return NFPROTO_IPV4;
+	else if (strcmp(str, "ip6") == 0)
+		return NFPROTO_IPV6;
+	else if (strcmp(str, "inet") == 0)
+		return NFPROTO_INET;
+	else if (strcmp(str, "arp") == 0)
+		return NFPROTO_INET;
+	else {
+		fprintf(stderr, "Unknown %s: ip, ip6, inet, arp\n", option);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void add_ct_expect(struct nftnl_rule *r, const char *obj_name)
+{
+	struct nftnl_expr *e;
+
+	e = nftnl_expr_alloc("objref");
+	if (e == NULL) {
+		perror("expr objref oom");
+		exit(EXIT_FAILURE);
+	}
+	nftnl_expr_set_str(e, NFTNL_EXPR_OBJREF_IMM_NAME, obj_name);
+	nftnl_expr_set_u32(e, NFTNL_EXPR_OBJREF_IMM_TYPE, NFT_OBJECT_CT_EXPECT);
+
+	nftnl_rule_add_expr(r, e);
+}
+
+static struct nftnl_rule *setup_rule(uint8_t family, const char *table,
+				   const char *chain, const char *handle, const char *obj_name)
+{
+	struct nftnl_rule *r = NULL;
+	uint64_t handle_num;
+
+	r = nftnl_rule_alloc();
+	if (r == NULL) {
+		perror("OOM");
+		exit(EXIT_FAILURE);
+	}
+
+	nftnl_rule_set(r, NFTNL_RULE_TABLE, table);
+	nftnl_rule_set(r, NFTNL_RULE_CHAIN, chain);
+	nftnl_rule_set_u32(r, NFTNL_RULE_FAMILY, family);
+
+	if (handle != NULL) {
+		handle_num = atoll(handle);
+		nftnl_rule_set_u64(r, NFTNL_RULE_POSITION, handle_num);
+	}
+
+	add_ct_expect(r, obj_name);
+
+	return r;
+}
+
+int main(int argc, char *argv[])
+{
+	struct mnl_socket *nl;
+	struct nftnl_rule *r;
+	struct nlmsghdr *nlh;
+	struct mnl_nlmsg_batch *batch;
+	uint8_t family;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	uint32_t seq = time(NULL);
+	int ret;
+
+	if (argc < 5 || argc > 6) {
+		fprintf(stderr,
+			"Usage: %s <family> <table> <chain> [<handle>] <name>\n",
+			argv[0]);
+		exit(EXIT_FAILURE);
+	}
+	family = parse_family(argv[1], "family");
+
+	if (argc != 6)
+		r = setup_rule(family, argv[2], argv[3], NULL, argv[4]);
+	else
+		r = setup_rule(family, argv[2], argv[3], argv[4], argv[5]);
+
+	nl = mnl_socket_open(NETLINK_NETFILTER);
+	if (nl == NULL) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+
+	batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
+
+	nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+
+	nlh = nftnl_rule_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+		NFT_MSG_NEWRULE,
+		nftnl_rule_get_u32(r, NFTNL_RULE_FAMILY),
+		NLM_F_APPEND|NLM_F_CREATE|NLM_F_ACK, seq++);
+
+	nftnl_rule_nlmsg_build_payload(nlh, r);
+	nftnl_rule_free(r);
+	mnl_nlmsg_batch_next(batch);
+
+	nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+
+	ret = mnl_socket_sendto(nl, mnl_nlmsg_batch_head(batch),
+				mnl_nlmsg_batch_size(batch));
+	if (ret == -1) {
+		perror("mnl_socket_sendto");
+		exit(EXIT_FAILURE);
+	}
+
+	mnl_nlmsg_batch_stop(batch);
+
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	if (ret == -1) {
+		perror("mnl_socket_recvfrom");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mnl_cb_run(buf, ret, 0, mnl_socket_get_portid(nl), NULL, NULL);
+	if (ret < 0) {
+		perror("mnl_cb_run");
+		exit(EXIT_FAILURE);
+	}
+
+	mnl_socket_close(nl);
+
+	return EXIT_SUCCESS;
+}
-- 
2.21.0

