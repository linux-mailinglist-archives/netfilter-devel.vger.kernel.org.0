Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15514DE56
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Jan 2020 17:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA3QEt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Jan 2020 11:04:49 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45778 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727191AbgA3QEt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:04:49 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from paulb@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 Jan 2020 18:04:47 +0200
Received: from reg-r-vrt-019-120.mtr.labs.mlnx (reg-r-vrt-019-120.mtr.labs.mlnx [10.213.19.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00UG4khe004757;
        Thu, 30 Jan 2020 18:04:46 +0200
From:   Paul Blakey <paulb@mellanox.com>
To:     Paul Blakey <paulb@mellanox.com>, Oz Shlomo <ozsh@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Majd Dibbiny <majd@mellanox.com>,
        netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 0/3] Various fixes for flowtable hardware offload
Date:   Thu, 30 Jan 2020 18:04:34 +0200
Message-Id: <1580400277-6305-1-git-send-email-paulb@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

First two related to flushing the pending hardware offload work,
and the third is just a line that was accidently removed.

Paul Blakey (3):
  netfilter: flowtable: Fix hardware flush order on
    nf_flow_table_cleanup
  netfilter: flowtable: Fix missing flush hardware on table free
  netfilter: flowtable: Fix setting forgotten NF_FLOW_HW_DEAD flag

 net/netfilter/nf_flow_table_core.c    | 3 ++-
 net/netfilter/nf_flow_table_offload.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
1.8.3.1

