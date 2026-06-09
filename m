Return-Path: <netfilter-devel+bounces-13146-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YNhmDzTCJ2qs1gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13146-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 09:35:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C246265D439
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 09:35:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=qaTHHrMn;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13146-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13146-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 868DE302F605
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FFD3DD51D;
	Tue,  9 Jun 2026 07:35:07 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C69378814
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 07:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990507; cv=none; b=gJ6SWxMUfRHS0hlLv0+r8+AdCwdHT/nHU9fjuGFfkA4DxTtOoeGaqMWjb6iPvNEmzxqHd6AYqxvzx9xos9ZCISrE8YJ+M1+DdM6YWLTenHczRneyzXiMrfFroPpet5dnCdgh6qRDEBBdJT6BpTkWhmtM0tylFfHFfRjUTSIRPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990507; c=relaxed/simple;
	bh=cf5Yg2b/+Bc4T8ToxMFO/gQ7yFE0/sTuXeXFV5ITDts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA5RA4ZLjb5UWOAsbfGl9v9H/hkfr4j1aHKiRlfCW6HgHXkDR2BPS6/W5if3rSFHxCzeEE9Lv83AeIRTE1+kSlkLCthiAGDB5CONb8/pvk9OA3StkKJncIN1RMQ5VyGCw1zH+4Q17uo0FRSm+nXTuhxgJCLNYxyRRN/HNC/Tgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=qaTHHrMn; arc=none smtp.client-ip=148.6.0.51
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4gZL951pPvz7s7wc;
	Tue, 09 Jun 2026 09:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1780990071; x=1782804472; bh=RytMLUp8CW
	FtjCs8ujpw7zVxKpuXB3oNh5BN+zcUT7Y=; b=qaTHHrMn4JiOOLxlDivVakUFBy
	S8ZstaF2pKetLPbhe6OVcdeZLw05ZrzV+nwBb3HPCZUZu02eCCDI35LNaLILTHab
	v90WPZFoQ8Dzb69a/yaSI+oa5NK663XRqPBVXjqIMy5KSms0q0HOtHhjqzRQ6nQd
	lyCYvoaHaUlqPGbVM=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 0oQOReID6iTK; Tue,  9 Jun 2026 09:27:51 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C0692.nat.pool.telekom.hu [37.76.6.146])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp2.kfki.hu (Postfix) with ESMTPSA id 4gZL9325GZz7s7wf;
	Tue, 09 Jun 2026 09:27:51 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 528AD14116B; Tue,  9 Jun 2026 09:27:50 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 7/9] netfilter: ipset: make sure gc is properly stopped
Date: Tue,  9 Jun 2026 09:27:48 +0200
Message-Id: <20260609072750.318774-8-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260609072750.318774-1-kadlec@netfilter.org>
References: <20260609072750.318774-1-kadlec@netfilter.org>
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13146-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[netfilter.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C246265D439

Sashiko noticed that when destroying a set,
cancel_delayed_work_sync() was called while gc
calls queue_delayed_work() unconditionally which
can lead not to properly shutting down the gc.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/=
ip_set_hash_gen.h
index a95feb013ac5..90a84121b925 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -609,7 +609,7 @@ mtype_cancel_gc(struct ip_set *set)
 	struct htype *h =3D set->data;
=20
 	if (SET_WITH_TIMEOUT(set))
-		cancel_delayed_work_sync(&h->gc.dwork);
+		disable_delayed_work_sync(&h->gc.dwork);
 }
=20
 static int
--=20
2.39.5


