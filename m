Return-Path: <netfilter-devel+bounces-12996-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vKn+M6HXHmpfVwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12996-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 15:16:17 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7BF62E645
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 15:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=knBwufFr;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-12996-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-12996-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6B22300A74F
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jun 2026 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361663DB334;
	Tue,  2 Jun 2026 13:07:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57337A493
	for <netfilter-devel@vger.kernel.org>; Tue,  2 Jun 2026 13:07:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405651; cv=none; b=batLQ0T1kbD18H9JplrZSuXFgEj1DCl3PJWxSKP2VTVXRap4Kv8suyAFL5RpVSMZq561ALk41mXYoSCkEnnVi8r3yjJ56fF/sT+bvYcLtCD2ZYdXV9xqsYEIRRrD5TWx63VpJnSyuz00+cSndqPq0mHaLDfPJY7PAkqpUmBdwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405651; c=relaxed/simple;
	bh=ulIMXrdw+4wUEhT6vbBlmhRu6IkP8EtPwV+4uxSk+ik=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hoYrFhptZG1hryBQN1eX8DP6fnJuNUHXm0RQ5Sxs5LAZf3LQ9D9VFWMjHwMosYpyusTrdw9Voc8KgBIi6hEGBPV2iADT4t+1OAAGDZpr6rPjGeiSRr1wbvC4kFmmai3mdINMmuCxGXj9ypckdgsm+cIHBa96qWhVi2PVMdXYpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=knBwufFr; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fdjQGybUKJ4Xsld021jpmpCL3ZfHYmMGVhd03ZIh7FE=; b=knBwufFrmveJCaCNwqLBfix952
	uIorNzqeFeQX1tlb6GfY/R9Ka6N3OToh4pjDYK+ww+HIlLnA2U4vNRap0bVg9+R8nPwGdGG+1jBbX
	nFLqTXTsbKjKbMsLo2ODQ7AkJc541nrxrgkonVvabL4REXzBHPEgNvuhTp1Zxsngs+BZRgytr8ElF
	r2Gf8EIEZb2nFZMVQdm9aefFHDBr+cJ5ujUNfbzkj/VKj0zkNaHy/1gnu/ezFJKLXL7uwRLif5h58
	drMuvOICH6Jz/Yp/skEmrj/ZUaXmXAt3f/uSsXVIS/EFXgvEGZFrgkZ9PloQL8KiVeu5ZSGWZA8bl
	ATIHEvww==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wUOq0-000000001F0-3L6l
	for netfilter-devel@vger.kernel.org;
	Tue, 02 Jun 2026 15:07:20 +0200
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Subject: [nft PATCH] tests: shell: packetpath/ct_count: Add missing socat feature test
Date: Tue,  2 Jun 2026 15:07:15 +0200
Message-ID: <20260602130715.727246-1-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12996-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D7BF62E645

Skip the test on systems which don't have socat installed.

Fixes: 95e4cbf6b63c2 ("tests: shell: add simple 'ct count' test case")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/shell/testcases/packetpath/ct_count | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/shell/testcases/packetpath/ct_count b/tests/shell/testcases/packetpath/ct_count
index 06f586ed7cce5..77efc715be3be 100755
--- a/tests/shell/testcases/packetpath/ct_count
+++ b/tests/shell/testcases/packetpath/ct_count
@@ -1,6 +1,8 @@
 #!/bin/bash
 # Test nftables connlimit functionality using network namespaces and socat
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_socat)
+
 . $NFT_TEST_LIBRARY_FILE
 
 set -e
-- 
2.54.0


