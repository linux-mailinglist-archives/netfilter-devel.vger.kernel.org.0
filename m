Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C586136D32
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 13:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgAJMiI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 07:38:08 -0500
Received: from kadath.azazel.net ([81.187.231.250]:39860 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgAJMiI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/3T9m6QEVfVUD/+aCjgdUGEDP5YZEMp2PxMcG7lIs9w=; b=TfB5s+DLasdSrnvy4SoPUr8Mzf
        BdkO77BFR8zNKm1FRIpSJIrY0bJB1xlhDvksCP3YtSTN/C26EWAebA44vlWFIdg27LSliEbLH9QE0
        Qpvt0i6COC5vWsAHByd7C9xckDquchmTikNhoW8jN7V/3ddKXtKk/qQes8kJtbRoj0MxnNO5Vd271
        6fDYOrMxuvgEnifKJuQgmLi8O6415ESqS2qzAphGTRzwyv0f7/SByzjReZ/cIsrXyqWVYVHUP8WeM
        63nl84rg03PBipElVGKd0JPgWux3kpNqyKi3s41uwPneItPja6z2nQV/7M5HzEKR6xwLsus3J+xAM
        tv35npNA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iptYF-0003im-6F
        for netfilter-devel@vger.kernel.org; Fri, 10 Jan 2020 12:38:07 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 4/7] netlink_delinearize: remove commented out pr_debug statement.
Date:   Fri, 10 Jan 2020 12:38:03 +0000
Message-Id: <20200110123806.106546-5-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110123806.106546-1-jeremy@azazel.net>
References: <20200110123806.106546-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The statement doesn't compile, so remove it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/netlink_delinearize.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 8b9b5c808384..8f2a5dfacd3e 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2047,8 +2047,6 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
 {
 	struct expr *expr = *exprp, *i;
 
-	//pr_debug("%s len %u\n", expr->ops->name, expr->len);
-
 	switch (expr->etype) {
 	case EXPR_MAP:
 		switch (expr->map->etype) {
-- 
2.24.1

