Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE2E2F2C
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 12:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407954AbfJXKfi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 06:35:38 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:44952 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405970AbfJXKfi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:35:38 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 2849441B15;
        Thu, 24 Oct 2019 18:35:36 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5] netfilter: nft_tunnel: support tunnel match expr offload
Date:   Thu, 24 Oct 2019 18:35:31 +0800
Message-Id: <1571913336-13431-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVNSk1LS0tKTE5PTE1LTFlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBQ6Tzo4Mzg1IR48OUwpPxEd
        EDRPChJVSlVKTkxKQkpISEhNSU9IVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpJQk43Bg++
X-HM-Tid: 0a6dfd5605732086kuqy2849441b15
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series add NFT_TUNNEL_IPV4/6_SRC/DST match and tunnel expr offload.

wenxu (5):
  netfilter: nft_tunnel: add nft_tunnel_mode_validate function
  netfilter: nft_tunnel: support NFT_TUNNEL_IPV4_SRC/DST match
  netfilter: nft_tunnel: add inet type check in nft_tunnel_mode_validate
  netfilter: nft_tunnel: support NFT_TUNNEL_IPV6_SRC/DST match
  netfilter: nft_tunnel: add nft_tunnel_get_offload support

 include/net/netfilter/nf_tables_offload.h |   5 ++
 include/uapi/linux/netfilter/nf_tables.h  |   4 +
 net/netfilter/nft_tunnel.c                | 130 +++++++++++++++++++++++++++---
 3 files changed, 129 insertions(+), 10 deletions(-)

-- 
1.8.3.1

