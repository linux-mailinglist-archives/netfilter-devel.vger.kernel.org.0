Return-Path: <netfilter-devel+bounces-11708-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WId8EjIA1mk7AAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11708-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 09:13:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B044E3B7F9F
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 09:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68234303A3DE
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037A370D71;
	Wed,  8 Apr 2026 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="ML6XKlx8"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CB376BD7
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Apr 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632396; cv=none; b=PbbXkkmmJjTY3Pepf3d1VY1plWX6UkYreXgG9l/79z9D1HSOab5Si0Kw00+omljyiIwYUqbZ03JEgBU0/EDZStDrVBG1CvgWUdVo9polAubpBuFCN/vLzvHKrkXeNIEN0PFK9T6DgjviCl7SM1IKlvHrjOpps0dvs0AWpZPbCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632396; c=relaxed/simple;
	bh=zNisx4JHHzJTg8xftFQ6+NaVq6uru66yqUHoNC0xM2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPexWq+Ys+nb5n+jeqMpjDCTes3wLbOmd+1kFV93Y/hgbvzHsbF5YIHrtomaHqSafwYWNdzmftVbs34GhHfzRjMXseOddGQBq+8NPx2S0O+Bea0m35zBk0Vc0BRpODP2HkYUO50tOza6/0IqtqtP9K6UhL8/qxt+HuZKArDyeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=ML6XKlx8; arc=none smtp.client-ip=148.6.0.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4frDXz24drz7s85j;
	Wed,  8 Apr 2026 09:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1775631777;
	 x=1777446178; bh=uApGESPJ9c8d9DUK9TQN4YVuW+pbbX+Q18r75b6Bj2o=; b=
	ML6XKlx8tuJOFpJFgKCQrkiwuECBRwNC7tcIJvGv2o7HyETLLsc3gaDaFhmzIDBy
	BXwRLNAqhRfxjwDoivvij8nr3Kfg3RcBLiysAEG+xW7KPFT1Ib6jfbUgy9wKB5CR
	VaAH1v5aZyKb66L/Z1Geoqz4sEBBD+kNTKAVq8W7mNs=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id cc19GfkT4lVd; Wed,  8 Apr 2026 09:02:57 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [IPv6:2001:738:5001:1::240:2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4frDXx0tY0z7s85S;
	Wed,  8 Apr 2026 09:02:57 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 1192334316A; Wed,  8 Apr 2026 09:02:57 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH 0/2] netfilter: ipset: concurrent add and dump fixes
Date: Wed,  8 Apr 2026 09:02:55 +0200
Message-Id: <20260408070257.2437291-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11708-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:mid,blackhole.kfki.hu:dkim];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B044E3B7F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pablo, Florian,

Please consider applying the next patches:

* Fix a data race between add and list in all hash types due to setting
  the position index too early.
* Fix a data race between add and list header commands in all hash types=20
  by protecting the list header dumping part as well.

Best regards,
Jozsef

The following changes since commit a9d4f4f6e65e0bf9bbddedecc84d6724999197=
9c:

  net/mlx5: Update the list of the PCI supported devices (2026-04-06 19:1=
7:42 -0700)

are available in the Git repository at:

  git://blackhole.kfki.hu/nf b93f39a52388ac

for you to fetch changes up to b93f39a52388ac170530633db53137ff7cc41cf3:

  netfilter: ipset: Fix data race between add and dump in all hash types =
(2026-04-08 08:52:31 +0200)

----------------------------------------------------------------
Jozsef Kadlecsik (2):
      netfilter: ipset: Fix data race between add and list header in all =
hash types
      netfilter: ipset: Fix data race between add and dump in all hash ty=
pes

 net/netfilter/ipset/ip_set_core.c     | 4 ++--
 net/netfilter/ipset/ip_set_hash_gen.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

