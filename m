Return-Path: <netfilter-devel+bounces-12434-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMenOpPL+Wn3EAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12434-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 12:50:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B54CBD9C
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 12:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2791E307F4B1
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 May 2026 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CA401A30;
	Tue,  5 May 2026 10:38:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AF401A26
	for <netfilter-devel@vger.kernel.org>; Tue,  5 May 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977486; cv=none; b=RaVGJx3JYW4UN/GxwwVC+m5CEMMdB1vm/2LA5i0+x93iiyCVnOIfWLOJkYRcCMo827oyEqYfxhbIXroIUiXbg4UyHle54Gzby+PRs+qjAfF1oQIlSkHUEO5Qrqyo44EkhYYNktveB42PPtt9spze5JfY1nfnmMmwo0mx2Lhgh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977486; c=relaxed/simple;
	bh=vIRXuQMwNmwh5SjREstmresjQPw9lUj4zZ+6W7e9VBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpyZ6TwstCcEqyIgNcREWlq5gB+zypMl9oHZlVddoceQvpSEotkuHaeqR5Py+s9JZsup41nrvCnPHJHFOjWyt9+TQJ0aJwjDGIFJYa+wYOS7q5bqePTEDV64fg5xhXdgxBKZ5we73zmrPg5JI7QP3FwHXtF2LDCwGVk1o4/9POs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A6441607D4; Tue, 05 May 2026 12:38:03 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: also test byte-based rate limiting
Date: Tue,  5 May 2026 12:37:54 +0200
Message-ID: <20260505103758.31371-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B1B54CBD9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-12434-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.846];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email]

This wasn't covered so far.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Warning: Requires the scanner.l fix to make 'drop' (verdicts)
 parseable even in rate scan state.

 tests/shell/testcases/packetpath/rate_limit | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/shell/testcases/packetpath/rate_limit b/tests/shell/testcases/packetpath/rate_limit
index e0a8abc96ae3..c431c11a4c24 100755
--- a/tests/shell/testcases/packetpath/rate_limit
+++ b/tests/shell/testcases/packetpath/rate_limit
@@ -134,3 +134,20 @@ assert_fail result "tcp connection limit rate 1/sec burst 1 reject"
 sleep 1
 ip netns exec $C socat -u - TCP:${ip_sc}:80,reuseport,connect-timeout=1 <<< 'AAA'
 assert_pass result "tcp connection limit rate 1/sec burst 1 accept"
+
+ip netns exec $S $NFT flush chain filter in_tcp
+assert_pass "flush chain"
+
+ip netns exec $S $NFT add rule filter in_tcp iifname s_c tcp dport 80 limit rate over 1 mbytes/second drop
+assert_pass "limit rate"
+
+s=$(date +%s)
+dd if=/dev/zero bs=1M count=10 | ip netns exec $C socat -u - TCP:${ip_sc}:80,reuseport,connect-timeout=1
+e=$(date +%s)
+d=$((e-s))
+if [ $d -ge 5 ] && [ $d -le 11 ];then
+	echo "limit effective (took $d s)"
+else
+	echo "limit not effective (took $d s)"; exit 1
+	exit 1
+fi
-- 
2.53.0


