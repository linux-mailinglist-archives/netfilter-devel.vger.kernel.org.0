Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76DEAD30F
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Sep 2019 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfIIGWY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Sep 2019 02:22:24 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:4745 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfIIGWY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:22:24 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id B468641A31;
        Mon,  9 Sep 2019 14:22:06 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 0/4] netfilter: nf_tables_offload: clean offload things when the device unregister
Date:   Mon,  9 Sep 2019 14:22:02 +0800
Message-Id: <1568010126-3173-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPTUpCQkJDQkhKQ0NPQ1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6KTo*Mzg8SDU*ShlWLk8B
        LUMKCz1VSlVKTk1DS0pLSklNQ0hMVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPS043Bg++
X-HM-Tid: 0a6d14afc59f2086kuqyb468641a31
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series clean the offload things for both chain and rules when the
related device unregister

This version just rebase the master and make __nft_offload_get_chain
fixes mutex and offload flag problem

wenxu (4):
  netfilter: nf_tables_offload: add __nft_offload_get_chain function
  netfilter: nf_offload: refactor the nft_flow_offload_chain function
  netfilter: nf_offload: refactor the nft_flow_offload_rule function
  netfilter: nf_offload: clean offload things when the device unregister

 include/net/netfilter/nf_tables_offload.h |   2 +-
 net/netfilter/nf_tables_api.c             |   9 +-
 net/netfilter/nf_tables_offload.c         | 142 +++++++++++++++++++++++-------
 3 files changed, 116 insertions(+), 37 deletions(-)

-- 
1.8.3.1

