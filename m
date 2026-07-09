Return-Path: <netfilter-devel+bounces-13809-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N87rCs7+T2qYrgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13809-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 22:04:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512E7353ED
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 22:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13809-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13809-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561BE30151E7
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92EC2E8DFC;
	Thu,  9 Jul 2026 20:04:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A629E116
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 20:04:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627465; cv=none; b=BEq8Jv887XN9dykurZXG3RY5WbmtrtKTGLu2BBfqqIGIgwPMUgJWlIh1eowkI6EArgB7pU/UTpCZ5Ry55+VSZI1rFgbAHlCEo6jp1gVdPAm4GUiTUqzbNybfxR9bAg2+5M5YAwyc9OJBqC9pjyXpyWDLmg2u0C4MeCPH8hq4bcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627465; c=relaxed/simple;
	bh=VewEeYr9KKqYj32ANHVqw6NDJZEzpMZ1/YHkVhUzqGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiqeaV5FMNbvWGdrlu1ejKidqLjKcjbfkP7iFzuVMvax15QY1Tc6Tmll8uDNlCuEiVCJZREQHC093N8NJzOgzSzmLrXne7STgtS+Mq9HCVCJrVIDcb+Ts2tnR1B6+slah8/QkFFOUNVcD9dgdSbP7OSaQdHN3HP7PFVLroNTNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C0E7C602A9; Thu, 09 Jul 2026 22:04:22 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: kadlec@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipset 4/7] tests: check_klog.sh: unclutter stderr
Date: Thu,  9 Jul 2026 22:03:55 +0200
Message-ID: <20260709200358.15504-5-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709200358.15504-1-fw@strlen.de>
References: <20260709200358.15504-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13809-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5512E7353ED

My test vm doesn't have a kern.log file, but the existing
script will fall back to dmesg which is good enough for me.

Suppress the 'no such file' error from tail and go straight
to the dmesg fallback.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/check_klog.sh | 7 ++++++-
 tests/sendip.sh     | 3 +--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/check_klog.sh b/tests/check_klog.sh
index 8ecad3eb987e..bc602be839aa 100755
--- a/tests/check_klog.sh
+++ b/tests/check_klog.sh
@@ -44,7 +44,12 @@ port=$1; shift
 
 set +e
 for setname in $@; do
-	match=`tail -n +$loglines /var/log/kern.log | grep -e "in set $setname: .* SRC=$ipaddr .* PROTO=$proto SPT=$port .*"`
+	if [ -r /var/log/kern.log ]; then
+		match=`tail -n +$loglines /var/log/kern.log | grep -e "in set $setname: .* SRC=$ipaddr .* PROTO=$proto SPT=$port .*"`
+	else
+		match=""
+	fi
+
 	if [ -z "$match" ]; then
 		match=`dmesg | tail -n +$loglines | grep -e "in set $setname: .* SRC=$ipaddr .* PROTO=$proto SPT=$port .*"`
 	fi
diff --git a/tests/sendip.sh b/tests/sendip.sh
index f80b24ab49b8..d1f8ebe4d75b 100755
--- a/tests/sendip.sh
+++ b/tests/sendip.sh
@@ -1,6 +1,5 @@
 #!/bin/bash
 
 # Save lineno for checking
-wc -l /var/log/kern.log | cut -d ' ' -f 1 > "$IPSET_TMP/.loglines"
+wc -l /var/log/kern.log 2>/dev/null | cut -d ' ' -f 1 > "$IPSET_TMP/.loglines"
 sendip "$@"
-
-- 
2.54.0


