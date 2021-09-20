Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0C41291A
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Sep 2021 00:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhITW5l (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 18:57:41 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39288 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbhITWzl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:55:41 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id E46FA6005C
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Sep 2021 00:52:54 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] monitor: display rule position handle
Date:   Tue, 21 Sep 2021 00:54:06 +0200
Message-Id: <20210920225407.1237-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This allow to locate the incremental update in the ruleset.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/monitor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/monitor.c b/src/monitor.c
index 144fe96c2898..ffaa39b67304 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -541,7 +541,10 @@ static int netlink_events_rule_cb(const struct nlmsghdr *nlh, int type,
 			      family,
 			      r->handle.table.name,
 			      r->handle.chain.name);
-
+		if (r->handle.position.id) {
+			nft_mon_print(monh, "handle %" PRIu64" ",
+				      r->handle.position.id);
+		}
 		switch (type) {
 		case NFT_MSG_NEWRULE:
 			rule_print(r, &monh->ctx->nft->output);
-- 
2.30.2

