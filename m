Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C95399675
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Jun 2021 01:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFBXt7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 19:49:59 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43216 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhFBXt7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:49:59 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 770F264200
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Jun 2021 01:47:07 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables] extensions: libxt_tcp: rework translation to use flags match representation
Date:   Thu,  3 Jun 2021 01:48:12 +0200
Message-Id: <20210602234812.25399-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use the new flags match representation available since nftables 0.9.9
to simplify the translation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 extensions/libxt_tcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/extensions/libxt_tcp.c b/extensions/libxt_tcp.c
index 58f3c0a0c3c2..4bcd94630111 100644
--- a/extensions/libxt_tcp.c
+++ b/extensions/libxt_tcp.c
@@ -381,7 +381,7 @@ static void print_tcp_xlate(struct xt_xlate *xl, uint8_t flags)
 		for (i = 0; (flags & tcp_flag_names_xlate[i].flag) == 0; i++);
 
 		if (have_flag)
-			xt_xlate_add(xl, "|");
+			xt_xlate_add(xl, ",");
 
 		xt_xlate_add(xl, "%s", tcp_flag_names_xlate[i].name);
 		have_flag = 1;
@@ -435,11 +435,11 @@ static int tcp_xlate(struct xt_xlate *xl,
 		return 0;
 
 	if (tcpinfo->flg_mask || (tcpinfo->invflags & XT_TCP_INV_FLAGS)) {
-		xt_xlate_add(xl, "%stcp flags & (", space);
-		print_tcp_xlate(xl, tcpinfo->flg_mask);
-		xt_xlate_add(xl, ") %s ",
-			   tcpinfo->invflags & XT_TCP_INV_FLAGS ? "!=": "==");
+		xt_xlate_add(xl, "%stcp flags %s", space,
+			     tcpinfo->invflags & XT_TCP_INV_FLAGS ? "!= ": "");
 		print_tcp_xlate(xl, tcpinfo->flg_cmp);
+		xt_xlate_add(xl, " / ");
+		print_tcp_xlate(xl, tcpinfo->flg_mask);
 	}
 
 	return 1;
-- 
2.20.1

