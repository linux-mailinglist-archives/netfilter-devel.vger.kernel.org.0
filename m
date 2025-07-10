Return-Path: <netfilter-devel+bounces-7841-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8AAFF626
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Jul 2025 02:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA21C447DB
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Jul 2025 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEA72622;
	Thu, 10 Jul 2025 00:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YJHwhwdn";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="pwzHeX0u"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C1143736;
	Thu, 10 Jul 2025 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108428; cv=none; b=jMwk1EnqGNcuMb/tmu+yv6HIgEPoutZtUnOcZ1mX0xmOJ0YuEXj0Y6wvXkzGvMFrpyNS/RIv6xepbp7BvePTig2fdIecqCNxfEGWwc0gX8G8YgT/XnuLepVJ0V5KwPNtrGFkja72BZy1OSkJdo5ldkN6NxANh0+MRRfWPX4xa0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108428; c=relaxed/simple;
	bh=Kf7T0ioQyaQezbFTzUyjniFBytVKhUE67h08dP1RvzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzRRUo6liFKEs6VsmMUtip0JPm0k15jIjGkUdZnm2bwVb/z+x2ch6nLrPbqxBGRkhtfWQ8jeTfzwRKrINR5jx0eDv+D+BG9Ksbc2J3bXMYGeha9pAROPJI2bdVFw6Ak/D4XI/SZrFdTsuoI1JPmSErvpLpIUrvOck1wixcHGBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YJHwhwdn; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pwzHeX0u; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 9D71560278; Thu, 10 Jul 2025 02:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1752108422;
	bh=bJdVhVJZmEV6aL3U0fkW8Dtj43X79pQkX1Thfmg7uQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJHwhwdnLlsDUqdqtp/UrAC88GdEN6kdbZJy2E8dFmTQOsnCilLqRGTNDr+kFKiOV
	 0vUDmV9VH/6Tnfebzcbp7X5gRvSSBIoG36ZCe+oAOhGdUXGMWCFJJ1yNppOGlae5fa
	 SP0ckBh72JfjOExMd+ft0NLAEiFFKKj9vEb/4HC9zi+pRrhq0p+lyIeXsFUChJP5UG
	 VUHprsc4zE3A7odlObKFiTwJlu5vqidBJBKDuz7sCFUZeTUv4y8BjOTjfuCHweIZz0
	 HkHHcVZqL7emE4cmnPaSeQDw+XUbgCs9ZO4Yim1u0ko40BeL3ogreqYrqNAS57xuZj
	 X1Fo2fXbG8LbA==
X-Spam-Level: 
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 2DF1F6026E;
	Thu, 10 Jul 2025 02:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1752108404;
	bh=bJdVhVJZmEV6aL3U0fkW8Dtj43X79pQkX1Thfmg7uQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwzHeX0uOw2+I0UnakIXp736AYz7xTmo10yHUF6SJ2kS6SNf9KE04cZqygsltjk+Y
	 Jwb5ykykty4bLqH0Je8r+QlrBaJDcXGgcY4VCdMbxNTgESddPoGzCaxMYgA2Ao4x3Z
	 szGX2fE99hK9CljXPLj48UF/RyGn6ikLOvmHat2TqkzZDmTNxfVGkqEe6gnGTC3xyY
	 05yYZclqzU7eyX8nhzn/aH2SmXtu9GSwkUFESBgMW6lHCGy2UBz5K3DNAEP3TckSqT
	 /foMWw7ScO/d+7H839+ZbZkLEQ8xDWpnROmqRTsctlNqCiwiRix2ND2hFDeetST0nA
	 CnOo90v+mMGmA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 1/4] netfilter: conntrack: remove DCCP protocol support
Date: Thu, 10 Jul 2025 02:46:36 +0200
Message-Id: <20250710004639.2849930-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250710004639.2849930-1-pablo@netfilter.org>
References: <20250710004639.2849930-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DCCP socket family has now been removed from this tree, see:

  8bb3212be4b4 ("Merge branch 'net-retire-dccp-socket'")

Remove connection tracking and NAT support for this protocol, this
should not pose a problem because no DCCP traffic is expected to be seen
on the wire.

As for the code for matching on dccp header for iptables and nftables,
mark it as deprecated and keep it in place. Ruleset restoration is an
atomic operation. Without dccp matching support, an astray match on dccp
could break this operation leaving your computer with no policy in
place, so let's follow a more conservative approach for matches.

Add CONFIG_NFT_EXTHDR_DCCP which is set to 'n' by default to deprecate
dccp extension support. Similarly, label CONFIG_NETFILTER_XT_MATCH_DCCP
as deprecated too and also set it to 'n' by default.

Code to match on DCCP protocol from ebtables also remains in place, this
is just a few checks on IPPROTO_DCCP from _check() path which is
exercised when ruleset is loaded. There is another use of IPPROTO_DCCP
from the _check() path in the iptables multiport match. Another check
for IPPROTO_DCCP from the packet in the reject target is also removed.

So let's schedule removal of the dccp matching for a second stage, this
should not interfer with the dccp retirement since this is only matching
on the dccp header.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../networking/nf_conntrack-sysctl.rst        |   1 -
 arch/arm/configs/omap2plus_defconfig          |   1 -
 arch/loongarch/configs/loongson3_defconfig    |   1 -
 arch/m68k/configs/amiga_defconfig             |   1 -
 arch/m68k/configs/apollo_defconfig            |   1 -
 arch/m68k/configs/atari_defconfig             |   1 -
 arch/m68k/configs/bvme6000_defconfig          |   1 -
 arch/m68k/configs/hp300_defconfig             |   1 -
 arch/m68k/configs/mac_defconfig               |   1 -
 arch/m68k/configs/multi_defconfig             |   1 -
 arch/m68k/configs/mvme147_defconfig           |   1 -
 arch/m68k/configs/mvme16x_defconfig           |   1 -
 arch/m68k/configs/q40_defconfig               |   1 -
 arch/m68k/configs/sun3_defconfig              |   1 -
 arch/m68k/configs/sun3x_defconfig             |   1 -
 arch/mips/configs/fuloong2e_defconfig         |   1 -
 arch/mips/configs/ip22_defconfig              |   1 -
 arch/mips/configs/loongson2k_defconfig        |   1 -
 arch/mips/configs/loongson3_defconfig         |   1 -
 arch/mips/configs/malta_defconfig             |   1 -
 arch/mips/configs/malta_kvm_defconfig         |   1 -
 arch/mips/configs/maltaup_xpa_defconfig       |   1 -
 arch/mips/configs/rb532_defconfig             |   1 -
 arch/mips/configs/rm200_defconfig             |   1 -
 arch/powerpc/configs/cell_defconfig           |   1 -
 arch/s390/configs/debug_defconfig             |   1 -
 arch/s390/configs/defconfig                   |   1 -
 arch/sh/configs/titan_defconfig               |   1 -
 include/linux/netfilter/nf_conntrack_dccp.h   |  38 -
 .../net/netfilter/ipv4/nf_conntrack_ipv4.h    |   3 -
 include/net/netfilter/nf_conntrack.h          |   2 -
 include/net/netfilter/nf_conntrack_l4proto.h  |  13 -
 include/net/netfilter/nf_reject.h             |   1 -
 include/net/netns/conntrack.h                 |  13 -
 net/netfilter/Kconfig                         |  20 +-
 net/netfilter/Makefile                        |   1 -
 net/netfilter/nf_conntrack_core.c             |   8 -
 net/netfilter/nf_conntrack_netlink.c          |   1 -
 net/netfilter/nf_conntrack_proto.c            |   6 -
 net/netfilter/nf_conntrack_proto_dccp.c       | 826 ------------------
 net/netfilter/nf_conntrack_standalone.c       |  92 --
 net/netfilter/nf_nat_core.c                   |   6 -
 net/netfilter/nf_nat_proto.c                  |  43 -
 net/netfilter/nfnetlink_cttimeout.c           |   5 -
 net/netfilter/nft_exthdr.c                    |   8 +
 45 files changed, 16 insertions(+), 1098 deletions(-)
 delete mode 100644 include/linux/netfilter/nf_conntrack_dccp.h
 delete mode 100644 net/netfilter/nf_conntrack_proto_dccp.c

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index 238b66d0e059..35f889259fcd 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -85,7 +85,6 @@ nf_conntrack_log_invalid - INTEGER
 	- 1   - log ICMP packets
 	- 6   - log TCP packets
 	- 17  - log UDP packets
