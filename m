Return-Path: <netfilter-devel+bounces-5913-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C49A27BF3
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Feb 2025 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275B97A10F4
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Feb 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFEA214233;
	Tue,  4 Feb 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMXc69mt"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA320370B;
	Tue,  4 Feb 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698595; cv=none; b=cRu0vYEPAFXrBAysEGPSNqWx0QMq+TIdNRZ0jf6p8iEaX8ITstS/FhMdGFLh/xVz/buUVYTHDMY0jooIhsMEM6JpEyKBkeomDlydE8uzca5Ao9NAlDkVv6TKNQ+5puJ15Ck/WW4J2da29mrjkQhZp2dsDtl42A29R7s58x+u3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698595; c=relaxed/simple;
	bh=SZ3n49GRuOCb3QhY/IgHYmn0++sLVZ9ukFUK6TTtgNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsmUv9qNqXDP7IbwE38zyotGtn2PTvvvzDyrSrQhQdQXLkDOh25w41aH/iWmYn0OGmf7decq0iBItoBhLj+q4cwP1YnzMMr8cyrbtjLkJ6R6x8eV2V/HHwW8fPsVeuYmKYsjY58Nn8Po9rBJwmd0s9B0UxS/5IGt6g28xgBt68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMXc69mt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so10765513a12.1;
        Tue, 04 Feb 2025 11:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698592; x=1739303392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7AexEiKcOYVclBb+I/d5LUGalgMU1GLNcoEaRydrIA=;
        b=dMXc69mtiQt8Iog8WcA4oZt2bjAhHCYZtPmzobFFFUiKlT3DmHsE8x8VaKSlqJJLkR
         EfIZuagTspEsdjkcTip3akDcAL8qaigQnpKs+Qymzbb7UucSIqha1VQNH1V84QZdyzk6
         e3V7GNJIcTHeKKLbpP1bzvNLZpbZ9SRy6vcVu6kFb1nZ3scdBauo2VLB9YsXm0F4e07r
         OBDjcEinoiXxVq2nlPKVMvQjGJINyOwAEB2QlFBp18uKKsd+1oZZzPSfY4xbpE/Egggx
         gfFnW1+e0RACLyg32bDtSgE2bjijvR+ldj/xjeWKVEXYBbl7NII7y054FeI5j5Wh5kaj
         SV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698592; x=1739303392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7AexEiKcOYVclBb+I/d5LUGalgMU1GLNcoEaRydrIA=;
        b=fsoT1+uNW6CZT7WLkNTH66XtvtE5J3C/hv2ihCm23gbV/QZxa2ovJO9zNZVSN59hfB
         ZcJ8swPUYdKds02WgDu+8M9qaoOlOflxjY2Rg0braK78I7aqzcNbIL60zSDV4C3RBz3H
         ozPmLVadfCCflk7pN8xcw5b/wFsNjMr7+KCqlPxJLW7QLfIVwqJeeW6rPq/84GMwYwWM
         DBD/fgAEoSZzJUS3NgcviXK3VFzQF9VNfLrWYlcDWIUn2m3xl2Sz83LLv0dFWTVocbJi
         4aBhyoOkbQnbDfa3TmbTo8AKDjQgFAdfUaHlYjrU4bC4otOk9EcgXE0b23ybfbJ9MGGY
         PjeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBvviKMMA5AuMlqk81b/GRM9ao9HLnoZUWFT1Vr2FXVZkJKo78EPBE9RNGPk+8VKc1sCc9dOKKfIjyjEHRO9zx@vger.kernel.org, AJvYcCWwHaIfxq7zfm2vjg/o6JSXhhV/dE60Tv9tcjI5MoDi9ChZ0F4h1Aur2nsZc7103hEfOGQJcQl+rqiVLCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIS/GYZYhh9BtLXnYNXCZbmIoC1nPakbUbgNwxun8H6UVzGqO9
	4hg7sarmnEPeZ7dOYvdKfCyoghLhciKQJPgfokQUK+YO7H24N9T1
