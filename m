Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC39ACF3D
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Sep 2019 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfIHOT7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Sep 2019 10:19:59 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:3237 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfIHOT7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:19:59 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id D29995C16C6;
        Sun,  8 Sep 2019 22:18:57 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 0/4] netfilter: nf_tables_offload: clean offload things when the device unregister
Date:   Sun,  8 Sep 2019 22:18:52 +0800
Message-Id: <1567952336-23669-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPSkhCQkJMQk5CSkhMWVdZKFlBSU
        I3V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6LQw4Qjg5HzUoExMyOTwB
        PzYKC1FVSlVKTk1MQk5JSEhMQkhPVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpITUs3Bg++
X-HM-Tid: 0a6d113dfbce2087kuqyd29995c16c6
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series clean the offload things for both chain and rules when the
related device unregister

This version add a __nft_offload_get_chain common function

wenxu (4):
  netfilter: nf_offload: refactor the nft_flow_offload_chain function
  netfilter: nf_offload: refactor the nft_flow_offload_rule function
  netfilter: nf_tables_offload: add __nft_offload_get_chain function
  netfilter: nf_offload: clean offload things when the device unregister

 include/net/netfilter/nf_tables_offload.h |   2 +-
 net/netfilter/nf_tables_api.c             |   9 ++-
 net/netfilter/nf_tables_offload.c         | 122 ++++++++++++++++++++++++------
 3 files changed, 105 insertions(+), 28 deletions(-)

-- 
1.8.3.1

