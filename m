Return-Path: <netfilter-devel+bounces-482-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFA81C983
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Dec 2023 12:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FBF28414B
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Dec 2023 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57D1D554;
	Fri, 22 Dec 2023 11:57:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840C18B19;
	Fri, 22 Dec 2023 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 7/8] netfilter: ctnetlink: support filtering by zone
Date: Fri, 22 Dec 2023 12:57:13 +0100
Message-Id: <20231222115714.364393-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222115714.364393-1-pablo@netfilter.org>
References: <20231222115714.364393-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Huettner <felix.huettner@mail.schwarz>

conntrack zones are heavily used by tools like openvswitch to run
multiple virtual "routers" on a single machine. In this context each
conntrack zone matches to a single router, thereby preventing
overlapping IPs from becoming issues.
In these systems it is common to operate on all conntrack entries of a
given zone, e.g. to delete them when a router is deleted. Previously this
required these tools to dump the full conntrack table and filter out the
relevant entries in userspace potentially causing performance issues.

To do this we reuse the existing CTA_ZONE attribute. This was previous
parsed but not used during dump and flush requests. Now if CTA_ZONE is
set we filter these operations based on the provided zone.
However this means that users that previously passed CTA_ZONE will
experience a difference in functionality.

Alternatively CTA_FILTER could have been used for the same
functionality. However it is not yet supported during flush requests and
is only available when using AF_INET or AF_INET6.

Co-developed-by: Luca Czesla <luca.czesla@mail.schwarz>
Signed-off-by: Luca Czesla <luca.czesla@mail.schwarz>
Co-developed-by: Max Lamprecht <max.lamprecht@mail.schwarz>
Signed-off-by: Max Lamprecht <max.lamprecht@mail.schwarz>
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_netlink.c          |  12 +-
 tools/testing/selftests/netfilter/.gitignore  |   2 +
 tools/testing/selftests/netfilter/Makefile    |   3 +-
 .../netfilter/conntrack_dump_flush.c          | 430 ++++++++++++++++++
 4 files changed, 442 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/netfilter/conntrack_dump_flush.c

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index fb0ae15e96df..0c22a02c2035 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -992,13 +992,13 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 	if (err)
 		goto err_filter;
 
-	if (!cda[CTA_FILTER])
-		return filter;
-
 	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
 	if (err < 0)
 		goto err_filter;
 
+	if (!cda[CTA_FILTER])
+		return filter;
+
 	err = ctnetlink_parse_filter(cda[CTA_FILTER], filter);
 	if (err < 0)
 		goto err_filter;
@@ -1043,7 +1043,7 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 
 static bool ctnetlink_needs_filter(u8 family, const struct nlattr * const *cda)
 {
-	return family || cda[CTA_MARK] || cda[CTA_FILTER] || cda[CTA_STATUS];
+	return family || cda[CTA_MARK] || cda[CTA_FILTER] || cda[CTA_STATUS] || cda[CTA_ZONE];
 }
 
 static int ctnetlink_start(struct netlink_callback *cb)
@@ -1148,6 +1148,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	if (filter->family && nf_ct_l3num(ct) != filter->family)
 		goto ignore_entry;
 
