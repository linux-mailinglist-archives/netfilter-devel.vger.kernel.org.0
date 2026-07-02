Return-Path: <netfilter-devel+bounces-13602-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id olZ/AiJsRmrcUAsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13602-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 15:48:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 662336F87FB
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 15:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=Qo1lYC0+;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13602-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13602-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB353025C48
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2414A33F5;
	Thu,  2 Jul 2026 13:47:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FB23909C
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Jul 2026 13:47:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000034; cv=none; b=AA0SGpkUKdE/xMtE7uRF/JDvF3JDW99N07r0B2ISzQAuteurxj6fpIR3575E+baLIyg5OHyInBzKhKb5qBS6W7T2yjdKdFesXtofC4mzC2hVL2ZZmWfRdzoBo9cOnpQPxYnmCSGnuZH6WVazH+ZUKpF2g//j5lCZ9e390actfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000034; c=relaxed/simple;
	bh=V+0UQ/vdeEej7x0jfyrPwD/SZ8iXEBlUvtPkLdMIQmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYFqrI7AkVikuwPGGmS7orlsCA90JfxkDRD/UnvMF3dz4yzkCMQaM5vsUoF0UitnLybdv2m8NPf/32ikiiRPkUf297cbSkJalkOfD1JZHh2ddqi+WZIeOOdE0Wb4/1BX5z8EU14vbQBn6VNpfP6UCsdkitdVL81rRguPfxg7N8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=Qo1lYC0+; arc=none smtp.client-ip=148.6.0.51
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4grdTz55tlz7s7wV;
	Thu, 02 Jul 2026 15:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
	:from:from:received:received:received; s=20151130; t=1783000021;
	 x=1784814422; bh=wLO86Z5EC+n2+gbqecV3Eeg3ojkIOPNPICkj49ExSCg=; b=
	Qo1lYC0+l15bWTAHxmXIB8OrWPN2ZNXhA7QPpvd/qvwU14MZUspeYuUUCe4uxHk1
	eCBI9UwY1b+VUBQnDlZhpGn0w4KKGCI0qmHGCTz0+emVeSyTm8d13igWHt2sYaN1
	nDoDd+JJ0osf2kHy3KFyrzPt8aElNZMmgEsKHS54UFI=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id nQCMkUhZcobz; Thu,  2 Jul 2026 15:47:01 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (unknown [148.6.40.64])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp2.kfki.hu (Postfix) with ESMTPSA id 4grdTx55ysz7s7wP;
	Thu, 02 Jul 2026 15:47:01 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 81418140786; Thu,  2 Jul 2026 15:47:01 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 0/5] netfilter: ipset: gc, backlog and cidr patches
Date: Thu,  2 Jul 2026 15:46:56 +0200
Message-Id: <20260702134701.207721-1-kadlec@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-13602-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 662336F87FB

Hi Pablo,

Here follows three patches which addresses the gc-resize clashing
in the comment extension, the add/del backlog cleanup in the
error path and a fairly large rewriting of the cidr bookkeeping.
The two other patches could be squeezed into the next ones on
the list but I think they are a bit independent cleanups and
clarifications.

The batch does not address the issue Florian pointed out about
sashiko's complains about possible missing rcu locking and the
possible torn reads, also from sashiko reports.

Best regards,
Jozsef

Jozsef Kadlecsik (5):
  netfilter: ipset: mark the rcu locked areas properly
  netfilter: ipset: exlude gc when resize is in progress
  netfilter: ipset: cleanup the add/del backlog when resize failed
  netfilter: ipset: allocate the proper memory for the generic hash
    structure
  netfilter: ipset: rework cidr bookkeeping

 net/netfilter/ipset/ip_set_hash_gen.h        | 311 ++++++++++++-------
 net/netfilter/ipset/ip_set_hash_ipportnet.c  |   4 +-
 net/netfilter/ipset/ip_set_hash_net.c        |   4 +-
 net/netfilter/ipset/ip_set_hash_netiface.c   |   4 +-
 net/netfilter/ipset/ip_set_hash_netnet.c     |  12 +-
 net/netfilter/ipset/ip_set_hash_netport.c    |   4 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c |  12 +-
 7 files changed, 230 insertions(+), 121 deletions(-)

--=20
2.39.5


