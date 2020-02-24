Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22D3169DC0
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 06:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBXF32 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Feb 2020 00:29:28 -0500
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:43323 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXF32 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:29:28 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id A5D905C17F4;
        Mon, 24 Feb 2020 13:22:55 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 0/4] netfilter: flowtable: add indr-block offload
Date:   Mon, 24 Feb 2020 13:22:51 +0800
Message-Id: <1582521775-25176-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVOTkxCQkJDT0JISkJPTVlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6KAw6Qzg5KCxIUSJOHU81
        KkowChBVSlVKTkNJTklKTExOTExIVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpISk43Bg++
X-HM-Tid: 0a7075a5f6492087kuqya5d905c17f4
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch provide tunnel offload based on route lwtunnel. 
The first two patches support indr callback setup
Then add tunnel match and action offload.

This version modify the second patch: make the dev can bind with different 
flowtable and check the NF_FLOWTABLE_HW_OFFLOAD flags in 
nf_flow_table_indr_block_cb_cmd. 

wenxu (4):
  netfilter: flowtable: add nf_flow_table_block_offload_init()
  netfilter: flowtable: add indr block setup support
  netfilter: flowtable: add tunnel match offload support
  netfilter: flowtable: add tunnel encap/decap action offload support

 net/netfilter/nf_flow_table_offload.c | 233 ++++++++++++++++++++++++++++++++--
 1 file changed, 219 insertions(+), 14 deletions(-)

-- 
1.8.3.1

