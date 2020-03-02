Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FBD1766B5
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCBWTT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:19:19 -0500
Received: from kadath.azazel.net ([81.187.231.250]:41498 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCBWTT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pqeDVg0Ewpsxb9JAmnAlmcKCzxTqlRlU+LINyC3QKIk=; b=D7Rp8RKfn7pd86iHO5g8FLasFb
        4CBGbL+6Ha52CmydLLJOJ/f2VpokUCPNvcUAhX21Sblo+XAYAz5H7Tvz44xf2EvdbgmbLlxzxtBYD
        mYuEjbGNjWCdJziG7aPNLWOttskX2C+ue7vDCybeu6Ac27KF68DdSoSwExGgSWw0DI4y+FKsbETmb
        GaEJVvNxLoM6doZ0ZMTPWF+je3NA7Wi4idw1yHSTCyeFcMLgR4EP8TJqCFkZ/+i9npGEfH7HjEXK6
        mUcbyj0oG8+dkJ+wJWWe4YsCw1Il0lhXeqtk5PDElzhN2U+foz8msqP/Cd483jl/WHZNqIYFM8wZY
        xEyVRMfQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPB-0000Sg-0Z; Mon, 02 Mar 2020 22:19:17 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 06/18] netlink_delinearize: set shift RHS byte-order.
Date:   Mon,  2 Mar 2020 22:19:04 +0000
Message-Id: <20200302221916.1005019-7-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302221916.1005019-1-jeremy@azazel.net>
References: <20200302221916.1005019-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The RHS operand for bitwise shift is in HBO.  Set this explicitly.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/netlink_delinearize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 0058e2cfe42a..3c80895a43f9 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -440,6 +440,7 @@ static struct expr *netlink_parse_bitwise_shift(struct netlink_parse_ctx *ctx,
 
 	nld.value = nftnl_expr_get(nle, NFTNL_EXPR_BITWISE_DATA, &nld.len);
 	right = netlink_alloc_value(loc, &nld);
+	right->byteorder = BYTEORDER_HOST_ENDIAN;
 
 	expr = binop_expr_alloc(loc, op, left, right);
 	expr->len = left->len;
-- 
2.25.1

