Return-Path: <netfilter-devel+bounces-13304-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v5fnDEFhMmr/zAUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13304-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 10:56:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8DA697B37
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 10:56:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=t7Y9Y2iK;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13304-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13304-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9572530A7B41
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334A3812EF;
	Wed, 17 Jun 2026 08:50:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572F3BE628
	for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:50:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686210; cv=none; b=FowZzn7ImqeRAKGO1uVyAAdmmNfMX3fSHFCUHJ1G82LEWEybaXdWBY5gN1KntB7ItWf6FX/fiB0/m6DSo/xGEmNgjp1BWRoPx1d/RhC1FlbFfn88Ik0mn8PNC2lLQqT3Nm2umLvYKi1TMpCK8Qr5XsAORdzDBji0b6RISCj5w2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686210; c=relaxed/simple;
	bh=qOz5t9KuiHknouCzqArg+qMcUOQjoAdUKBaOkhO+K20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qz9A5PqEMLtAM50/HCL3Byv+3C7oxngUL17yiYfulogFXba6hGGK+hlGOyG1ioXUXmjFyjG1jTsuVEyiOfpZkALvK6ikkVOTSNBUU7vrXcD3i3KzIkOoD1egThlv7xfCpMSt3rhOMfDEUNZfEYc3P/CAv9N3IxkyTQ366oYvDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=t7Y9Y2iK; arc=none smtp.client-ip=148.6.0.50
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4ggHQL5ntczGFDCV;
	Wed, 17 Jun 2026 10:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1781685688;
	 x=1783500089; bh=zRiz+swikSm8LriJ20mi4d0p6J6dRthjp76+fSBlY2M=; b=
	t7Y9Y2iKSJV9Y6KXyLgjMTTLBJ6n6aOVqvuo9Ta2ZLLoyzTMx+NL/GLIYv+ROyyN
	2vNPM7aoqQHqamEQDOE4U4hD6aeBFCM/2b7vkTtiQskZF1OuLRbBZgEMDZWh0T3Y
	/tD43244jixcBzkeLix+qNdfCrLhMRQg+PeGbQZhjk0=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id HRSMj5lwwzzX; Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (unknown [148.6.40.64])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp1.kfki.hu (Postfix) with ESMTPSA id 4ggHQJ6CGXzGFDCP;
	Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id A40B914045C; Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v3 0/7] netfilter: ipset fixes, second batch
Date: Wed, 17 Jun 2026 10:41:21 +0200
Message-Id: <20260617084128.6603-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13304-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[netfilter.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:mid,netfilter.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF8DA697B37

Hi Pablo,

Here follows the updated patches for the second batch. I left out=20
some potential issues (like torn read in reuse/forceadd cases),=20
those will be handled later.

Best regards,
Jozsef

Jozsef Kadlecsik (7):
  netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash
    types
  netfilter: ipset: Don't use test_bit() in lockless RCU readers in
    bitmap types
  netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
  netfilter: ipset: exlude gc when resize is in progress
  netfilter: ipset: make sure gc is properly stopped
  netfilter: ipset: cleanup the add/del backlog when resize failed
  netfilter: ipset: rework cidr bookkeeping

 net/netfilter/ipset/ip_set_bitmap_gen.h      |  4 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c       |  2 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c    |  2 +-
 net/netfilter/ipset/ip_set_bitmap_port.c     |  2 +-
 net/netfilter/ipset/ip_set_core.c            |  4 +-
 net/netfilter/ipset/ip_set_hash_gen.h        | 96 ++++++++++++++------
 net/netfilter/ipset/ip_set_hash_ipportnet.c  |  4 +-
 net/netfilter/ipset/ip_set_hash_net.c        |  4 +-
 net/netfilter/ipset/ip_set_hash_netiface.c   |  4 +-
 net/netfilter/ipset/ip_set_hash_netnet.c     |  8 +-
 net/netfilter/ipset/ip_set_hash_netport.c    |  4 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c |  8 +-
 12 files changed, 90 insertions(+), 52 deletions(-)

--=20
2.39.5


