Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297C96A00B
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbfGPArv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jul 2019 20:47:51 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:24124 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfGPArv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:47:51 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1FB26417DB;
        Tue, 16 Jul 2019 08:47:47 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 0/8] netfilter: nf_flow_offload: support bridge family offload for both
Date:   Tue, 16 Jul 2019 08:47:38 +0800
Message-Id: <1563238066-3105-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVMTUxCQkJNT0JLT0xDTllXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kzo6DDo5SDg5EANJTUgNQwJR
        SE4wCzZVSlVKTk1ISUhDS01MSk1DVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlLSEk3Bg++
X-HM-Tid: 0a6bf83febc62086kuqy1fb26417db
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

wenxu (8):
  netfilter:nf_flow_table: Refactor flow_offload_tuple to destination
  netfilter:nf_flow_table_core: Separate inet operation to single
    function
  netfilter:nf_flow_table_ip: Separate inet operation to single function
  bridge: add br_vlan_get_info_rcu()
  netfilter:nf_flow_table_core: Support bridge family flow offload
  netfilter:nf_flow_table_ip: Support bridge family flow offload
  netfilter:nft_flow_offload: Support bridge family flow offload
  netfilter: Support the bridge family in flow table

 include/linux/if_bridge.h                   |   7 ++
 include/net/netfilter/nf_flow_table.h       |  39 +++++++-
 net/bridge/br_vlan.c                        |  25 +++++
 net/bridge/netfilter/Kconfig                |   8 ++
 net/bridge/netfilter/Makefile               |   1 +
 net/bridge/netfilter/nf_flow_table_bridge.c |  48 ++++++++++
 net/netfilter/nf_flow_table_core.c          | 102 ++++++++++++++++----
 net/netfilter/nf_flow_table_ip.c            | 127 +++++++++++++++++++------
 net/netfilter/nft_flow_offload.c            | 142 ++++++++++++++++++++++++++--
 9 files changed, 440 insertions(+), 59 deletions(-)
 create mode 100644 net/bridge/netfilter/nf_flow_table_bridge.c

-- 
This new version support IPV6 and get rid of the dependency of br_private.h.
Splite to more patches to make the patch can be more readable
1.8.3.1

