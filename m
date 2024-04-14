Return-Path: <netfilter-devel+bounces-1748-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8170D8A226F
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Apr 2024 01:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43B21C20E2F
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Apr 2024 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E04B5AE;
	Thu, 11 Apr 2024 23:42:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C8481CD;
	Thu, 11 Apr 2024 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878954; cv=none; b=qBhDrCwloNc2qh3bKJ+8YurHUL+hMm9oHMmceQpf08RSFWd4GLyNE1EOQ+KkGoqeN/IBU0O0SC3FLVkzVNaH36sB2ETsJj+8GiE9z55ZJVCKH7A2IFlBXiCA8+CqLoUEGR8jEJGJxrScRB/Fx+VXPTrWeZW4kzJb9Vr5Xm2BGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878954; c=relaxed/simple;
	bh=DRSt9hegIMh2NAZW+7cv0W2NDz5TOlZ2L/qPDGN5dxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDqdTj2DGvX/MwYk4xamks3HJ3dSSbdGR5EHmnGsoNDSwGSRhgXgShTNJK+IInsKFhX0sBb8eVdLGl5bW9WRLDKLNwfl2Z+7NEvHZlskCkDwrMwh5nXMBbSgc05tiypiXsb5cnHkvFwUtvXEPs9Lh7s45JX/TwVsTOEcLAkpXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rv43j-0000tB-J7; Fri, 12 Apr 2024 01:42:23 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: <netfilter-devel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net-next 01/15] selftests: netfilter: move to net subdir
Date: Fri, 12 Apr 2024 01:36:06 +0200
Message-ID: <20240411233624.8129-2-fw@strlen.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411233624.8129-1-fw@strlen.de>
References: <20240411233624.8129-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.. so this can start re-using existing lib.sh infra in next patches.

Several of these scripts will not work, e.g. because they assume
rp_filter is disabled, or reliance on a particular version/flavor
of "netcat" tool.

Add config settings for them.

nft_trans_stress.sh script is removed, it also exists in the nftables
userspace selftests.  I do not see a reason to keep two versions in
different repositories/projects.

The settings file is removed for now:

It was used to increase the timeout to avoid slow scripts from getting
zapped by the 45s timeout, but some of the slow scripts can be sped up.
Re-add it later for scripts that cannot be sped up easily.

