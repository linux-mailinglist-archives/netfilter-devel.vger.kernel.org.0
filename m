Return-Path: <netfilter-devel+bounces-12597-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBjWEymOBWppYgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12597-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:56:09 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EC53F86F
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE418301D317
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0FE3B2FCA;
	Thu, 14 May 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="A75f2In3"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610833B6374
	for <netfilter-devel@vger.kernel.org>; Thu, 14 May 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748937; cv=none; b=NUs1a3NXZIoMMniebn/vLPyGu7N6XND69XlJw4Do9LrZZc9rFcuuIicfCz42/BqpIY28JINob7xlrPlc/MyCLAk5b9dLXVN5AYQKL886MovI3V8s7m63leQuoZnJlI+fYHEa6wTGnKfILujVXoj++WByDLrLSpF0/3E4Rp1Ve7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748937; c=relaxed/simple;
	bh=9qr1skJXUi20lAqOZ1ZAH9y/mr5OxskFc5e/Q9m1p2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OS4OZKFJ1RZYQGRuZOceiOTItD37zgMMqYNshybyWs8bGKj/VqHytSnBQXBIHlAmltfTaDj977YfZR0y3EreVMoGBguIpF78aYJttvwftlz/P6deEN0YAcuiOZ60jDWlTMNv3d7pQ9pO74175EtzeHxBtNfNe0pVnj/3kEtiAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=A75f2In3; arc=none smtp.client-ip=148.6.0.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4gGPL66c5xzGFDNS;
	Thu, 14 May 2026 10:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1778748925; x=1780563326; bh=gun7x77rR7
	IZbpCadqeiQ7CxSbiH1+Atrm8E8jY93Bs=; b=A75f2In3CDdTJbh6f3Us7cS1H0
	OCiRz6k02318GShlcxz1o4SjX/8Naua1PQidkSZtUNhvakhTBtheqNltj3Z00nhY
	T4vsvjhrfKXgd8si+N1UeQXbLAdBMsDAa+UzlKJp79PkA48SqkSTh1kCfUS2Rjli
	/HesFbAAhGuQKRrNI=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id DGE4lYAsy1AN; Thu, 14 May 2026 10:55:25 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (guest-144-149.eduroam.kfki.hu [148.6.144.149])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp1.kfki.hu (Postfix) with ESMTPSA id 4gGPKz42LXzGFDNV;
	Thu, 14 May 2026 10:55:19 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 165D5140EFE; Thu, 14 May 2026 10:55:20 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v7 10/10] netfilter: ipset: add comment how cidr bookkeeping is working
Date: Thu, 14 May 2026 10:55:19 +0200
Message-Id: <20260514085519.12729-11-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260514085519.12729-1-kadlec@netfilter.org>
References: <20260514085519.12729-1-kadlec@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD9EC53F86F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12597-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:mid,blackhole.kfki.hu:dkim];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Sashiko thinks that cidr bookkeeping might be unsafe because the
concurrent RCU reader in mtype_test_cidrs() uses the data without
sequence locks or read-side barriers. However every right shift
(add new entry) and left shift (delete entry) is performed by
duplicating the entry just shifted. Therefore concurrent reader
will just duplicate a test with the same values as just before:
existing entries cannot be skipped.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/=
ip_set_hash_gen.h
index 9d1fcf6c8328..6838b46df9b8 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -342,6 +342,12 @@ mtype_add_cidr(struct ip_set *set, struct htype *h, =
u8 cidr, u8 n)
 		}
 	}
 	if (j !=3D -1) {
+		/* We shift the cidr values to the right
+		 * by duplicating the entries one by one,
+		 * starting from the end.
+		 * It means the same test can be repeated twice
+		 * by a concurrent mtype_test_cidrs() reader.
+		 */
 		for (; i > j; i--)
 			h->nets[i].cidr[n] =3D h->nets[i - 1].cidr[n];
 	}
@@ -363,6 +369,11 @@ mtype_del_cidr(struct ip_set *set, struct htype *h, =
u8 cidr, u8 n)
 		h->nets[CIDR_POS(cidr)].nets[n]--;
 		if (h->nets[CIDR_POS(cidr)].nets[n] > 0)
 			goto unlock;
+		/* We shift the cidr values to the left
+		 * by duplicating the remaining entries one by one.
+		 * It means the same test can be repeated twice
+		 * by a concurrent mtype_test_cidrs() reader.
+		 */
 		for (j =3D i; j < net_end && h->nets[j].cidr[n]; j++)
 			h->nets[j].cidr[n] =3D h->nets[j + 1].cidr[n];
 		h->nets[j].cidr[n] =3D 0;
--=20
2.39.5


