Return-Path: <netfilter-devel+bounces-12204-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDKpHnMS72mU5QAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12204-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 09:38:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6ED46E727
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05DB43015731
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BAC37D110;
	Mon, 27 Apr 2026 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="VE4mZRQa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6537CD3A
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275279; cv=none; b=qIH/EMQQhXKf0SrseDXQD+Oq1M6FaKDT5iMZq5DzuvuWRKRiEdWeR5ziCA9ACQ7YLNaLQ2M1OLp4fmB0+BJbma6b/ub/OlFH5heGqwZhfWWkPgfv2CA9mWZAh5pObNrNR8NNJmPw2Vq9tEKJkyJ67Q7wGXxiGF+HtWUVSjpCxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275279; c=relaxed/simple;
	bh=IyMJ/kKKTp/atnPILUb2iLFE05POTpZn9tZjG3nky3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHSSFBMhYLTeFzeTdOlQxf3pQ51YzVnLD19ukKR6weo7fJ+IAX5jcsQuUqSqtQQGLiKHt/thmB/EQfmWMBlhzKfYmA5rq+i8JlGF75YvBA6W1jkoa0R1K6ant908tOk/zflyfCR18tA01deSywAf/C7fhfS2SC/bGjTdMRxo4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=VE4mZRQa; arc=none smtp.client-ip=148.6.0.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4g3wLV6sCvz3sbBf;
	Mon, 27 Apr 2026 09:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1777275265;
	 x=1779089666; bh=ZSGnmFijdACSim399gCzTA1B/Eo8MOEZAZUynjWutyw=; b=
	VE4mZRQamcjkvLblhtQ3T/c0JTegHpH/EhKQCanMpsV7HCUvAminXCkTVUQ5/3og
	AACK1oM+ktrLumLjdgVVRO5tkvhoGt3MTRZGq7LCu5uL0zlyXHoyH2YhoQ2y+pNS
	rrYADsBt+QbQbahpXN9aF6ee+OmHATJF0IPqI5N5q0M=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id d-UIHIUJF_5E; Mon, 27 Apr 2026 09:34:25 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C0B05.nat.pool.telekom.hu [37.76.11.5])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4g3wLT0CQjz3sb8x;
	Mon, 27 Apr 2026 09:34:24 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 808B2140B40; Mon, 27 Apr 2026 09:34:24 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 0/5] netfilter: ipset fixes
Date: Mon, 27 Apr 2026 09:34:19 +0200
Message-Id: <20260427073424.573672-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-deepspam: ham 1%
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A6ED46E727
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-12204-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackhole.kfki.hu:dkim];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Pablo,

Here follows the tentative fixes for the current list of ipset related
issues. I'll take into account sashiko reports and after that submit
the final versions. Thanks!

Best regards,
Jozsef

Jozsef Kadlecsik (5):
  netfilter: ipset: Fix data race between add and list header in all
    hash types
  netfilter: ipset: Fix data race between add and dump in all hash types
  netfilter: ipset: annotate "pos" for concurrent readers/writers
  netfilter: ipset: skip gc when resize is in progress
  netfilter: ipset: fix order of usage counters

 net/netfilter/ipset/ip_set_core.c     |  4 +-
 net/netfilter/ipset/ip_set_hash_gen.h | 69 +++++++++++++++++----------
 2 files changed, 47 insertions(+), 26 deletions(-)

--=20
2.39.5