Update MAINTAINERS to reflect that future updates to netfilter
scripts should go through netfilter-devel@.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 MAINTAINERS                                   |   1 +
 .../selftests/{ => net}/netfilter/.gitignore  |   4 +-
 .../testing/selftests/net/netfilter/Makefile  |  44 +++++
 .../{ => net}/netfilter/audit_logread.c       |   0
 .../netfilter/br_netfilter.sh}                |   0
 .../{ => net}/netfilter/bridge_brouter.sh     |   0
 tools/testing/selftests/net/netfilter/config  |  37 +++++
 .../{ => net}/netfilter/connect_close.c       |   0
 .../netfilter/conntrack_dump_flush.c          |   2 +-
 .../netfilter/conntrack_icmp_related.sh       |   0
 .../netfilter/conntrack_ipip_mtu.sh}          |   0
 .../netfilter/conntrack_sctp_collision.sh     |   0
 .../netfilter/conntrack_tcp_unreplied.sh      |   0
 .../{ => net}/netfilter/conntrack_vrf.sh      |   0
 .../selftests/{ => net}/netfilter/ipvs.sh     |   0
 tools/testing/selftests/net/netfilter/lib.sh  |   3 +
 .../{ => net}/netfilter/nf_nat_edemux.sh      |   0
 .../nf-queue.c => net/netfilter/nf_queue.c}   |   0
 .../{ => net}/netfilter/nft_audit.sh          |   0
 .../{ => net}/netfilter/nft_concat_range.sh   |   0
 .../netfilter/nft_conntrack_helper.sh         |   0
 .../selftests/{ => net}/netfilter/nft_fib.sh  |   0
 .../{ => net}/netfilter/nft_flowtable.sh      |   0
 .../selftests/{ => net}/netfilter/nft_meta.sh |   0
 .../selftests/{ => net}/netfilter/nft_nat.sh  |   0
 .../{ => net}/netfilter/nft_nat_zones.sh      |   0
 .../{ => net}/netfilter/nft_queue.sh          |  18 +--
 .../{ => net}/netfilter/nft_synproxy.sh       |   0
 .../{ => net}/netfilter/nft_zones_many.sh     |   0
 .../selftests/{ => net}/netfilter/rpath.sh    |   0
 .../{ => net}/netfilter/sctp_collision.c      |   0
 .../{ => net}/netfilter/xt_string.sh          |   0
 tools/testing/selftests/netfilter/Makefile    |  21 ---
 tools/testing/selftests/netfilter/config      |   9 --
 .../selftests/netfilter/nft_trans_stress.sh   | 151 ------------------
 tools/testing/selftests/netfilter/settings    |   1 -
 36 files changed, 97 insertions(+), 194 deletions(-)
 rename tools/testing/selftests/{ => net}/netfilter/.gitignore (92%)
 create mode 100644 tools/testing/selftests/net/netfilter/Makefile
 rename tools/testing/selftests/{ => net}/netfilter/audit_logread.c (100%)
 rename tools/testing/selftests/{netfilter/bridge_netfilter.sh => net/netfilter/br_netfilter.sh} (100%)
 mode change 100644 => 100755
 rename tools/testing/selftests/{ => net}/netfilter/bridge_brouter.sh (100%)
 create mode 100644 tools/testing/selftests/net/netfilter/config
 rename tools/testing/selftests/{ => net}/netfilter/connect_close.c (100%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_dump_flush.c (99%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_icmp_related.sh (100%)
 rename tools/testing/selftests/{netfilter/ipip-conntrack-mtu.sh => net/netfilter/conntrack_ipip_mtu.sh} (100%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_sctp_collision.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_tcp_unreplied.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_vrf.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/ipvs.sh (100%)
 create mode 100644 tools/testing/selftests/net/netfilter/lib.sh
 rename tools/testing/selftests/{ => net}/netfilter/nf_nat_edemux.sh (100%)
 rename tools/testing/selftests/{netfilter/nf-queue.c => net/netfilter/nf_queue.c} (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_audit.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_concat_range.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_conntrack_helper.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_fib.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_flowtable.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_meta.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_nat.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_nat_zones.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_queue.sh (95%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_synproxy.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_zones_many.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/rpath.sh (100%)
 rename tools/testing/selftests/{ => net}/netfilter/sctp_collision.c (100%)
 rename tools/testing/selftests/{ => net}/netfilter/xt_string.sh (100%)
 delete mode 100644 tools/testing/selftests/netfilter/Makefile
 delete mode 100644 tools/testing/selftests/netfilter/config
 delete mode 100755 tools/testing/selftests/netfilter/nft_trans_stress.sh
 delete mode 100644 tools/testing/selftests/netfilter/settings

diff --git a/MAINTAINERS b/MAINTAINERS
index 4745ea94d463..48083ff4b87c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15268,6 +15268,7 @@ F:	net/*/netfilter.c
 F:	net/*/netfilter/
 F:	net/bridge/br_netfilter*.c
 F:	net/netfilter/
+F:	tools/testing/selftests/net/netfilter/
 
 NETROM NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/selftests/net/netfilter/.gitignore
similarity index 92%
rename from tools/testing/selftests/netfilter/.gitignore
rename to tools/testing/selftests/net/netfilter/.gitignore
index c2229b3e40d4..0a64d6d0e29a 100644
--- a/tools/testing/selftests/netfilter/.gitignore
+++ b/tools/testing/selftests/net/netfilter/.gitignore
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-nf-queue
-connect_close
 audit_logread
+connect_close
 conntrack_dump_flush
 sctp_collision
+nf_queue
diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
new file mode 100644
index 000000000000..dd9a75a33d28
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+
+top_srcdir = ../../../../..
+
+HOSTPKG_CONFIG := pkg-config
+MNL_CFLAGS := $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
+MNL_LDLIBS := $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+
+TEST_PROGS := br_netfilter.sh bridge_brouter.sh
+TEST_PROGS += conntrack_icmp_related.sh
+TEST_PROGS += conntrack_ipip_mtu.sh
+TEST_PROGS += conntrack_tcp_unreplied.sh
+TEST_PROGS += conntrack_sctp_collision.sh
+TEST_PROGS += conntrack_vrf.sh
+TEST_PROGS += ipvs.sh
+TEST_PROGS += nf_nat_edemux.sh
+TEST_PROGS += nft_audit.sh
+TEST_PROGS += nft_concat_range.sh
+TEST_PROGS += nft_conntrack_helper.sh
+TEST_PROGS += nft_fib.sh
+TEST_PROGS += nft_flowtable.sh
+TEST_PROGS += nft_meta.sh
+TEST_PROGS += nft_nat.sh
+TEST_PROGS += nft_nat_zones.sh
+TEST_PROGS += nft_queue.sh
+TEST_PROGS += nft_synproxy.sh
+TEST_PROGS += nft_zones_many.sh
+TEST_PROGS += rpath.sh
+TEST_PROGS += xt_string.sh
+
+TEST_CUSTOM_PROGS += conntrack_dump_flush
+
+TEST_GEN_FILES = audit_logread
+TEST_GEN_FILES += conntrack_dump_flush
+TEST_GEN_FILES += connect_close nf_queue
+TEST_GEN_FILES += sctp_collision
+
+include ../../lib.mk
+
+$(OUTPUT)/nf_queue: CFLAGS += $(MNL_CFLAGS)
+$(OUTPUT)/nf_queue: LDLIBS += $(MNL_LDLIBS)
+
+$(OUTPUT)/conntrack_dump_flush: CFLAGS += $(MNL_CFLAGS)
+$(OUTPUT)/conntrack_dump_flush: LDLIBS += $(MNL_LDLIBS)
diff --git a/tools/testing/selftests/netfilter/audit_logread.c b/tools/testing/selftests/net/netfilter/audit_logread.c
similarity index 100%
rename from tools/testing/selftests/netfilter/audit_logread.c
rename to tools/testing/selftests/net/netfilter/audit_logread.c
diff --git a/tools/testing/selftests/netfilter/bridge_netfilter.sh b/tools/testing/selftests/net/netfilter/br_netfilter.sh
old mode 100644
new mode 100755
similarity index 100%
rename from tools/testing/selftests/netfilter/bridge_netfilter.sh
rename to tools/testing/selftests/net/netfilter/br_netfilter.sh
diff --git a/tools/testing/selftests/netfilter/bridge_brouter.sh b/tools/testing/selftests/net/netfilter/bridge_brouter.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/bridge_brouter.sh
rename to tools/testing/selftests/net/netfilter/bridge_brouter.sh
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
new file mode 100644
index 000000000000..9df6a9f11384
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/config
@@ -0,0 +1,37 @@
+CONFIG_AUDIT=y
+CONFIG_BRIDGE_EBT_BROUTE=m
+CONFIG_BRIDGE_EBT_REDIRECT=m
+CONFIG_BRIDGE_NETFILTER=m
+CONFIG_IP_NF_MATCH_RPFILTER=m
+CONFIG_IP6_NF_MATCH_RPFILTER=m
+CONFIG_IP_SCTP=m
+CONFIG_IP_VS=m
+CONFIG_IP_VS_PROTO_TCP=y
+CONFIG_NET_CLS_U32=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_IPIP=m
+CONFIG_NET_VRF=y
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NETFILTER_SYNPROXY=m
+CONFIG_NETFILTER_XT_NAT=m
+CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_EVENTS=m
+CONFIG_NF_CONNTRACK_ZONES=y
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NF_CT_PROTO_SCTP=y
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=y
+CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_TABLES_IPV6=y
+CONFIG_NFT_CT=m
+CONFIG_NFT_FIB=m
+CONFIG_NFT_FIB_INET=m
+CONFIG_NFT_FIB_IPV4=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NFT_MASQ=m
+CONFIG_NFT_NAT=m
+CONFIG_NFT_QUEUE=m
+CONFIG_NFT_REDIR=m
+CONFIG_NFT_SYNPROXY=m
diff --git a/tools/testing/selftests/netfilter/connect_close.c b/tools/testing/selftests/net/netfilter/connect_close.c
similarity index 100%
rename from tools/testing/selftests/netfilter/connect_close.c
rename to tools/testing/selftests/net/netfilter/connect_close.c
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
similarity index 99%
rename from tools/testing/selftests/netfilter/conntrack_dump_flush.c
rename to tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index b11ea8ee6719..ca8d6b976c42 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -10,7 +10,7 @@
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_conntrack.h>
 #include <linux/netfilter/nf_conntrack_tcp.h>
-#include "../kselftest_harness.h"
+#include "../../kselftest_harness.h"
 
 #define TEST_ZONE_ID 123
 #define NF_CT_DEFAULT_ZONE_ID 0
diff --git a/tools/testing/selftests/netfilter/conntrack_icmp_related.sh b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/conntrack_icmp_related.sh
rename to tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
diff --git a/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh b/tools/testing/selftests/net/netfilter/conntrack_ipip_mtu.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh
rename to tools/testing/selftests/net/netfilter/conntrack_ipip_mtu.sh
diff --git a/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh b/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
rename to tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
diff --git a/tools/testing/selftests/netfilter/conntrack_tcp_unreplied.sh b/tools/testing/selftests/net/netfilter/conntrack_tcp_unreplied.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/conntrack_tcp_unreplied.sh
rename to tools/testing/selftests/net/netfilter/conntrack_tcp_unreplied.sh
diff --git a/tools/testing/selftests/netfilter/conntrack_vrf.sh b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/conntrack_vrf.sh
rename to tools/testing/selftests/net/netfilter/conntrack_vrf.sh
diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/net/netfilter/ipvs.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/ipvs.sh
rename to tools/testing/selftests/net/netfilter/ipvs.sh
diff --git a/tools/testing/selftests/net/netfilter/lib.sh b/tools/testing/selftests/net/netfilter/lib.sh
new file mode 100644
index 000000000000..eb109eb527db
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/lib.sh
@@ -0,0 +1,3 @@
+net_netfilter_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "$net_netfilter_dir/../lib.sh"
diff --git a/tools/testing/selftests/netfilter/nf_nat_edemux.sh b/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nf_nat_edemux.sh
rename to tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
diff --git a/tools/testing/selftests/netfilter/nf-queue.c b/tools/testing/selftests/net/netfilter/nf_queue.c
similarity index 100%
rename from tools/testing/selftests/netfilter/nf-queue.c
rename to tools/testing/selftests/net/netfilter/nf_queue.c
diff --git a/tools/testing/selftests/netfilter/nft_audit.sh b/tools/testing/selftests/net/netfilter/nft_audit.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_audit.sh
rename to tools/testing/selftests/net/netfilter/nft_audit.sh
diff --git a/tools/testing/selftests/netfilter/nft_concat_range.sh b/tools/testing/selftests/net/netfilter/nft_concat_range.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_concat_range.sh
rename to tools/testing/selftests/net/netfilter/nft_concat_range.sh
diff --git a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh b/tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_conntrack_helper.sh
rename to tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh
diff --git a/tools/testing/selftests/netfilter/nft_fib.sh b/tools/testing/selftests/net/netfilter/nft_fib.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_fib.sh
rename to tools/testing/selftests/net/netfilter/nft_fib.sh
diff --git a/tools/testing/selftests/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_flowtable.sh
rename to tools/testing/selftests/net/netfilter/nft_flowtable.sh
diff --git a/tools/testing/selftests/netfilter/nft_meta.sh b/tools/testing/selftests/net/netfilter/nft_meta.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_meta.sh
rename to tools/testing/selftests/net/netfilter/nft_meta.sh
diff --git a/tools/testing/selftests/netfilter/nft_nat.sh b/tools/testing/selftests/net/netfilter/nft_nat.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_nat.sh
rename to tools/testing/selftests/net/netfilter/nft_nat.sh
diff --git a/tools/testing/selftests/netfilter/nft_nat_zones.sh b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_nat_zones.sh
rename to tools/testing/selftests/net/netfilter/nft_nat_zones.sh
diff --git a/tools/testing/selftests/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
similarity index 95%
rename from tools/testing/selftests/netfilter/nft_queue.sh
rename to tools/testing/selftests/net/netfilter/nft_queue.sh
index e12729753351..2eb65887e570 100755
--- a/tools/testing/selftests/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -222,9 +222,9 @@ test_queue()
 	local expected=$1
 	local last=""
 
-	# spawn nf-queue listeners
-	ip netns exec ${nsrouter} ./nf-queue -c -q 0 -t $timeout > "$TMPFILE0" &
-	ip netns exec ${nsrouter} ./nf-queue -c -q 1 -t $timeout > "$TMPFILE1" &
+	# spawn nf_queue listeners
+	ip netns exec ${nsrouter} ./nf_queue -c -q 0 -t $timeout > "$TMPFILE0" &
+	ip netns exec ${nsrouter} ./nf_queue -c -q 1 -t $timeout > "$TMPFILE1" &
 	sleep 1
 	test_ping
 	ret=$?
@@ -259,7 +259,7 @@ test_queue()
 
 test_tcp_forward()
 {
-	ip netns exec ${nsrouter} ./nf-queue -q 2 -t $timeout &
+	ip netns exec ${nsrouter} ./nf_queue -q 2 -t $timeout &
 	local nfqpid=$!
 
 	tmpfile=$(mktemp) || exit 1
@@ -285,7 +285,7 @@ test_tcp_localhost()
 	ip netns exec ${nsrouter} nc -w 5 -l -p 12345 <"$tmpfile" >/dev/null &
 	local rpid=$!
 
-	ip netns exec ${nsrouter} ./nf-queue -q 3 -t $timeout &
+	ip netns exec ${nsrouter} ./nf_queue -q 3 -t $timeout &
 	local nfqpid=$!
 
 	sleep 1
@@ -303,7 +303,7 @@ test_tcp_localhost_connectclose()
 
 	ip netns exec ${nsrouter} ./connect_close -p 23456 -t $timeout &
 
-	ip netns exec ${nsrouter} ./nf-queue -q 3 -t $timeout &
+	ip netns exec ${nsrouter} ./nf_queue -q 3 -t $timeout &
 	local nfqpid=$!
 
 	sleep 1
@@ -334,11 +334,11 @@ EOF
 	ip netns exec ${nsrouter} nc -w 5 -l -p 12345 <"$tmpfile" >/dev/null &
 	local rpid=$!
 
-	ip netns exec ${nsrouter} ./nf-queue -c -q 1 -t $timeout > "$TMPFILE2" &
+	ip netns exec ${nsrouter} ./nf_queue -c -q 1 -t $timeout > "$TMPFILE2" &
 
 	# nfqueue 1 will be called via output hook.  But this time,
         # re-queue the packet to nfqueue program on queue 2.
-	ip netns exec ${nsrouter} ./nf-queue -G -d 150 -c -q 0 -Q 1 -t $timeout > "$TMPFILE3" &
+	ip netns exec ${nsrouter} ./nf_queue -G -d 150 -c -q 0 -Q 1 -t $timeout > "$TMPFILE3" &
 
 	sleep 1
 	ip netns exec ${nsrouter} nc -w 5 127.0.0.1 12345 <"$tmpfile" > /dev/null
@@ -380,7 +380,7 @@ table inet filter {
 	}
 }
 EOF
-	ip netns exec ${ns1} ./nf-queue -q 1 -t $timeout &
+	ip netns exec ${ns1} ./nf_queue -q 1 -t $timeout &
 	local nfqpid=$!
 
 	sleep 1
diff --git a/tools/testing/selftests/netfilter/nft_synproxy.sh b/tools/testing/selftests/net/netfilter/nft_synproxy.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_synproxy.sh
rename to tools/testing/selftests/net/netfilter/nft_synproxy.sh
diff --git a/tools/testing/selftests/netfilter/nft_zones_many.sh b/tools/testing/selftests/net/netfilter/nft_zones_many.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/nft_zones_many.sh
rename to tools/testing/selftests/net/netfilter/nft_zones_many.sh
diff --git a/tools/testing/selftests/netfilter/rpath.sh b/tools/testing/selftests/net/netfilter/rpath.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/rpath.sh
rename to tools/testing/selftests/net/netfilter/rpath.sh
diff --git a/tools/testing/selftests/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
similarity index 100%
rename from tools/testing/selftests/netfilter/sctp_collision.c
rename to tools/testing/selftests/net/netfilter/sctp_collision.c
diff --git a/tools/testing/selftests/netfilter/xt_string.sh b/tools/testing/selftests/net/netfilter/xt_string.sh
similarity index 100%
rename from tools/testing/selftests/netfilter/xt_string.sh
rename to tools/testing/selftests/net/netfilter/xt_string.sh
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
deleted file mode 100644
index 936c3085bb83..000000000000
--- a/tools/testing/selftests/netfilter/Makefile
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Makefile for netfilter selftests
-
-TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
-	conntrack_icmp_related.sh nft_flowtable.sh ipvs.sh \
-	nft_concat_range.sh nft_conntrack_helper.sh \
-	nft_queue.sh nft_meta.sh nf_nat_edemux.sh \
-	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
-	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh \
-	conntrack_sctp_collision.sh xt_string.sh \
-	bridge_netfilter.sh
-
-HOSTPKG_CONFIG := pkg-config
-
-CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
-LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
-
-TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision \
-	conntrack_dump_flush
-
-include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/config b/tools/testing/selftests/netfilter/config
deleted file mode 100644
index 7c42b1b2c69b..000000000000
--- a/tools/testing/selftests/netfilter/config
+++ /dev/null
@@ -1,9 +0,0 @@
-CONFIG_NET_NS=y
-CONFIG_NF_TABLES_INET=y
-CONFIG_NFT_QUEUE=m
-CONFIG_NFT_NAT=m
-CONFIG_NFT_REDIR=m
-CONFIG_NFT_MASQ=m
-CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NF_CT_NETLINK=m
-CONFIG_AUDIT=y
diff --git a/tools/testing/selftests/netfilter/nft_trans_stress.sh b/tools/testing/selftests/netfilter/nft_trans_stress.sh
deleted file mode 100755
index 2ffba45a78bf..000000000000
--- a/tools/testing/selftests/netfilter/nft_trans_stress.sh
+++ /dev/null
@@ -1,151 +0,0 @@
-#!/bin/bash
-#
-# This test is for stress-testing the nf_tables config plane path vs.
-# packet path processing: Make sure we never release rules that are
-# still visible to other cpus.
-#
-# set -e
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-testns=testns-$(mktemp -u "XXXXXXXX")
-tmp=""
-
-tables="foo bar baz quux"
-global_ret=0
-eret=0
-lret=0
-
-cleanup() {
-	ip netns pids "$testns" | xargs kill 2>/dev/null
-	ip netns del "$testns"
-
-	rm -f "$tmp"
-}
-
-check_result()
-{
-	local r=$1
-	local OK="PASS"
-
-	if [ $r -ne 0 ] ;then
-		OK="FAIL"
-		global_ret=$r
-	fi
-
-	echo "$OK: nft $2 test returned $r"
-
-	eret=0
-}
-
-nft --version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without nft tool"
-	exit $ksft_skip
-fi
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-trap cleanup EXIT
-tmp=$(mktemp)
-
-for table in $tables; do
-	echo add table inet "$table" >> "$tmp"
-	echo flush table inet "$table" >> "$tmp"
-
-	echo "add chain inet $table INPUT { type filter hook input priority 0; }" >> "$tmp"
-	echo "add chain inet $table OUTPUT { type filter hook output priority 0; }" >> "$tmp"
-	for c in $(seq 1 400); do
-		chain=$(printf "chain%03u" "$c")
-		echo "add chain inet $table $chain" >> "$tmp"
-	done
-
-	for c in $(seq 1 400); do
-		chain=$(printf "chain%03u" "$c")
-		for BASE in INPUT OUTPUT; do
-			echo "add rule inet $table $BASE counter jump $chain" >> "$tmp"
-		done
-		echo "add rule inet $table $chain counter return" >> "$tmp"
-	done
-done
-
-ip netns add "$testns"
-ip -netns "$testns" link set lo up
-
-lscpu | grep ^CPU\(s\): | ( read cpu cpunum ;
-cpunum=$((cpunum-1))
-for i in $(seq 0 $cpunum);do
-	mask=$(printf 0x%x $((1<<$i)))
-        ip netns exec "$testns" taskset $mask ping -4 127.0.0.1 -fq > /dev/null &
-        ip netns exec "$testns" taskset $mask ping -6 ::1 -fq > /dev/null &
-done)
-
-sleep 1
-
-ip netns exec "$testns" nft -f "$tmp"
-for i in $(seq 1 10) ; do ip netns exec "$testns" nft -f "$tmp" & done
-
-for table in $tables;do
-	randsleep=$((RANDOM%2))
-	sleep $randsleep
-	ip netns exec "$testns" nft delete table inet $table
-	lret=$?
-	if [ $lret -ne 0 ]; then
-		eret=$lret
-	fi
-done
-
-check_result $eret "add/delete"
-
-for i in $(seq 1 10) ; do
-	(echo "flush ruleset"; cat "$tmp") | ip netns exec "$testns" nft -f /dev/stdin
-
-	lret=$?
-	if [ $lret -ne 0 ]; then
-		eret=$lret
-	fi
-done
-
-check_result $eret "reload"
-
-for i in $(seq 1 10) ; do
-	(echo "flush ruleset"; cat "$tmp"
-	 echo "insert rule inet foo INPUT meta nftrace set 1"
-	 echo "insert rule inet foo OUTPUT meta nftrace set 1"
-	 ) | ip netns exec "$testns" nft -f /dev/stdin
-	lret=$?
-	if [ $lret -ne 0 ]; then
-		eret=$lret
-	fi
-
-	(echo "flush ruleset"; cat "$tmp"
-	 ) | ip netns exec "$testns" nft -f /dev/stdin
-
-	lret=$?
-	if [ $lret -ne 0 ]; then
-		eret=$lret
-	fi
-done
-
-check_result $eret "add/delete with nftrace enabled"
-
-echo "insert rule inet foo INPUT meta nftrace set 1" >> $tmp
-echo "insert rule inet foo OUTPUT meta nftrace set 1" >> $tmp
-
-for i in $(seq 1 10) ; do
-	(echo "flush ruleset"; cat "$tmp") | ip netns exec "$testns" nft -f /dev/stdin
-
-	lret=$?
-	if [ $lret -ne 0 ]; then
-		eret=1
-	fi
-done
-
-check_result $lret "add/delete with nftrace enabled"
-
-exit $global_ret
diff --git a/tools/testing/selftests/netfilter/settings b/tools/testing/selftests/netfilter/settings
deleted file mode 100644
index 6091b45d226b..000000000000
--- a/tools/testing/selftests/netfilter/settings
+++ /dev/null
@@ -1 +0,0 @@
-timeout=120
-- 
2.43.2


