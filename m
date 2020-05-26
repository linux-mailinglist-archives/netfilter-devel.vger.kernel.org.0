Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCEE1AF9B4
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2020 13:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgDSLxq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Apr 2020 07:53:46 -0400
Received: from correo.us.es ([193.147.175.20]:55910 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgDSLxq (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Apr 2020 07:53:46 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5AE54191907
        for <netfilter-devel@vger.kernel.org>; Sun, 19 Apr 2020 13:53:44 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4D4E6BAC2F
        for <netfilter-devel@vger.kernel.org>; Sun, 19 Apr 2020 13:53:44 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 424F7DA3C2; Sun, 19 Apr 2020 13:53:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 552A8DA736;
        Sun, 19 Apr 2020 13:53:42 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 19 Apr 2020 13:53:42 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 1474E41E4800;
        Sun, 19 Apr 2020 13:53:42 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        jiri@resnulli.us
Subject: [PATCH net] net: flow_offload: skip hw stats check for FLOW_ACTION_HW_STATS_DISABLED
Date:   Sun, 19 Apr 2020 13:53:38 +0200
Message-Id: <20200419115338.659487-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the frontend requests no stats through FLOW_ACTION_HW_STATS_DISABLED,
drivers that are checking for the hw stats configuration bail out with
EOPNOTSUPP.

Fixes: 319a1d19471e ("flow_offload: check for basic action hw stats type")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/flow_offload.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 3619c6acf60f..c2519a25d0bd 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -326,6 +326,9 @@ __flow_action_hw_stats_check(const struct flow_action *action,
 	if (!flow_action_mixed_hw_stats_check(action, extack))
 		return false;
 	action_entry = flow_action_first_entry_get(action);
+	if (action_entry->hw_stats == FLOW_ACTION_HW_STATS_DISABLED)
+		return true;
+
 	if (!check_allow_bit &&
 	    action_entry->hw_stats != FLOW_ACTION_HW_STATS_ANY) {
 		NL_SET_ERR_MSG_MOD(extack, "Driver supports only default HW stats type \"any\"");
-- 
2.11.0

