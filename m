Return-Path: <netfilter-devel+bounces-11055-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKEDBUbsrmmSKQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11055-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 16:50:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B278423C140
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA94730E2337
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2026 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AABB363C4E;
	Mon,  9 Mar 2026 15:45:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281413D5226
	for <netfilter-devel@vger.kernel.org>; Mon,  9 Mar 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071142; cv=none; b=NVDikd9nm6tufkbXd5JOZBfT7CPuAGwQhCItw78M6THVx5vl7t3HhcpKTsWSHVST/czInw3Cw6i2q6EfpxTwL29cLCo1dAdfwp4rsoGw76rYXPRgaQt4ZQaq+MxhRswKsqh/HAHush6MQG4j6n2YS+3cRa/9prv/6yHi/QPFa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071142; c=relaxed/simple;
	bh=Rdv37xjTeY00UMMFjbe2W/Ow8f2bIeb8AZwlmGG3MYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsG2+Vuh7xGa/XLUEL0kVdPA42JfSQzR4WvHo6a7vbW2cAXc6rh0lKY5VbKW4nhctnFeOPUQR/NBrFuHvyo/KRMKH1GDf1mjGFRvnV6+K5klV5q5hCY/I6aKgO0c/PBWZQFgBYy+p+Bhk7sd4ZhJaaK6Guoxvj9A6iO7wtGQh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 72C266047A; Mon, 09 Mar 2026 16:45:39 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH libnetfilter_conntrack] tests: add a wrapper for the filter test case
Date: Mon,  9 Mar 2026 16:45:31 +0100
Message-ID: <20260309154534.8366-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B278423C140
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
	TAGGED_FROM(0.00)[bounces-11055-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.619];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

The test requires traffic + active conntrack to pass.
Add a wrapper script that creates a new netns, enables
conntrack and then creates traffic (== ctnetlink events).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/test_filter.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 tests/test_filter.sh

diff --git a/tests/test_filter.sh b/tests/test_filter.sh
new file mode 100755
index 000000000000..0910a61070ce
--- /dev/null
+++ b/tests/test_filter.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+
+exec unshare -n bash -c '
+ip link set lo up
+nft -f -<<EOF
+table t {
+	chain c {
+		ct state new accept
+	}
+}
+EOF
+
+timeout 20 ./test_filter | grep -q NEW &
+rp=$!
+sleep 1
+
+for i in $(seq 1 127); do
+	timeout 1 ping -q -c 1 -I 127.0.0.$i 127.0.0.$i
+done > /dev/null
+
+wait $rp
+ret=$?
+
+echo "test_filter: return $ret"
+
+exit $ret
+'
-- 
2.52.0


