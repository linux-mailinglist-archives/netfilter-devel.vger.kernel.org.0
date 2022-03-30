Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934AF4EC8F8
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Mar 2022 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiC3QA6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Mar 2022 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347877AbiC3QA6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:00:58 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2720BD5
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Mar 2022 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Yb0bQEObbvFMgJtN9lLx5aEkoL/WQQyFl/fSw8cBPmM=; b=KwRst3GLptNPSvvwIkfwx3+vnA
        x4/xdTygPLNW+r3QdXq2fOzwZHBlJZm5RziOHWP/kZm4fN3OnOL4JSjmcnV50GU5oQOworP30H3rq
        q6DrAxArewmGLhNXhO1kmwHqYZJArXEK4p4I4LQYH7juQYL8+ZCQoaKipDk/4r+vusx6Wb65d6Tox
        8RfPUTzAVeV+pjwbtDO4i9xuRKUyWlqjadKthUiPK6el03lIoyjZmKwzBm+Cnv/Wwb34yb7j+lgGD
        TNTAddTOTgvrDKkIEPTnuPEArpmnlmu/TTthnj6TmkECZb0r/mr0OM8FnC2fgVxdyvvcf8wG8QCU2
        0yg9WNlg==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nZaiz-0004XH-HJ; Wed, 30 Mar 2022 17:59:09 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 8/9] extensions: Merge REDIRECT into DNAT
Date:   Wed, 30 Mar 2022 17:58:50 +0200
Message-Id: <20220330155851.13249-9-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330155851.13249-1-phil@nwl.cc>
References: <20220330155851.13249-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Code is very similar, join them to reuse parsing code at least.

As a side-effect, this enables parsing of service names for ports in
DNAT.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/GNUmakefile.in          |   4 +-
 extensions/libip6t_REDIRECT.c      | 170 ----------------------------
 extensions/libip6t_REDIRECT.t      |   6 -
 extensions/libip6t_REDIRECT.txlate |   5 -
 extensions/libipt_DNAT.t           |   2 +
 extensions/libipt_REDIRECT.c       | 174 -----------------------------
 extensions/libipt_REDIRECT.t       |   6 -
 extensions/libipt_REDIRECT.txlate  |   5 -
 extensions/libxt_DNAT.c            | 169 +++++++++++++++++++++++++---
 extensions/libxt_REDIRECT.t        |   9 ++
 extensions/libxt_REDIRECT.txlate   |  17 +++
 11 files changed, 186 insertions(+), 381 deletions(-)
 delete mode 100644 extensions/libip6t_REDIRECT.c
 delete mode 100644 extensions/libip6t_REDIRECT.t
 delete mode 100644 extensions/libip6t_REDIRECT.txlate
 delete mode 100644 extensions/libipt_REDIRECT.c
 delete mode 100644 extensions/libipt_REDIRECT.t
 delete mode 100644 extensions/libipt_REDIRECT.txlate
 create mode 100644 extensions/libxt_REDIRECT.t
 create mode 100644 extensions/libxt_REDIRECT.txlate

diff --git a/extensions/GNUmakefile.in b/extensions/GNUmakefile.in
index 956ccb38b2ab9..6dad4e02481bd 100644
--- a/extensions/GNUmakefile.in
+++ b/extensions/GNUmakefile.in
@@ -42,7 +42,7 @@ endif
 pfx_build_mod := $(patsubst ${srcdir}/libxt_%.c,%,$(sort $(wildcard ${srcdir}/libxt_*.c)))
 @ENABLE_NFTABLES_TRUE@ pfb_build_mod := $(patsubst ${srcdir}/libebt_%.c,%,$(sort $(wildcard ${srcdir}/libebt_*.c)))
 @ENABLE_NFTABLES_TRUE@ pfa_build_mod := $(patsubst ${srcdir}/libarpt_%.c,%,$(sort $(wildcard ${srcdir}/libarpt_*.c)))
-pfx_symlinks  := NOTRACK state
+pfx_symlinks  := NOTRACK state REDIRECT
 @ENABLE_IPV4_TRUE@ pf4_build_mod := $(patsubst ${srcdir}/libipt_%.c,%,$(sort $(wildcard ${srcdir}/libipt_*.c)))
 @ENABLE_IPV6_TRUE@ pf6_build_mod := $(patsubst ${srcdir}/libip6t_%.c,%,$(sort $(wildcard ${srcdir}/libip6t_*.c)))
 pfx_build_mod := $(filter-out @blacklist_modules@ @blacklist_x_modules@,${pfx_build_mod})
