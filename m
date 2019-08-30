Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7293A2E08
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Aug 2019 06:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfH3ER0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Aug 2019 00:17:26 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:42645 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfH3ERZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:17:25 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 887E94176F;
        Fri, 30 Aug 2019 12:17:22 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v7 0/8]  netfilter: Support the bridge family in flow table
Date:   Fri, 30 Aug 2019 12:17:14 +0800
Message-Id: <1567138642-11446-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJQ01LS0tLSkhITkpPT1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Lww4PDgyITIeMiMOLzpD
        LDMKFDlVSlVKTk1MSkhDTU9JTUhLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlLSEk3Bg++
X-HM-Tid: 0a6ce0bdfa942086kuqy887e94176f
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series add the bridge flow table type. Implement the datapath
flow table to forward both IPV4 and IPV6 traffic through bridge.

This version just rebase with upstream fix

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
 include/net/netfilter/nf_flow_table.h       |  39 +++++-
 net/bridge/br_vlan.c                        |  25 ++++
 net/bridge/netfilter/Kconfig                |   8 ++
 net/bridge/netfilter/Makefile               |   1 +
 net/bridge/netfilter/nf_flow_table_bridge.c |  48 ++++++++
 net/netfilter/nf_flow_table_core.c          | 102 ++++++++++++---
 net/netfilter/nf_flow_table_ip.c            | 184 ++++++++++++++++++++--------
 net/netfilter/nft_flow_offload.c            | 144 ++++++++++++++++++++--
 9 files changed, 475 insertions(+), 83 deletions(-)
 create mode 100644 net/bridge/netfilter/nf_flow_table_bridge.c

-- 
1.8.3.1

