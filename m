Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8710352FF7
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Apr 2021 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDBTyJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Apr 2021 15:54:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55696 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBTyJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:54:09 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 749ED63E3D;
        Fri,  2 Apr 2021 21:53:50 +0200 (CEST)
Date:   Fri, 2 Apr 2021 21:54:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_payload: fix vlan_tpid get from
 h_vlan_proto
Message-ID: <20210402195403.GA22049@salvia>
References: <1617347632-19283-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1617347632-19283-1-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Apr 02, 2021 at 03:13:52PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> vlan_tpid of flow_dissector_key_vlan should be set as h_vlan_proto
> but not h_vlan_encapsulated_proto.

Probably this patch instead?


--5vNYLRcllDrimb99
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="x.patch"

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index cb1c8c231880..dc45199c2489 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -237,15 +237,14 @@ static int nft_payload_offload_ll(struct nft_offload_ctx *ctx,
 				  vlan_tpid, sizeof(__be16), reg);
 		nft_offload_set_dependency(ctx, NFT_OFFLOAD_DEP_NETWORK);
 		break;
-	case offsetof(struct vlan_ethhdr, h_vlan_TCI) + sizeof(struct vlan_hdr):
+	case sizeof(struct vlan_ethhdr) + offsetof(struct vlan_hdr, h_vlan_TCI):
 		if (!nft_payload_offload_mask(reg, priv->len, sizeof(__be16)))
 			return -EOPNOTSUPP;
 
 		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_CVLAN, vlan,
 				  vlan_tci, sizeof(__be16), reg);
 		break;
-	case offsetof(struct vlan_ethhdr, h_vlan_encapsulated_proto) +
-							sizeof(struct vlan_hdr):
+	case sizeof(struct vlan_ethhdr) + offsetof(struct vlan_hdr, h_vlan_encapsulated_proto):
 		if (!nft_payload_offload_mask(reg, priv->len, sizeof(__be16)))
 			return -EOPNOTSUPP;
 

--5vNYLRcllDrimb99--
