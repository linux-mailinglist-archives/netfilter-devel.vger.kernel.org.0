Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090323F408A
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Aug 2021 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhHVQjD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Aug 2021 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhHVQjC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:39:02 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4CC061575
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Aug 2021 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Cl3oMvcj0YSg/UG88JZ1lSKPXqKtXyzAKGoyerHo4so=; b=JvuH/fjLgSWf4zO6phPfnjaq7j
        2jeTKiW+R1ETwxznSQxQYG3kGxPoRCcpbt3xdZVRs/lSghbd1AQaTIw5eoZ/b4xEJkKJP9jq/jXXJ
        lDVlJOkebzDa6dgPlboexXhCxJK324S+GZjnjC4Gdkz2Cc/0SsnTrG2pYQWhFHA9sct1iG9/NqO99
        YAEa4cUGMIm2u0PCrY5kJyw3Yqe9vnm+YNB9LopoydnBqnZJVd8FWVgO0NjVcLwtgBwkz/exXhzrP
        Yj/dC10kJCWo8JzvYBUGyQehADaIGqMLILuXj5QVrZsyuuyigEzh6AeFKGJ8QNa3bfHG98AVtDCaL
        8KYIu46Q==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mHqUE-008Q2I-PG; Sun, 22 Aug 2021 17:38:18 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     =?UTF-8?q?Grzegorz=20Kuczy=C5=84ski?= 
        <grzegorz.kuczynski@interia.eu>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons 8/8] xt_condition: simplify clean-up of variables.
Date:   Sun, 22 Aug 2021 17:35:56 +0100
Message-Id: <20210822163556.693925-9-jeremy@azazel.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822163556.693925-1-jeremy@azazel.net>
References: <20210822163556.693925-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Unlocking early and returning in the if-block just complicate the code
to no material benefit.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/xt_condition.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/extensions/xt_condition.c b/extensions/xt_condition.c
index 0b0508b7723c..cf07966e71b7 100644
--- a/extensions/xt_condition.c
+++ b/extensions/xt_condition.c
@@ -193,9 +193,7 @@ static void condition_mt_destroy(const struct xt_mtdtor_param *par)
 		list_del(&var->list);
 		if (cnet->proc_net_condition)
 			remove_proc_entry(var->name, cnet->proc_net_condition);
-		mutex_unlock(&cnet->proc_lock);
 		kfree(var);
-		return;
 	}
 	mutex_unlock(&cnet->proc_lock);
 }
-- 
2.32.0

