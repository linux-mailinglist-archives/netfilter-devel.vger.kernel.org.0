Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E646E9C6B
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Apr 2023 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDTTVu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Apr 2023 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjDTTVs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:21:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320A12717
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Apr 2023 12:21:45 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74dd7f52f18so313546485a.0
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Apr 2023 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682018504; x=1684610504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikAUUTkAjsIgsVi2OQ/n2YNQ7DxQJG/nlXdtv9jYb80=;
        b=q0Hq9n+qo4yNIqz1oyoDSYf+FGi79znCfsippcwekC0DOFO8IX220k41rVP8Q8n05G
         ldfud5N2SnVNv2LvJlFNmiSnrU7UgdggD15wsf0FAEpTMvc+LZEYskAVB6O1u+BUWfRA
         r+9UQQub6Q9/+0CPTP+Ru4wWyPA3tSbaHVg7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682018504; x=1684610504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikAUUTkAjsIgsVi2OQ/n2YNQ7DxQJG/nlXdtv9jYb80=;
        b=HOYHhAmgqruztyH+Vk7da85LpS2usM33d8TRNOXPoFluljKRjDrtQ7xI6eARNJXkIH
         VmmL6GgZvdShCPzGxt+ur0EzL483EYLjh+q9JUZJ4x+wnniqht9B3bdhuA6mwpeZAIeo
         GlY3vw4lqnAbHFGAON+do6l+GELbQmHPXlxrLPE9G8GMZZcm15BVsaYtBsjmVYTqB2Bv
         VnlT/eDbiIHM/qHGwct/bGwMGKwKIt+TevqComOiIjv34pxRIB+MkJLvxV40rL64MXAg
         OUcQzP18CaCoXk2xEh6j1JYDNbGNUCG46xCGcPWBHSTpr6KQ/7A7j0nsQYdOfHpKjJ9E
         vHQA==
X-Gm-Message-State: AAQBX9cDpRhQ8Xtw9NvQBnW7lCYJ6zadjGd03jwDnUR9xEhmBZ8RPPrt
        hpnhFStOIO3YPwHK4AVUPUVm4r+NitoZNABoNX7RYQ==
X-Google-Smtp-Source: AKy350bq/gw1aX3tssDy1YSbLGUR71MUlcazHFFwhJ+K8PBICRJZBM5CjuJzJHaIwTpuKGk3WaC6Dg==
X-Received: by 2002:a05:622a:406:b0:3ec:8c61:54d9 with SMTP id n6-20020a05622a040600b003ec8c6154d9mr5391545qtx.14.1682018504007;
        Thu, 20 Apr 2023 12:21:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-5-99-194.retail.telecomitalia.it. [87.5.99.194])
        by smtp.gmail.com with ESMTPSA id t10-20020a37460a000000b0074e17456a87sm667081qka.7.2023.04.20.12.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:21:43 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        dario.binacchi@amarulasolutions.com
Subject: [libmnl, PATCH] examples: add rtnl-link-can
Date:   Thu, 20 Apr 2023 21:21:15 +0200
Message-Id: <20230420192115.1953830-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I developed this application to test the Linux kernel series [1]. As
described in the cover letter I could not use the iproute2 package
since the microcontroller is without MMU.

On suggestion of the Linux CAN subsystem maintainer I decided to upstream
it.

cc: Marc Kleine-Budde <mkl@pengutronix.de>
[1] https://marc.info/?l=linux-netdev&m=167999323611710&w=2
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 examples/rtnl/Makefile.am     |   4 +
 examples/rtnl/rtnl-link-can.c | 451 ++++++++++++++++++++++++++++++++++
 2 files changed, 455 insertions(+)
 create mode 100644 examples/rtnl/rtnl-link-can.c

