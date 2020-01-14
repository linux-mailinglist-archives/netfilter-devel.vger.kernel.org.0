Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50B113A4C1
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2020 11:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgANKAn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jan 2020 05:00:43 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:56969 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANKAm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:00:42 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 7DC0541881;
        Tue, 14 Jan 2020 18:00:40 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 0/4] netfilter: flowtable: add indr-block offload
Date:   Tue, 14 Jan 2020 18:00:36 +0800
Message-Id: <1578996040-6413-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJTEJCQkJCTEpIQ0JMTFlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6MAw4Fzg0TzI#PDdLGEoD
        QhZPFENVSlVKTkxDQkJNS09LTUtKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpJQ0o3Bg++
X-HM-Tid: 0a6fa37f834e2086kuqy7dc0541881
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch provide tunnel offload based on route lwtunnel. 
The first two patches support indr callback setup
Then add tunnel match and action offload.

This version just rebase to the nf-next.

Pablo, please give me some feedback. If you feel this series is ok, please
apply it. Thanks.

wenxu (4):
  netfilter: flowtable: add nf_flow_table_block_offload_init()
  netfilter: flowtable: add indr block setup support
  netfilter: flowtable: add tunnel match offload support
  netfilter: flowtable: add tunnel encap/decap action offload support

 net/netfilter/nf_flow_table_offload.c | 239 +++++++++++++++++++++++++++++++---
 1 file changed, 222 insertions(+), 17 deletions(-)

-- 
1.8.3.1

