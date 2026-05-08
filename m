Return-Path: <netfilter-devel+bounces-12515-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIpsKPxP/ml/pAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12515-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 23:05:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9494FBBD4
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35CFA30470D9
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 May 2026 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572742315F;
	Fri,  8 May 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="Tti836hJ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0F36403B
	for <netfilter-devel@vger.kernel.org>; Fri,  8 May 2026 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274262; cv=none; b=RGwqSMIPi4zfq5OPaupmcCGjzBB4W+3STBnCR6W9b5OU3bzjRpcK89H6L2MGaKguFXtqxrJZs8ZCWLuPxm4xHuWJbgaOXQfvZiSNpBMQb3iKEAsm1XOXFlRpyqN++1NqTPXiajrmHTNoBWvQOHJHILlylci3CyZnjMTqiNMbxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274262; c=relaxed/simple;
	bh=VBmWw4K90l56etN30cLzQrR5qMRXpdUUw0kfS9vRVKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FcsQtMnQRDlvZovPeEKeXBcNesGwd10KGdJiWuH9QJ6k02RHPEC8f2tzU0vinqM09Z1+VgwqTngw4ry7Ns/JsppfDsJMBBRNSOqDWtulaA+R49Hjm4zeKo5VA2IP5HSksdF/7ot73l2AUwCLqSOHAKkKRldV/vLnm7dhxAnPDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=Tti836hJ; arc=none smtp.client-ip=148.6.0.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4gC1gw3Rvwz3sb8r;
	Fri,  8 May 2026 22:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1778273946;
	 x=1780088347; bh=oGb96l/S8WijJSk1sUQGzB7IrwGLZO5aEkXTV3YzVDE=; b=
	Tti836hJ3EuHs3+lA5M67HiM5ylQTJzUuxrKq/X/D/h+WOOwQfmrFToeWzU+jsLI
	AMWLXC9gki6vYt93C8OtBPEE0h9CM81oy4TEVLqGor7j+uh14MRyxzba7TDTN2CQ
	0zSECxzTpvpmCoM7rJ6cCf0Cn6UXjKa+BtzdcdTJJEM=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id FxK_9KEdxti3; Fri,  8 May 2026 22:59:06 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C131D.nat.pool.telekom.hu [37.76.19.29])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4gC1gr5MkSz3sb9B;
	Fri,  8 May 2026 22:59:04 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id E6D55141C70; Fri,  8 May 2026 22:59:03 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v6 0/8] netfilter: ipset fixes
Date: Fri,  8 May 2026 22:58:55 +0200
Message-Id: <20260508205903.10238-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-deepspam: ham 1%
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EB9494FBBD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12515-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackhole.kfki.hu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:mid];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Pablo,

Here follows the new revision of the fixes for the current list
of ipset related issues. If sashiko won't find any issues in=20
the patches themselves, then please consider applying them.

Best regards,
Jozsef

Jozsef Kadlecsik (8):
  netfilter: ipset: fix a potential dump-destroy race
  netfilter: ipset: Fix data race between add and list header in all
    hash types
  netfilter: ipset: Fix data race between add and dump in all hash types
  netfilter: ipset: annotate "pos" for concurrent readers/writers
  netfilter: ipset: Don't use test_bit() in lockless RCU readers
  netfilter: ipset: fix potential torn read in reuse/forceadd cases
  netfilter: ipset: skip gc when resize is in progress
  netfilter: ipset: fix order of usage counters

 net/netfilter/ipset/ip_set_core.c     |  5 +-
 net/netfilter/ipset/ip_set_hash_gen.h | 82 ++++++++++++++++++---------
 2 files changed, 58 insertions(+), 29 deletions(-)

--=20
2.39.5


