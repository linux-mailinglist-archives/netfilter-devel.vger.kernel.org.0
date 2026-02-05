Return-Path: <netfilter-devel+bounces-10634-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GkLJQcBhGkbwwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10634-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:31:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E273AEDFAD
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F34B30053EC
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3F238C0B;
	Thu,  5 Feb 2026 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Y2dkQqYm"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D151FF1B5
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258685; cv=none; b=c6KV/XUMWhwmZVTjW4OpF68GYhLjb64Yr5kMFPSxcOd1rpweBmB6pjzklcvZn+AFhkL7UZ5NW7qsGHEQJj4fKY+Xuj6krzFrQ+28MFZN5JIRYkoaL8TwsV0FasjUQyTAzt6cj1GiCxrDsxymE4JWY5fETLldzVDjjUwo3L28a5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258685; c=relaxed/simple;
	bh=oTda1+xTStdfMBAFP/3SZ4+XbeQYuj/TIYfp6BHImR8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qAzE95YklJoPsSPeImKZy8ZW99kkRYAmiK0vwfoATtQtw6DexYo4UqgTczyFoqUDL4rx253r12egn4D0zTgIURf4W9HThrsR9w72aA8b9FRNgqmdqWDu7poDo6HWNRfZ72jeB25XJWMnPoP1TPV6qj79U39oW0eYKPW+cz2MtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Y2dkQqYm; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E0BF960627
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 03:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770258683;
	bh=o5segeF2zeMwmAHXSOpnhzG6aVol7B2g3DZlfN1Gd+Y=;
	h=From:To:Subject:Date:From;
	b=Y2dkQqYmwDDbrrx2SeFRDbjZ6LEnlqD53PsZcLMPbMXaCRJ/2IN38inDYWvEopZPL
	 hVEpttS5WvWKOiMw50quxsoc+pCp8sPQg1k+2MgN4y3n5LQUv7LZSXEj2PvTOCSRR+
	 akdGkJ5E526GarcLUi6BWaisrv61M2A+XfBQfa20KlJYJ+uxKeh+S7XV3+eDmuL3eb
	 x1xqJZZLYVX883UyZ4llbp+E66RRaFJulBrGN6G0/HIUH/O6pfs3gdPSBWBlRM1GgM
	 cQ3yPZZi/UmMg65uijmFTczoXEcGx0Nj9DhktSGfvpxMMPLGmUU9AEJxq2z68eIKhk
	 5N3gGpSHfeJ0g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: double chain update with same device
Date: Thu,  5 Feb 2026 03:31:18 +0100
Message-ID: <20260205023118.1470019-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-10634-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: E273AEDFAD
X-Rspamd-Action: no action

For Linux kernel patch:

  cf5fb87fcdaa ("netfilter: nf_tables: reject duplicate device on updates")

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../testcases/transactions/chain_update_dup   | 22 +++++++++++++++++++
 .../transactions/flowtable_update_dup         | 22 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/shell/testcases/transactions/chain_update_dup
 create mode 100755 tests/shell/testcases/transactions/flowtable_update_dup

diff --git a/tests/shell/testcases/transactions/chain_update_dup b/tests/shell/testcases/transactions/chain_update_dup
new file mode 100755
index 000000000000..5d529dd157dc
--- /dev/null
+++ b/tests/shell/testcases/transactions/chain_update_dup
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+ip link add dummy0 type dummy
+
+$NFT -f /dev/stdin <<EOF
+table netdev t {
+	chain c {
+		type filter hook ingress priority 0;
+	}
+}
+EOF
+
+$NFT -f /dev/stdin <<EOF
+add chain netdev t c { devices = { dummy0 }; }
+add chain netdev t c { devices = { dummy0 }; }
+EOF
+
+ip link del dummy0
+
+sleep 4
+
+$NFT flush ruleset
diff --git a/tests/shell/testcases/transactions/flowtable_update_dup b/tests/shell/testcases/transactions/flowtable_update_dup
new file mode 100755
index 000000000000..434d8de5d5bc
--- /dev/null
+++ b/tests/shell/testcases/transactions/flowtable_update_dup
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+ip link add dummy0 type dummy
+
+$NFT -f /dev/stdin <<EOF
+table inet t {
+	flowtable f {
+		hook ingress priority 0;
+	}
+}
+EOF
+
+$NFT -f /dev/stdin <<EOF
+add flowtable inet t f { devices = { dummy0 }; }
+add flowtable inet t f { devices = { dummy0 }; }
+EOF
+
+ip link del dummy0
+
+sleep 4
+
+$NFT flush ruleset
-- 
2.47.3


