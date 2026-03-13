Return-Path: <netfilter-devel+bounces-11177-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MpsCsDqs2nadAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11177-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 11:45:20 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA8281B17
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A91E7301E99C
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063F388E65;
	Fri, 13 Mar 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="RxwQvall"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62C381B18
	for <netfilter-devel@vger.kernel.org>; Fri, 13 Mar 2026 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398670; cv=none; b=uWVGWuM2LNjcid9CEE3nTVUNL8a1Oi35CUcIvvr9+8HYUO2JH600Jv1tJbIrZwjvpcndZowODm2DjAn9VQhlVMbodPGQXVLNtpRodtiAmfDKMFFRuRfb6RGMOuk0RaQFVt8O1NXHgl7BpNAQnGdGz76BxZh533RwjScouN/xbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398670; c=relaxed/simple;
	bh=lWhaWeHKX44Y1PORTFVGWpg4M6uYobzxJQuIRREeYbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhXooKiXTkpccdqth0Als3J/rTppwJxVEKJvzioYO1OigPlOPi95KDvC3MUvh7saOf+CiZuA9menjb8RbKRULaHm4rzyf1tZ27vdPfhJ0HPm87QWg6z1gvMXLIHN9NRgS3BCo0cC2f9eQfWBC2suc3rArjbUjwxhBGtPmTD6ezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=RxwQvall; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wmwgsJhl/I8uKjsjr+Fc+WdAEZwb2grf/yIfgjno+tE=; b=RxwQvallefguu9Jw6ArOLHDZyR
	35JjZHbAMGr8COt0UaHpv3FtkaK67EZtUptSSTsY0Aj+M1TSwx05iS62n05OaDblmMV9Y+ppCuuhx
	VzX0Y+ogfuhfH/dZKswK0yC5xbz52HvI9XhPFmSHtjnDcgyuopUw08gbqnyCa3blghc50p5RUmYKc
	YhcLlsjIa4gnNYmLRRef/CQD9WAAa5rfe0vnz4K/HS5sQkCFZYQvoOTK/mJ8bxdccxD7w9LgZCRlc
	y/4vlyAstQxCub38zdKUmDqkLzVku9AkII5KCY6u4yMyG/c4W8q6lLeNHA9gTrQNtu6BZvx676q3X
	BvP08pkg==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w100B-000000000Va-3Wod;
	Fri, 13 Mar 2026 11:44:19 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Jeremy Sowden <jeremy@azazel.net>
Subject: [nft PATCH] Revert "tests: py: use `os.unshare` Python function"
Date: Fri, 13 Mar 2026 11:44:14 +0100
Message-ID: <20260313104414.21686-1-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11177-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-0.586];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93FA8281B17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit c29407ab300f8ed54b5ca27cf4837c0aab920760.

This change breaks 'time' expression tests in py test suite. It looks
like with os.unshare, modifications to os.environ are lost. Neither
unshare module nor unshare command suffer from this problem.

Fixes: c29407ab300f8 ("tests: py: use `os.unshare` Python function")
Suggested-by: Jeremy Sowden <jeremy@azazel.net>
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/nft-test.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
index 64837da360359..53fd3f7ae6fea 100755
--- a/tests/py/nft-test.py
+++ b/tests/py/nft-test.py
@@ -1466,14 +1466,7 @@ def set_delete_elements(set_element, set_name, table, filename=None,
     return [tests, passed, total_warning, total_error, total_unit_run]
 
 def spawn_netns():
-    # prefer stdlib unshare function ...
-    try:
-        os.unshare(os.CLONE_NEWNET)
-        return True
-    except Exception as e:
-        pass
-
-    # ... or unshare module
+    # prefer unshare module
     try:
         import unshare
         unshare.unshare(unshare.CLONE_NEWNET)
-- 
2.51.0


