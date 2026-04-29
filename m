Return-Path: <netfilter-devel+bounces-12299-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDhXDoUl8mnKoQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12299-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 17:36:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB74970F2
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FCA301455F
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2832ED5C;
	Wed, 29 Apr 2026 15:28:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B934D926
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476539; cv=none; b=giIkiPztTYuR454yJOMUwLcHqGXPCVKS2YhSt386HedPs8gkZg48XEF6dgVZkR/MtF+DGKrl6n6LYK9FqK8c8mWhft+XRleIeKZHxfH3dtiiK1HSA/Gy4e8baxLoV/IK4D5DxfcQXY9pVpTvo9DgeTHKKjI2ZgZ4TSoBLmnU3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476539; c=relaxed/simple;
	bh=o8f1J8kJtjuvaIrz22C7vatd40iBy42YE3DJ3upHhec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/ufJ6u2MAyZ2vwsjHcS1kbf+6uQFUzZUbHh0cmDByXjUsXwRGurwYcUYcx7zcq+GHNJRyvcIvtb7CcyyM7d+5KCFvHqhWHZrRWpq77XjfPLBfFBpdOLA2rQRHdBHLa5h7NV+1UHmXHknn8jY2sQY0L6/jpD2sJQYGYqOleS30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9AA8860336; Wed, 29 Apr 2026 17:28:51 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH conntrack-tools] tests: allow to run conntrackd-tests.py via unshare
Date: Wed, 29 Apr 2026 17:28:43 +0200
Message-ID: <20260429152846.12504-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEEB74970F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12299-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.326];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Minor tweak, set lo to up so this works when run as:
unshare -n ./conntrackd-tests.py

Also allow the script to exit(1) in case there are failures
so CI pipeline doesn't have to screen-scrape for errors.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/conntrackd/conntrackd-tests.py | 4 ++++
 tests/conntrackd/tests.yaml          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tests/conntrackd/conntrackd-tests.py b/tests/conntrackd/conntrackd-tests.py
index f760351d6342..25ebda2a0e59 100755
--- a/tests/conntrackd/conntrackd-tests.py
+++ b/tests/conntrackd/conntrackd-tests.py
@@ -185,6 +185,10 @@ def stage_report():
     logging.info("--- failed tests: {}".format(ctx.counter_test_failed))
     logging.info("--- scenario failure: {}".format(ctx.counter_scenario_failed))
     logging.info("--- total tests: {}".format(total))
+    if ctx.counter_test_failed > 0:
+        exit(1)
+    if ctx.counter_test_ok == 0:
+        exit(1)
 
 
 def parse_args():
diff --git a/tests/conntrackd/tests.yaml b/tests/conntrackd/tests.yaml
index 307f38fee483..a19e443e6bb5 100644
--- a/tests/conntrackd/tests.yaml
+++ b/tests/conntrackd/tests.yaml
@@ -78,6 +78,7 @@
         NetlinkBufferSizeMaxGrowth 8388608
       }
       EOF
+    - ip link set lo up
     - $CONNTRACKD -C /tmp/conntrackd_notrack_hash_defaults -d
     - $CONNTRACKD -C /tmp/conntrackd_notrack_hash_defaults -s | grep -q "cache"
     - $CONNTRACKD -C /tmp/conntrackd_notrack_hash_defaults -k
-- 
2.53.0


