Return-Path: <netfilter-devel+bounces-2680-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F807908F28
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Jun 2024 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68331F29BAB
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Jun 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E615FA95;
	Fri, 14 Jun 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx8cunPj"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD6249FF;
	Fri, 14 Jun 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379674; cv=none; b=WGZDj7O4UUtp3DVs0E8t55QFUiaD3IFCtX7iOHvgSEgu3rwAuKhQmQXSBmogJYAMq0+Dnu5CYJ3QsWP7emP7XxYV0K5hyUS+NyOq19j3MG3p78DwPZERn0L+d5lSacug/PRj/qfkiMSXgYq+utk8Vv1v/sbqJHcOCiP9H9iK190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379674; c=relaxed/simple;
	bh=0CiBUMk8s5ZrLTt2yCw7D43qYi8xrUQcqESSbq/4pRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYLlqUL6TUXXyuNwntE8dBJ8fDw8LhTOvNzm9o81gcZWlEkiwdrGLtbGIGA14QEGJea/7aEB+BgSXKvdVLy1yL2x3KJoP8Nl5iBDqvyG6a4oRCYJOXXHT48X9DguiAyTllUxJ5otf8shOj5AlLiCS6TRsr16w5lTAgyfy+SAl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx8cunPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A50C2BD10;
	Fri, 14 Jun 2024 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379673;
	bh=0CiBUMk8s5ZrLTt2yCw7D43qYi8xrUQcqESSbq/4pRk=;
	h=From:To:Cc:Subject:Date:From;
	b=jx8cunPjwFvBGWtAroRhkjWKxFJlS7OtFiNGiD8Bx1CXtjnLdH4NcN8tvTilRNs69
	 OcdpXCvquS3naD0ryOqJCWUdOXdUESBu2c0HlAby7Xlsab7OAmvoUxIFRBp2NkgVx4
	 3asS8s5eYPP6nQ2bNlNKAs6TXX8WFDwNsoawPPfLFJPTjvyIWab71vPuidPEr01Kla
	 svK19AEo6KAdmOX09fLMtobSl4c7QdEfjokg+u03aC+oUz3jQKZdYP/dj9sXzDxvZb
	 B1VHLrdcVx5NaZB2dPfHzyDkT7/1d4ZI0gAl2AtRhz90D2i0dfikbYhLGnwLoYBcP9
	 auZU02gHlcbpw==
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
Subject: [PATCH v5 bpf-next 0/3] netfilter: Add the capability to offload flowtable in XDP layer
Date: Fri, 14 Jun 2024 17:40:45 +0200
Message-ID: <cover.1718379122.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup of
a given flowtable entry based on the fib tuple of incoming traffic.
bpf_xdp_flow_lookup can be used as building block to offload in XDP
the sw flowtable processing when the hw support is not available.

This series has been tested running the xdp_flowtable_offload eBPF program
on an ixgbe 10Gbps NIC (eno2) in order to XDP_REDIRECT the TCP traffic to
a veth pair (veth0-veth1) based on the content of the nf_flowtable as soon
as the TCP connection is in the established state:

[tcp client] (eno1) == LAN == (eno2) xdp_flowtable_offload [XDP_REDIRECT] --> veth0 == veth1 [tcp server]

table inet filter {
	flowtable ft {
		hook ingress priority filter
		devices = { eno2, veth0 }
	}
	chain forward {
		type filter hook forward priority filter
		meta l4proto { tcp, udp } flow add @ft
	}
}

-  sw flowtable [1 TCP stream, T = 300s]: ~ 6.2 Gbps
- xdp flowtable [1 TCP stream, T = 300s]: ~ 7.6 Gbps

-  sw flowtable [3 TCP stream, T = 300s]: ~ 7.7 Gbps
- xdp flowtable [3 TCP stream, T = 300s]: ~ 8.8 Gbps

Changes since v4:
- add missing BPF_NO_KFUNC_PROTOTYPES macro to selftest
Changes since v3:
- move flowtable map utilities in nf_flow_table_xdp.c
Changes since v2:
- introduce bpf_flowtable_opts struct in bpf_xdp_flow_lookup signature
- get rid of xdp_flowtable_offload bpf sample
- get rid of test_xdp_flowtable.sh for selftest and rely on prog_tests instead
- rename bpf_xdp_flow_offload_lookup in bpf_xdp_flow_lookup
Changes since v1:
- return NULL in bpf_xdp_flow_offload_lookup kfunc in case of error
- take into account kfunc registration possible failures
Changes since RFC:
- fix compilation error if BTF is not enabled

Akced-by: Pablo Neira Ayuso <pablo@netfilter.org>

Florian Westphal (1):
  netfilter: nf_tables: add flowtable map for xdp offload

Lorenzo Bianconi (2):
  netfilter: add bpf_xdp_flow_lookup kfunc
  selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc

 include/net/netfilter/nf_flow_table.h         |  18 ++
 net/netfilter/Makefile                        |   7 +-
 net/netfilter/nf_flow_table_bpf.c             | 117 ++++++++++++
 net/netfilter/nf_flow_table_inet.c            |   2 +-
 net/netfilter/nf_flow_table_offload.c         |   6 +-
 net/netfilter/nf_flow_table_xdp.c             | 163 +++++++++++++++++
 tools/testing/selftests/bpf/config            |  13 ++
 .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_flowtable.c       | 146 +++++++++++++++
 9 files changed, 636 insertions(+), 4 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 net/netfilter/nf_flow_table_xdp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

-- 
2.45.1


