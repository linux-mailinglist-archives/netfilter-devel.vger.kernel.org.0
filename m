Return-Path: <netfilter-devel+bounces-12206-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE0oO5UR72mU5QAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12206-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 09:34:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC3346E699
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7F3A300A53C
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 07:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5F37DEAD;
	Mon, 27 Apr 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="J9xa+zB3"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36937CD29
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275280; cv=none; b=eolCIYp1TRaJeCIp50SfIeoFm1TYL7OiVNj0UVobYzE2+73UsXF4iDW7tIW4K3TKc+ETPFFun033hD2cx4G1agcJ+H6VvyRmvR8Ri+vnR31Z93AHsZ+lyZ238lovumAXLZH/SRReoS6dRPgrfLhQMLE3xbswj4/Mtp6sF9+ng6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275280; c=relaxed/simple;
	bh=SLp5+e4JCIBWYzPlLRpHDJns9OX22HwTVDTGhvA/qQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4cMkkSoL905eMNEZd5cL/RqVOkGJ6SgBNSuYxfFYehAYXbioJtqkMzWi+fEbMH6BKj3rWUPNFEZPeWJGkbXS0z9US6+MZjRekd7QRHZRGPlgTiCL0q6TaGJiA1cgc2e28im+HWqBs5uRE3YDTiWnCw0o7GMuGwF6DuWIRwTqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=J9xa+zB3; arc=none smtp.client-ip=148.6.0.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4g3wLX67kLz3sb8x;
	Mon, 27 Apr 2026 09:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1777275267; x=1779089668; bh=SMliz13asO
	Sm0YbOnZYJXi5yXh41bAlFoRICKQ+BQZw=; b=J9xa+zB31y+7cbOrPpFpY6ySCV
	7nXPNPKmNvGMCjmY1YxCDZTtNBcHwHmCSOsXKgqkTP+r4vSKjBIt9rKM3cJ4NpTD
	9n36IvGa/JnLTb8wg9b9AIHHzEzY4Q7AvjTNTWYTur/lMxFoZqCBhLxIyDfVd7JP
	MAq53hzO+awLD+XTE=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id EmlYi-7G9zTc; Mon, 27 Apr 2026 09:34:27 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C0B05.nat.pool.telekom.hu [37.76.11.5])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4g3wLT0f30z3sb9S;
	Mon, 27 Apr 2026 09:34:25 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 8C7B41413C9; Mon, 27 Apr 2026 09:34:24 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4/5] netfilter: ipset: skip gc when resize is in progress
Date: Mon, 27 Apr 2026 09:34:23 +0200
Message-Id: <20260427073424.573672-5-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260427073424.573672-1-kadlec@netfilter.org>
References: <20260427073424.573672-1-kadlec@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-deepspam: maybeham 3%
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5BC3346E699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12206-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackhole.kfki.hu:dkim];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Zhengchuan Liang reported that because resize does not copy
the comment extension into the resized set but uses it's pointer,
ongoing gc can free the extension in the original set which then
results stale pointer in the resized one. The proposed patch was
to recreate the extensions for every element in the resized set.
It is both expensive and wastes memory, so better skip gc
when resizing in progress detected: resizing will destroy
the original set anyway, so doing gc on it unnecessary.

Reported by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/=
ip_set_hash_gen.h
index 130cab2e2397..cdb681708b0d 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -508,6 +508,8 @@ mtype_gc_do(struct ip_set *set, struct htype *h, stru=
ct htable *t, u32 r)
 			data =3D ahash_data(n, j, dsize);
 			if (!ip_set_timeout_expired(ext_timeout(data, set)))
 				continue;
+			if (atomic_read(&t->ref))
+				goto resize_in_progress;
 			pr_debug("expired %u/%u\n", i, j);
 			clear_bit(j, n->used);
 			smp_mb__after_atomic();
@@ -552,6 +554,7 @@ mtype_gc_do(struct ip_set *set, struct htype *h, stru=
ct htable *t, u32 r)
 			kfree_rcu(n, rcu);
 		}
 	}
+resize_in_progress:
 	spin_unlock_bh(&t->hregion[r].lock);
 }
=20
@@ -672,7 +675,10 @@ mtype_resize(struct ip_set *set, bool retried)
 		spin_lock_init(&t->hregion[i].lock);
=20
 	/* There can't be another parallel resizing,
-	 * but dumping, gc, kernel side add/del are possible
+	 * but dumping, kernel side add/del are possible.
+	 * gc must detect ongoing resize when comments are in use
+	 * in order not to free the comment extension area shared
+	 * between the original and resized sets.
 	 */
 	orig =3D ipset_dereference_bh_nfnl(h->table);
 	atomic_set(&orig->ref, 1);
--=20
2.39.5


