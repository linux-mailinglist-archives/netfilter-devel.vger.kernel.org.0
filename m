Return-Path: <netfilter-devel+bounces-13808-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NHFhLsf+T2qTrgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13808-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 22:04:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70F7353EA
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 22:04:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13808-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13808-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDB91301B816
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B229E116;
	Thu,  9 Jul 2026 20:04:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7E282F10
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 20:04:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627461; cv=none; b=rBmzbV87N6dhXC2AR8skhvvEkARhrPcVEgjhI9OZ0B/d8GYzHlee3Dz5A5fs8SGvNKsEwzsKimSdsyj9kSqdzp8hASgBGmD+f8EOKF4I//O1M+d06I3eRRS6at5Lo3CM6woyXo9Cf7WlivO1MGvul982Ilcg7HDHX0pJPCBYdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627461; c=relaxed/simple;
	bh=2zArP/qSnPkdSw/LccIyDJtm0ZIKVjyEIBLF4DOqsGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlYORies5Kauq/lJUNZ1JdpBCmU+hOKWGZObrlGJZkjA11HETuJn32bbVcrtpIFODb3cs7wiWVvP77/DKjynKe6GWEvh2uW7nYAmDlak/gjDDKhy2zs/YJ3vV1mGN0B2Uk+LmeQkGGhhJCtfZjmdZNvTY9oQE6xKSmU6aTlCZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 816BE602A9; Thu, 09 Jul 2026 22:04:18 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: kadlec@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipset 3/7] tests: diff.sh: preserve file name
Date: Thu,  9 Jul 2026 22:03:54 +0200
Message-ID: <20260709200358.15504-4-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13808-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:from_mime,strlen.de:email,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B70F7353EA

As-is, in case of error, its not easy to see which diff file has
failed, because diff gets fed via <(sed...), so diff shows
something like
--- /dev/fd/63
+++ /dev/ ..

Take advantage of the temporary directory and output a file
that has keeps part of the original name.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/diff.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/diff.sh b/tests/diff.sh
index a364a28b1dda..76b1938149eb 100755
--- a/tests/diff.sh
+++ b/tests/diff.sh
@@ -1,7 +1,14 @@
 #!/bin/bash
 
-diff -u -I 'Revision: .*' -I 'Size in memory.*' \
-    <(sed -e 's/timeout [0-9]*/timeout x/' -e 's/initval 0x[0-9a-fA-F]\{8\}/initval 0x00000000/' $1) \
-    <(sed -e 's/timeout [0-9]*/timeout x/' -e 's/initval 0x[0-9a-fA-F]\{8\}/initval 0x00000000/' $2)
+NEW_DUMP="$IPSET_TMP/kernel-dump.sed"
+STORED_DUMP="$IPSET_TMP/$2.sed"
 
+sed -e 's/timeout [0-9]*/timeout x/' -e 's/initval 0x[0-9a-fA-F]\{8\}/initval 0x00000000/' "$1" > "$NEW_DUMP"
+sed -e 's/timeout [0-9]*/timeout x/' -e 's/initval 0x[0-9a-fA-F]\{8\}/initval 0x00000000/' "$2" > "$STORED_DUMP"
 
+diff -u -I 'Revision: .*' -I 'Size in memory.*' "$STORED_DUMP" "$NEW_DUMP"
+ret=$?
+
+rm -f "$STORED_DUMP" "$NEW_DUMP"
+
+exit $ret
-- 
2.54.0