@@ -130,6 +130,8 @@ libxt_NOTRACK.so: libxt_CT.so
 	ln -fs $< $@
 libxt_state.so: libxt_conntrack.so
 	ln -fs $< $@
+libxt_REDIRECT.so: libxt_DNAT.so
+	ln -fs $< $@
 
 # Need the LIBADDs in iptables/Makefile.am too for libxtables_la_LIBADD
 xt_RATEEST_LIBADD   = -lm
diff --git a/extensions/libip6t_REDIRECT.c b/extensions/libip6t_REDIRECT.c
deleted file mode 100644
index 8e04d2cd33d50..0000000000000
--- a/extensions/libip6t_REDIRECT.c
+++ /dev/null
@@ -1,170 +0,0 @@
-/*
- * Copyright (c) 2011 Patrick McHardy <kaber@trash.net>
- *
- * Based on Rusty Russell's IPv4 REDIRECT target. Development of IPv6 NAT
- * funded by Astaro.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <xtables.h>
-#include <limits.h> /* INT_MAX in ip_tables.h */
-#include <linux/netfilter_ipv6/ip6_tables.h>
-#include <linux/netfilter/nf_nat.h>
-
-enum {
-	O_TO_PORTS = 0,
-	O_RANDOM,
-	F_TO_PORTS = 1 << O_TO_PORTS,
-	F_RANDOM   = 1 << O_RANDOM,
-};
-
-static void REDIRECT_help(void)
-{
-	printf(
-"REDIRECT target options:\n"
-" --to-ports <port>[-<port>]\n"
-"				Port (range) to map to.\n"
-" [--random]\n");
-}
-
-static const struct xt_option_entry REDIRECT_opts[] = {
-	{.name = "to-ports", .id = O_TO_PORTS, .type = XTTYPE_STRING},
-	{.name = "random", .id = O_RANDOM, .type = XTTYPE_NONE},
-	XTOPT_TABLEEND,
-};
-
-/* Parses ports */
-static void
-parse_ports(const char *arg, struct nf_nat_range *range)
-{
-	char *end = "";
-	unsigned int port, maxport;
-
-	range->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-
-	if (!xtables_strtoui(arg, &end, &port, 0, UINT16_MAX) &&
-	    (port = xtables_service_to_port(arg, NULL)) == (unsigned)-1)
-		xtables_param_act(XTF_BAD_VALUE, "REDIRECT", "--to-ports", arg);
-
-	switch (*end) {
-	case '\0':
-		range->min_proto.tcp.port
-			= range->max_proto.tcp.port
-			= htons(port);
-		return;
-	case '-':
-		if (!xtables_strtoui(end + 1, NULL, &maxport, 0, UINT16_MAX) &&
-		    (maxport = xtables_service_to_port(end + 1, NULL)) == (unsigned)-1)
-			break;
-
-		if (maxport < port)
-			break;
-
-		range->min_proto.tcp.port = htons(port);
-		range->max_proto.tcp.port = htons(maxport);
-		return;
-	default:
-		break;
-	}
-	xtables_param_act(XTF_BAD_VALUE, "REDIRECT", "--to-ports", arg);
-}
-
-static void REDIRECT_parse(struct xt_option_call *cb)
-{
-	const struct ip6t_entry *entry = cb->xt_entry;
-	struct nf_nat_range *range = (void *)(*cb->target)->data;
-	int portok;
-
-	if (entry->ipv6.proto == IPPROTO_TCP
-	    || entry->ipv6.proto == IPPROTO_UDP
-	    || entry->ipv6.proto == IPPROTO_SCTP
-	    || entry->ipv6.proto == IPPROTO_DCCP
-	    || entry->ipv6.proto == IPPROTO_ICMP)
-		portok = 1;
-	else
-		portok = 0;
-
-	xtables_option_parse(cb);
-	switch (cb->entry->id) {
-	case O_TO_PORTS:
-		if (!portok)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Need TCP, UDP, SCTP or DCCP with port specification");
-		parse_ports(cb->arg, range);
-		if (cb->xflags & F_RANDOM)
-			range->flags |= NF_NAT_RANGE_PROTO_RANDOM;
-		break;
-	case O_RANDOM:
-		if (cb->xflags & F_TO_PORTS)
-			range->flags |= NF_NAT_RANGE_PROTO_RANDOM;
-		break;
-	}
-}
-
-static void REDIRECT_print(const void *ip, const struct xt_entry_target *target,
-                           int numeric)
-{
-	const struct nf_nat_range *range = (const void *)target->data;
-
-	if (range->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		printf(" redir ports ");
-		printf("%hu", ntohs(range->min_proto.tcp.port));
-		if (range->max_proto.tcp.port != range->min_proto.tcp.port)
-			printf("-%hu", ntohs(range->max_proto.tcp.port));
-		if (range->flags & NF_NAT_RANGE_PROTO_RANDOM)
-			printf(" random");
-	}
-}
-
-static void REDIRECT_save(const void *ip, const struct xt_entry_target *target)
-{
-	const struct nf_nat_range *range = (const void *)target->data;
-
-	if (range->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		printf(" --to-ports ");
-		printf("%hu", ntohs(range->min_proto.tcp.port));
-		if (range->max_proto.tcp.port != range->min_proto.tcp.port)
-			printf("-%hu", ntohs(range->max_proto.tcp.port));
-		if (range->flags & NF_NAT_RANGE_PROTO_RANDOM)
-			printf(" --random");
-	}
-}
-
-static int REDIRECT_xlate(struct xt_xlate *xl,
-			  const struct xt_xlate_tg_params *params)
-{
-	const struct nf_nat_range *range = (const void *)params->target->data;
-
-	if (range->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		xt_xlate_add(xl, "redirect to :%hu",
-			   ntohs(range->min_proto.tcp.port));
-		if (range->max_proto.tcp.port != range->min_proto.tcp.port)
-			xt_xlate_add(xl, "-%hu ",
-				   ntohs(range->max_proto.tcp.port));
-		if (range->flags & NF_NAT_RANGE_PROTO_RANDOM)
-			xt_xlate_add(xl, " random ");
-	}
-
-	return 1;
-}
-
-static struct xtables_target redirect_tg_reg = {
-	.name		= "REDIRECT",
-	.version	= XTABLES_VERSION,
-	.family		= NFPROTO_IPV6,
-	.size		= XT_ALIGN(sizeof(struct nf_nat_range)),
-	.userspacesize	= XT_ALIGN(sizeof(struct nf_nat_range)),
-	.help		= REDIRECT_help,
-	.x6_parse	= REDIRECT_parse,
-	.print		= REDIRECT_print,
-	.save		= REDIRECT_save,
-	.x6_options	= REDIRECT_opts,
-	.xlate		= REDIRECT_xlate,
-};
-
-void _init(void)
-{
-	xtables_register_target(&redirect_tg_reg);
-}
diff --git a/extensions/libip6t_REDIRECT.t b/extensions/libip6t_REDIRECT.t
deleted file mode 100644
index a0fb0ed19a5ea..0000000000000
--- a/extensions/libip6t_REDIRECT.t
+++ /dev/null
@@ -1,6 +0,0 @@
-:PREROUTING,OUTPUT
-*nat
--p tcp -j REDIRECT --to-ports 42;=;OK
--p udp -j REDIRECT --to-ports 42-1234;=;OK
--p tcp -j REDIRECT --to-ports 42-1234 --random;=;OK
--j REDIRECT --to-ports 42;;FAIL
diff --git a/extensions/libip6t_REDIRECT.txlate b/extensions/libip6t_REDIRECT.txlate
deleted file mode 100644
index 209f67a4235f9..0000000000000
--- a/extensions/libip6t_REDIRECT.txlate
+++ /dev/null
@@ -1,5 +0,0 @@
-ip6tables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080
-nft add rule ip6 nat prerouting tcp dport 80 counter redirect to :8080
-
-ip6tables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080 --random
-nft add rule ip6 nat prerouting tcp dport 80 counter redirect to :8080 random
diff --git a/extensions/libipt_DNAT.t b/extensions/libipt_DNAT.t
index 1c4413b9b3bb5..eb187bc91053b 100644
--- a/extensions/libipt_DNAT.t
+++ b/extensions/libipt_DNAT.t
@@ -13,4 +13,6 @@
 -p tcp -j DNAT --to-destination 1.1.1.1:1000-2000/65535;=;OK
 -p tcp -j DNAT --to-destination 1.1.1.1:1000-2000/0;;FAIL
 -p tcp -j DNAT --to-destination 1.1.1.1:1000-2000/65536;;FAIL