-	- 33  - log DCCP packets
 	- 41  - log ICMPv6 packets
 	- 136 - log UDPLITE packets
 	- 255 - log packets of any protocol
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9f9780c8e62a..fee43d156622 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -142,7 +142,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_CPU=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 0d59af6007b7..68e337aed2bb 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -225,7 +225,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_CPU=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index d05690289e33..83eab331872f 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -85,7 +85,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index a1747fbe23fb..0e5de7edd544 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -81,7 +81,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 74293551f66b..35fc466095f4 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -88,7 +88,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 419b13ae950a..53b7844cf301 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -78,7 +78,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 4c81d756587c..560fdf3ed106 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -80,7 +80,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index daa01d7fb462..2e28e54b52f8 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -79,7 +79,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 641ca22eb3b2..f5f6b8e65c26 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -99,7 +99,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index f98ffa7a1640..36bbf98d6aa4 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -77,7 +77,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 2bfc3f4b48f9..e247bff8f1a4 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -78,7 +78,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 2bd46cbcca2a..27aa4eb5d3f4 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -79,7 +79,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index dc7fc94fc669..b338f2043d97 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -74,7 +74,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index b026a54867f5..87ee47da4e31 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -75,7 +75,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CT_PROTO_DCCP is not set
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 114fcd67898d..cdedbb8a8f53 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -44,7 +44,6 @@ CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_TARGET_TRACE=m
 CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index f1a8ccf2c459..2decf8b98d31 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -79,7 +79,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 4b7f914d01d0..6aea6a5b1b66 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -52,7 +52,6 @@ CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NETFILTER_XT_MATCH_LIMIT=m
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 98844b457b7f..43a72c410538 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -72,7 +72,6 @@ CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NETFILTER_XT_MATCH_LIMIT=m
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 869a14b3184f..9fcbac829920 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -80,7 +80,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 41e1fea303ea..19102386a81c 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -84,7 +84,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 13ff1877e26e..1dd07c9d1812 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -82,7 +82,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 9fb114ef5e2d..30d18b084cda 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -56,7 +56,6 @@ CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_TARGET_TRACE=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_LIMIT=y
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 7b5a5591ccc9..39a2419e1f3e 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -64,7 +64,6 @@ CONFIG_NETFILTER_XT_MATCH_COMMENT=m
 CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 3347192b77b8..7a31b52e92e1 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -62,7 +62,6 @@ CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
 CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 8ecad727497e..0808a3718298 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -248,7 +248,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_CPU=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c13a77765162..6118e3105adb 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -239,7 +239,6 @@ CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_CPU=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
 CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index f022ada363b5..8ef72b8dbcd3 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -61,7 +61,6 @@ CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NETFILTER_XT_MATCH_LIMIT=m
diff --git a/include/linux/netfilter/nf_conntrack_dccp.h b/include/linux/netfilter/nf_conntrack_dccp.h
deleted file mode 100644
index c509ed76e714..000000000000
--- a/include/linux/netfilter/nf_conntrack_dccp.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NF_CONNTRACK_DCCP_H
-#define _NF_CONNTRACK_DCCP_H
-
-/* Exposed to userspace over nfnetlink */
-enum ct_dccp_states {
-	CT_DCCP_NONE,
-	CT_DCCP_REQUEST,
-	CT_DCCP_RESPOND,
-	CT_DCCP_PARTOPEN,
-	CT_DCCP_OPEN,
-	CT_DCCP_CLOSEREQ,
-	CT_DCCP_CLOSING,
-	CT_DCCP_TIMEWAIT,
-	CT_DCCP_IGNORE,
-	CT_DCCP_INVALID,
-	__CT_DCCP_MAX
-};
-#define CT_DCCP_MAX		(__CT_DCCP_MAX - 1)
-
-enum ct_dccp_roles {
-	CT_DCCP_ROLE_CLIENT,
-	CT_DCCP_ROLE_SERVER,
-	__CT_DCCP_ROLE_MAX
-};
-#define CT_DCCP_ROLE_MAX	(__CT_DCCP_ROLE_MAX - 1)
-
-#include <linux/netfilter/nf_conntrack_tuple_common.h>
-
-struct nf_ct_dccp {
-	u_int8_t	role[IP_CT_DIR_MAX];
-	u_int8_t	state;
-	u_int8_t	last_pkt;
-	u_int8_t	last_dir;
-	u_int64_t	handshake_seq;
-};
-
-#endif /* _NF_CONNTRACK_DCCP_H */
diff --git a/include/net/netfilter/ipv4/nf_conntrack_ipv4.h b/include/net/netfilter/ipv4/nf_conntrack_ipv4.h
index 2c8c2b023848..8d65ffbf57de 100644
--- a/include/net/netfilter/ipv4/nf_conntrack_ipv4.h
+++ b/include/net/netfilter/ipv4/nf_conntrack_ipv4.h
@@ -13,9 +13,6 @@
 extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_tcp;
 extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_udp;
 extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_icmp;
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_dccp;
-#endif
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_sctp;
 #endif
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 3f02a45773e8..a844aa46d076 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -18,7 +18,6 @@
 
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_conntrack_tcp.h>
-#include <linux/netfilter/nf_conntrack_dccp.h>
 #include <linux/netfilter/nf_conntrack_sctp.h>
 #include <linux/netfilter/nf_conntrack_proto_gre.h>
 
