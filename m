Return-Path: <netfilter-devel+bounces-10512-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKrNI/Jpe2lEEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10512-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:08:50 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A807FB0BA0
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9925930093B2
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C3385508;
	Thu, 29 Jan 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="SbQeVnwP"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A03081BE
	for <netfilter-devel@vger.kernel.org>; Thu, 29 Jan 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695675; cv=none; b=QANcKpvGW1plWen97DksITcuG6acUtve/Qy/B1ItYD2Dsx0GyMnnClU2j2hmRbYu/Qi4MgQ5RxkNIEr1AHNlYBIZPnJj+u5iL5vmqpB0O3OdaJQtquukHf/LKXNeBgOeulri7WdQeOSINF7C1EaoaNbwpHRRBi++QNq6Ho0U7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695675; c=relaxed/simple;
	bh=a7jQNainYGuKosPZ6+Ps86r0s/FmbCqVgcB8YQOLrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaZ45AX7tvEx8G5+W94aW9D/bJDyDbcs3TnOdeNA2gCpCItOJmm9Mc8d7JOrrzEjw7PGVOb13F52X3+Q+KT970EeVB/H+iSqKFaXUhwVX6KoTfS5k7x+dPoEjTNPjxOElfk9JYucgU6ZcLYbOEGBbC9ll1CwuWGrElliIq3etrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=SbQeVnwP; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CW2QQCfY9/Hdysd1SI1CuGbgzATAxK+je1pgsfvpoVQ=; b=SbQeVnwPEUEMf7aEBw+FZ4WhrY
	NwwwuwdooyCxAjMXI6++ETSd2l+/U0Le6/YB5sfkhSL+vAcrA2Z2BDq29mUfg4NoRz3PTmldoBNm/
	rS6luAWd6ORpF/hP2Nc6BWwAqfwtLWMOrlHQnnZTBMr6TjUqhZrB+L5hB52omTIQyf4Ik929+OJ3C
	uXno1nzkyCqb76N1N+oWHVcvmrbBNgVRVk8Q4zEcd3oDLD7Gsw5UH1CF2JbEUrncWJQ3q3on49N6m
	C4PuYFfqhmehSt5nf6hAl3sG6S9hp4X7qltrlJgRM+bOSePXbL6d10ObdpjqYJ1w9LeusHqC7/QTQ
	lEIu+6Ww==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vlSgZ-000000001NW-4AXv;
	Thu, 29 Jan 2026 15:07:52 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nft PATCH] tests: py: Adjust payloads to changed userdata printing
Date: Thu, 29 Jan 2026 15:07:46 +0100
Message-ID: <20260129140746.10140-1-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10512-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nwl.cc:mid,nwl.cc:email]
X-Rspamd-Queue-Id: A807FB0BA0
X-Rspamd-Action: no action

libnftnl no longer prints userdata content but merely its size and a sum
of all bytes.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/ip6/srh.t.payload | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/py/ip6/srh.t.payload b/tests/py/ip6/srh.t.payload
index 5c3031f3bdd23..54fdd0ea5ad09 100644
--- a/tests/py/ip6/srh.t.payload
+++ b/tests/py/ip6/srh.t.payload
@@ -11,7 +11,7 @@ ip6 test-ip6 input
 # srh last-entry { 0, 4-127, 255 }
 __set%d test-ip6 7 size 5
 __set%d test-ip6 0
-	element 00	element 01 flags 1	element 04	element 80 flags 1	element ff  userdata = { \x01\x04\x00\x00\x00\x01 }
+	element 00	element 01 flags 1	element 04	element 80 flags 1	element ff  userdata len 6 sum 0x6
 ip6 test-ip6 input
   [ exthdr load ipv6 1b @ 43 + 4 => reg 1 ]
   [ lookup reg 1 set __set%d ]
@@ -29,7 +29,7 @@ ip6 test-ip6 input
 # srh flags { 0, 4-127, 255 }
 __set%d test-ip6 7 size 5
 __set%d test-ip6 0
-	element 00	element 01 flags 1	element 04	element 80 flags 1	element ff  userdata = { \x01\x04\x00\x00\x00\x01 }
+	element 00	element 01 flags 1	element 04	element 80 flags 1	element ff  userdata len 6 sum 0x6
 ip6 test-ip6 input
   [ exthdr load ipv6 1b @ 43 + 5 => reg 1 ]
   [ lookup reg 1 set __set%d ]
@@ -47,7 +47,7 @@ ip6 test-ip6 input
 # srh tag { 0, 4-127, 0xffff }
 __set%d test-ip6 7 size 5
 __set%d test-ip6 0
-	element 0000	element 0001 flags 1	element 0004	element 0080 flags 1	element ffff  userdata = { \x01\x04\x00\x00\x00\x01 }
+	element 0000	element 0001 flags 1	element 0004	element 0080 flags 1	element ffff  userdata len 6 sum 0x6
 ip6 test-ip6 input
   [ exthdr load ipv6 2b @ 43 + 6 => reg 1 ]
   [ lookup reg 1 set __set%d ]
-- 
2.51.0


