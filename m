Return-Path: <netfilter-devel+bounces-12512-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKjBAthP/ml/pAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12512-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 23:04:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ECF4FBBA2
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 23:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28E6F302DF99
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 May 2026 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F562423147;
	Fri,  8 May 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="NfLBCWSD"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7B33E35B
	for <netfilter-devel@vger.kernel.org>; Fri,  8 May 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274261; cv=none; b=TcngEG2TR6WXLMdI9aNRnRUSPYE86olD2kTr3sakAwkA57j+PXgohbBbIkeYPFJOr1ZIa3hU7UOYC6eROKaeRIfvAqrsvOO0YXohH55xkLliiVoC1nwULLs7JRugLXfJoc9lt57awzFdVCgtOID3SNo65Y5gbTxe/Hfit8dQMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274261; c=relaxed/simple;
	bh=PweMeeNiWetmI1IlqZYsffCOo6DRZfNO60rlsv7kr9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gi37PsYrBYoPPKUjZOpmP0ALjaApVFDMokb/KeW5b55dotnOu7ec6ECLdtVriXoLOb6llsvkGTzYgOQA64s5MdENmE0segN5FVNdMX8fMXE2LYuLAz6WQmGh1M440zE+OD3vk6113t44TCoqZpTL1F3mZjkPgIesumpBeY7iDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=NfLBCWSD; arc=none smtp.client-ip=148.6.0.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4gC1gt4SqhzGFDNR;
	Fri,  8 May 2026 22:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1778273944; x=1780088345; bh=iOqXsFHMy7
	Y7qcmN400r3PykLdkYw5JCX7S3PYF8nD0=; b=NfLBCWSDVdu5u9rPRNAkfYG6qo
	t8r+LLhDpOgNrld9bWiJmVFdrz3AItXuklOXLZRDU1rntfoYcAufY8KsZvA7MeV9
	RCnwS1eNI59YFnRvao2vr9kSi+ZwT6D7pZ232KHlNZmcB0ZTzdbXiz9/Q86D4HKo
	6npKHtu5YSPbOSG5g=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id zrmtHEsaVUiF; Fri,  8 May 2026 22:59:04 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C131D.nat.pool.telekom.hu [37.76.19.29])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp1.kfki.hu (Postfix) with ESMTPSA id 4gC1gr4yDVzGFDNK;
	Fri,  8 May 2026 22:59:04 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id E84981408C5; Fri,  8 May 2026 22:59:03 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v6 1/8] netfilter: ipset: fix a potential dump-destroy race
Date: Fri,  8 May 2026 22:58:56 +0200
Message-Id: <20260508205903.10238-2-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260508205903.10238-1-kadlec@netfilter.org>
References: <20260508205903.10238-1-kadlec@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-deepspam: maybeham 2%
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B5ECF4FBBA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12512-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When dumping sets in order to create the proper order for restore,
the list type of sets dumped last. Therefore internally we run the
dumping loop twice: first with all non-list type of sets and skipping
the list type ones and then secondly for the list type of sets.

Sashiko noticed that there's a potential race between dump and destroy
if in the first loop the last set was a list type of set: its pointer
remains unreferenced and a concurrent destroy can free it.

Fix the issue by resetting the variable holding the pointer.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_s=
et_core.c
index c5a26236a0bb..0874029cb0f2 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1613,6 +1613,7 @@ ip_set_dump_do(struct sk_buff *skb, struct netlink_=
callback *cb)
 		    ((dump_type =3D=3D DUMP_ALL) =3D=3D
 		     !!(set->type->features & IPSET_DUMP_LAST))) {
 			write_unlock_bh(&ip_set_ref_lock);
+			set =3D NULL;
 			continue;
 		}
 		pr_debug("List set: %s\n", set->name);
--=20
2.39.5