+-p tcp -j DNAT --to-destination 1.1.1.1:ssh;-p tcp -j DNAT --to-destination 1.1.1.1:22;OK
+-p tcp -j DNAT --to-destination 1.1.1.1:ftp-data;-p tcp -j DNAT --to-destination 1.1.1.1:20;OK
 -j DNAT;;FAIL
diff --git a/extensions/libipt_REDIRECT.c b/extensions/libipt_REDIRECT.c
deleted file mode 100644
index 7850306f5fe25..0000000000000
--- a/extensions/libipt_REDIRECT.c
+++ /dev/null
@@ -1,174 +0,0 @@
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <xtables.h>
-#include <limits.h> /* INT_MAX in ip_tables.h */
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter/nf_nat.h>
-
-enum {
-	O_TO_PORTS = 0,
-	O_RANDOM,
-	F_TO_PORTS = 1 << O_TO_PORTS,
-	F_RANDOM   = 1 << O_RANDOM,
-};
-
-static void REDIRECT_help(void)
-{
-	printf(
-"REDIRECT target options:\n"
-" --to-ports <port>[-<port>]\n"
-"				Port (range) to map to.\n"
-" [--random]\n");
-}
-
-static const struct xt_option_entry REDIRECT_opts[] = {
-	{.name = "to-ports", .id = O_TO_PORTS, .type = XTTYPE_STRING},
-	{.name = "random", .id = O_RANDOM, .type = XTTYPE_NONE},
-	XTOPT_TABLEEND,
-};
-
-static void REDIRECT_init(struct xt_entry_target *t)
-{
-	struct nf_nat_ipv4_multi_range_compat *mr = (struct nf_nat_ipv4_multi_range_compat *)t->data;
-
-	/* Actually, it's 0, but it's ignored at the moment. */
-	mr->rangesize = 1;
-}
-
-/* Parses ports */
-static void
-parse_ports(const char *arg, struct nf_nat_ipv4_multi_range_compat *mr)
-{
-	char *end = "";
-	unsigned int port, maxport;
-
-	mr->range[0].flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-
-	if (!xtables_strtoui(arg, &end, &port, 0, UINT16_MAX) &&
-	    (port = xtables_service_to_port(arg, NULL)) == (unsigned)-1)
-		xtables_param_act(XTF_BAD_VALUE, "REDIRECT", "--to-ports", arg);
-
-	switch (*end) {
-	case '\0':
-		mr->range[0].min.tcp.port
-			= mr->range[0].max.tcp.port
-			= htons(port);
-		return;
-	case '-':
-		if (!xtables_strtoui(end + 1, NULL, &maxport, 0, UINT16_MAX) &&
-		    (maxport = xtables_service_to_port(end + 1, NULL)) == (unsigned)-1)
-			break;
-
-		if (maxport < port)
-			break;
-
-		mr->range[0].min.tcp.port = htons(port);
-		mr->range[0].max.tcp.port = htons(maxport);
-		return;
-	default:
-		break;
-	}
-	xtables_param_act(XTF_BAD_VALUE, "REDIRECT", "--to-ports", arg);
-}
-
-static void REDIRECT_parse(struct xt_option_call *cb)
-{
-	const struct ipt_entry *entry = cb->xt_entry;
-	struct nf_nat_ipv4_multi_range_compat *mr = (void *)(*cb->target)->data;
-	int portok;
-
-	if (entry->ip.proto == IPPROTO_TCP
-	    || entry->ip.proto == IPPROTO_UDP
-	    || entry->ip.proto == IPPROTO_SCTP
-	    || entry->ip.proto == IPPROTO_DCCP
-	    || entry->ip.proto == IPPROTO_ICMP)
-		portok = 1;
-	else
-		portok = 0;
-
-	xtables_option_parse(cb);
-	switch (cb->entry->id) {
-	case O_TO_PORTS:
-		if (!portok)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Need TCP, UDP, SCTP or DCCP with port specification");
-		parse_ports(cb->arg, mr);
-		if (cb->xflags & F_RANDOM)
-			mr->range[0].flags |= NF_NAT_RANGE_PROTO_RANDOM;
-		break;
-	case O_RANDOM:
-		if (cb->xflags & F_TO_PORTS)
-			mr->range[0].flags |= NF_NAT_RANGE_PROTO_RANDOM;
-		break;
-	}
-}
-
-static void REDIRECT_print(const void *ip, const struct xt_entry_target *target,
-                           int numeric)
-{
-	const struct nf_nat_ipv4_multi_range_compat *mr = (const void *)target->data;
-	const struct nf_nat_ipv4_range *r = &mr->range[0];
-
-	if (r->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		printf(" redir ports ");
-		printf("%hu", ntohs(r->min.tcp.port));
-		if (r->max.tcp.port != r->min.tcp.port)
-			printf("-%hu", ntohs(r->max.tcp.port));
-		if (mr->range[0].flags & NF_NAT_RANGE_PROTO_RANDOM)
-			printf(" random");
-	}
-}
-
-static void REDIRECT_save(const void *ip, const struct xt_entry_target *target)
-{
-	const struct nf_nat_ipv4_multi_range_compat *mr = (const void *)target->data;
-	const struct nf_nat_ipv4_range *r = &mr->range[0];
-
-	if (r->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		printf(" --to-ports ");
-		printf("%hu", ntohs(r->min.tcp.port));
-		if (r->max.tcp.port != r->min.tcp.port)
-			printf("-%hu", ntohs(r->max.tcp.port));
-		if (mr->range[0].flags & NF_NAT_RANGE_PROTO_RANDOM)
-			printf(" --random");
-	}
-}
-
-static int REDIRECT_xlate(struct xt_xlate *xl,
-			  const struct xt_xlate_tg_params *params)
-{
-	const struct nf_nat_ipv4_multi_range_compat *mr =
-		(const void *)params->target->data;
-	const struct nf_nat_ipv4_range *r = &mr->range[0];
-
-	if (r->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		xt_xlate_add(xl, "redirect to :%hu", ntohs(r->min.tcp.port));
-		if (r->max.tcp.port != r->min.tcp.port)
-			xt_xlate_add(xl, "-%hu ", ntohs(r->max.tcp.port));
-		if (mr->range[0].flags & NF_NAT_RANGE_PROTO_RANDOM)
-			xt_xlate_add(xl, " random ");
-	}
-
-	return 1;
-}
-
-static struct xtables_target redirect_tg_reg = {
-	.name		= "REDIRECT",
-	.version	= XTABLES_VERSION,
-	.family		= NFPROTO_IPV4,
-	.size		= XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compat)),
-	.userspacesize	= XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compat)),
-	.help		= REDIRECT_help,
-	.init		= REDIRECT_init,
- 	.x6_parse	= REDIRECT_parse,
-	.print		= REDIRECT_print,
-	.save		= REDIRECT_save,
-	.x6_options	= REDIRECT_opts,
-	.xlate		= REDIRECT_xlate,
-};
-
-void _init(void)
-{
-	xtables_register_target(&redirect_tg_reg);
-}
diff --git a/extensions/libipt_REDIRECT.t b/extensions/libipt_REDIRECT.t
deleted file mode 100644
index a0fb0ed19a5ea..0000000000000
--- a/extensions/libipt_REDIRECT.t
+++ /dev/null
@@ -1,6 +0,0 @@
-:PREROUTING,OUTPUT
-*nat
--p tcp -j REDIRECT --to-ports 42;=;OK
--p udp -j REDIRECT --to-ports 42-1234;=;OK
--p tcp -j REDIRECT --to-ports 42-1234 --random;=;OK
--j REDIRECT --to-ports 42;;FAIL
diff --git a/extensions/libipt_REDIRECT.txlate b/extensions/libipt_REDIRECT.txlate
deleted file mode 100644
index 815bb7714138d..0000000000000
--- a/extensions/libipt_REDIRECT.txlate
+++ /dev/null
@@ -1,5 +0,0 @@
-iptables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080
-nft add rule ip nat prerouting tcp dport 80 counter redirect to :8080
-
-iptables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080 --random
-nft add rule ip nat prerouting tcp dport 80 counter redirect to :8080 random
diff --git a/extensions/libxt_DNAT.c b/extensions/libxt_DNAT.c
index 83ff95b0013c7..754e244e0dbe6 100644
--- a/extensions/libxt_DNAT.c
+++ b/extensions/libxt_DNAT.c
@@ -28,10 +28,12 @@
 
 enum {
 	O_TO_DEST = 0,
+	O_TO_PORTS,
 	O_RANDOM,
 	O_PERSISTENT,
-	F_TO_DEST = 1 << O_TO_DEST,
-	F_RANDOM  = 1 << O_RANDOM,
+	F_TO_DEST  = 1 << O_TO_DEST,
+	F_TO_PORTS = 1 << O_TO_PORTS,
+	F_RANDOM   = 1 << O_RANDOM,
 };
 
 static void DNAT_help(void)
