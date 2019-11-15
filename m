Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8586FDCE7
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 13:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKOMDe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 07:03:34 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:42901 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKOMDe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:03:34 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 8DACD4160B;
        Fri, 15 Nov 2019 20:03:30 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/4] netfilter: nf_flow_table_offload: support tunnel match
Date:   Fri, 15 Nov 2019 20:03:26 +0800
Message-Id: <1573819410-3685-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVNSUtLS0tKSUhCTExNTVlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46Ezo6Azg4CwpDIw4zGkI3
        D00wCTdVSlVKTkxIQ0pCT0pKTEtLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpIT0w3Bg++
X-HM-Tid: 0a6e6ef2689b2086kuqy8dacd4160b
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch provide tunnel offload based on route lwtunnel. 
The first two patches support indr callback setup
Then add tunnel match and action offload

This patch is based on 
http://patchwork.ozlabs.org/patch/1194247/
http://patchwork.ozlabs.org/patch/1195539/

wenxu (4):
  netfilter: nf_flow_table_offload: refactor nf_flow_table_offload_setup
    to support indir setup
  netfilter: nf_flow_table_offload: add indr block setup support
  netfilter: nf_flow_table_offload: add tunnel match offload support
  netfilter: nf_flow_table_offload: add tunnel encap/decap action
    offload support

 net/netfilter/nf_flow_table_offload.c | 240 +++++++++++++++++++++++++++++++---
 1 file changed, 223 insertions(+), 17 deletions(-)

-- 
1.8.3.1