X-Gm-Gg: ASbGncv1SozaTMjPDwR60YQyERjnPUJUhFdiw6bk4/Kwiz7PrwrR8fiC65b+917j/ce
	O1qpljOw0vCgL9YioHkLba+qU1u2rtvFiMmGUIIwXCfMYuhFpQsH8eYJn247lP4NbrcWrG0lgrf
	OncaMQDSc62oybByt7qp5BtWGGJXQGEW+ed5vSXYuhwPmB8GgRsTMG2/KHb8d9jhmSe6PAtsBVt
	DoBBdtkfcqI6If5Rf4e2foPsI+I4cxeg3ySR0Sii1y2m1K9lcULhCyra+B9271UB9QC/uveGXFe
	37eOUzY3s/+lU/rd3b1JFnXvOFcyoUwccmaBDSMDFSZWZtFFnrwKKKKzFGpk+acKHeQ44YgONL5
	1hDvWVQl4oVR5NiBUGLx0pUJXCJBbjEuc
X-Google-Smtp-Source: AGHT+IEkNXnUwFNe3IWSAlNFdlaFSV9sdqDzq8JKWt5SDi8U+md0+91ll7x5UTV1h+WC2LKu5j6ThA==
X-Received: by 2002:a17:907:7d8a:b0:ab6:eeb4:504f with SMTP id a640c23a62f3a-ab6eeb457a8mr2088291066b.21.1738698591346;
        Tue, 04 Feb 2025 11:49:51 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:50 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v5 net-next 00/14] bridge-fastpath and related improvements
Date: Tue,  4 Feb 2025 20:49:07 +0100
Message-ID: <20250204194921.46692-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes it possible to set up a software fastpath between
bridged interfaces. One patch adds the flow rule for the hardware
fastpath. This creates the possibility to have a hardware offloaded
fastpath between bridged interfaces. More patches are added to solve
issues found with the existing code.

To set up the fastpath with offloading, add this extra flowtable:

table bridge filter {
        flowtable fb {
                hook ingress priority filter
                devices = { lan0, lan1, lan2, lan3, lan4, wlan0, wlan1 }
                flags offload
        }
        chain forward {
                type filter hook forward priority filter; policy accept;
		ct state established flow add @fb
        }
}

Creating a separate fastpath for bridges.

         forward fastpath bypass
 .----------------------------------------.
/                                          \
|                        IP - forwarding    |
|                       /                \  v
|                      /                  wan ...
|                     /
|                     |
|                     |
|                   brlan.1
|                     |
|    +-------------------------------+
|    |           vlan 1              |
|    |                               |
|    |     brlan (vlan-filtering)    |
|    +---------------+               |
|    |  DSA-SWITCH   |               |
|    |               |    vlan 1     |
|    |               |      to       |
|    |   vlan 1      |   untagged    |
|    +---------------+---------------+
.         /                   \
 ------>lan0                 wlan1
        .  ^                 ^
        .  |                 |
        .  \_________________/
        .  bridge fastpath bypass
        .
        ^
     vlan 1 tagged packets

While testing direct transmit in the software forward-fastpath, it is
useful to enslave the wan interface to another bridge, brwan. This will
make sure both directions of the software forward-fastpath use direct
transmit.

To have the ability to handle xmit direct with outgoing encaps in the
bridge fastpass bypass, we need to be able to handle them without going
through vlan/pppoe devices. So I've applied, amended and squashed wenxu's
patchset. This patch also makes it possible to egress from vlan-filtering
brlan to lan0 with vlan tagged packets, if the bridge master port is doing
the vlan tagging, instead of the vlan-device. Without this patch, this is
not possible in the bridge-fastpath and also not in the forward-fastpath,
as seen in the figure above.

There are also some more fixes for filling in the forward path. These
fixes also apply to for the forward-fastpath. They include handling
DEV_PATH_MTK_WDMA in nft_dev_path_info(). There are now 2 patches for
avoiding ingress_vlans bit set for bridged dsa user ports and foreign
(dsa) ports.

Another patch introduces DEV_PATH_BR_VLAN_KEEP_HW, needed for the
bridge-fastpath only.

Conntrack bridge only tracks untagged and 802.1q. To make the bridge
fastpath experience more similar to the forward fastpath experience,
I've added double vlan, pppoe and pppoe-in-q tagged packets to bridge
conntrack and to bridge filter chain.