+	if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
+	    !nf_ct_zone_equal_any(ct, &filter->zone))
+		goto ignore_entry;
+
 	if (filter->orig_flags) {
 		tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
 		if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/selftests/netfilter/.gitignore
index 4b2928e1c19d..c2229b3e40d4 100644
--- a/tools/testing/selftests/netfilter/.gitignore
+++ b/tools/testing/selftests/netfilter/.gitignore
@@ -2,3 +2,5 @@
 nf-queue
 connect_close
 audit_logread
+conntrack_dump_flush
+sctp_collision
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index bced422b78f7..db27153eb4a0 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -14,6 +14,7 @@ HOSTPKG_CONFIG := pkg-config
 CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
 LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
-TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision
+TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision \
+	conntrack_dump_flush
 
 include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
new file mode 100644
index 000000000000..f18c6db13bbf
--- /dev/null
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <time.h>
+#include <libmnl/libmnl.h>
+#include <netinet/ip.h>
+
+#include <linux/netlink.h>
+#include <linux/netfilter/nfnetlink.h>
+#include <linux/netfilter/nfnetlink_conntrack.h>
+#include <linux/netfilter/nf_conntrack_tcp.h>
+#include "../kselftest_harness.h"
+
+#define TEST_ZONE_ID 123
+#define CTA_FILTER_F_CTA_TUPLE_ZONE (1 << 2)
+
+static int reply_counter;
+
+static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
+			      uint32_t src_ip, uint32_t dst_ip,
+			      uint16_t src_port, uint16_t dst_port)
+{
+	struct nlattr *nest, *nest_ip, *nest_proto;
+
+	nest = mnl_attr_nest_start(nlh, type);
+	if (!nest)
+		return -1;
+
+	nest_ip = mnl_attr_nest_start(nlh, CTA_TUPLE_IP);
+	if (!nest_ip)
+		return -1;
+	mnl_attr_put_u32(nlh, CTA_IP_V4_SRC, src_ip);
+	mnl_attr_put_u32(nlh, CTA_IP_V4_DST, dst_ip);
+	mnl_attr_nest_end(nlh, nest_ip);
+
+	nest_proto = mnl_attr_nest_start(nlh, CTA_TUPLE_PROTO);
+	if (!nest_proto)
+		return -1;
+	mnl_attr_put_u8(nlh, CTA_PROTO_NUM, 6);
+	mnl_attr_put_u16(nlh, CTA_PROTO_SRC_PORT, htons(src_port));
+	mnl_attr_put_u16(nlh, CTA_PROTO_DST_PORT, htons(dst_port));
+	mnl_attr_nest_end(nlh, nest_proto);
+
+	mnl_attr_nest_end(nlh, nest);
+}
+
+static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
+			      struct in6_addr src_ip, struct in6_addr dst_ip,
+			      uint16_t src_port, uint16_t dst_port)
+{
+	struct nlattr *nest, *nest_ip, *nest_proto;
+
+	nest = mnl_attr_nest_start(nlh, type);
+	if (!nest)
+		return -1;
+
+	nest_ip = mnl_attr_nest_start(nlh, CTA_TUPLE_IP);
+	if (!nest_ip)
+		return -1;
+	mnl_attr_put(nlh, CTA_IP_V6_SRC, sizeof(struct in6_addr), &src_ip);
+	mnl_attr_put(nlh, CTA_IP_V6_DST, sizeof(struct in6_addr), &dst_ip);
+	mnl_attr_nest_end(nlh, nest_ip);
+
+	nest_proto = mnl_attr_nest_start(nlh, CTA_TUPLE_PROTO);
+	if (!nest_proto)
+		return -1;
+	mnl_attr_put_u8(nlh, CTA_PROTO_NUM, 6);
+	mnl_attr_put_u16(nlh, CTA_PROTO_SRC_PORT, htons(src_port));
+	mnl_attr_put_u16(nlh, CTA_PROTO_DST_PORT, htons(dst_port));
+	mnl_attr_nest_end(nlh, nest_proto);
+
+	mnl_attr_nest_end(nlh, nest);
+}
+
+static int build_cta_proto(struct nlmsghdr *nlh)
+{
+	struct nlattr *nest, *nest_proto;
+
+	nest = mnl_attr_nest_start(nlh, CTA_PROTOINFO);
+	if (!nest)
+		return -1;
+
+	nest_proto = mnl_attr_nest_start(nlh, CTA_PROTOINFO_TCP);
+	if (!nest_proto)
+		return -1;
+	mnl_attr_put_u8(nlh, CTA_PROTOINFO_TCP_STATE, TCP_CONNTRACK_ESTABLISHED);
+	mnl_attr_put_u16(nlh, CTA_PROTOINFO_TCP_FLAGS_ORIGINAL, 0x0a0a);
+	mnl_attr_put_u16(nlh, CTA_PROTOINFO_TCP_FLAGS_REPLY, 0x0a0a);
+	mnl_attr_nest_end(nlh, nest_proto);
+
+	mnl_attr_nest_end(nlh, nest);
+}
+
+static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
+				 uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *rplnlh;
+	unsigned int portid;
+	int err, ret;
+
+	portid = mnl_socket_get_portid(sock);
+
+	ret = build_cta_proto(nlh);
+	if (ret < 0) {
+		perror("build_cta_proto");
+		return -1;
+	}
+	mnl_attr_put_u32(nlh, CTA_TIMEOUT, htonl(20000));
+	mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+	if (mnl_socket_sendto(sock, nlh, nlh->nlmsg_len) < 0) {
+		perror("mnl_socket_sendto");
+		return -1;
+	}
+
+	ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	if (ret < 0) {
+		perror("mnl_socket_recvfrom");
+		return ret;
+	}
+
+	ret = mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
+	if (ret < 0) {
+		if (errno == EEXIST) {
+			/* The entries are probably still there from a previous
+			 * run. So we are good
+			 */
+			return 0;
+		}
+		perror("mnl_cb_run");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int conntrack_data_generate_v4(struct mnl_socket *sock, uint32_t src_ip,
+				      uint32_t dst_ip, uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	struct nfgenmsg *nfh;
+	int ret;
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type = (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_NEW;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
+			   NLM_F_ACK | NLM_F_EXCL;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_INET;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	ret = build_cta_tuple_v4(nlh, CTA_TUPLE_ORIG, src_ip, dst_ip, 12345, 443);
+	if (ret < 0) {
+		perror("build_cta_tuple_v4");
+		return ret;
+	}
+	ret = build_cta_tuple_v4(nlh, CTA_TUPLE_REPLY, dst_ip, src_ip, 443, 12345);
+	if (ret < 0) {
+		perror("build_cta_tuple_v4");
+		return ret;
+	}
+	return conntrack_data_insert(sock, nlh, zone);
+}
+
+static int conntrack_data_generate_v6(struct mnl_socket *sock,
+				      struct in6_addr src_ip,
+				      struct in6_addr dst_ip,
+				      uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh;
+	struct nfgenmsg *nfh;
+	int ret;
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type = (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_NEW;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
+			   NLM_F_ACK | NLM_F_EXCL;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_INET6;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	ret = build_cta_tuple_v6(nlh, CTA_TUPLE_ORIG, src_ip, dst_ip,
+				 12345, 443);
+	if (ret < 0) {
+		perror("build_cta_tuple_v6");
+		return ret;
+	}
+	ret = build_cta_tuple_v6(nlh, CTA_TUPLE_REPLY, dst_ip, src_ip,
+				 12345, 443);
+	if (ret < 0) {
+		perror("build_cta_tuple_v6");
+		return ret;
+	}
+	return conntrack_data_insert(sock, nlh, zone);
+}
+
+static int count_entries(const struct nlmsghdr *nlh, void *data)
+{
+	reply_counter++;
+}
+
+static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh, *rplnlh;
+	struct nfgenmsg *nfh;
+	struct nlattr *nest;
+	unsigned int portid;
+	int err, ret;
+
+	portid = mnl_socket_get_portid(sock);
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_GET;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_UNSPEC;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+	ret = mnl_socket_sendto(sock, nlh, nlh->nlmsg_len);
+	if (ret < 0) {
+		perror("mnl_socket_sendto");
+		return ret;
+	}
+
+	reply_counter = 0;
+	ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	while (ret > 0) {
+		ret = mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid,
+				 count_entries, NULL);
+		if (ret <= MNL_CB_STOP)
+			break;
+
+		ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	}
+	if (ret < 0) {
+		perror("mnl_socket_recvfrom");
+		return ret;
+	}
+
+	return reply_counter;
+}
+
+static int conntrack_flush_zone(struct mnl_socket *sock, uint16_t zone)
+{
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct nlmsghdr *nlh, *rplnlh;
+	struct nfgenmsg *nfh;
+	struct nlattr *nest;
+	unsigned int portid;
+	int err, ret;
+
+	portid = mnl_socket_get_portid(sock);
+
+	nlh = mnl_nlmsg_put_header(buf);
+	nlh->nlmsg_type	= (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_DELETE;
+	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	nlh->nlmsg_seq = time(NULL);
+
+	nfh = mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+	nfh->nfgen_family = AF_UNSPEC;
+	nfh->version = NFNETLINK_V0;
+	nfh->res_id = 0;
+
+	mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+	ret = mnl_socket_sendto(sock, nlh, nlh->nlmsg_len);
+	if (ret < 0) {
+		perror("mnl_socket_sendto");
+		return ret;
+	}
+
+	ret = mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+	if (ret < 0) {
+		perror("mnl_socket_recvfrom");
+		return ret;
+	}
+
+	ret = mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
+	if (ret < 0) {
+		perror("mnl_cb_run");
+		return ret;
+	}
+
+	return 0;
+}
+
+FIXTURE(conntrack_dump_flush)
+{
+	struct mnl_socket *sock;
+};
+
+FIXTURE_SETUP(conntrack_dump_flush)
+{
+	struct in6_addr src, dst;
+	int ret;
+
+	self->sock = mnl_socket_open(NETLINK_NETFILTER);
+	if (!self->sock) {
+		perror("mnl_socket_open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (mnl_socket_bind(self->sock, 0, MNL_SOCKET_AUTOPID) < 0) {
+		perror("mnl_socket_bind");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	if (ret < 0 && errno == EPERM)
+		SKIP(return, "Needs to be run as root");
+	else if (ret < 0 && errno == EOPNOTSUPP)
+		SKIP(return, "Kernel does not seem to support conntrack zones");
+
+	ret = conntrack_data_generate_v4(self->sock, 0xf0f0f0f0, 0xf1f1f1f1,
+					 TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf2f2f2f2, 0xf3f3f3f3,
+					 TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf4f4f4f4, 0xf5f5f5f5,
+					 TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 0);
+
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x01000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x02000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x03000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x04000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 0);
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x05000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x06000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 0);
+
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_GE(ret, 2);
+	if (ret > 2)
+		SKIP(return, "kernel does not support filtering by zone");
+}
+
+FIXTURE_TEARDOWN(conntrack_dump_flush)
+{
+}
+
+TEST_F(conntrack_dump_flush, test_dump_by_zone)
+{
+	int ret;
+
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_F(conntrack_dump_flush, test_flush_by_zone)
+{
+	int ret;
+
+	ret = conntrack_flush_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_HARNESS_MAIN
-- 
2.30.2


