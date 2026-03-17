Return-Path: <netfilter-devel+bounces-11255-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAPOFnzouWntPQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11255-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 00:49:16 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29682B474E
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 00:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED8530C294D
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Mar 2026 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464D39526D;
	Tue, 17 Mar 2026 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVUkoI9j"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610A3644C6
	for <netfilter-devel@vger.kernel.org>; Tue, 17 Mar 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791351; cv=none; b=GCUElKe3xvfqG0e9/0V4YNY9FJQHyH2tYL3RsB+gtNmOOmITtD2Q7NkfMwE5bdeblANok6luRRf78QZ8a6GLaWldLp8kJVMYBi9bz+QMOqoGKfNGILOWmVyqSTB3VM+tXuRvB8d8hPuG/lg6d23L1I3QYIr5IcNW7fuJEVjRfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791351; c=relaxed/simple;
	bh=iCfLStrJ5xU284gWT1jqtFYszhwO+cBqLM0F0D4bPPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iusnwIPsyWuxcGdy2Q+gKOI3Dsmi2th0ms3WI9Ae+q/DcFlnJZ6FZJvUAXyxBjrEAtGkJ/DtcnMp+EFqhy4OjlDhslV+m/YO8KdywO0+rj3WPzdIhCRsTp+dy4qVKt4u7mT6NRuQ/41IbGNLjsHxwsBSDH1Pbu48ccuhs+dFCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVUkoI9j; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439bcec8613so4837382f8f.3
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Mar 2026 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791348; x=1774396148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OksVYoK/qo2obFncaGvvPyNkyaBlPz61UvAGQYizmo=;
        b=JVUkoI9jsmPGnwxrXaCVzIQ+vqIeFu5u7ni+byw7CP4EEt90c9hVJ81s3lRoYbTFmD
         Jo8NVRkx34WtOStMrJOkb5YaSRyk18owi8nZl9YoulrEGIVrfhNKWUrDmNJgbUAnbzzN
         Kf6QtDvdSc/J3lq+B8LDFiv23FdHRWA4QVIFB0wXW/QOKej45XMxmpXodiz9NUhRyjxK
         2q13Ib7obxi70kWTwk6/kSPu2Sb6eSobW8wr3UZ7Eu+ZUvrL7BipXBU1mlz6ZWFVLR89
         h2h433cyqars7PSp7rK1AV/9AHj39igZtK8dj3EGtcj/UMaErmupZVn9BgWFp3/lMw5z
         6OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791348; x=1774396148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OksVYoK/qo2obFncaGvvPyNkyaBlPz61UvAGQYizmo=;
        b=DpdR1zKR6edZ838WfQDgAbXtF3kgREXbk9Zb5IX+s766lh5DQrDfQvjsiUd3J1nrXX
         oaQCBUFOmtQXwxbz9NqWCkPDYqjutrER4A1rtCCkYkrcI/XqjnbhA4G2CEmtWOA4nUE0
         g5T93+lljlc0zobY139BXYS0IXD6iAaRu+s9hHDNNWpuWQZBw2z2DsOOr5xx4CpCe1rX
         hu2PsTspYavnrBeJX9OLFrwgsSBCV+Jiz9OijNH5A3Zg9t+JtnjvrndEpLDFibnp3OB7
         nZam/t7RDwySzQFDV2oYE/2vfSscO+A9ap829M0xZtvz1uNv6o+S0BZjO+VFYV23nrGO
         sF5w==
X-Gm-Message-State: AOJu0Yw2ZPWEwv8TPdH7a4o6ktLck3wd6PrAAJIZvFMbUMfyDo85ZmVO
	euCFFZIrSXEj89glw8TjhuAuZw2F7hjmiBrlhe5fmddhTkUOspk/BpFoJGtBoB7uJOy0qQ==
