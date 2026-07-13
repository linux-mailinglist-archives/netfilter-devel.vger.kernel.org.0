Return-Path: <netfilter-devel+bounces-13898-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ChuPCTreVGppgAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13898-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 14:46:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CD74B12D
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 14:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Jy3/LEc2";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13898-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13898-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53421300D69C
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68640D56A;
	Mon, 13 Jul 2026 12:46:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4A40C5C0;
	Mon, 13 Jul 2026 12:46:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946806; cv=none; b=IN/UUnFHc+otGnBvPJZnXLGQwj2gVskeMGjGo8qcBOBQIvvTc1YqtCZ8Ux1JxckoaFYSVfxgf1fbYSOdufIp0LaBCeFOlGHIKsGuuf1Ccffwr1XWX8kexF6OC39rjhZnjl3FtKuOKkwnKaep43ZIGed8xHzOiGwCPLfpUoGj380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946806; c=relaxed/simple;
	bh=WqY4kgObe7k+Ht3BPmidAur8oJyfvHtuANHiwv7xrmM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NFPb7VG+4XwOBDbG1KAYogno0DbJw/qx7afh2bs1nQMc5JyjBPw2c3cWHhPDxD3XWuKaX5i0c4nATuCgtAAD5Dy+hENqtY/usa50lMWyJ3N914VbycJ3leb/dtuJVt6uXksUdcmUzUrSOVq7djKCOHDgCUao1ToGC6IfuFdYU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy3/LEc2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B001F000E9;
	Mon, 13 Jul 2026 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783946802;
	bh=ELuP+JlstmobvcR8nFgZQhy9eTzAwZCD1GxbQQU5DDk=;
	h=From:Subject:Date:To:Cc;
	b=Jy3/LEc2ASJAPC7O0145GxG1rBT5NuM4BR2cL2E5+LR27kRFZViXGf/Q4buygkV7z
	 aYDpRIYl/wG8r2HIZzQa109+oMkukZEj6hFjkSZjVoBc5CcAA990h0bIKU8Au9KHGa
	 nyYbKfvDq8HZ1sqfKy4HvlxQNIOquxqUSoS/qGBHR9imO6piXaxqa2PQe6aIZPTzrs
	 LPj+mIz9Oc/64mr85zjEG/y1Wwg1G9r5HT1osSoDe3S4X7hAdEQUsoFjXDH++iiqoz
	 RXR99vqwp1NmZELpzOy7lBBicQ94SWdQzT3YhG8/UienZE0ngwBbBf2O7QkARlz6RP
	 lYga6LXF42BmQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v6 0/6] Add IPv4 over IPv6 and SIT flowtable SW
 acceleration
Date: Mon, 13 Jul 2026 14:46:17 +0200
Message-Id: <20260713-b4-flowtable-sw-accel-ip6ip-v6-0-33f0155fc658@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTWrDMBAF4KsErasijf676j1KF7I8SkSNbCTjp
 ATfvcKbuhhMl48H3xvmSSqWhJW8XZ6k4JJqGnML+uVCws3nK9LUt0yAgWaKKdpJGofxPvtuQFr
 v1IeAA02TThM1nHEmZOi5NKQJU8GYHpv+QXKkGR8z+WzFLdV5LN/b6sK3+l8DC6eMOh+ECyE49
 O79C0vG4XUs1w1eYI/pcwwaJoWLvQRjQOMBEztM8HNMNExpDxZ0FGCOl8lfzDBxjsmGMSacba8
 EYeGAqT3mzjHVMAs2oI9Wdb77g63r+gPOv/GPBAIAAA==
X-Change-ID: 20260505-b4-flowtable-sw-accel-ip6ip-7101034cd147
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
 Shuah Khan <shuah@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nbd@nbd.name,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:shuah@kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,gmail.com,collabora.com,nvidia.com,netfilter.org,strlen.de,nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13898-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F6CD74B12D

Similar to IPIP and IP6I6 tunnels, introduce sw acceleration for IPv4 over
IPv6 and SIT tunnels in the netfilter flowtable infrastructure.

---
Changes in v6:
- Rebase on top of nf-next and fixed conflicts.
- Fix the case when both ingress and egress interfaces are IP tunnels.
- Link to v5: https://lore.kernel.org/r/20260709-b4-flowtable-sw-accel-ip6ip-v5-0-828ceaf85bab@kernel.org

Changes in v5:
- Fix ipip6_tunnel_fill_forward_path() to take into account not only
  IPv6 packet since SIT tunnels can encapsulate even IPv4/MPLS traffic.
- Return an error in ipip6_tunnel_fill_forward_path() if tunnel daddr is
  not set since NBMA tunnels are not supported yet.
- Return an error in ipip6_tunnel_fill_forward_path() if encap.type is
  not TUNNEL_ENCAP_NONE
- cosmetics
- Link to v4: https://lore.kernel.org/r/20260703-b4-flowtable-sw-accel-ip6ip-v4-0-00398cd12382@kernel.org

Changes in v4:
- Rebase on top of nf-next and fixed conflicts.
- Link to v3: https://lore.kernel.org/r/20260531-b4-flowtable-sw-accel-ip6ip-v3-0-56a2826f3279@kernel.org

Changes in v3:
- Drop nf_flow_tunnel_v4_push and nf_flow_tunnel_v6_push routines
- Rebase on top of net-next tree.
- Link to v2: https://lore.kernel.org/r/20260506-b4-flowtable-sw-accel-ip6ip-v2-0-439fd427726e@kernel.org

Changes in v2:
- Fix MTU check in nf_flow_offload_forward() and in
  nf_flow_offload_ipv6_forward()
- Add SIT sw acceleration support
- Link to v1: https://lore.kernel.org/r/20260505-b4-flowtable-sw-accel-ip6ip-v1-0-9ac39ccc9ea9@kernel.org

---
Lorenzo Bianconi (6):
      net: netfilter: add ether_type to net_device_path_ctx
      net: netfilter: add encap_proto to flow_offload_tunnel
      net: netfilter: add IPv4 over IPv6 tunnel flowtable acceleration
      selftests: netfilter: nft_flowtable.sh: add IPv4 over IPv6 flowtable selftest
      net: netfilter: add SIT tunnel flowtable acceleration
      selftests: netfilter: nft_flowtable.sh: add SIT flowtable selftest

 drivers/net/ethernet/airoha/airoha_ppe.c           |  13 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |  13 +-
 include/linux/netdevice.h                          |   5 +-
 include/net/netfilter/nf_flow_table.h              |   1 +
 net/core/dev.c                                     |   6 +-
 net/ipv4/ipip.c                                    |   1 +
 net/ipv6/ip6_tunnel.c                              |   6 +-
 net/ipv6/sit.c                                     |  60 +++
 net/netfilter/nf_flow_table_core.c                 |  19 +-
 net/netfilter/nf_flow_table_ip.c                   | 424 +++++++++++++--------
 net/netfilter/nf_flow_table_path.c                 |  20 +-
 tools/testing/selftests/net/netfilter/config       |   1 +
 .../selftests/net/netfilter/nft_flowtable.sh       |  86 ++++-
 13 files changed, 461 insertions(+), 194 deletions(-)
---
base-commit: 0150128b9506b5869d8d2000c6e71bef0719d6ce
change-id: 20260505-b4-flowtable-sw-accel-ip6ip-7101034cd147

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


