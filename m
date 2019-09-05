Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF48A9922
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Sep 2019 06:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfIEEAW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 00:00:22 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:26714 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIEEAV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:00:21 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id C99A141623;
        Thu,  5 Sep 2019 12:00:19 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v3 0/4] netfilter: nf_tables_offload: clean offload things when the device unregister
Date:   Thu,  5 Sep 2019 12:00:15 +0800
Message-Id: <1567656019-6881-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJQ01LS0tLSkhITkpPT1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006Nxw6Ljg2AzcWEB4zATE1
        HBUaFDVVSlVKTk1MTU5NS0pCQkNMVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPS0s3Bg++
X-HM-Tid: 0a6cff9487802086kuqyc99a141623
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series clean the offload things for both chain and rules when the
related device unregister

This version add a nft_offload_netdev_iterate common function

wenxu (4):
  netfilter: nf_tables_offload: refactor the nft_flow_offload_chain
    function
  netfilter: nf_tables_offload: refactor the nft_flow_offload_rule
    function
  netfilter: nf_tables_offload: add nft_offload_netdev_iterate function
  netfilter: nf_tables_offload: clean offload things when the device
    unregister

 include/net/netfilter/nf_tables_offload.h |   2 +-
 net/netfilter/nf_tables_api.c             |   9 ++-
 net/netfilter/nf_tables_offload.c         | 122 ++++++++++++++++++++++++------
 3 files changed, 105 insertions(+), 28 deletions(-)

-- 
1.8.3.1

