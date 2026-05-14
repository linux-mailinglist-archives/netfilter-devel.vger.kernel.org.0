Return-Path: <netfilter-devel+bounces-12596-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMCmJB+OBWpNYgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12596-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:55:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81B53F861
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 10:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747913016506
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD33DFC86;
	Thu, 14 May 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="an+Hk3jU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469803DF01F
	for <netfilter-devel@vger.kernel.org>; Thu, 14 May 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748936; cv=none; b=hjnLW+dXp5q7/SY8OKg6sTrnG0LWz7YNowoOAzZlNOUhvRgrsmxLNuT+PFlckv2ZneDJSQ4b1JnE0GjqAxQJGa8oINeKA6NcPatv60jdm4kZrlkznTbw07TaWm83rJM6I7ZbThwpdnygVqkDnlKrNFrjBQHzTUqAo1ldvRoW3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748936; c=relaxed/simple;
	bh=+6BRIaNtvk5rAKXpix7QthaF+1jRDMPHqYJCsvUAxL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fdi29gcjbP51tqBK8ce396TiZ4jhvv0hHjQWaSAyR+qXM6NLCOCRkb3lPL3gbU9e7aEVlsTzz5mw3XWqGmz2jiq8sUzQA96LBxW2hiLzJsnSsoJz003eytsjs/CbYyFmp7UyQJwcFUy/77Rk8UlQfdR/TURNlm4GJ7rLKUtSut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=an+Hk3jU; arc=none smtp.client-ip=148.6.0.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4gGPL509wTzGFDNJ;
	Thu, 14 May 2026 10:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1778748923; x=1780563324; bh=djO71CRZBk
	+p+L+kr8DM1adBQijJI2N1oXOlYF6D9tA=; b=an+Hk3jUVHAIjEYN1ExEWfSMYT
	mQA10WTwc9t1HJuoMJmP/GCv9ELHofvZl/JhSAT8zwLlKPoqZW0TJarvSNXEpe9K
	qIQQUzGByv1kFSbRrVXmobpVVWmt1YqCQhFEHwc7R9vCGy1I8LEpKwSgqoP8YF6R
	u7cHACc1SaUpLkL2o=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id RRHQwcZ-UdsO; Thu, 14 May 2026 10:55:23 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (guest-144-149.eduroam.kfki.hu [148.6.144.149])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp1.kfki.hu (Postfix) with ESMTPSA id 4gGPKz3lkSzGFDNS;
	Thu, 14 May 2026 10:55:19 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 0EF55140E21; Thu, 14 May 2026 10:55:20 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v7 07/10] netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
Date: Thu, 14 May 2026 10:55:16 +0200
Message-Id: <20260514085519.12729-8-kadlec@netfilter.org>
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
X-Rspamd-Queue-Id: EE81B53F861
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
	TAGGED_FROM(0.00)[bounces-12596-lists,netfilter-devel=lfdr.de];
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

Sashiko pointed out that kfree_rcu() was called before
rcu_assign_pointer() in handling the comment extension.
Fix the order so that rcu_assign_pointer() called first.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_s=
et_core.c
index 3706b4a85a0f..a531b654b8d9 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -351,8 +351,8 @@ ip_set_init_comment(struct ip_set *set, struct ip_set=
_comment *comment,
=20
 	if (unlikely(c)) {
 		set->ext_size -=3D sizeof(*c) + strlen(c->str) + 1;
-		kfree_rcu(c, rcu);
 		rcu_assign_pointer(comment->c, NULL);
+		kfree_rcu(c, rcu);
 	}
 	if (!len)
 		return;
@@ -393,8 +393,8 @@ ip_set_comment_free(struct ip_set *set, void *ptr)
 	if (unlikely(!c))
 		return;
 	set->ext_size -=3D sizeof(*c) + strlen(c->str) + 1;
-	kfree_rcu(c, rcu);
 	rcu_assign_pointer(comment->c, NULL);
+	kfree_rcu(c, rcu);
 }
=20
 typedef void (*destroyer)(struct ip_set *, void *);
--=20
2.39.5


