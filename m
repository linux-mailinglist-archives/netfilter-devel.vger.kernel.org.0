Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23042122716
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2019 09:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLQIw5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Dec 2019 03:52:57 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:20005 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLQIw5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:52:57 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 0E41541A20;
        Tue, 17 Dec 2019 16:52:48 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf v2 0/3] netfilter: nf_flow_table_offload: something fixes
Date:   Tue, 17 Dec 2019 16:52:44 +0800
Message-Id: <1576572767-19779-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVOTkJCQkJCT0lMTEJOT1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQw6DSo*QzgxH00#Lxg#PDgP
        KzNPCh5VSlVKTkxNTkxJTE1DSkxJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUJDQjcG
X-HM-Tid: 0a6f130f4f472086kuqy0e41541a20
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This version fix a release neigh problem in the v1 for patch2

wenxu (3):
  netfilter: nf_flow_table_offload: fix dst_neigh lookup
  netfilter: nf_flow_table_offload: check the status of dst_neigh
  netfilter: nf_flow_table_offload: fix the nat port mangle.

 net/netfilter/nf_flow_table_offload.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 12 deletions(-)

-- 
1.8.3.1

