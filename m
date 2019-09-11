Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA79AF525
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Sep 2019 06:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfIKEx2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Sep 2019 00:53:28 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:59564 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfIKEx2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Sep 2019 00:53:28 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 3FBA04170C;
        Wed, 11 Sep 2019 12:53:25 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 0/4] netfilter: nf_tables_offload: clean offload things when the device unregister
Date:   Wed, 11 Sep 2019 12:53:20 +0800
Message-Id: <1568177604-26989-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVOTUpCQkJOTkJPS0lPTFlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46Tww*PTg3LTQRFjEQMEoj
        SU0KCy9VSlVKTk1DSkxMTUtOSE9CVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPSU83Bg++
X-HM-Tid: 0a6d1eab4a9a2086kuqy3fba04170c
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series clean the offload things for both chain and rules when the
related device unregister

this version modify the 2/4 and 3/4 and only refactor the
nft_flow_offload_chain/rule function with no add other functions

wenxu (4):
  netfilter: nf_tables_offload: add __nft_offload_get_chain function
  netfilter: nf_offload: refactor the nft_flow_offload_chain function
  netfilter: nf_offload: refactor the nft_flow_offload_rule function
  netfilter: nf_offload: clean offload things when the device unregister

 include/net/netfilter/nf_tables_offload.h |   2 +-
 net/netfilter/nf_tables_api.c             |   9 +-
 net/netfilter/nf_tables_offload.c         | 135 ++++++++++++++++++++++--------
 3 files changed, 110 insertions(+), 36 deletions(-)

-- 
1.8.3.1

