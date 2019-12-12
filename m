Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59811C9C0
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Dec 2019 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfLLJn5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Dec 2019 04:43:57 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:29199 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfLLJn5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:43:57 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 8B11A41AE0;
        Thu, 12 Dec 2019 17:43:55 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 0/4] netfilter: nf_flow_table_offload: something fixes
Date:   Thu, 12 Dec 2019 17:43:51 +0800
Message-Id: <1576143835-19749-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVOTkJCQkJCT0lMTEJOT1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6Nhw5AjgxPUg5GBIoFRpD
        NzJPCSNVSlVKTkxNSk9IQ0hOTU1DVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUJCSTcG
X-HM-Tid: 0a6ef97e51ba2086kuqy8b11a41ae0
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>


wenxu (4):
  netfilter: nf_flow_table_offload: fix dst_neigh lookup
  netfilter: nf_flow_table_offload: check the status of dst_neigh
  netfilter: nf_flow_table_offload: fix miss dst_neigh_lookup for ipv6
  netfilter: nf_flow_table_offload: fix the nat port mangle.

 net/netfilter/nf_flow_table_offload.c | 56 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

-- 
1.8.3.1

