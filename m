Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED597164
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 07:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfHUFKA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 01:10:00 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:31723 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfHUFKA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:10:00 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1F3F0415FE;
        Wed, 21 Aug 2019 13:09:54 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 0/8]  netfilter: nf_tables_offload: support tunnel offload
Date:   Wed, 21 Aug 2019 13:09:45 +0800
Message-Id: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVOSE5LS0tLQ05DSEtNQllXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6Sjo6ITg1OT8LHhwMIzke
        MD4wFApVSlVKTk1NSE1PSkJPSkxKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpMSU03Bg++
X-HM-Tid: 0a6cb294d5602086kuqy1f3f0415fe
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series add NFT_TUNNEL_IP/6_SRC/DST match and tunnel expr offload.
Also add NFTA_TUNNEL_KEY_RELEASE actions adn objref, tunnel obj offload

This version just split from the orignal big seriese without dependency
with each other

wenxu (8):
  netfilter: nft_tunnel: add nft_tunnel_mode_validate function
  netfilter: nft_tunnel: support NFT_TUNNEL_IP_SRC/DST match
  netfilter: nft_tunnel: add ipv6 check in nft_tunnel_mode_validate
  netfilter: nft_tunnel: support NFT_TUNNEL_IP6_SRC/DST match
  netfilter: nft_tunnel: support tunnel meta match offload
  netfilter: nft_tunnel: add NFTA_TUNNEL_KEY_RELEASE action
  netfilter: nft_objref: add nft_objref_type offload
  netfilter: nft_tunnel: support nft_tunnel_obj offload

 include/net/netfilter/nf_tables.h         |   3 +
 include/net/netfilter/nf_tables_offload.h |   5 +
 include/uapi/linux/netfilter/nf_tables.h  |   5 +
 net/netfilter/nft_objref.c                |  14 +++
 net/netfilter/nft_tunnel.c                | 159 +++++++++++++++++++++++++++---
 5 files changed, 173 insertions(+), 13 deletions(-)

-- 
1.8.3.1