@@ -31,7 +30,6 @@ struct nf_ct_udp {
 /* per conntrack: protocol private data */
 union nf_conntrack_proto {
 	/* insert conntrack proto private data here */
-	struct nf_ct_dccp dccp;
 	struct ip_ct_sctp sctp;
 	struct ip_ct_tcp tcp;
 	struct nf_ct_udp udp;
diff --git a/include/net/netfilter/nf_conntrack_l4proto.h b/include/net/netfilter/nf_conntrack_l4proto.h
index 1f47bef51722..6929f8daf1ed 100644
--- a/include/net/netfilter/nf_conntrack_l4proto.h
+++ b/include/net/netfilter/nf_conntrack_l4proto.h
@@ -117,11 +117,6 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			    unsigned int dataoff,
 			    enum ip_conntrack_info ctinfo,
 			    const struct nf_hook_state *state);
-int nf_conntrack_dccp_packet(struct nf_conn *ct,
-			     struct sk_buff *skb,
-			     unsigned int dataoff,
-			     enum ip_conntrack_info ctinfo,
-			     const struct nf_hook_state *state);
 int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			     struct sk_buff *skb,
 			     unsigned int dataoff,
@@ -137,7 +132,6 @@ void nf_conntrack_generic_init_net(struct net *net);
 void nf_conntrack_tcp_init_net(struct net *net);
 void nf_conntrack_udp_init_net(struct net *net);
 void nf_conntrack_gre_init_net(struct net *net);
-void nf_conntrack_dccp_init_net(struct net *net);
 void nf_conntrack_sctp_init_net(struct net *net);
 void nf_conntrack_icmp_init_net(struct net *net);
 void nf_conntrack_icmpv6_init_net(struct net *net);
@@ -223,13 +217,6 @@ static inline bool nf_conntrack_tcp_established(const struct nf_conn *ct)
 }
 #endif
 
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-static inline struct nf_dccp_net *nf_dccp_pernet(struct net *net)
-{
-	return &net->ct.nf_ct_proto.dccp;
-}
-#endif
-
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 static inline struct nf_sctp_net *nf_sctp_pernet(struct net *net)
 {
diff --git a/include/net/netfilter/nf_reject.h b/include/net/netfilter/nf_reject.h
index 7c669792fb9c..f1db33bc6bf8 100644
--- a/include/net/netfilter/nf_reject.h
+++ b/include/net/netfilter/nf_reject.h
@@ -34,7 +34,6 @@ static inline bool nf_reject_verify_csum(struct sk_buff *skb, int dataoff,
 
 		/* Protocols with partial checksums. */
 		case IPPROTO_UDPLITE:
-		case IPPROTO_DCCP:
 			return false;
 	}
 	return true;
diff --git a/include/net/netns/conntrack.h b/include/net/netns/conntrack.h
index bae914815aa3..ab74b5ed0b01 100644
--- a/include/net/netns/conntrack.h
+++ b/include/net/netns/conntrack.h
@@ -7,9 +7,6 @@
 #include <linux/atomic.h>
 #include <linux/workqueue.h>
 #include <linux/netfilter/nf_conntrack_tcp.h>
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-#include <linux/netfilter/nf_conntrack_dccp.h>
-#endif
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 #include <linux/netfilter/nf_conntrack_sctp.h>
 #endif
@@ -50,13 +47,6 @@ struct nf_icmp_net {
 	unsigned int timeout;
 };
 
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-struct nf_dccp_net {
-	u8 dccp_loose;
-	unsigned int dccp_timeout[CT_DCCP_MAX + 1];
-};
-#endif
-
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 struct nf_sctp_net {
 	unsigned int timeouts[SCTP_CONNTRACK_MAX];
@@ -82,9 +72,6 @@ struct nf_ip_net {
 	struct nf_udp_net	udp;
 	struct nf_icmp_net	icmp;
 	struct nf_icmp_net	icmpv6;
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	struct nf_dccp_net	dccp;
-#endif
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 	struct nf_sctp_net	sctp;
 #endif
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 2560416218d0..ba60b48d7567 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -195,16 +195,6 @@ config NF_CONNTRACK_LABELS
 config NF_CONNTRACK_OVS
 	bool
 
-config NF_CT_PROTO_DCCP
-	bool 'DCCP protocol connection tracking support'
-	depends on NETFILTER_ADVANCED
-	default y
-	help
-	  With this option enabled, the layer 3 independent connection
-	  tracking code will be able to do state tracking on DCCP connections.
-
-	  If unsure, say Y.
-
 config NF_CT_PROTO_GRE
 	bool
 
@@ -516,6 +506,12 @@ config NFT_CT
 	  This option adds the "ct" expression that you can use to match
 	  connection tracking information such as the flow state.
 
+config NFT_EXTHDR_DCCP
+	bool "Netfilter nf_tables exthdr DCCP support (DEPRECATED)"
+	default n
+	help
+	  This option adds support for matching on DCCP extension headers.
+
 config NFT_FLOW_OFFLOAD
 	depends on NF_CONNTRACK && NF_FLOW_TABLE
 	tristate "Netfilter nf_tables hardware flow offload module"
@@ -1278,9 +1274,9 @@ config NETFILTER_XT_MATCH_CPU
 	  To compile it as a module, choose M here.  If unsure, say N.
 
 config NETFILTER_XT_MATCH_DCCP
-	tristate '"dccp" protocol match support'
+	tristate '"dccp" protocol match support (DEPRECATED)'
 	depends on NETFILTER_ADVANCED
-	default IP_DCCP
+	default n
 	help
 	  With this option enabled, you will be able to use the iptables
 	  `dccp' match in order to match on DCCP source/destination ports
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index f0aa4d7ef499..e43e20f529f8 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -12,7 +12,6 @@ nf_conntrack-$(CONFIG_NF_CONNTRACK_TIMESTAMP) += nf_conntrack_timestamp.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_EVENTS) += nf_conntrack_ecache.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_LABELS) += nf_conntrack_labels.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_OVS) += nf_conntrack_ovs.o
-nf_conntrack-$(CONFIG_NF_CT_PROTO_DCCP) += nf_conntrack_proto_dccp.o
 nf_conntrack-$(CONFIG_NF_CT_PROTO_SCTP) += nf_conntrack_proto_sctp.o
 nf_conntrack-$(CONFIG_NF_CT_PROTO_GRE) += nf_conntrack_proto_gre.o
 ifeq ($(CONFIG_NF_CONNTRACK),m)
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 201d3c4ec623..1097f26a6788 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -328,9 +328,6 @@ nf_ct_get_tuple(const struct sk_buff *skb,
 #endif
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 	case IPPROTO_SCTP:
-#endif
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	case IPPROTO_DCCP:
 #endif
 		/* fallthrough */
 		return nf_ct_get_tuple_ports(skb, dataoff, tuple);
@@ -1982,11 +1979,6 @@ static int nf_conntrack_handle_packet(struct nf_conn *ct,
 		return nf_conntrack_sctp_packet(ct, skb, dataoff,
 						ctinfo, state);
 #endif
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	case IPPROTO_DCCP:
-		return nf_conntrack_dccp_packet(ct, skb, dataoff,
-						ctinfo, state);
-#endif
 #ifdef CONFIG_NF_CT_PROTO_GRE
 	case IPPROTO_GRE:
 		return nf_conntrack_gre_packet(ct, skb, dataoff,
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 2cc0fde23344..486d52b45fe5 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2036,7 +2036,6 @@ static void ctnetlink_change_mark(struct nf_conn *ct,
 
 static const struct nla_policy protoinfo_policy[CTA_PROTOINFO_MAX+1] = {
 	[CTA_PROTOINFO_TCP]	= { .type = NLA_NESTED },
-	[CTA_PROTOINFO_DCCP]	= { .type = NLA_NESTED },
 	[CTA_PROTOINFO_SCTP]	= { .type = NLA_NESTED },
 };
 
diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index f36727ed91e1..bc1d96686b9c 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -100,9 +100,6 @@ const struct nf_conntrack_l4proto *nf_ct_l4proto_find(u8 l4proto)
 	case IPPROTO_UDP: return &nf_conntrack_l4proto_udp;
 	case IPPROTO_TCP: return &nf_conntrack_l4proto_tcp;
 	case IPPROTO_ICMP: return &nf_conntrack_l4proto_icmp;
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	case IPPROTO_DCCP: return &nf_conntrack_l4proto_dccp;
-#endif
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 	case IPPROTO_SCTP: return &nf_conntrack_l4proto_sctp;
 #endif
@@ -681,9 +678,6 @@ void nf_conntrack_proto_pernet_init(struct net *net)
 #if IS_ENABLED(CONFIG_IPV6)
 	nf_conntrack_icmpv6_init_net(net);
 #endif
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	nf_conntrack_dccp_init_net(net);
-#endif
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 	nf_conntrack_sctp_init_net(net);
 #endif
diff --git a/net/netfilter/nf_conntrack_proto_dccp.c b/net/netfilter/nf_conntrack_proto_dccp.c
deleted file mode 100644
index ebc4f733bb2e..000000000000
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ /dev/null
@@ -1,826 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * DCCP connection tracking protocol helper
- *
- * Copyright (c) 2005, 2006, 2008 Patrick McHardy <kaber@trash.net>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/sysctl.h>
-#include <linux/spinlock.h>
-#include <linux/skbuff.h>
-#include <linux/dccp.h>
-#include <linux/slab.h>
-
-#include <net/net_namespace.h>
-#include <net/netns/generic.h>
-
-#include <linux/netfilter/nfnetlink_conntrack.h>
-#include <net/netfilter/nf_conntrack.h>
-#include <net/netfilter/nf_conntrack_l4proto.h>
-#include <net/netfilter/nf_conntrack_ecache.h>
-#include <net/netfilter/nf_conntrack_timeout.h>
-#include <net/netfilter/nf_log.h>
-
-/* Timeouts are based on values from RFC4340:
- *
- * - REQUEST:
- *
- *   8.1.2. Client Request
- *
- *   A client MAY give up on its DCCP-Requests after some time
- *   (3 minutes, for example).
- *
- * - RESPOND:
- *
- *   8.1.3. Server Response
- *
- *   It MAY also leave the RESPOND state for CLOSED after a timeout of
- *   not less than 4MSL (8 minutes);
- *
- * - PARTOPEN:
- *
- *   8.1.5. Handshake Completion
- *
- *   If the client remains in PARTOPEN for more than 4MSL (8 minutes),
- *   it SHOULD reset the connection with Reset Code 2, "Aborted".
- *
- * - OPEN:
- *
- *   The DCCP timestamp overflows after 11.9 hours. If the connection
- *   stays idle this long the sequence number won't be recognized
- *   as valid anymore.
- *
- * - CLOSEREQ/CLOSING:
- *
- *   8.3. Termination
- *
- *   The retransmission timer should initially be set to go off in two
- *   round-trip times and should back off to not less than once every
- *   64 seconds ...
- *
- * - TIMEWAIT:
- *
- *   4.3. States
- *
- *   A server or client socket remains in this state for 2MSL (4 minutes)
- *   after the connection has been town down, ...
- */
-
-#define DCCP_MSL (2 * 60 * HZ)
-
-#ifdef CONFIG_NF_CONNTRACK_PROCFS
-static const char * const dccp_state_names[] = {
-	[CT_DCCP_NONE]		= "NONE",
-	[CT_DCCP_REQUEST]	= "REQUEST",
-	[CT_DCCP_RESPOND]	= "RESPOND",
-	[CT_DCCP_PARTOPEN]	= "PARTOPEN",
-	[CT_DCCP_OPEN]		= "OPEN",
-	[CT_DCCP_CLOSEREQ]	= "CLOSEREQ",
-	[CT_DCCP_CLOSING]	= "CLOSING",
-	[CT_DCCP_TIMEWAIT]	= "TIMEWAIT",
-	[CT_DCCP_IGNORE]	= "IGNORE",
-	[CT_DCCP_INVALID]	= "INVALID",
-};
-#endif
-
-#define sNO	CT_DCCP_NONE
-#define sRQ	CT_DCCP_REQUEST
-#define sRS	CT_DCCP_RESPOND
-#define sPO	CT_DCCP_PARTOPEN
-#define sOP	CT_DCCP_OPEN
-#define sCR	CT_DCCP_CLOSEREQ
-#define sCG	CT_DCCP_CLOSING
-#define sTW	CT_DCCP_TIMEWAIT
-#define sIG	CT_DCCP_IGNORE
-#define sIV	CT_DCCP_INVALID
-
-/*
- * DCCP state transition table
- *
- * The assumption is the same as for TCP tracking:
- *
- * We are the man in the middle. All the packets go through us but might
- * get lost in transit to the destination. It is assumed that the destination
- * can't receive segments we haven't seen.
- *
- * The following states exist:
- *
- * NONE:	Initial state, expecting Request
- * REQUEST:	Request seen, waiting for Response from server
- * RESPOND:	Response from server seen, waiting for Ack from client
- * PARTOPEN:	Ack after Response seen, waiting for packet other than Response,
- * 		Reset or Sync from server
- * OPEN:	Packet other than Response, Reset or Sync seen
- * CLOSEREQ:	CloseReq from server seen, expecting Close from client
- * CLOSING:	Close seen, expecting Reset
- * TIMEWAIT:	Reset seen
- * IGNORE:	Not determinable whether packet is valid
- *
- * Some states exist only on one side of the connection: REQUEST, RESPOND,
- * PARTOPEN, CLOSEREQ. For the other side these states are equivalent to
- * the one it was in before.
- *
- * Packets are marked as ignored (sIG) if we don't know if they're valid
- * (for example a reincarnation of a connection we didn't notice is dead
- * already) and the server may send back a connection closing Reset or a
- * Response. They're also used for Sync/SyncAck packets, which we don't
- * care about.
- */
-static const u_int8_t
-dccp_state_table[CT_DCCP_ROLE_MAX + 1][DCCP_PKT_SYNCACK + 1][CT_DCCP_MAX + 1] = {
-	[CT_DCCP_ROLE_CLIENT] = {
-		[DCCP_PKT_REQUEST] = {
-		/*
-		 * sNO -> sRQ		Regular Request
-		 * sRQ -> sRQ		Retransmitted Request or reincarnation
-		 * sRS -> sRS		Retransmitted Request (apparently Response
-		 * 			got lost after we saw it) or reincarnation
-		 * sPO -> sIG		Ignore, conntrack might be out of sync
-		 * sOP -> sIG		Ignore, conntrack might be out of sync
-		 * sCR -> sIG		Ignore, conntrack might be out of sync
-		 * sCG -> sIG		Ignore, conntrack might be out of sync
-		 * sTW -> sRQ		Reincarnation
-		 *
-		 *	sNO, sRQ, sRS, sPO. sOP, sCR, sCG, sTW, */
-			sRQ, sRQ, sRS, sIG, sIG, sIG, sIG, sRQ,
-		},
-		[DCCP_PKT_RESPONSE] = {
-		/*
-		 * sNO -> sIV		Invalid
-		 * sRQ -> sIG		Ignore, might be response to ignored Request
-		 * sRS -> sIG		Ignore, might be response to ignored Request
-		 * sPO -> sIG		Ignore, might be response to ignored Request
-		 * sOP -> sIG		Ignore, might be response to ignored Request
-		 * sCR -> sIG		Ignore, might be response to ignored Request
-		 * sCG -> sIG		Ignore, might be response to ignored Request
-		 * sTW -> sIV		Invalid, reincarnation in reverse direction
-		 *			goes through sRQ
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIV,
-		},
-		[DCCP_PKT_ACK] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sPO		Ack for Response, move to PARTOPEN (8.1.5.)
-		 * sPO -> sPO		Retransmitted Ack for Response, remain in PARTOPEN
-		 * sOP -> sOP		Regular ACK, remain in OPEN
-		 * sCR -> sCR		Ack in CLOSEREQ MAY be processed (8.3.)
-		 * sCG -> sCG		Ack in CLOSING MAY be processed (8.3.)
-		 * sTW -> sIV
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sPO, sPO, sOP, sCR, sCG, sIV
-		},
-		[DCCP_PKT_DATA] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sIV		MUST use DataAck in PARTOPEN state (8.1.5.)
-		 * sOP -> sOP		Regular Data packet
-		 * sCR -> sCR		Data in CLOSEREQ MAY be processed (8.3.)
-		 * sCG -> sCG		Data in CLOSING MAY be processed (8.3.)
-		 * sTW -> sIV
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sIV, sOP, sCR, sCG, sIV,
-		},
-		[DCCP_PKT_DATAACK] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sPO		Ack for Response, move to PARTOPEN (8.1.5.)
-		 * sPO -> sPO		Remain in PARTOPEN state
-		 * sOP -> sOP		Regular DataAck packet in OPEN state
-		 * sCR -> sCR		DataAck in CLOSEREQ MAY be processed (8.3.)
-		 * sCG -> sCG		DataAck in CLOSING MAY be processed (8.3.)
-		 * sTW -> sIV
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sPO, sPO, sOP, sCR, sCG, sIV
-		},
-		[DCCP_PKT_CLOSEREQ] = {
-		/*
-		 * CLOSEREQ may only be sent by the server.
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sIV, sIV, sIV, sIV, sIV
-		},
-		[DCCP_PKT_CLOSE] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sCG		Client-initiated close
-		 * sOP -> sCG		Client-initiated close
-		 * sCR -> sCG		Close in response to CloseReq (8.3.)
-		 * sCG -> sCG		Retransmit
-		 * sTW -> sIV		Late retransmit, already in TIME_WAIT
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sCG, sCG, sCG, sIV, sIV
-		},
-		[DCCP_PKT_RESET] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sTW		Sync received or timeout, SHOULD send Reset (8.1.1.)
-		 * sRS -> sTW		Response received without Request
-		 * sPO -> sTW		Timeout, SHOULD send Reset (8.1.5.)
-		 * sOP -> sTW		Connection reset
-		 * sCR -> sTW		Connection reset
-		 * sCG -> sTW		Connection reset
-		 * sTW -> sIG		Ignore (don't refresh timer)
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sTW, sTW, sTW, sTW, sTW, sTW, sIG
-		},
-		[DCCP_PKT_SYNC] = {
-		/*
-		 * We currently ignore Sync packets
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
-		},
-		[DCCP_PKT_SYNCACK] = {
-		/*
-		 * We currently ignore SyncAck packets
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
-		},
-	},
-	[CT_DCCP_ROLE_SERVER] = {
-		[DCCP_PKT_REQUEST] = {
-		/*
-		 * sNO -> sIV		Invalid
-		 * sRQ -> sIG		Ignore, conntrack might be out of sync
-		 * sRS -> sIG		Ignore, conntrack might be out of sync
-		 * sPO -> sIG		Ignore, conntrack might be out of sync
-		 * sOP -> sIG		Ignore, conntrack might be out of sync
-		 * sCR -> sIG		Ignore, conntrack might be out of sync
-		 * sCG -> sIG		Ignore, conntrack might be out of sync
-		 * sTW -> sRQ		Reincarnation, must reverse roles
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sRQ
-		},
-		[DCCP_PKT_RESPONSE] = {
-		/*
-		 * sNO -> sIV		Response without Request
-		 * sRQ -> sRS		Response to clients Request
-		 * sRS -> sRS		Retransmitted Response (8.1.3. SHOULD NOT)
-		 * sPO -> sIG		Response to an ignored Request or late retransmit
-		 * sOP -> sIG		Ignore, might be response to ignored Request
-		 * sCR -> sIG		Ignore, might be response to ignored Request
-		 * sCG -> sIG		Ignore, might be response to ignored Request
-		 * sTW -> sIV		Invalid, Request from client in sTW moves to sRQ
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sRS, sRS, sIG, sIG, sIG, sIG, sIV
-		},
-		[DCCP_PKT_ACK] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sOP		Enter OPEN state (8.1.5.)
-		 * sOP -> sOP		Regular Ack in OPEN state
-		 * sCR -> sIV		Waiting for Close from client
-		 * sCG -> sCG		Ack in CLOSING MAY be processed (8.3.)
-		 * sTW -> sIV
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sOP, sOP, sIV, sCG, sIV
-		},
-		[DCCP_PKT_DATA] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sOP		Enter OPEN state (8.1.5.)
-		 * sOP -> sOP		Regular Data packet in OPEN state
-		 * sCR -> sIV		Waiting for Close from client
-		 * sCG -> sCG		Data in CLOSING MAY be processed (8.3.)
-		 * sTW -> sIV
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sOP, sOP, sIV, sCG, sIV
-		},
-		[DCCP_PKT_DATAACK] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sOP		Enter OPEN state (8.1.5.)
-		 * sOP -> sOP		Regular DataAck in OPEN state
-		 * sCR -> sIV		Waiting for Close from client
-		 * sCG -> sCG		Data in CLOSING MAY be processed (8.3.)
-		 * sTW -> sIV
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sOP, sOP, sIV, sCG, sIV
-		},
-		[DCCP_PKT_CLOSEREQ] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sOP -> sCR	Move directly to CLOSEREQ (8.1.5.)
-		 * sOP -> sCR		CloseReq in OPEN state
-		 * sCR -> sCR		Retransmit
-		 * sCG -> sCR		Simultaneous close, client sends another Close
-		 * sTW -> sIV		Already closed
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sCR, sCR, sCR, sCR, sIV
-		},
-		[DCCP_PKT_CLOSE] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sIV		No connection
-		 * sRS -> sIV		No connection
-		 * sPO -> sOP -> sCG	Move direcly to CLOSING
-		 * sOP -> sCG		Move to CLOSING
-		 * sCR -> sIV		Close after CloseReq is invalid
-		 * sCG -> sCG		Retransmit
-		 * sTW -> sIV		Already closed
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIV, sIV, sCG, sCG, sIV, sCG, sIV
-		},
-		[DCCP_PKT_RESET] = {
-		/*
-		 * sNO -> sIV		No connection
-		 * sRQ -> sTW		Reset in response to Request
-		 * sRS -> sTW		Timeout, SHOULD send Reset (8.1.3.)
-		 * sPO -> sTW		Timeout, SHOULD send Reset (8.1.3.)
-		 * sOP -> sTW
-		 * sCR -> sTW
-		 * sCG -> sTW
-		 * sTW -> sIG		Ignore (don't refresh timer)
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW, sTW */
-			sIV, sTW, sTW, sTW, sTW, sTW, sTW, sTW, sIG
-		},
-		[DCCP_PKT_SYNC] = {
-		/*
-		 * We currently ignore Sync packets
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
-		},
-		[DCCP_PKT_SYNCACK] = {
-		/*
-		 * We currently ignore SyncAck packets
-		 *
-		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
-		},
-	},
-};
-
-static noinline bool
-dccp_new(struct nf_conn *ct, const struct sk_buff *skb,
-	 const struct dccp_hdr *dh,
-	 const struct nf_hook_state *hook_state)
-{
-	struct net *net = nf_ct_net(ct);
-	struct nf_dccp_net *dn;
-	const char *msg;
-	u_int8_t state;
-
-	state = dccp_state_table[CT_DCCP_ROLE_CLIENT][dh->dccph_type][CT_DCCP_NONE];
-	switch (state) {
-	default:
-		dn = nf_dccp_pernet(net);
-		if (dn->dccp_loose == 0) {
-			msg = "not picking up existing connection ";
-			goto out_invalid;
-		}
-		break;
-	case CT_DCCP_REQUEST:
-		break;
-	case CT_DCCP_INVALID:
-		msg = "invalid state transition ";
-		goto out_invalid;
-	}
-
-	ct->proto.dccp.role[IP_CT_DIR_ORIGINAL] = CT_DCCP_ROLE_CLIENT;
-	ct->proto.dccp.role[IP_CT_DIR_REPLY] = CT_DCCP_ROLE_SERVER;
-	ct->proto.dccp.state = CT_DCCP_NONE;
-	ct->proto.dccp.last_pkt = DCCP_PKT_REQUEST;
-	ct->proto.dccp.last_dir = IP_CT_DIR_ORIGINAL;
-	ct->proto.dccp.handshake_seq = 0;
-	return true;
-
-out_invalid:
-	nf_ct_l4proto_log_invalid(skb, ct, hook_state, "%s", msg);
-	return false;
-}
-
-static u64 dccp_ack_seq(const struct dccp_hdr *dh)
-{
-	const struct dccp_hdr_ack_bits *dhack;
-
-	dhack = (void *)dh + __dccp_basic_hdr_len(dh);
-	return ((u64)ntohs(dhack->dccph_ack_nr_high) << 32) +
-		     ntohl(dhack->dccph_ack_nr_low);
-}
-
-static bool dccp_error(const struct dccp_hdr *dh,
-		       struct sk_buff *skb, unsigned int dataoff,
-		       const struct nf_hook_state *state)
-{
-	static const unsigned long require_seq48 = 1 << DCCP_PKT_REQUEST |
-						   1 << DCCP_PKT_RESPONSE |
-						   1 << DCCP_PKT_CLOSEREQ |
-						   1 << DCCP_PKT_CLOSE |
-						   1 << DCCP_PKT_RESET |
-						   1 << DCCP_PKT_SYNC |
-						   1 << DCCP_PKT_SYNCACK;
-	unsigned int dccp_len = skb->len - dataoff;
-	unsigned int cscov;
-	const char *msg;
-	u8 type;
-
-	BUILD_BUG_ON(DCCP_PKT_INVALID >= BITS_PER_LONG);
-
-	if (dh->dccph_doff * 4 < sizeof(struct dccp_hdr) ||
-	    dh->dccph_doff * 4 > dccp_len) {
-		msg = "nf_ct_dccp: truncated/malformed packet ";
-		goto out_invalid;
-	}
-
-	cscov = dccp_len;
-	if (dh->dccph_cscov) {
-		cscov = (dh->dccph_cscov - 1) * 4;
-		if (cscov > dccp_len) {
-			msg = "nf_ct_dccp: bad checksum coverage ";
-			goto out_invalid;
-		}
-	}
-
-	if (state->hook == NF_INET_PRE_ROUTING &&
-	    state->net->ct.sysctl_checksum &&
-	    nf_checksum_partial(skb, state->hook, dataoff, cscov,
-				IPPROTO_DCCP, state->pf)) {
-		msg = "nf_ct_dccp: bad checksum ";
-		goto out_invalid;
-	}
-
-	type = dh->dccph_type;
-	if (type >= DCCP_PKT_INVALID) {
-		msg = "nf_ct_dccp: reserved packet type ";
-		goto out_invalid;
-	}
-
-	if (test_bit(type, &require_seq48) && !dh->dccph_x) {
-		msg = "nf_ct_dccp: type lacks 48bit sequence numbers";
-		goto out_invalid;
-	}
-
-	return false;
-out_invalid:
-	nf_l4proto_log_invalid(skb, state, IPPROTO_DCCP, "%s", msg);
-	return true;
-}
-
-struct nf_conntrack_dccp_buf {
-	struct dccp_hdr dh;	 /* generic header part */
-	struct dccp_hdr_ext ext; /* optional depending dh->dccph_x */
-	union {			 /* depends on header type */
-		struct dccp_hdr_ack_bits ack;
-		struct dccp_hdr_request req;
-		struct dccp_hdr_response response;
-		struct dccp_hdr_reset rst;
-	} u;
-};
-
-static struct dccp_hdr *
-dccp_header_pointer(const struct sk_buff *skb, int offset, const struct dccp_hdr *dh,
-		    struct nf_conntrack_dccp_buf *buf)
-{
-	unsigned int hdrlen = __dccp_hdr_len(dh);
-
-	if (hdrlen > sizeof(*buf))
-		return NULL;
-
-	return skb_header_pointer(skb, offset, hdrlen, buf);
-}
-
-int nf_conntrack_dccp_packet(struct nf_conn *ct, struct sk_buff *skb,
-			     unsigned int dataoff,
-			     enum ip_conntrack_info ctinfo,
-			     const struct nf_hook_state *state)
-{
-	enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
-	struct nf_conntrack_dccp_buf _dh;
-	u_int8_t type, old_state, new_state;
-	enum ct_dccp_roles role;
-	unsigned int *timeouts;
-	struct dccp_hdr *dh;
-
-	dh = skb_header_pointer(skb, dataoff, sizeof(*dh), &_dh.dh);
-	if (!dh)
-		return -NF_ACCEPT;
-
-	if (dccp_error(dh, skb, dataoff, state))
-		return -NF_ACCEPT;
-
-	/* pull again, including possible 48 bit sequences and subtype header */
-	dh = dccp_header_pointer(skb, dataoff, dh, &_dh);
-	if (!dh)
-		return -NF_ACCEPT;
-
-	type = dh->dccph_type;
-	if (!nf_ct_is_confirmed(ct) && !dccp_new(ct, skb, dh, state))
-		return -NF_ACCEPT;
-
-	if (type == DCCP_PKT_RESET &&
-	    !test_bit(IPS_SEEN_REPLY_BIT, &ct->status)) {
-		/* Tear down connection immediately if only reply is a RESET */
-		nf_ct_kill_acct(ct, ctinfo, skb);
-		return NF_ACCEPT;
-	}
-
-	spin_lock_bh(&ct->lock);
-
-	role = ct->proto.dccp.role[dir];
-	old_state = ct->proto.dccp.state;
-	new_state = dccp_state_table[role][type][old_state];
-
-	switch (new_state) {
-	case CT_DCCP_REQUEST:
-		if (old_state == CT_DCCP_TIMEWAIT &&
-		    role == CT_DCCP_ROLE_SERVER) {
-			/* Reincarnation in the reverse direction: reopen and
-			 * reverse client/server roles. */
-			ct->proto.dccp.role[dir] = CT_DCCP_ROLE_CLIENT;
-			ct->proto.dccp.role[!dir] = CT_DCCP_ROLE_SERVER;
-		}
-		break;
-	case CT_DCCP_RESPOND:
-		if (old_state == CT_DCCP_REQUEST)
-			ct->proto.dccp.handshake_seq = dccp_hdr_seq(dh);
-		break;
-	case CT_DCCP_PARTOPEN:
-		if (old_state == CT_DCCP_RESPOND &&
-		    type == DCCP_PKT_ACK &&
-		    dccp_ack_seq(dh) == ct->proto.dccp.handshake_seq)
-			set_bit(IPS_ASSURED_BIT, &ct->status);
-		break;
-	case CT_DCCP_IGNORE:
-		/*
-		 * Connection tracking might be out of sync, so we ignore
-		 * packets that might establish a new connection and resync
-		 * if the server responds with a valid Response.
-		 */
-		if (ct->proto.dccp.last_dir == !dir &&
-		    ct->proto.dccp.last_pkt == DCCP_PKT_REQUEST &&
-		    type == DCCP_PKT_RESPONSE) {
-			ct->proto.dccp.role[!dir] = CT_DCCP_ROLE_CLIENT;
-			ct->proto.dccp.role[dir] = CT_DCCP_ROLE_SERVER;
-			ct->proto.dccp.handshake_seq = dccp_hdr_seq(dh);
-			new_state = CT_DCCP_RESPOND;
-			break;
-		}
-		ct->proto.dccp.last_dir = dir;
-		ct->proto.dccp.last_pkt = type;
-
-		spin_unlock_bh(&ct->lock);
-		nf_ct_l4proto_log_invalid(skb, ct, state, "%s", "invalid packet");
-		return NF_ACCEPT;
-	case CT_DCCP_INVALID:
-		spin_unlock_bh(&ct->lock);
-		nf_ct_l4proto_log_invalid(skb, ct, state, "%s", "invalid state transition");
-		return -NF_ACCEPT;
-	}
-
-	ct->proto.dccp.last_dir = dir;
-	ct->proto.dccp.last_pkt = type;
-	ct->proto.dccp.state = new_state;
-	spin_unlock_bh(&ct->lock);
-
-	if (new_state != old_state)
-		nf_conntrack_event_cache(IPCT_PROTOINFO, ct);
-
-	timeouts = nf_ct_timeout_lookup(ct);
-	if (!timeouts)
-		timeouts = nf_dccp_pernet(nf_ct_net(ct))->dccp_timeout;
-	nf_ct_refresh_acct(ct, ctinfo, skb, timeouts[new_state]);
-
-	return NF_ACCEPT;
-}
-
-static bool dccp_can_early_drop(const struct nf_conn *ct)
-{
-	switch (ct->proto.dccp.state) {
-	case CT_DCCP_CLOSEREQ:
-	case CT_DCCP_CLOSING:
-	case CT_DCCP_TIMEWAIT:
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
-#ifdef CONFIG_NF_CONNTRACK_PROCFS
-static void dccp_print_conntrack(struct seq_file *s, struct nf_conn *ct)
-{
-	seq_printf(s, "%s ", dccp_state_names[ct->proto.dccp.state]);
-}
-#endif
-
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK)
-static int dccp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
-			  struct nf_conn *ct, bool destroy)
-{
-	struct nlattr *nest_parms;
-
-	spin_lock_bh(&ct->lock);
-	nest_parms = nla_nest_start(skb, CTA_PROTOINFO_DCCP);
-	if (!nest_parms)
-		goto nla_put_failure;
-	if (nla_put_u8(skb, CTA_PROTOINFO_DCCP_STATE, ct->proto.dccp.state))
-		goto nla_put_failure;
-
-	if (destroy)
-		goto skip_state;
-
-	if (nla_put_u8(skb, CTA_PROTOINFO_DCCP_ROLE,
-		       ct->proto.dccp.role[IP_CT_DIR_ORIGINAL]) ||
-	    nla_put_be64(skb, CTA_PROTOINFO_DCCP_HANDSHAKE_SEQ,
-			 cpu_to_be64(ct->proto.dccp.handshake_seq),
-			 CTA_PROTOINFO_DCCP_PAD))
-		goto nla_put_failure;
-skip_state:
-	nla_nest_end(skb, nest_parms);
-	spin_unlock_bh(&ct->lock);
-
-	return 0;
-
-nla_put_failure:
-	spin_unlock_bh(&ct->lock);
-	return -1;
-}
-
-static const struct nla_policy dccp_nla_policy[CTA_PROTOINFO_DCCP_MAX + 1] = {
-	[CTA_PROTOINFO_DCCP_STATE]	= { .type = NLA_U8 },
-	[CTA_PROTOINFO_DCCP_ROLE]	= { .type = NLA_U8 },
-	[CTA_PROTOINFO_DCCP_HANDSHAKE_SEQ] = { .type = NLA_U64 },
-	[CTA_PROTOINFO_DCCP_PAD]	= { .type = NLA_UNSPEC },
-};
-
-#define DCCP_NLATTR_SIZE ( \
-	NLA_ALIGN(NLA_HDRLEN + 1) + \
-	NLA_ALIGN(NLA_HDRLEN + 1) + \
-	NLA_ALIGN(NLA_HDRLEN + sizeof(u64)) + \
-	NLA_ALIGN(NLA_HDRLEN + 0))
-
-static int nlattr_to_dccp(struct nlattr *cda[], struct nf_conn *ct)
-{
-	struct nlattr *attr = cda[CTA_PROTOINFO_DCCP];
-	struct nlattr *tb[CTA_PROTOINFO_DCCP_MAX + 1];
-	int err;
-
-	if (!attr)
-		return 0;
-
-	err = nla_parse_nested_deprecated(tb, CTA_PROTOINFO_DCCP_MAX, attr,
-					  dccp_nla_policy, NULL);
-	if (err < 0)
-		return err;
-
-	if (!tb[CTA_PROTOINFO_DCCP_STATE] ||
-	    !tb[CTA_PROTOINFO_DCCP_ROLE] ||
-	    nla_get_u8(tb[CTA_PROTOINFO_DCCP_ROLE]) > CT_DCCP_ROLE_MAX ||
-	    nla_get_u8(tb[CTA_PROTOINFO_DCCP_STATE]) >= CT_DCCP_IGNORE) {
-		return -EINVAL;
-	}
-
-	spin_lock_bh(&ct->lock);
-	ct->proto.dccp.state = nla_get_u8(tb[CTA_PROTOINFO_DCCP_STATE]);
-	if (nla_get_u8(tb[CTA_PROTOINFO_DCCP_ROLE]) == CT_DCCP_ROLE_CLIENT) {
-		ct->proto.dccp.role[IP_CT_DIR_ORIGINAL] = CT_DCCP_ROLE_CLIENT;
-		ct->proto.dccp.role[IP_CT_DIR_REPLY] = CT_DCCP_ROLE_SERVER;
-	} else {
-		ct->proto.dccp.role[IP_CT_DIR_ORIGINAL] = CT_DCCP_ROLE_SERVER;
-		ct->proto.dccp.role[IP_CT_DIR_REPLY] = CT_DCCP_ROLE_CLIENT;
-	}
-	if (tb[CTA_PROTOINFO_DCCP_HANDSHAKE_SEQ]) {
-		ct->proto.dccp.handshake_seq =
-		be64_to_cpu(nla_get_be64(tb[CTA_PROTOINFO_DCCP_HANDSHAKE_SEQ]));
-	}
-	spin_unlock_bh(&ct->lock);
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
-
-#include <linux/netfilter/nfnetlink.h>
-#include <linux/netfilter/nfnetlink_cttimeout.h>
-
-static int dccp_timeout_nlattr_to_obj(struct nlattr *tb[],
-				      struct net *net, void *data)
-{
-	struct nf_dccp_net *dn = nf_dccp_pernet(net);
-	unsigned int *timeouts = data;
-	int i;
-
-	if (!timeouts)
-		 timeouts = dn->dccp_timeout;
-
-	/* set default DCCP timeouts. */
-	for (i=0; i<CT_DCCP_MAX; i++)
-		timeouts[i] = dn->dccp_timeout[i];
-
-	/* there's a 1:1 mapping between attributes and protocol states. */
-	for (i=CTA_TIMEOUT_DCCP_UNSPEC+1; i<CTA_TIMEOUT_DCCP_MAX+1; i++) {
-		if (tb[i]) {
-			timeouts[i] = ntohl(nla_get_be32(tb[i])) * HZ;
-		}
-	}
-
-	timeouts[CTA_TIMEOUT_DCCP_UNSPEC] = timeouts[CTA_TIMEOUT_DCCP_REQUEST];
-	return 0;
-}
-
-static int
-dccp_timeout_obj_to_nlattr(struct sk_buff *skb, const void *data)
-{
-        const unsigned int *timeouts = data;
-	int i;
-
-	for (i=CTA_TIMEOUT_DCCP_UNSPEC+1; i<CTA_TIMEOUT_DCCP_MAX+1; i++) {
-		if (nla_put_be32(skb, i, htonl(timeouts[i] / HZ)))
-			goto nla_put_failure;
-	}
-	return 0;
-
-nla_put_failure:
-	return -ENOSPC;
-}
-
-static const struct nla_policy
-dccp_timeout_nla_policy[CTA_TIMEOUT_DCCP_MAX+1] = {
-	[CTA_TIMEOUT_DCCP_REQUEST]	= { .type = NLA_U32 },
-	[CTA_TIMEOUT_DCCP_RESPOND]	= { .type = NLA_U32 },
-	[CTA_TIMEOUT_DCCP_PARTOPEN]	= { .type = NLA_U32 },
-	[CTA_TIMEOUT_DCCP_OPEN]		= { .type = NLA_U32 },
-	[CTA_TIMEOUT_DCCP_CLOSEREQ]	= { .type = NLA_U32 },
-	[CTA_TIMEOUT_DCCP_CLOSING]	= { .type = NLA_U32 },
-	[CTA_TIMEOUT_DCCP_TIMEWAIT]	= { .type = NLA_U32 },
-};
-#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
-
-void nf_conntrack_dccp_init_net(struct net *net)
-{
-	struct nf_dccp_net *dn = nf_dccp_pernet(net);
-
-	/* default values */
-	dn->dccp_loose = 1;
-	dn->dccp_timeout[CT_DCCP_REQUEST]	= 2 * DCCP_MSL;
-	dn->dccp_timeout[CT_DCCP_RESPOND]	= 4 * DCCP_MSL;
-	dn->dccp_timeout[CT_DCCP_PARTOPEN]	= 4 * DCCP_MSL;
-	dn->dccp_timeout[CT_DCCP_OPEN]		= 12 * 3600 * HZ;
-	dn->dccp_timeout[CT_DCCP_CLOSEREQ]	= 64 * HZ;
-	dn->dccp_timeout[CT_DCCP_CLOSING]	= 64 * HZ;
-	dn->dccp_timeout[CT_DCCP_TIMEWAIT]	= 2 * DCCP_MSL;
-
-	/* timeouts[0] is unused, make it same as SYN_SENT so
-	 * ->timeouts[0] contains 'new' timeout, like udp or icmp.
-	 */
-	dn->dccp_timeout[CT_DCCP_NONE] = dn->dccp_timeout[CT_DCCP_REQUEST];
-}
-
-const struct nf_conntrack_l4proto nf_conntrack_l4proto_dccp = {
-	.l4proto		= IPPROTO_DCCP,
-	.can_early_drop		= dccp_can_early_drop,
-#ifdef CONFIG_NF_CONNTRACK_PROCFS
-	.print_conntrack	= dccp_print_conntrack,
-#endif
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK)
-	.nlattr_size		= DCCP_NLATTR_SIZE,
-	.to_nlattr		= dccp_to_nlattr,
-	.from_nlattr		= nlattr_to_dccp,
-	.tuple_to_nlattr	= nf_ct_port_tuple_to_nlattr,
-	.nlattr_tuple_size	= nf_ct_port_nlattr_tuple_size,
-	.nlattr_to_tuple	= nf_ct_port_nlattr_to_tuple,
-	.nla_policy		= nf_ct_port_nla_policy,
-#endif
-#ifdef CONFIG_NF_CONNTRACK_TIMEOUT
-	.ctnl_timeout		= {
-		.nlattr_to_obj	= dccp_timeout_nlattr_to_obj,
-		.obj_to_nlattr	= dccp_timeout_obj_to_nlattr,
-		.nlattr_max	= CTA_TIMEOUT_DCCP_MAX,
-		.obj_size	= sizeof(unsigned int) * CT_DCCP_MAX,
-		.nla_policy	= dccp_timeout_nla_policy,
-	},
-#endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
-};
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 6c4cff10357d..829f60496008 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -67,11 +67,6 @@ print_tuple(struct seq_file *s, const struct nf_conntrack_tuple *tuple,
 			   ntohs(tuple->dst.u.udp.port));
 
 		break;
-	case IPPROTO_DCCP:
-		seq_printf(s, "sport=%hu dport=%hu ",
-			   ntohs(tuple->src.u.dccp.port),
-			   ntohs(tuple->dst.u.dccp.port));
-		break;
 	case IPPROTO_SCTP:
 		seq_printf(s, "sport=%hu dport=%hu ",
 			   ntohs(tuple->src.u.sctp.port),
@@ -279,7 +274,6 @@ static const char* l4proto_name(u16 proto)
 	case IPPROTO_ICMP: return "icmp";
 	case IPPROTO_TCP: return "tcp";
 	case IPPROTO_UDP: return "udp";
-	case IPPROTO_DCCP: return "dccp";
 	case IPPROTO_GRE: return "gre";
 	case IPPROTO_SCTP: return "sctp";
 	case IPPROTO_UDPLITE: return "udplite";
@@ -612,16 +606,6 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_ACK_SENT,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_HEARTBEAT_SENT,
 #endif
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_REQUEST,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_RESPOND,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_PARTOPEN,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_OPEN,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_CLOSEREQ,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_CLOSING,
-	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_TIMEWAIT,
-	NF_SYSCTL_CT_PROTO_DCCP_LOOSE,
-#endif
 #ifdef CONFIG_NF_CT_PROTO_GRE
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM,
@@ -895,58 +879,6 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.proc_handler	= proc_dointvec_jiffies,
 	},
 #endif
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_REQUEST] = {
-		.procname	= "nf_conntrack_dccp_timeout_request",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_RESPOND] = {
-		.procname	= "nf_conntrack_dccp_timeout_respond",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_PARTOPEN] = {
-		.procname	= "nf_conntrack_dccp_timeout_partopen",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_OPEN] = {
-		.procname	= "nf_conntrack_dccp_timeout_open",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_CLOSEREQ] = {
-		.procname	= "nf_conntrack_dccp_timeout_closereq",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_CLOSING] = {
-		.procname	= "nf_conntrack_dccp_timeout_closing",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_TIMEWAIT] = {
-		.procname	= "nf_conntrack_dccp_timeout_timewait",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	[NF_SYSCTL_CT_PROTO_DCCP_LOOSE] = {
-		.procname	= "nf_conntrack_dccp_loose",
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1 	= SYSCTL_ZERO,
-		.extra2 	= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_NF_CT_PROTO_GRE
 	[NF_SYSCTL_CT_PROTO_TIMEOUT_GRE] = {
 		.procname       = "nf_conntrack_gre_timeout",
@@ -1032,29 +964,6 @@ static void nf_conntrack_standalone_init_sctp_sysctl(struct net *net,
 #endif
 }
 
-static void nf_conntrack_standalone_init_dccp_sysctl(struct net *net,
-						     struct ctl_table *table)
-{
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	struct nf_dccp_net *dn = nf_dccp_pernet(net);
-
-#define XASSIGN(XNAME, dn) \
-	table[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_ ## XNAME].data = \
-			&(dn)->dccp_timeout[CT_DCCP_ ## XNAME]
-
-	XASSIGN(REQUEST, dn);
-	XASSIGN(RESPOND, dn);
-	XASSIGN(PARTOPEN, dn);
-	XASSIGN(OPEN, dn);
-	XASSIGN(CLOSEREQ, dn);
-	XASSIGN(CLOSING, dn);
-	XASSIGN(TIMEWAIT, dn);
-#undef XASSIGN
-
-	table[NF_SYSCTL_CT_PROTO_DCCP_LOOSE].data = &dn->dccp_loose;
-#endif
-}
-
 static void nf_conntrack_standalone_init_gre_sysctl(struct net *net,
 						    struct ctl_table *table)
 {
@@ -1100,7 +1009,6 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 
 	nf_conntrack_standalone_init_tcp_sysctl(net, table);
 	nf_conntrack_standalone_init_sctp_sysctl(net, table);
-	nf_conntrack_standalone_init_dccp_sysctl(net, table);
 	nf_conntrack_standalone_init_gre_sysctl(net, table);
 
 	/* Don't allow non-init_net ns to alter global sysctls */
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index f391cd267922..78a61dac4ade 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -69,7 +69,6 @@ static void nf_nat_ipv4_decode_session(struct sk_buff *skb,
 		if (t->dst.protonum == IPPROTO_TCP ||
 		    t->dst.protonum == IPPROTO_UDP ||
 		    t->dst.protonum == IPPROTO_UDPLITE ||
-		    t->dst.protonum == IPPROTO_DCCP ||
 		    t->dst.protonum == IPPROTO_SCTP)
 			fl4->fl4_dport = t->dst.u.all;
 	}
@@ -81,7 +80,6 @@ static void nf_nat_ipv4_decode_session(struct sk_buff *skb,
 		if (t->dst.protonum == IPPROTO_TCP ||
 		    t->dst.protonum == IPPROTO_UDP ||
 		    t->dst.protonum == IPPROTO_UDPLITE ||
-		    t->dst.protonum == IPPROTO_DCCP ||
 		    t->dst.protonum == IPPROTO_SCTP)
 			fl4->fl4_sport = t->src.u.all;
 	}
@@ -102,7 +100,6 @@ static void nf_nat_ipv6_decode_session(struct sk_buff *skb,
 		if (t->dst.protonum == IPPROTO_TCP ||
 		    t->dst.protonum == IPPROTO_UDP ||
 		    t->dst.protonum == IPPROTO_UDPLITE ||
-		    t->dst.protonum == IPPROTO_DCCP ||
 		    t->dst.protonum == IPPROTO_SCTP)
 			fl6->fl6_dport = t->dst.u.all;
 	}
@@ -114,7 +111,6 @@ static void nf_nat_ipv6_decode_session(struct sk_buff *skb,
 		if (t->dst.protonum == IPPROTO_TCP ||
 		    t->dst.protonum == IPPROTO_UDP ||
 		    t->dst.protonum == IPPROTO_UDPLITE ||
-		    t->dst.protonum == IPPROTO_DCCP ||
 		    t->dst.protonum == IPPROTO_SCTP)
 			fl6->fl6_sport = t->src.u.all;
 	}
@@ -432,7 +428,6 @@ static bool l4proto_in_range(const struct nf_conntrack_tuple *tuple,
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
 	case IPPROTO_UDPLITE:
-	case IPPROTO_DCCP:
 	case IPPROTO_SCTP:
 		if (maniptype == NF_NAT_MANIP_SRC)
 			port = tuple->src.u.all;
@@ -632,7 +627,6 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 	case IPPROTO_UDPLITE:
 	case IPPROTO_TCP:
 	case IPPROTO_SCTP:
-	case IPPROTO_DCCP:
 		if (maniptype == NF_NAT_MANIP_SRC)
 			keyptr = &tuple->src.u.all;
 		else
diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index dc450cc81222..b14a434b9561 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -179,46 +179,6 @@ tcp_manip_pkt(struct sk_buff *skb,
 	return true;
 }
 
-static bool
-dccp_manip_pkt(struct sk_buff *skb,
-	       unsigned int iphdroff, unsigned int hdroff,
-	       const struct nf_conntrack_tuple *tuple,
-	       enum nf_nat_manip_type maniptype)
-{
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-	struct dccp_hdr *hdr;
-	__be16 *portptr, oldport, newport;
-	int hdrsize = 8; /* DCCP connection tracking guarantees this much */
-
-	if (skb->len >= hdroff + sizeof(struct dccp_hdr))
-		hdrsize = sizeof(struct dccp_hdr);
-
-	if (skb_ensure_writable(skb, hdroff + hdrsize))
-		return false;
-
-	hdr = (struct dccp_hdr *)(skb->data + hdroff);
-
-	if (maniptype == NF_NAT_MANIP_SRC) {
-		newport = tuple->src.u.dccp.port;
-		portptr = &hdr->dccph_sport;
-	} else {
-		newport = tuple->dst.u.dccp.port;
-		portptr = &hdr->dccph_dport;
-	}
-
-	oldport = *portptr;
-	*portptr = newport;
-
-	if (hdrsize < sizeof(*hdr))
-		return true;
-
-	nf_csum_update(skb, iphdroff, &hdr->dccph_checksum, tuple, maniptype);
-	inet_proto_csum_replace2(&hdr->dccph_checksum, skb, oldport, newport,
-				 false);
-#endif
-	return true;
-}
-
 static bool
 icmp_manip_pkt(struct sk_buff *skb,
 	       unsigned int iphdroff, unsigned int hdroff,
@@ -338,9 +298,6 @@ static bool l4proto_manip_pkt(struct sk_buff *skb,
 	case IPPROTO_ICMPV6:
 		return icmpv6_manip_pkt(skb, iphdroff, hdroff,
 					tuple, maniptype);
-	case IPPROTO_DCCP:
-		return dccp_manip_pkt(skb, iphdroff, hdroff,
-				      tuple, maniptype);
 	case IPPROTO_GRE:
 		return gre_manip_pkt(skb, iphdroff, hdroff,
 				     tuple, maniptype);
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index eab4f476b47f..38d75484e531 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -461,11 +461,6 @@ static int cttimeout_default_get(struct sk_buff *skb,
 	case IPPROTO_UDPLITE:
 		timeouts = nf_udp_pernet(info->net)->timeouts;
 		break;
-	case IPPROTO_DCCP:
-#ifdef CONFIG_NF_CT_PROTO_DCCP
-		timeouts = nf_dccp_pernet(info->net)->dccp_timeout;
-#endif
-		break;
 	case IPPROTO_ICMPV6:
 		timeouts = &nf_icmpv6_pernet(info->net)->timeout;
 		break;
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index c74012c99125..7eedf4e3ae9c 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -407,6 +407,7 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 		regs->verdict.code = NFT_BREAK;
 }
 
+#ifdef CONFIG_NFT_EXTHDR_DCCP
 static void nft_exthdr_dccp_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -482,6 +483,7 @@ static void nft_exthdr_dccp_eval(const struct nft_expr *expr,
 err:
 	*dest = 0;
 }
+#endif
 
 static const struct nla_policy nft_exthdr_policy[NFTA_EXTHDR_MAX + 1] = {
 	[NFTA_EXTHDR_DREG]		= { .type = NLA_U32 },
@@ -634,6 +636,7 @@ static int nft_exthdr_ipv4_init(const struct nft_ctx *ctx,
 	return 0;
 }
 
+#ifdef CONFIG_NFT_EXTHDR_DCCP
 static int nft_exthdr_dccp_init(const struct nft_ctx *ctx,
 				const struct nft_expr *expr,
 				const struct nlattr * const tb[])
@@ -649,6 +652,7 @@ static int nft_exthdr_dccp_init(const struct nft_ctx *ctx,
 
 	return 0;
 }
+#endif
 
 static int nft_exthdr_dump_common(struct sk_buff *skb, const struct nft_exthdr *priv)
 {
@@ -779,6 +783,7 @@ static const struct nft_expr_ops nft_exthdr_sctp_ops = {
 	.reduce		= nft_exthdr_reduce,
 };
 
+#ifdef CONFIG_NFT_EXTHDR_DCCP
 static const struct nft_expr_ops nft_exthdr_dccp_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
@@ -787,6 +792,7 @@ static const struct nft_expr_ops nft_exthdr_dccp_ops = {
 	.dump		= nft_exthdr_dump,
 	.reduce		= nft_exthdr_reduce,
 };
+#endif
 
 static const struct nft_expr_ops *
 nft_exthdr_select_ops(const struct nft_ctx *ctx,
@@ -822,10 +828,12 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_sctp_ops;
 		break;
+#ifdef CONFIG_NFT_EXTHDR_DCCP
 	case NFT_EXTHDR_OP_DCCP:
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_dccp_ops;
 		break;
+#endif
 	}
 
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.30.2


