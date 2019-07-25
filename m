Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4474432
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 06:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfGYEJy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 00:09:54 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:3891 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYEJy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:09:54 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id E0A2941720;
        Thu, 25 Jul 2019 12:09:47 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5] sipport nft_tunnel offload
Date:   Thu, 25 Jul 2019 12:09:36 +0800
Message-Id: <1564027781-24882-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJQ0tCQkJDQkNCSktOSVlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6Lio5Mzg3UVY*CSI1PBIZ
        AxFPCjpVSlVKTk1PS0lMTENCSUxPVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPTkk3Bg++
X-HM-Tid: 0a6c27521a9d2086kuqye0a2941720
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series support tunnel meta match offload and
tunnel_obj ation offload. This series depends on
http://patchwork.ozlabs.org/project/netfilter-devel/list/?series=120961
http://patchwork.ozlabs.org/patch/1136197/

wenxu (5):
  netfilter: nft_tunnel: support NFT_TUNNEL_SRC/DST_IP match
  netfilter: nft_tunnel: support tunnel meta match offload
  netfilter: nft_tunnel: add NFTA_TUNNEL_KEY_RELEASE action
  netfilter: nft_objref: add nft_objref_type offload
  netfilter: nft_tunnel: support nft_tunnel_obj offload

 include/net/netfilter/nf_tables.h         |   3 +
 include/net/netfilter/nf_tables_offload.h |   2 +
 include/uapi/linux/netfilter/nf_tables.h  |   3 +
 net/netfilter/nft_objref.c                |  15 ++++
 net/netfilter/nft_tunnel.c                | 123 ++++++++++++++++++++++++++----
 5 files changed, 133 insertions(+), 13 deletions(-)

-- 
1.8.3.1

