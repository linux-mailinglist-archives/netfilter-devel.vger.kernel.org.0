Return-Path: <netfilter-devel+bounces-13289-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QlPpL+uWMWpxngUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13289-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 20:33:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 157596943CB
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 20:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=BKcnDV2Z;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13289-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13289-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7473214924
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4E47D920;
	Tue, 16 Jun 2026 18:30:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BB3D8902;
	Tue, 16 Jun 2026 18:30:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634656; cv=pass; b=PVZJ4y/dxtiah/kUqLX71R9FCg8YrC08GiYSDXDn6JLm85NPAYYC+sVgpk4+gnqZInBfKWrywlg1g+gULTpyWpJB5qiiIx2ntfegtzdv2aU6Lt2FbyhwQdsmoq5PuqUagFUDFHVAAR758Pcdwwc12ExkF0dHZDbSXKCMRLHEsSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634656; c=relaxed/simple;
	bh=REH0d3wYoIYM1ZfwUz5WWrrGIOX6hD42sKYZ0MI/c68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX+su7Rqvdluzbxm6K0C5ecYR35tV7YFNthR20/wL+onVzMnFUoly2Hp2JwSjUqHTo30aSCdow9PTrs6GFv8/Py7lOdEq2OhfLxayrnewJyGvn1rNGsUx9ABKdp6Ka48+35QEXWFr5wH1yzRrQ/cEU5qkopS7llZVR3yHGBwJNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=BKcnDV2Z; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1781634626; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=by5pmXhRVrnkvv1S4D+VIc9b4VBij+dN2jDpAJSwSVq2HordivljUYmjsaKv4WPMqii9sje3s9dYfKLt4EZLj3cuzaz1tW2/amyVjFsY2lZ/ej/KfDhCOZi2CS02EI0XiZS3ilMdKaN5557f92X0QS9V9P6m2pTmWuVyKs9GT/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781634626; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0KL/XF/Vvi8vAhmaVj+NFnFKfoqpckK1aQ0xkfQQy4E=; 
	b=IuSYmF2akC6FYicORZV3dJ2N+NmXP168kD7aQi6zKucr21XH2xqM5is/2k2TxwY24+Y48s3Or6ErlI48AptFhd9LcYA8lNbrFjRAfA60hSUOhP8eyzy5n9oPxjGEhq9p5TxXkI6IBcVr6L7Gy8LIPYF9vSZNQYqrhdiArIz9aUo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781634626;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0KL/XF/Vvi8vAhmaVj+NFnFKfoqpckK1aQ0xkfQQy4E=;
	b=BKcnDV2Zsaa7Op19Uo71hXYZaJprEunX5AB4a3ERPMs2dP9LxVohdaOocoz9ft3m
	nVzezXrucP1ck8oKrxUPj5cup+6sfEvTndv1Msi9CqT7vgkm9gzXgi5lHEByrZvO7cr
	YaSFLLSDMhtDbzPfhdcmrrFFq2SzR8ZwSljwvCZE=
Received: by mx.zoho.eu with SMTPS id 1781634625040188.20574878349134;
	Tue, 16 Jun 2026 20:30:25 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v3 2/4] netfilter: nf_nat_irc: replace u_int16_t with u16
Date: Tue, 16 Jun 2026 20:29:44 +0200
Message-ID: <20260616182948.96865-3-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616182948.96865-1-carlos@carlosgrillet.me>
References: <20260616182948.96865-1-carlos@carlosgrillet.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13289-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[carlosgrillet.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 157596943CB

Replace POSIX u_int16_t with preferred kernel type u16

No functional changes.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/nf_nat_irc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_irc.c b/net/netfilter/nf_nat_irc.c
index 19c4fcc60c50..14b79cb0171b 100644
--- a/net/netfilter/nf_nat_irc.c
+++ b/net/netfilter/nf_nat_irc.c
@@ -39,7 +39,7 @@ static unsigned int help(struct sk_buff *skb,
 	char buffer[sizeof("4294967296 65635")];
 	struct nf_conn *ct = exp->master;
 	union nf_inet_addr newaddr;
-	u_int16_t port;
+	u16 port;
 
 	/* Reply comes from server. */
 	newaddr = ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.u3;
-- 
2.54.0


