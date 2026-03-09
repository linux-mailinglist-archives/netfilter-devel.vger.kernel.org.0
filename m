Return-Path: <netfilter-devel+bounces-11053-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UILSBS3rrmlRKAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11053-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 16:45:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D409723BF9D
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81B4E30266EE
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2026 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90CA3CD8AE;
	Mon,  9 Mar 2026 15:41:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04483D3304
	for <netfilter-devel@vger.kernel.org>; Mon,  9 Mar 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070870; cv=none; b=roBV3Ue5eaKVRy8CE5dDoc6+Vm5RtZ02JI/kE5XmQI3bYB/mQJStHfpEyqXOw6LAm55O8w7xJZUrtb0W3zfig0r8iKbqwWpg4hDOan9jde1VLs2Uq1loesgnLviKbGpEP8UOEHAtNNioWAAEp1ZFbxA6YDGPmzwEot4GvZrd250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070870; c=relaxed/simple;
	bh=eJvzTGsRAXguKMxjYfHVn0MzvUleN669+A3xLNUn9Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBMZtHVJNzlzMBMdnyzGbm8IBjIlgfGYcE3SFMfssRSj5f4RXXoDyDGUZwHe0/EAp3MneSYxqw0fcY1dD3E7wB6DKOFyUbmlgsGJxFKn4GJhSxm12byKROwYcYAZBOvVDTKC2xqLkTk8MsnV+0HxdgX2fSWHD2NWfCP2+gJElLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6D9536047A; Mon, 09 Mar 2026 16:41:00 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: add rbtree reload test case
Date: Mon,  9 Mar 2026 16:40:52 +0100
Message-ID: <20260309154055.15005-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D409723BF9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-11053-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.589];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

Generate a random interval set, then flush and reload it a few times.
Note that this test fails with several up-to-date distros that lack
nft commit e83e32c8d1cd ("mnl: restore create element command with large batches").

This hints that we will likely need to revert
648946966a08 ("netfilter: nft_set_rbtree: validate open interval overlap") soon,
or risk major breakage in most current distros .

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../transactions/dumps/large_rbtree.nodump    |   0
 .../testcases/transactions/large_rbtree.sh    | 123 ++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tests/shell/testcases/transactions/dumps/large_rbtree.nodump
 create mode 100755 tests/shell/testcases/transactions/large_rbtree.sh

diff --git a/tests/shell/testcases/transactions/dumps/large_rbtree.nodump b/tests/shell/testcases/transactions/dumps/large_rbtree.nodump
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/shell/testcases/transactions/large_rbtree.sh b/tests/shell/testcases/transactions/large_rbtree.sh
new file mode 100755
index 000000000000..09b16c5d70e9
--- /dev/null
+++ b/tests/shell/testcases/transactions/large_rbtree.sh
@@ -0,0 +1,123 @@
+#!/bin/bash
+
+# load+reload a large, randomly generated rbtree set
+
+set -e
+
+MAXSIZE=50000
+tmpfile=$(mktemp)
+
+cleanup()
+{
+	# error? Dump the failed set
+	test -r "$tmpfile" && cat "$tmpfile"
+	rm -f "$tmpfile"
+}
+trap cleanup EXIT
+
+create_elements() {
+	local howmany=$1
+	local a=10
+	local b=0
+	local c=0
+	local d=1
+	local e=0
+	local i=0
+
+	while [ $i -le $howmany ];do
+		local step1=$((RANDOM%50))
+		d=$((d+step1))
+		if [ $d -ge 256 ];then
+			d=1
+			c=$((c+1))
+		fi
+
+		if [ $c -ge 256 ];then
+			b=$((b+1))
+			c=0
+		fi
+
+		if [ $b -ge 256 ];then
+			a=$((a+1))
+			b=0
+		fi
+
+		echo -n "$a.$b.$c.$d-"
+
+		local step2=$((RANDOM%10))
+		e=$((d+step2))
+		d=$((e+1))
+		if [ $e -ge 256 ];then
+			e=0
+			c=$((c+1))
+		fi
+
+		if [ $c -ge 256 ];then
+			b=$((b+1))
+			c=0
+		fi
+
+		if [ $b -ge 256 ];then
+			a=$((a+1))
+			b=0
+		fi
+
+		echo -n "$a.$b.$c.$e"
+		[ $i -lt $howmany ] && echo ", "
+		i=$((i+1))
+	done
+
+	echo "}"
+}
+
+create_set() {
+cat - <<EOF
+table ip t {
+	set s {
+		typeof ip saddr
+		flags interval
+		elements = {
+EOF
+
+local size1=$((RANDOM+1))
+local size2=$((RANDOM+1))
+
+create_elements $(((size1 * size2) % MAXSIZE))
+
+echo "}"
+}
+
+create_ruleset() {
+	create_set
+cat - <<EOF
+	chain input {
+		type filter hook input priority 0
+
+		ip saddr @s counter
+	}
+}
+EOF
+}
+
+recreate_set() {
+	create_set
+
+	# closes table
+	echo "}"
+}
+
+create_ruleset > "$tmpfile"
+
+# load set
+$NFT -f "$tmpfile"
+
+# flush + reload the same, then different sets
+reloads=$(((RANDOM%5)+1))
+for i in $(seq 1 $reloads); do
+	echo reload:
+	wc -l $tmpfile
+	( echo flush set t s ; cat "$tmpfile" ) | $NFT -f -
+	recreate_set > "$tmpfile"
+done
+
+rm -f "$tmpfile"
-- 
2.52.0


