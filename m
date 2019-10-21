Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC1DF019
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfJUOkN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 10:40:13 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51482 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfJUOkN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:40:13 -0400
Received: from localhost ([::1]:36340 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iMYqx-0006CB-9h; Mon, 21 Oct 2019 16:40:11 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org,
        =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>
Subject: [nft PATCH] tproxy: Add missing error checking when parsing from netlink
Date:   Mon, 21 Oct 2019 16:40:03 +0200
Message-Id: <20191021144003.13415-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

netlink_get_register() may return NULL and every other caller checks
that. Assuming this situation is not expected, just jump to 'err' label
without queueing an explicit error message.

Fixes: 2be1d52644cf7 ("src: Add tproxy support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_delinearize.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index f7d328a836998..154353b8161a0 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -1041,6 +1041,8 @@ static void netlink_parse_tproxy(struct netlink_parse_ctx *ctx,
 	reg = netlink_parse_register(nle, NFTNL_EXPR_TPROXY_REG_ADDR);
 	if (reg) {
 		addr = netlink_get_register(ctx, loc, reg);
+		if (addr == NULL)
+			goto err;
 
 		switch (stmt->tproxy.family) {
 		case NFPROTO_IPV4:
@@ -1060,6 +1062,8 @@ static void netlink_parse_tproxy(struct netlink_parse_ctx *ctx,
 	reg = netlink_parse_register(nle, NFTNL_EXPR_TPROXY_REG_PORT);
 	if (reg) {
 		port = netlink_get_register(ctx, loc, reg);
+		if (port == NULL)
+			goto err;
 		expr_set_type(port, &inet_service_type, BYTEORDER_BIG_ENDIAN);
 		stmt->tproxy.port = port;
 	}
-- 
2.23.0

