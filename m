Return-Path: <netfilter-devel+bounces-2878-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E791CF79
	for <lists+netfilter-devel@lfdr.de>; Sun, 30 Jun 2024 00:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4594C1F2105D
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 Jun 2024 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AA31422BC;
	Sat, 29 Jun 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnNMkQn5"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F67E572;
	Sat, 29 Jun 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719700075; cv=none; b=XgrrEvxDM7EHVDu1m2QCKrE9NMDNiwytZ0imwNGHEXpz+tqVsWCnuj/YZw6hYZfHCf8NUVx1R2oBy/DaCFPMR80OWuG+HC5hayKnDjt6lcp5OQjymWjHfAm6x73trIfCwOdFiJLZB/wQPEijmZgOqwcGd1wqZpANJsN6BxLKws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719700075; c=relaxed/simple;
	bh=P+zd3HWWrYJ5/IFc3vTBN7fIdR7GkPKVynEutO9u8PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsenxPUrFwFrQPxW9MJqZSgElzSl8BTsygW8wB7YrsapLTQjzUf7OIzAsmDEQno99f7W26KjwNzsSDx3jJYQmwhtrhCCDXwRk/894ZspoBWKI61pqng4/e/nPMPt7AL0lTi+V5Q/yxgYtwq+Hh0mpjZmtlQU41MjoycYlIrYjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnNMkQn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B03C2BBFC;
	Sat, 29 Jun 2024 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719700075;
	bh=P+zd3HWWrYJ5/IFc3vTBN7fIdR7GkPKVynEutO9u8PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnNMkQn5L49PHafZQ+y7AVDxdx5EzzAH10lJGxXQoICG519F4cZ6mxijS3fOoRxZ3
	 nocj0mnpERNMeIqwbjwqgHVZiSqvomau7ZsSfOuO6LJ4f0tfx15GpnaZhKvZOLAUAM
	 y1RDOPEy1GVfGgSD/4QcvMMQYE5XSOt+gbpbqozaOhZQa/5wMTKYcwFwvkpHmLbMhx
	 QpEdUHQNsmh9VuY7ub0tEN++Rv82tHrwkH7pIMwglQkh6kyRIKDDiY9Mld0IjZWXL2
	 8DZf2kkphIO1B3/liWbB82I0kUhRY+2IFkvvULrwHxMXM9FJcLX1RoVeSHqSxIup1y
	 t3q13+NZ7ncWQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com,
	toke@redhat.com,
	fw@strlen.de,
	hawk@kernel.org,
	horms@kernel.org,
	donhunte@redhat.com,
	memxor@gmail.com
Subject: [PATCH v6 bpf-next 3/3] selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc
Date: Sun, 30 Jun 2024 00:26:50 +0200
Message-ID: <b74393fb4539aecbbd5ac7883605f86a95fb0b6b.1719698275.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719698275.git.lorenzo@kernel.org>
References: <cover.1719698275.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce e2e selftest for bpf_xdp_flow_lookup kfunc through
xdp_flowtable utility.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/config            |  13 ++
 .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_flowtable.c       | 144 +++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2fb16da78dce8..5291e97df7494 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -83,6 +83,19 @@ CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