@@ -52,6 +54,15 @@ static void DNAT_help_v2(void)
 "[--random] [--persistent]\n");
 }
 
+static void REDIRECT_help(void)
+{
+	printf(
+"REDIRECT target options:\n"
+" --to-ports <port>[-<port>]\n"
+"				Port (range) to map to.\n"
+" [--random]\n");
+}
+
 static const struct xt_option_entry DNAT_opts[] = {
 	{.name = "to-destination", .id = O_TO_DEST, .type = XTTYPE_STRING,
 	 .flags = XTOPT_MAND},
@@ -60,6 +71,12 @@ static const struct xt_option_entry DNAT_opts[] = {
 	XTOPT_TABLEEND,
 };
 
+static const struct xt_option_entry REDIRECT_opts[] = {
+	{.name = "to-ports", .id = O_TO_PORTS, .type = XTTYPE_STRING},
+	{.name = "random", .id = O_RANDOM, .type = XTTYPE_NONE},
+	XTOPT_TABLEEND,
+};
+
 /* Parses ports */
 static void
 parse_ports(const char *arg, bool portok, struct nf_nat_range2 *range)
@@ -73,9 +90,12 @@ parse_ports(const char *arg, bool portok, struct nf_nat_range2 *range)
 
 	range->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 
-	if (!xtables_strtoui(arg, &end, &port, 1, UINT16_MAX))
-		xtables_error(PARAMETER_PROBLEM,
-			      "Port `%s' not valid", arg);
+	if (!xtables_strtoui(arg, &end, &port, 1, UINT16_MAX)) {
+		port = xtables_service_to_port(arg, NULL);
+		if (port == (unsigned)-1)
+			xtables_error(PARAMETER_PROBLEM,
+				      "Port `%s' not valid", arg);
+	}
 
 	switch (*end) {
 	case '\0':
@@ -94,10 +114,12 @@ parse_ports(const char *arg, bool portok, struct nf_nat_range2 *range)
 			      "Garbage after port value: `%s'", end);
 	}
 