Note: While testing direct transmit in the software forward-fastpath,
without the capability of setting the offload flag, it is sometimes useful
to enslave the wan interface to another bridge, brwan. This will make
sure both directions of the software forward-fastpath use direct transmit,
which also happens when the offload flag is set.

I have send RFC v2 as I previously only owned a dsa device. I now have
obtained a switchdev supporting SWITCHDEV_OBJ_ID_PORT_VLAN, and found
there was more to do to handle the ingress_vlans bit and corresponding
vlan encap.

I send v4 and above as non-RFC as the previous 2 RFC's did not get any
comment.

Changes in v5:
- Conntrack double vlan and pppoe patch: Moved pskb_may_pull() up to the
   first switch statement, to the start of the cases. Removed the second
   switch statement. Replaced 0xffffffff with U32_MAX.
- Added patch removing hw_outdev, out.hw_ifindex and out.hw_ifidx members.
- Fix error path returned from nft_flow_offload_bridge_init().
- Cosmetics.

Changes in v4:
- Added !CONFIG_NET_SWITCHDEV version of
   br_switchdev_port_vlan_no_foreign_add().

Changes in v3:
- Squashed the two 'port to port' patches to avoid build errors when only
   one of the two commits is applied.

Changes in v2:
- Introduce DEV_PATH_BR_VLAN_KEEP_HW for use in the bridge-fastpath only.
   It is needed for switchdevs supporting SWITCHDEV_OBJ_ID_PORT_VLAN.
- Different approach for handling BR_VLFLAG_ADDED_BY_SWITCHDEV in
   br_vlan_fill_forward_path_mode() for foreign devices. Introduce
   SWITCHDEV_F_NO_FOREIGN, BR_VLFLAG_TAGGING_BY_SWITCHDEV and
   br_switchdev_port_vlan_no_foreign_add(). The latter function can be
   used to make sure the vlan was added to a switchdev native device.
   When that fails, adding the vlan with br_switchdev_port_vlan_add()
   means it was added to a switchdev foreign device.
- Clear ingress_vlans bit and corresponding encap for dsa user ports.
- Add check for ingress_vlans bit to nft_dev_fill_bridge_path().
- Adapted cover letter description to make clear the patches apply
   to software fastpath, making hardware-offloaded fastpath possible.
- Fixed clang error for vlan_hdr * and struct ppp_hdr * by adding block.
- Updated !CONFIG_BRIDGE_VLAN_FILTERING version of
   br_vlan_fill_forward_path_pvid().
- Removed erroneous check netif_is_bridge_master(ctx->dev) from
   dev_fill_bridge_path().
- Cosmetic changes.

Eric Woudstra (14):
  netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit
    direct
  netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe
  bridge: Add filling forward path from port to port
  net: core: dev: Add dev_fill_bridge_path()
  netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
  netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
  netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
  netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to
    nft_dev_path_info()
  netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user
    port
  bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
  bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
  netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()

 include/linux/netdevice.h                  |   3 +
 include/net/netfilter/nf_flow_table.h      |   5 +-
 include/net/switchdev.h                    |   1 +
 net/bridge/br_device.c                     |  23 ++-
 net/bridge/br_private.h                    |  12 ++
 net/bridge/br_switchdev.c                  |  15 ++
 net/bridge/br_vlan.c                       |  29 +++-
 net/bridge/netfilter/nf_conntrack_bridge.c |  81 ++++++++--
 net/core/dev.c                             |  66 ++++++--
 net/netfilter/nf_flow_table_core.c         |   1 -
 net/netfilter/nf_flow_table_inet.c         |  13 ++
 net/netfilter/nf_flow_table_ip.c           |  96 +++++++++++-
 net/netfilter/nf_flow_table_offload.c      |  15 +-
 net/netfilter/nft_chain_filter.c           |  20 ++-
 net/netfilter/nft_flow_offload.c           | 168 +++++++++++++++++++--
 net/switchdev/switchdev.c                  |   2 +-
 16 files changed, 490 insertions(+), 60 deletions(-)

-- 
2.47.1


