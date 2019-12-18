Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B1124A7E
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 15:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLRO7R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 09:59:17 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:38319 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfLRO7R (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:59:17 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1A12240F4C;
        Wed, 18 Dec 2019 22:59:14 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 0/3] netfilter: nf_tables: fix use counter for rule
Date:   Wed, 18 Dec 2019 22:59:10 +0800
Message-Id: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPSkhCQkJMQk5CSkhMWVdZKFlBSU
        I3V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6PQw4LjgyD0wQOBdRNB8Y
        L1FPFAlVSlVKTkxNTUNKSk5PSkJLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUNDQzcG
X-HM-Tid: 0a6f198526422086kuqy1a12240f4c
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

wenxu (3):
  netfilter: nf_tables: fix rule release in err path
  netfilter: nf_tables: fix miss activate operation in the
  netfilter: nf_tables: fix miss dec set use counter in the
    nf_tables_destroy_set

 net/netfilter/nf_tables_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
1.8.3.1