+CONFIG_NF_TABLES=y
+CONFIG_NF_TABLES_INET=y
+CONFIG_NF_TABLES_NETDEV=y
+CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_TABLES_IPV6=y
+CONFIG_NETFILTER_INGRESS=y
+CONFIG_NF_FLOW_TABLE=y
+CONFIG_NF_FLOW_TABLE_INET=y
+CONFIG_NETFILTER_NETLINK=y
+CONFIG_NFT_FLOW_OFFLOAD=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP6_NF_IPTABLES=y
+CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
new file mode 100644
index 0000000000000..e1bf141d34015
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <bpf/btf.h>
+#include <linux/if_link.h>
+#include <linux/udp.h>
+#include <net/if.h>
+#include <unistd.h>
+
+#include "xdp_flowtable.skel.h"
+
+#define TX_NETNS_NAME	"ns0"
+#define RX_NETNS_NAME	"ns1"
+
+#define TX_NAME		"v0"
+#define FORWARD_NAME	"v1"
+#define RX_NAME		"d0"
+
+#define TX_MAC		"00:00:00:00:00:01"
+#define FORWARD_MAC	"00:00:00:00:00:02"
+#define RX_MAC		"00:00:00:00:00:03"
+#define DST_MAC		"00:00:00:00:00:04"
+
+#define TX_ADDR		"10.0.0.1"
+#define FORWARD_ADDR	"10.0.0.2"
+#define RX_ADDR		"20.0.0.1"
+#define DST_ADDR	"20.0.0.2"
+
+#define PREFIX_LEN	"8"
+#define N_PACKETS	10
+#define UDP_PORT	12345
+#define UDP_PORT_STR	"12345"
+
+static int send_udp_traffic(void)
+{
+	struct sockaddr_storage addr;
+	int i, sock;
+
+	if (make_sockaddr(AF_INET, DST_ADDR, UDP_PORT, &addr, NULL))
+		return -EINVAL;
+
+	sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return sock;
+
+	for (i = 0; i < N_PACKETS; i++) {
+		unsigned char buf[] = { 0xaa, 0xbb, 0xcc };
+		int n;
+
+		n = sendto(sock, buf, sizeof(buf), MSG_NOSIGNAL | MSG_CONFIRM,
+			   (struct sockaddr *)&addr, sizeof(addr));
+		if (n != sizeof(buf)) {
+			close(sock);
+			return -EINVAL;
+		}
+
+		usleep(50000); /* 50ms */
+	}
+	close(sock);
+
+	return 0;
+}
+
+void test_xdp_flowtable(void)
+{
+	struct xdp_flowtable *skel = NULL;
+	struct nstoken *tok = NULL;
+	int iifindex, stats_fd;
+	__u32 value, key = 0;
+	struct bpf_link *link;
+
+	if (SYS_NOFAIL("nft -v")) {
+		fprintf(stdout, "Missing required nft tool\n");
+		test__skip();
+		return;
+	}
+
+	SYS(out, "ip netns add " TX_NETNS_NAME);
+	SYS(out, "ip netns add " RX_NETNS_NAME);
+
+	tok = open_netns(RX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "sysctl -qw net.ipv4.conf.all.forwarding=1");
+
+	SYS(out, "ip link add " TX_NAME " type veth peer " FORWARD_NAME);
+	SYS(out, "ip link set " TX_NAME " netns " TX_NETNS_NAME);
+	SYS(out, "ip link set dev " FORWARD_NAME " address " FORWARD_MAC);
+	SYS(out,
+	    "ip addr add " FORWARD_ADDR "/" PREFIX_LEN " dev " FORWARD_NAME);
+	SYS(out, "ip link set dev " FORWARD_NAME " up");
+
+	SYS(out, "ip link add " RX_NAME " type dummy");
+	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
+	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
+	SYS(out, "ip link set dev " RX_NAME " up");
+
+	/* configure the flowtable */
+	SYS(out, "nft add table ip filter");
+	SYS(out,
+	    "nft add flowtable ip filter f { hook ingress priority 0\\; "
+	    "devices = { " FORWARD_NAME ", " RX_NAME " }\\; }");
+	SYS(out,
+	    "nft add chain ip filter forward "
+	    "{ type filter hook forward priority 0\\; }");
+	SYS(out,
+	    "nft add rule ip filter forward ip protocol udp th dport "
+	    UDP_PORT_STR " flow add @f");
+
+	/* Avoid ARP calls */
+	SYS(out,
+	    "ip -4 neigh add " DST_ADDR " lladdr " DST_MAC " dev " RX_NAME);
+
+	close_netns(tok);
+	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
+	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
+	SYS(out, "ip link set dev " TX_NAME " up");
+	SYS(out, "ip route add default via " FORWARD_ADDR);
+
+	close_netns(tok);
+	tok = open_netns(RX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	iifindex = if_nametoindex(FORWARD_NAME);
+	if (!ASSERT_NEQ(iifindex, 0, "iifindex"))
+		goto out;
+
+	skel = xdp_flowtable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto out;
+
+	link = bpf_program__attach_xdp(skel->progs.xdp_flowtable_do_lookup,
+				       iifindex);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	if (!ASSERT_OK(send_udp_traffic(), "send udp"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(RX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	stats_fd = bpf_map__fd(skel->maps.stats);
+	if (!ASSERT_OK(bpf_map_lookup_elem(stats_fd, &key, &value),
+		       "bpf_map_update_elem stats"))
+		goto out;
+
+	ASSERT_GE(value, N_PACKETS - 2, "bpf_xdp_flow_lookup failed");
+out:
+	xdp_flowtable__destroy(skel);
+	if (tok)
+		close_netns(tok);
+	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
new file mode 100644
index 0000000000000..15209650f73b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define ETH_P_IP	0x0800
+#define ETH_P_IPV6	0x86dd
+#define IP_MF		0x2000	/* "More Fragments" */
+#define IP_OFFSET	0x1fff	/* "Fragment Offset" */
+#define AF_INET		2
+#define AF_INET6	10
+
+struct bpf_flowtable_opts___local {
+	s32 error;
+};
+
+struct flow_offload_tuple_rhash *
+bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
+		    struct bpf_flowtable_opts___local *, u32) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} stats SEC(".maps");
+
+static bool xdp_flowtable_offload_check_iphdr(struct iphdr *iph)
+{
+	/* ip fragmented traffic */
+	if (iph->frag_off & bpf_htons(IP_MF | IP_OFFSET))
+		return false;
+
+	/* ip options */
+	if (iph->ihl * 4 != sizeof(*iph))
+		return false;
+
+	if (iph->ttl <= 1)
+		return false;
+
+	return true;
+}
+
+static bool xdp_flowtable_offload_check_tcp_state(void *ports, void *data_end,
+						  u8 proto)
+{
+	if (proto == IPPROTO_TCP) {
+		struct tcphdr *tcph = ports;
+
+		if (tcph + 1 > data_end)
+			return false;
+
+		if (tcph->fin || tcph->rst)
+			return false;
+	}
+
+	return true;
+}
+
+SEC("xdp.frags")
+int xdp_flowtable_do_lookup(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	struct bpf_flowtable_opts___local opts = {};
+	struct flow_offload_tuple_rhash *tuplehash;
+	struct bpf_fib_lookup tuple = {
+		.ifindex = ctx->ingress_ifindex,
+	};
+	void *data = (void *)(long)ctx->data;
+	struct ethhdr *eth = data;
+	struct flow_ports *ports;
+	__u32 *val, key = 0;
+
+	if (eth + 1 > data_end)
+		return XDP_DROP;
+
+	switch (eth->h_proto) {
+	case bpf_htons(ETH_P_IP): {
+		struct iphdr *iph = data + sizeof(*eth);
+
+		ports = (struct flow_ports *)(iph + 1);
+		if (ports + 1 > data_end)
+			return XDP_PASS;
+
+		/* sanity check on ip header */
+		if (!xdp_flowtable_offload_check_iphdr(iph))
+			return XDP_PASS;
+
+		if (!xdp_flowtable_offload_check_tcp_state(ports, data_end,
+							   iph->protocol))
+			return XDP_PASS;
+
+		tuple.family		= AF_INET;
+		tuple.tos		= iph->tos;
+		tuple.l4_protocol	= iph->protocol;
+		tuple.tot_len		= bpf_ntohs(iph->tot_len);
+		tuple.ipv4_src		= iph->saddr;
+		tuple.ipv4_dst		= iph->daddr;
+		tuple.sport		= ports->source;
+		tuple.dport		= ports->dest;
+		break;
+	}
+	case bpf_htons(ETH_P_IPV6): {
+		struct in6_addr *src = (struct in6_addr *)tuple.ipv6_src;
+		struct in6_addr *dst = (struct in6_addr *)tuple.ipv6_dst;
+		struct ipv6hdr *ip6h = data + sizeof(*eth);
+
+		ports = (struct flow_ports *)(ip6h + 1);
+		if (ports + 1 > data_end)
+			return XDP_PASS;
+
+		if (ip6h->hop_limit <= 1)
+			return XDP_PASS;
+
+		if (!xdp_flowtable_offload_check_tcp_state(ports, data_end,
+							   ip6h->nexthdr))
+			return XDP_PASS;
+
+		tuple.family		= AF_INET6;
+		tuple.l4_protocol	= ip6h->nexthdr;
+		tuple.tot_len		= bpf_ntohs(ip6h->payload_len);
+		*src			= ip6h->saddr;
+		*dst			= ip6h->daddr;
+		tuple.sport		= ports->source;
+		tuple.dport		= ports->dest;
+		break;
+	}
+	default:
+		return XDP_PASS;
+	}
+
+	tuplehash = bpf_xdp_flow_lookup(ctx, &tuple, &opts, sizeof(opts));
+	if (!tuplehash)
+		return XDP_PASS;
+
+	val = bpf_map_lookup_elem(&stats, &key);
+	if (val)
+		__sync_add_and_fetch(val, 1);
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2