diff --git a/examples/rtnl/Makefile.am b/examples/rtnl/Makefile.am
index dd8a77d914b6..5a28e0965926 100644
--- a/examples/rtnl/Makefile.am
+++ b/examples/rtnl/Makefile.am
@@ -2,6 +2,7 @@ include $(top_srcdir)/Make_global.am
 
 check_PROGRAMS = rtnl-addr-add \
 		 rtnl-addr-dump \
+		 rtnl-link-can \
 		 rtnl-link-dump rtnl-link-dump2 rtnl-link-dump3 \
 		 rtnl-link-event \
 		 rtnl-link-set \
@@ -13,6 +14,9 @@ check_PROGRAMS = rtnl-addr-add \
 rtnl_addr_add_SOURCES = rtnl-addr-add.c
 rtnl_addr_add_LDADD = ../../src/libmnl.la
 
+rtnl_link_can_SOURCES = rtnl-link-can.c
+rtnl_link_can_LDADD = ../../src/libmnl.la
+
 rtnl_addr_dump_SOURCES = rtnl-addr-dump.c
 rtnl_addr_dump_LDADD = ../../src/libmnl.la
 
diff --git a/examples/rtnl/rtnl-link-can.c b/examples/rtnl/rtnl-link-can.c
new file mode 100644
index 000000000000..9245a27e482c
--- /dev/null
+++ b/examples/rtnl/rtnl-link-can.c
@@ -0,0 +1,451 @@
+/* This example is placed in the public domain. */
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+
+#include <libmnl/libmnl.h>
+#include <linux/can/netlink.h>
+#include <linux/if.h>
+#include <linux/if_link.h>
+#include <linux/rtnetlink.h>
+
+static void incomplete_command(void) __attribute__((noreturn));
+
+#define NEXT_ARG()				\
+	do { \
+		if (argc <= 0) incomplete_command();	\
+		argv++; \
+		argc--; \
+	} while (0)
+
+void duparg2(const char *key, const char *arg)
+{
+	fprintf(stderr,
+		"Error: either \"%s\" is duplicate, or \"%s\" is a garbage.\n",
+		key, arg);
+	exit(-1);
+}
+
+static void incomplete_command(void)
+{
+	fprintf(stderr, "Command line is not complete. Try option \"help\"\n");
+	exit(EXIT_FAILURE);
+}
+
+/* Returns false if 'prefix' is a not empty prefix of 'string'.
+ */
+static bool matches(const char *prefix, const char *string)
+{
+	if (!*prefix)
+		return true;
+
+	while (*string && *prefix == *string) {
+		prefix++;
+		string++;
+	}
+
+	return !!*prefix;
+}
+
+static int get_u16(__u16 *val, const char *arg, int base)
+{
+	unsigned long res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+
+	res = strtoul(arg, &ptr, base);
+
+	/* empty string or trailing non-digits */
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+
+	/* overflow */
+	if (res == ULONG_MAX && errno == ERANGE)
+		return -1;
+
+	if (res > 0xFFFFUL)
+		return -1;
+
+	*val = res;
+	return 0;
+}
+
+static int get_u32(__u32 *val, const char *arg, int base)
+{
+	unsigned long res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+
+	res = strtoul(arg, &ptr, base);
+
+	/* empty string or trailing non-digits */
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+
+	/* overflow */
+	if (res == ULONG_MAX && errno == ERANGE)
+		return -1;
+
+	/* in case UL > 32 bits */
+	if (res > 0xFFFFFFFFUL)
+		return -1;
+
+	*val = res;
+	return 0;
+}
+
+static int get_float(float *val, const char *arg)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+
+	*val = res;
+	return 0;
+}
+
+static void set_ctrlmode(char *name, char *arg,
+			 struct can_ctrlmode *cm, __u32 flags)
+{
+	if (strcmp(arg, "on") == 0) {
+		cm->flags |= flags;
+	} else if (strcmp(arg, "off") != 0) {
+		fprintf(stderr,
+			"Error: argument of \"%s\" must be \"on\" or \"off\", not \"%s\"\n",
+			name, arg);
+		exit(EXIT_FAILURE);
+	}
+
+	cm->mask |= flags;
+}
+
+static void invarg(const char *msg, const char *arg)
+{
+	fprintf(stderr, "Error: argument \"%s\" is wrong: %s\n", arg, msg);
+	exit(-1);
+}
+
+static void print_usage(FILE *f)
+{
+	fprintf(f,
+		"Usage: ip link set DEVICE type can\n"
+		"\t[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |\n"
+		"\t[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1\n \t  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]\n"
+		"\n"
+		"\t[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |\n"
+		"\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
+		"\n"
+		"\t[ loopback { on | off } ]\n"
+		"\t[ listen-only { on | off } ]\n"
+		"\t[ triple-sampling { on | off } ]\n"
+		"\t[ one-shot { on | off } ]\n"
+		"\t[ berr-reporting { on | off } ]\n"
+		"\t[ fd { on | off } ]\n"
+		"\t[ fd-non-iso { on | off } ]\n"
+		"\t[ presume-ack { on | off } ]\n"
+		"\t[ cc-len8-dlc { on | off } ]\n"
+		"\n"
+		"\t[ restart-ms TIME-MS ]\n"
+		"\t[ restart ]\n"
+		"\n"
+		"\t[ termination { 0..65535 } ]\n"
+		"\n"
+		"\tWhere: BITRATE	:= { 1..1000000 }\n"
+		"\t	  SAMPLE-POINT	:= { 0.000..0.999 }\n"
+		"\t	  TQ		:= { NUMBER }\n"
+		"\t	  PROP-SEG	:= { 1..8 }\n"
+		"\t	  PHASE-SEG1	:= { 1..8 }\n"
+		"\t	  PHASE-SEG2	:= { 1..8 }\n"
+		"\t	  SJW		:= { 1..4 }\n"
+		"\t	  RESTART-MS	:= { 0 | NUMBER }\n"
+		);
+}
+
+static void usage(void)
+{
+	print_usage(stderr);
+}
+
+static int iplink_set_can_parse(int argc, char **argv, struct nlmsghdr *nlh)
+{
+	struct can_bittiming bt = {}, dbt = {};
+	struct can_ctrlmode cm = {};
+
+	while (argc > 0) {
+		if (matches(*argv, "bitrate") == 0) {
+			NEXT_ARG();
+			if (get_u32(&bt.bitrate, *argv, 0))
+				invarg("invalid \"bitrate\" value\n", *argv);
+		} else if (matches(*argv, "sample-point") == 0) {
+			float sp;
+
+			NEXT_ARG();
+			if (get_float(&sp, *argv))
+				invarg("invalid \"sample-point\" value\n",
+				       *argv);
+
+			bt.sample_point = (__u32)(sp * 1000);
+		} else if (matches(*argv, "tq") == 0) {
+			NEXT_ARG();
+			if (get_u32(&bt.tq, *argv, 0))
+				invarg("invalid \"tq\" value\n", *argv);
+		} else if (matches(*argv, "prop-seg") == 0) {
+			NEXT_ARG();
+			if (get_u32(&bt.prop_seg, *argv, 0))
+				invarg("invalid \"prop-seg\" value\n", *argv);
+		} else if (matches(*argv, "phase-seg1") == 0) {
+			NEXT_ARG();
+			if (get_u32(&bt.phase_seg1, *argv, 0))
+				invarg("invalid \"phase-seg1\" value\n", *argv);
+		} else if (matches(*argv, "phase-seg2") == 0) {
+			NEXT_ARG();
+			if (get_u32(&bt.phase_seg2, *argv, 0))
+				invarg("invalid \"phase-seg2\" value\n", *argv);
+		} else if (matches(*argv, "sjw") == 0) {
+			NEXT_ARG();
+			if (get_u32(&bt.sjw, *argv, 0))
+				invarg("invalid \"sjw\" value\n", *argv);
+		} else if (matches(*argv, "dbitrate") == 0) {
+			NEXT_ARG();
+			if (get_u32(&dbt.bitrate, *argv, 0))
+				invarg("invalid \"dbitrate\" value\n", *argv);
+		} else if (matches(*argv, "dsample-point") == 0) {
+			float sp;
+
+			NEXT_ARG();
+			if (get_float(&sp, *argv))
+				invarg("invalid \"dsample-point\" value\n", *argv);
+			dbt.sample_point = (__u32)(sp * 1000);
+		} else if (matches(*argv, "dtq") == 0) {
+			NEXT_ARG();
+			if (get_u32(&dbt.tq, *argv, 0))
+				invarg("invalid \"dtq\" value\n", *argv);
+		} else if (matches(*argv, "dprop-seg") == 0) {
+			NEXT_ARG();
+			if (get_u32(&dbt.prop_seg, *argv, 0))
+				invarg("invalid \"dprop-seg\" value\n", *argv);
+		} else if (matches(*argv, "dphase-seg1") == 0) {
+			NEXT_ARG();
+			if (get_u32(&dbt.phase_seg1, *argv, 0))
+				invarg("invalid \"dphase-seg1\" value\n", *argv);
+		} else if (matches(*argv, "dphase-seg2") == 0) {
+			NEXT_ARG();
+			if (get_u32(&dbt.phase_seg2, *argv, 0))
+				invarg("invalid \"dphase-seg2\" value\n", *argv);
+		} else if (matches(*argv, "dsjw") == 0) {
+			NEXT_ARG();
+			if (get_u32(&dbt.sjw, *argv, 0))
+				invarg("invalid \"dsjw\" value\n", *argv);
+		} else if (matches(*argv, "loopback") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("loopback", *argv, &cm,
+				     CAN_CTRLMODE_LOOPBACK);
+		} else if (matches(*argv, "listen-only") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("listen-only", *argv, &cm,
+				     CAN_CTRLMODE_LISTENONLY);
+		} else if (matches(*argv, "triple-sampling") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("triple-sampling", *argv, &cm,
+				     CAN_CTRLMODE_3_SAMPLES);
+		} else if (matches(*argv, "one-shot") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("one-shot", *argv, &cm,
+				     CAN_CTRLMODE_ONE_SHOT);
+		} else if (matches(*argv, "berr-reporting") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("berr-reporting", *argv, &cm,
+				     CAN_CTRLMODE_BERR_REPORTING);
+		} else if (matches(*argv, "fd") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("fd", *argv, &cm,
+				     CAN_CTRLMODE_FD);
+		} else if (matches(*argv, "fd-non-iso") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("fd-non-iso", *argv, &cm,
+				     CAN_CTRLMODE_FD_NON_ISO);
+		} else if (matches(*argv, "presume-ack") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("presume-ack", *argv, &cm,
+				     CAN_CTRLMODE_PRESUME_ACK);
+#if defined(CAN_CTRLMODE_CC_LEN8_DLC)
+		} else if (matches(*argv, "cc-len8-dlc") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("cc-len8-dlc", *argv, &cm,
+				     CAN_CTRLMODE_CC_LEN8_DLC);
+#endif
+		} else if (matches(*argv, "restart") == 0) {
+			__u32 val = 1;
+
+			mnl_attr_put(nlh, IFLA_CAN_RESTART, sizeof(val), &val);
+		} else if (matches(*argv, "restart-ms") == 0) {
+			__u32 val;
+
+			NEXT_ARG();
+			if (get_u32(&val, *argv, 0))
+				invarg("invalid \"restart-ms\" value\n", *argv);
+
+			mnl_attr_put(nlh, IFLA_CAN_RESTART_MS, sizeof(val), &val);
+		} else if (matches(*argv, "termination") == 0) {
+			__u16 val;
+
+			NEXT_ARG();
+			if (get_u16(&val, *argv, 0))
+				invarg("invalid \"termination\" value\n",
+				       *argv);
+
+			mnl_attr_put(nlh, IFLA_CAN_TERMINATION, sizeof(val), &val);
+		} else {
+			fprintf(stderr, "unknown option \"%s\"\n", *argv);
+			usage();
+			return -1;
+		}
+
+		NEXT_ARG();
+	}
+
+	if (bt.bitrate || bt.tq)
+		mnl_attr_put(nlh, IFLA_CAN_BITTIMING, sizeof(bt), &bt);
+
+	if (cm.mask)
+		mnl_attr_put(nlh, IFLA_CAN_CTRLMODE, sizeof(cm), &cm);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct mnl_socket *nl;
+	struct nlmsghdr *nlh;
+	struct ifinfomsg *ifm;
+	int ret;
+	unsigned int seq, portid;
+	struct nlattr *linkinfo, *data;
+	const char *signatures[] = {
+		"ip", "link", "set", ""
+	};
+	char *type = NULL;
+	char *dev = NULL;
+	int i;
+
+	NEXT_ARG();
+	for (i = 0; argc > 0 && signatures[i][0];) {
+		if (matches(*argv, signatures[i]))
+			incomplete_command();
+
+		NEXT_ARG();
+		i++;
+	}
+
+	if (argc == 0)
+		incomplete_command();
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= RTM_NEWLINK;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	nlh->nlmsg_seq = seq = time(NULL);
+	ifm = mnl_nlmsg_put_extra_header(nlh, sizeof(*ifm));
+	ifm->ifi_family = AF_UNSPEC;
+	ifm->ifi_change = 0;
+	ifm->ifi_flags = 0;
+
+	while (argc > 0) {
+		if (matches(*argv, "up") == 0) {
+			ifm->ifi_change |= IFF_UP;
+			ifm->ifi_flags |= IFF_UP;
+		} else if (matches(*argv, "down") == 0) {
+			ifm->ifi_change |= IFF_UP;
+			ifm->ifi_flags &= ~IFF_UP;
+		} else if (matches(*argv, "type") == 0) {
+			NEXT_ARG();
+			type = *argv;
+			NEXT_ARG();
+			break;
+		} else if (matches(*argv, "help") == 0) {
+			usage();
+			exit(EXIT_FAILURE);
+		} else {
+			if (matches(*argv, "dev") == 0)
+				NEXT_ARG();
+
+			if (dev)
+				duparg2("dev", *argv);
+
+			dev = *argv;
+		}
+
+		NEXT_ARG();
+	}
+
+	if (dev)
+		mnl_attr_put_str(nlh, IFLA_IFNAME, dev);
+
+	if (type) {
+		if (matches(type, "can")) {
+			fprintf(stderr, "unknown type \"%s\"\n", type);
+			usage();
+			exit(EXIT_FAILURE);
+		}
+
+		linkinfo = mnl_attr_nest_start(nlh, IFLA_LINKINFO);
+		mnl_attr_put_str(nlh, IFLA_INFO_KIND, "can");
+		data = mnl_attr_nest_start(nlh, IFLA_INFO_DATA);
+
+		if (iplink_set_can_parse(argc, argv, nlh))
+			return -1;
+
+		mnl_attr_nest_end(nlh, data);
+		mnl_attr_nest_end(nlh, linkinfo);
+	}
+
+	nl = mnl_socket_open(NETLINK_ROUTE);
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
+	portid = mnl_socket_get_portid(nl);
+
+	mnl_nlmsg_fprintf(stdout, nlh, nlh->nlmsg_len,
+			  sizeof(struct ifinfomsg));
+
+	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
+		perror("mnl_socket_sendto");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+	if (ret == -1) {
+		perror("mnl_socket_recvfrom");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mnl_cb_run(buf, ret, seq, portid, NULL, NULL);
+	if (ret == -1) {
+		perror("mnl_cb_run");
+		exit(EXIT_FAILURE);
+	}
+
+	mnl_socket_close(nl);
+
+	return 0;
+}
-- 
2.32.0

