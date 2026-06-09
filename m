Return-Path: <netfilter-devel+bounces-13141-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sxvQB8jCJ2rR1gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13141-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 09:37:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291565D499
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 09:37:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=MWZgpLzb;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13141-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13141-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 571FD300D7B4
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3F3DDDA6;
	Tue,  9 Jun 2026 07:34:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30353DD537
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 07:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990497; cv=none; b=dR/5siXVy0xUPTGfKCPVgLzXvEZl31agfhF8zANxKQvg1kRW6jh8aj1a2/knTQYii/L1tXFSr2o8yh7hy3TyyhP6d2RSadcyh3SXiccWwXjWH2ggP8dTJlcHvUVCcGhHvsT7jeSB8uxGFLV6X0g0jOoNBN0e670m3MAVi3eYP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990497; c=relaxed/simple;
	bh=17+QzvOWwrHsvjqhnNu+pqKduIne1F8+BotFG8kXrEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KN+s60/mYaQbR/l6vhdKctP9v+MRUMIkoWeQupWp1R7R0KiX9zZThzSsGgmIZ+T/iZkbjkVec/o6YLAvh98FXinsli8BjeopO7RYYU+rMHW7QA/EUhqx7hSJUoBTWTYP1/0d9hTU/eW08mI9q+MWjPhRLSZm8q4SclAszE7yzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=MWZgpLzb; arc=none smtp.client-ip=148.6.0.49
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4gZL945pljz3sb0b;
	Tue, 09 Jun 2026 09:27:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1780990070;
	 x=1782804471; bh=APhPpBlHiVprsAVjFoY31i4tgscVkDJJHx5huAYCYJU=; b=
	MWZgpLzbxpdjWF/+QdvIbWw1AezoHyrN1PuvACmd9f51C4O+Xo/DRlxI93+uFuyd
	76UdXOXq8TYEtXI4UHLQULUyfSzV/aV6Du76BKKVwEdoF6LYmn2EuxXTabWFsyFp
	tzqy4FlpCBJAkFMr50bA71zZIKy9881q3lX5fGs/JzY=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id TtWE_dHDqVy6; Tue,  9 Jun 2026 09:27:50 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C0692.nat.pool.telekom.hu [37.76.6.146])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4gZL925mPSz3sb0c;
	Tue, 09 Jun 2026 09:27:50 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 439441404E1; Tue,  9 Jun 2026 09:27:50 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 0/9] netfilter: ipset fixes, second batch
Date: Tue,  9 Jun 2026 09:27:41 +0200
Message-Id: <20260609072750.318774-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-deepspam: ham 0%
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-13141-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5291565D499

Hi Pablo,

Here comes the reworked version of the patches, including the fixes
of the relevant new issues sashiko complained about at the last review.

Best regards,
Jozsef

Jozsef Kadlecsik (9):
  netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash
    types
  netfilter: ipset: Don't use test_bit() in lockless RCU readers in
    bitmap types
  netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
  netfilter: ipset: Extend the rcu locked area properly
  netfilter: ipset: exlude gc when resize is in progress
  netfilter: ipset: fix potential double free at resize/del
  netfilter: ipset: make sure gc is properly stopped
  netfilter: ipset: fix potential torn read in reuse/forceadd cases
  netfilter: ipset: rework cidr bookkeeping

 include/linux/netfilter/ipset/ip_set.h       |  11 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h      |   6 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c       |   6 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c    |   6 +-
 net/netfilter/ipset/ip_set_bitmap_port.c     |   6 +-
 net/netfilter/ipset/ip_set_core.c            |   4 +-
 net/netfilter/ipset/ip_set_hash_gen.h        | 118 ++++++++++++-------
 net/netfilter/ipset/ip_set_hash_ipportnet.c  |   4 +-
 net/netfilter/ipset/ip_set_hash_net.c        |   4 +-
 net/netfilter/ipset/ip_set_hash_netiface.c   |   4 +-
 net/netfilter/ipset/ip_set_hash_netnet.c     |   8 +-
 net/netfilter/ipset/ip_set_hash_netport.c    |   4 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c |   8 +-
 13 files changed, 116 insertions(+), 73 deletions(-)

--=20
2.39.5


