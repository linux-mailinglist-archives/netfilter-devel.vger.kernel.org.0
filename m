Return-Path: <netfilter-devel+bounces-12589-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFFJEwmOBWpNYgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12589-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:55:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B89D853F833
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 720773023E09
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122693DFC80;
	Thu, 14 May 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="hx9EJMTM"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BD3DF006
	for <netfilter-devel@vger.kernel.org>; Thu, 14 May 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748933; cv=none; b=Nz/1FQgQhG5mFyqHGBOBF28t9oiBveRZqvDxHnuQZuwS4thVUQ9ThIGxewlsC2rhJEqVSBLhsHyq2CTTMOtwE+5tzHrrNAHs3u+sx8D1eQrd8CZusVRMyYo0goWrQTN8W/OV5u+ffqzw3jctQBJp99tNSGLd2UK1GzseEKvWCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748933; c=relaxed/simple;
	bh=GIVTYDxJ6DV7A3rvHdAhpdi5/9h1g8LCYCkykTEkVPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p/4CiJuPWEF86RYqiu+JxpA+xIYGgn3cEMsI+kiWIHUoPTDATH4ri3y9G/2Bkx4LMQBDKszmI/2YuFMUsoHCzUZF9IlQJw+IH6QivoAJrLEThzp9LXZeq9Kr29Vi/IUMi1eJuiyMMAqgl+MB4YVyValBf4GO9UalpIX7oFLKW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=hx9EJMTM; arc=none smtp.client-ip=148.6.0.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4gGPL11WwCz7s861;
	Thu, 14 May 2026 10:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1778748919;
	 x=1780563320; bh=/MKGs5J5c/vx1OTj4r5IZ90dmCtHbx1DsHKOH5AR8Lk=; b=
	hx9EJMTMLjoRuVy34EtAQVq6cbpx2HjHbnl1uaBmgMzo2RKGoWdE5aOEuW5tYxNi
	Tgk53/25kZAMhELG+w+XReDkrzlzCdyAKET+kmPV/jMDJuW2Y4/YGL1gmKzfFj74
	lWM3qxQcDeWu8e7zdYRw5vhrs29kz2twkYo/JSjCN8E=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id wNh5d1q6-Slb; Thu, 14 May 2026 10:55:19 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (guest-144-149.eduroam.kfki.hu [148.6.144.149])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp2.kfki.hu (Postfix) with ESMTPSA id 4gGPKz26LMz7s85w;
	Thu, 14 May 2026 10:55:19 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 006D9140A0F; Thu, 14 May 2026 10:55:19 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v7 00/10] netfilter: ipset fixes
Date: Thu, 14 May 2026 10:55:09 +0200
Message-Id: <20260514085519.12729-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B89D853F833
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12589-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:mid];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Pablo,

Here follows the new revision of the fixes for the current list
of ipset related issues. Let's see what else is lurking.

Best regards,
Jozsef

Jozsef Kadlecsik (10):
  netfilter: ipset: fix a potential dump-destroy race
  netfilter: ipset: Fix data race between add and list header in all
    hash types
  netfilter: ipset: Fix data race between add and dump in all hash types
  netfilter: ipset: annotate "pos" for concurrent readers/writers
  netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash
    types
  netfilter: ipset: Don't use test_bit() in lockless RCU readers in
    bitmap types
  netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
  netfilter: ipset: skip gc when resize is in progress
  netfilter: ipset: fix potential torn read in reuse/forceadd cases
  netfilter: ipset: add comment how cidr bookkeeping is working

 net/netfilter/ipset/ip_set_bitmap_gen.h |   7 +-
 net/netfilter/ipset/ip_set_core.c       |   9 +-
 net/netfilter/ipset/ip_set_hash_gen.h   | 125 ++++++++++++++++--------
 3 files changed, 94 insertions(+), 47 deletions(-)

--=20
2.39.5


