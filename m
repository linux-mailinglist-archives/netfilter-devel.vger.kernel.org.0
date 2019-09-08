Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7178ACF41
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Sep 2019 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfIHOWR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Sep 2019 10:22:17 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:4101 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfIHOWR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:22:17 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id D355C5C16CF;
        Sun,  8 Sep 2019 22:22:08 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 0/8]  netfilter: nf_tables_offload: support tunnel offload
Date:   Sun,  8 Sep 2019 22:22:00 +0800
Message-Id: <1567952528-24421-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVNTU5CQkJDQ0JITEhMQ1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6DSo5Njg4SDUVAxIYORgK
        FDgKCyNVSlVKTk1MQk5JTklDQkhNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpNTk83Bg++
X-HM-Tid: 0a6d1140e5ea2087kuqyd355c5c16cf
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series add NFT_TUNNEL_IP/6_SRC/DST match and tunnel expr offload.
Also add NFTA_TUNNEL_KEY_RELEASE actions adn objref, tunnel obj offload

This version just rebase to master for patch 7

wenxu (8):
  netfilter: nft_tunnel: add nft_tunnel_mode_validate function
  netfilter: nft_tunnel: support NFT_TUNNEL_IP_SRC/DST match
  netfilter: nft_tunnel: add ipv6 check in nft_tunnel_mode_validate
  netfilter: nft_tunnel: support NFT_TUNNEL_IP6_SRC/DST match
  netfilter: nft_tunnel: support tunnel meta match offload
  netfilter: nft_tunnel: add NFTA_TUNNEL_KEY_RELEASE action
  netfilter: nft_objref: add nft_objref_type offload
  netfilter: nft_tunnel: support nft_tunnel_obj offload

 include/net/netfilter/nf_tables.h         |   4 +
 include/net/netfilter/nf_tables_offload.h |   5 +
 include/uapi/linux/netfilter/nf_tables.h  |   5 +
 net/netfilter/nft_objref.c                |  14 +++
 net/netfilter/nft_tunnel.c                | 159 +++++++++++++++++++++++++++---
 5 files changed, 174 insertions(+), 13 deletions(-)

-- 
1.8.3.1

