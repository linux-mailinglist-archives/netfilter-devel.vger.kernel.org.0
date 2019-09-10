Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A614DAF27B
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfIJVKb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 17:10:31 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:44982 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfIJVKb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 17:10:31 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i7nPA-0000WV-Jw; Tue, 10 Sep 2019 23:10:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Duncan Roe <duncan_roe@optusnet.com.au>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH iptables] netfilter: hashlimit: prefer PRIu64 to avoid warnings on 32bit platforms
Date:   Tue, 10 Sep 2019 23:08:20 +0200
Message-Id: <20190910210820.9742-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Duncan Roe <duncan_roe@optusnet.com.au>

I found this patch attached to an older BZ, apply this finally...

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1107
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 extensions/libxt_hashlimit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extensions/libxt_hashlimit.c b/extensions/libxt_hashlimit.c
index f3b6e04309bd..7f1d2a402c4f 100644
--- a/extensions/libxt_hashlimit.c
+++ b/extensions/libxt_hashlimit.c
@@ -772,7 +772,7 @@ static void hashlimit_mt_check(struct xt_fcheck_call *cb)
 		if (cb->xflags & F_BURST) {
 			if (info->cfg.burst < cost_to_bytes(info->cfg.avg))
 				xtables_error(PARAMETER_PROBLEM,
-					"burst cannot be smaller than %lub", cost_to_bytes(info->cfg.avg));
+					"burst cannot be smaller than %"PRIu64"b", cost_to_bytes(info->cfg.avg));
 
 			burst = info->cfg.burst;
 			burst /= cost_to_bytes(info->cfg.avg);
-- 
2.21.0