-	if (!xtables_strtoui(arg, &end, &maxport, 1, UINT16_MAX))
-		xtables_error(PARAMETER_PROBLEM,
-			      "Port `%s' not valid", arg);
-
+	if (!xtables_strtoui(arg, &end, &maxport, 1, UINT16_MAX)) {
+		maxport = xtables_service_to_port(arg, NULL);
+		if (maxport == (unsigned)-1)
+			xtables_error(PARAMETER_PROBLEM,
+				      "Port `%s' not valid", arg);
+	}
 	if (maxport < port)
 		/* People are stupid. */
 		xtables_error(PARAMETER_PROBLEM,
@@ -117,9 +139,12 @@ parse_ports(const char *arg, bool portok, struct nf_nat_range2 *range)
 			      "Garbage after port range: `%s'", end);
 	}
 
-	if (!xtables_strtoui(arg, &end, &baseport, 1, UINT16_MAX))
-		xtables_error(PARAMETER_PROBLEM,
-			      "Port `%s' not valid", arg);
+	if (!xtables_strtoui(arg, &end, &baseport, 1, UINT16_MAX)) {
+		baseport = xtables_service_to_port(arg, NULL);
+		if (baseport == (unsigned)-1)
+			xtables_error(PARAMETER_PROBLEM,
+				      "Port `%s' not valid", arg);
+	}
 
 	range->flags |= NF_NAT_RANGE_PROTO_OFFSET;
 	range->base_proto.tcp.port = htons(baseport);
