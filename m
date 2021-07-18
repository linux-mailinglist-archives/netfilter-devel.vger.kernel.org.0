Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3D3CC9E3
	for <lists+netfilter-devel@lfdr.de>; Sun, 18 Jul 2021 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhGRQjI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 18 Jul 2021 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhGRQjI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 18 Jul 2021 12:39:08 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C575C061762
        for <netfilter-devel@vger.kernel.org>; Sun, 18 Jul 2021 09:36:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1m59lv-0005sr-1d; Sun, 18 Jul 2021 18:36:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: conntrack: adjust stop timestamp to real expiry value
Date:   Sun, 18 Jul 2021 18:36:00 +0200
Message-Id: <20210718163600.220854-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In case the entry is evicted via garbage collection there is
delay between the timeout value and the eviction event.

This adjusts the stop value based on how much time has passed.

Fixes: b87a2f9199ea82 ("netfilter: conntrack: add gc worker to remove timed-out entries")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 96ba19fc8155..97274698050b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -662,8 +662,13 @@ bool nf_ct_delete(struct nf_conn *ct, u32 portid, int report)
 		return false;
 
 	tstamp = nf_conn_tstamp_find(ct);
-	if (tstamp && tstamp->stop == 0)
+	if (tstamp) {
+		s32 timeout = ct->timeout - nfct_time_stamp;
+
 		tstamp->stop = ktime_get_real_ns();
+		if (timeout < 0)
+			tstamp->stop -= jiffies_to_nsecs(-timeout);
+	}
 
 	if (nf_conntrack_event_report(IPCT_DESTROY, ct,
 				    portid, report) < 0) {
-- 
2.31.1

