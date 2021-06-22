Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C933B010E
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Jun 2021 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVKQD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Jun 2021 06:16:03 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57788 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVKQC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:16:02 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 008FD64133
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Jun 2021 12:12:21 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/2] netfilter: nf_tables: skip netlink portID validation if zero
Date:   Tue, 22 Jun 2021 12:13:41 +0200
Message-Id: <20210622101342.33758-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft_table_lookup() allows us to obtain the table object by the name and
the family. The netlink portID validation needs to be skipped for the
dump path, since the ownership only applies to commands to update the
given table. Skip validation if the specified netlink PortID is zero
when calling nft_table_lookup().

Fixes: 6001a930ce03 ("netfilter: nftables: introduce table ownership")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ca9ec8721e6c..1d62b1a83299 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -571,7 +571,7 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 		    table->family == family &&
 		    nft_active_genmask(table, genmask)) {
 			if (nft_table_has_owner(table) &&
-			    table->nlpid != nlpid)
+			    nlpid && table->nlpid != nlpid)
 				return ERR_PTR(-EPERM);
 
 			return table;
-- 
2.30.2

