Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E98E9714B
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHUE4p (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 00:56:45 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:18875 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfHUE4p (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:56:45 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id D2E764161C;
        Wed, 21 Aug 2019 12:56:41 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 0/2]  netfilter: nf_tables_offload: support fwd_netdev offload
Date:   Wed, 21 Aug 2019 12:56:37 +0800
Message-Id: <1566363399-30976-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJQ0lCQkJCQklITEtNSllXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6OCo*IjgzOT8oQx5DPhxN
        DzdPFEpVSlVKTk1NSE1IT0tKQk9OVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpIS0I3Bg++
X-HM-Tid: 0a6cb288be952086kuqyd2e764161c
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This series patch support fwd_netdev offload: 
1). add net in offload ctx to make get the netdevice in the related net.
2). add fw_netdev action offload

This version just split from the orignal big seriese without dependency
with each other

wenxu (2):
  netfilter: nf_flow_offload: add net in offload_ctx
  netfilter: nft_fwd_netdev: add fw_netdev action support

 include/net/netfilter/nf_tables_offload.h |  3 ++-
 net/netfilter/nf_tables_api.c             |  2 +-
 net/netfilter/nf_tables_offload.c         |  3 ++-
 net/netfilter/nft_fwd_netdev.c            | 26 ++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
1.8.3.1