@@ -199,6 +224,9 @@ static void __DNAT_parse(struct xt_option_call *cb, __u16 proto,
 	case O_TO_DEST:
 		parse_to(cb->arg, portok, range, family);
 		break;
+	case O_TO_PORTS:
+		parse_ports(cb->arg, portok, range);
+		break;
 	case O_PERSISTENT:
 		range->flags |= NF_NAT_RANGE_PERSISTENT;
 		break;
@@ -217,6 +245,8 @@ static void DNAT_parse(struct xt_option_call *cb)
 	case O_TO_DEST:
 		mr->range->min_ip = range.min_addr.ip;
 		mr->range->max_ip = range.max_addr.ip;
+		/* fall through */
+	case O_TO_PORTS:
 		mr->range->min = range.min_proto;
 		mr->range->max = range.max_proto;
 		/* fall through */
@@ -228,9 +258,13 @@ static void DNAT_parse(struct xt_option_call *cb)
 
 static void __DNAT_fcheck(struct xt_fcheck_call *cb, unsigned int *flags)
 {
-	static const unsigned int f = F_TO_DEST | F_RANDOM;
+	static const unsigned int redir_f = F_TO_PORTS | F_RANDOM;
+	static const unsigned int dnat_f = F_TO_DEST | F_RANDOM;
+
 
-	if ((cb->xflags & f) == f)
+
+	if ((cb->xflags & redir_f) == redir_f ||
+	    (cb->xflags & dnat_f) == dnat_f)
 		*flags |= NF_NAT_RANGE_PROTO_RANDOM;
 }
 
@@ -441,6 +475,84 @@ static int DNAT_xlate6_v2(struct xt_xlate *xl,
 	return __DNAT_xlate(xl, (const void *)params->target->data, AF_INET6);
 }
 
+static void __REDIRECT_print(const struct nf_nat_range2 *range, bool save)
+{
+	char *range_str = sprint_range(range, AF_INET);
+	const char *dashdash = save ? "--" : "";
+
+	if (strlen(range_str))
+		/* range_str starts with colon, skip over them */
+		printf(" %s %s", save ? "--to-ports" : "redir ports",
+		       range_str + 1);
+	if (range->flags & NF_NAT_RANGE_PROTO_RANDOM)
+		printf(" %srandom", dashdash);
+}
+
+static int __REDIRECT_xlate(struct xt_xlate *xl,
+			    const struct nf_nat_range2 *range)
+{
+	char *range_str = sprint_range(range, AF_INET);
+
+	xt_xlate_add(xl, "redirect");
+	if (strlen(range_str))
+		xt_xlate_add(xl, " to %s", range_str);
+	if (range->flags & NF_NAT_RANGE_PROTO_RANDOM)
+		xt_xlate_add(xl, " random");
+
+	return 1;
+}
+
+static void REDIRECT_print(const void *ip, const struct xt_entry_target *target,
+                           int numeric)
+{
+	struct nf_nat_range2 range = RANGE2_INIT_FROM_IPV4_MRC(target->data);
+
+	__REDIRECT_print(&range, false);
+}
+
+static void REDIRECT_save(const void *ip, const struct xt_entry_target *target)
+{
+	struct nf_nat_range2 range = RANGE2_INIT_FROM_IPV4_MRC(target->data);
+
+	__REDIRECT_print(&range, true);
+}
+
+static int REDIRECT_xlate(struct xt_xlate *xl,
+			   const struct xt_xlate_tg_params *params)
+{
+	struct nf_nat_range2 range =
+		RANGE2_INIT_FROM_IPV4_MRC(params->target->data);
+
+	return __REDIRECT_xlate(xl, &range);
+}
+
+static void REDIRECT_print6(const void *ip, const struct xt_entry_target *target,
+                            int numeric)
+{
+	struct nf_nat_range2 range = {};
+
+	memcpy(&range, (const void *)target->data, sizeof(struct nf_nat_range));
+	__REDIRECT_print(&range, false);
+}
+
+static void REDIRECT_save6(const void *ip, const struct xt_entry_target *target)
+{
+	struct nf_nat_range2 range = {};
+
+	memcpy(&range, (const void *)target->data, sizeof(struct nf_nat_range));
+	__REDIRECT_print(&range, true);
+}
+
+static int REDIRECT_xlate6(struct xt_xlate *xl,
+			   const struct xt_xlate_tg_params *params)
+{
+	struct nf_nat_range2 range = {};
+
+	memcpy(&range, (const void *)params->target->data,
+	       sizeof(struct nf_nat_range));
+	return __REDIRECT_xlate(xl, &range);
+}
+
 static struct xtables_target dnat_tg_reg[] = {
 	{
 		.name		= "DNAT",
@@ -457,6 +569,21 @@ static struct xtables_target dnat_tg_reg[] = {
 		.x6_options	= DNAT_opts,
 		.xlate		= DNAT_xlate,
 	},
+	{
+		.name		= "REDIRECT",
+		.version	= XTABLES_VERSION,
+		.family		= NFPROTO_IPV4,
+		.revision	= 0,
+		.size		= XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compat)),
+		.userspacesize	= XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compat)),
+		.help		= REDIRECT_help,
+		.print		= REDIRECT_print,
+		.save		= REDIRECT_save,
+		.x6_parse	= DNAT_parse,
+		.x6_fcheck	= DNAT_fcheck,
+		.x6_options	= REDIRECT_opts,
+		.xlate		= REDIRECT_xlate,
+	},
 	{
 		.name		= "DNAT",
 		.version	= XTABLES_VERSION,
@@ -472,6 +599,20 @@ static struct xtables_target dnat_tg_reg[] = {
 		.x6_options	= DNAT_opts,
 		.xlate		= DNAT_xlate6,
 	},
+	{
+		.name		= "REDIRECT",
+		.version	= XTABLES_VERSION,
+		.family		= NFPROTO_IPV6,
+		.size		= XT_ALIGN(sizeof(struct nf_nat_range)),
+		.userspacesize	= XT_ALIGN(sizeof(struct nf_nat_range)),
+		.help		= REDIRECT_help,
+		.print		= REDIRECT_print6,
+		.save		= REDIRECT_save6,
+		.x6_parse	= DNAT_parse6,
+		.x6_fcheck	= DNAT_fcheck6,
+		.x6_options	= REDIRECT_opts,
+		.xlate		= REDIRECT_xlate6,
+	},
 	{
 		.name		= "DNAT",
 		.version	= XTABLES_VERSION,
diff --git a/extensions/libxt_REDIRECT.t b/extensions/libxt_REDIRECT.t
new file mode 100644
index 0000000000000..3f0b8a6000445
--- /dev/null
+++ b/extensions/libxt_REDIRECT.t
@@ -0,0 +1,9 @@
+:PREROUTING,OUTPUT
+*nat
+-p tcp -j REDIRECT --to-ports 42;=;OK
+-p udp -j REDIRECT --to-ports 42-1234;=;OK
+-p tcp -j REDIRECT --to-ports 42-1234 --random;=;OK
+-p tcp -j REDIRECT --to-ports 42-1234/567;;FAIL
+-p tcp -j REDIRECT --to-ports ssh;-p tcp -j REDIRECT --to-ports 22;OK
+-p tcp -j REDIRECT --to-ports ftp-data;-p tcp -j REDIRECT --to-ports 20;OK
+-j REDIRECT --to-ports 42;;FAIL
diff --git a/extensions/libxt_REDIRECT.txlate b/extensions/libxt_REDIRECT.txlate
new file mode 100644
index 0000000000000..c7375c614f50a
--- /dev/null
+++ b/extensions/libxt_REDIRECT.txlate
@@ -0,0 +1,17 @@
+iptables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT
+nft add rule ip nat prerouting tcp dport 80 counter redirect
+
+iptables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080
+nft add rule ip nat prerouting tcp dport 80 counter redirect to :8080
+
+iptables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080 --random
+nft add rule ip nat prerouting tcp dport 80 counter redirect to :8080 random
+
+ip6tables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT
+nft add rule ip6 nat prerouting tcp dport 80 counter redirect
+
+ip6tables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080
+nft add rule ip6 nat prerouting tcp dport 80 counter redirect to :8080
+
+ip6tables-translate -t nat -A prerouting -p tcp --dport 80 -j REDIRECT --to-ports 8080 --random
+nft add rule ip6 nat prerouting tcp dport 80 counter redirect to :8080 random
-- 
2.34.1