X-Gm-Gg: ATEYQzy1EGkBpHk8Jw/0YQ6NWXoanWgbvJClFpnMUJo5KgreJGz47npGtflfUU6Lbj0
	ud5NU2jhFUzkAViv/Eq+in2TIcIiZViH7VNUaLN0eQsXFU1+y9PjxnZlXH+Ldkm02iiaUaMwa3Y
	Ct2WqRLHuDoXUZfoa8zdtUaP/YeYymwyUU7LZN2ABxpO7AtXroTlv5htuNZoZbJOxe2g+8vOUTd
	rYUMk/r+tnU5zvLrqDsqqxDJriWvCDc+pIVQ5cqv/XrWQ0DVX+R6V5bS0QU8iULCj0DBeOd/FJH
	vZ032yYfLmJZtIBjbEeh10CffU6GRRsaOziCuMW5LEycIcjQkjX0ydX7lTsmI7pluGOGWc8ye1p
	PzyN/KWY3+BIBCu7BRaipjg4ptRRwu0tgEWcU0vQMj/Lo+a7AdR1Jrsjo7gD9IJ4XmOgJwOnH/4
	Iir6jiN4DlXQh/wyUT96Vi
X-Received: by 2002:a05:6000:144a:b0:43b:5097:6f60 with SMTP id ffacd0b85a97d-43b527c5490mr1734002f8f.32.1773791348062;
        Tue, 17 Mar 2026 16:49:08 -0700 (PDT)
Received: from azaki-desk1.. ([41.234.201.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3d78sm3279810f8f.34.2026.03.17.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:49:07 -0700 (PDT)
From: Ahmed Zaki <anzaki@gmail.com>
To: netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	fw@strlen.de
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next 0/2] Update netdev stats with offloaded flows
Date: Tue, 17 Mar 2026 17:48:49 -0600
Message-ID: <20260317234851.234466-1-anzaki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11255-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B29682B474E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let's allow SNMP-based tools to accurately report the Tx/Rx stats
on devices implementing hardware flow offloads. Without this, its is very
confusing since these devices are reporting very-low stats compared to
others that do not do hardware-offloading.

First patch is prep work, change the prototype of dev_sw_netstats_rx_add()
to pass "packets" instead of the implied "1". Second patch updates the
netdev stats.

Ahmed Zaki (2):
  net: treewide: pass number of pkts to dev_sw_netstats_rx_add()
  netfilter: flowtable: update netdev stats with HW_OFFLOAD flows

 drivers/infiniband/hw/hfi1/driver.c           |  2 +-
 drivers/net/amt.c                             |  6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c |  2 +-
 drivers/net/ethernet/litex/litex_liteeth.c    |  2 +-
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 .../net/ethernet/realtek/rtase/rtase_main.c   |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  6 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  4 +-
 drivers/net/gtp.c                             |  2 +-
 drivers/net/macsec.c                          |  2 +-
 drivers/net/netkit.c                          |  2 +-
 drivers/net/ppp/ppp_generic.c                 |  2 +-
 drivers/net/tun.c                             |  8 +--
 drivers/net/usb/qmi_wwan.c                    |  2 +-
 drivers/net/wireguard/receive.c               |  2 +-
 .../quantenna/qtnfmac/pcie/pearl_pcie.c       |  2 +-
 .../quantenna/qtnfmac/pcie/topaz_pcie.c       |  2 +-
 include/linux/netdevice.h                     |  6 +-
 net/bridge/br_input.c                         |  2 +-
 net/core/filter.c                             |  2 +-
 net/dsa/tag.c                                 |  2 +-
 net/ipv4/ip_tunnel.c                          |  2 +-
 net/ipv4/ip_vti.c                             |  2 +-
 net/ipv6/ip6_tunnel.c                         |  2 +-
 net/ipv6/ip6_vti.c                            |  2 +-
 net/ipv6/sit.c                                |  2 +-
 net/mac80211/rx.c                             |  8 +--
 net/netfilter/nf_flow_table_offload.c         | 59 +++++++++++++++++--
 net/openvswitch/vport-internal_dev.c          |  2 +-
 net/xfrm/xfrm_interface_core.c                |  2 +-
 30 files changed, 96 insertions(+), 47 deletions(-)

-- 
2.43.0


