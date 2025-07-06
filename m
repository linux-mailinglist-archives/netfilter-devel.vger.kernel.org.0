Return-Path: <netfilter-devel+bounces-7681-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF629AF0660
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Jul 2025 00:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21B93B50C2
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Jul 2025 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619E302059;
	Tue,  1 Jul 2025 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dan6Rn5M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sa39Jx5s"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F09278150
	for <netfilter-devel@vger.kernel.org>; Tue,  1 Jul 2025 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407995; cv=none; b=PfWgTUBhjrEs7lWi3VU+N4gGYi0c6JY0Ev6LMJyuIBPsn0y+/qwdx27pvgk30tGfq7Egv2cHY3RuA5IhwRqfKMmFZZK8QBMcWScIFbX1j4aa0KcrkQjWDai+YDXyMLrcT05F4WZMYeXR90o8PhysnItg4Cd1G39PpmhNI6gCyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407995; c=relaxed/simple;
	bh=MrsoC8seV30B2LkhgR01avlYeztqYHenNybXwIkJpic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daMNVlC527gHJnc7sKWawJwL2YdFRy1YmVJ5Vb3cOJqfDIQU8bLumWhkNo9/+wKD/wvm9As02AYgE8d/oE1qFikpRsKpff2VmLnW6XXDkTSydLjRuYBdfq/NU/Flwct1crlf4o/9ng8fYm9ZTXGvgK5amLqP9op2hENas6etYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dan6Rn5M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sa39Jx5s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751407990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qS5Bb3kXSu+vbr+RiaFzUX+sZsfL/dX197QXB1TsCBA=;
	b=dan6Rn5M3QN9/VmSk/0ir7QkvcL8SUzByyfXX7/WIA3gD7qRWQIvxle/5BwLMV1ac5Sen+
	9OXsjhQDmeveEBFK7N1ez61KTCPNCvHnas+qOtEpQtkPzLlcHx9nYSztu+BfCIWoMe3O1Y
	U7ZRdGFgsgJR4XI3mI6ofiqpaH5wppVMGa2F01JndqG+HV45UL5Eq6tnrHon9UuYXkZLAj
	N8XdsLH5KMCGjCuAutWqEcZ56/sIh3JY9LwPOTcqPC2QxZPyfbheYDejqSwcsGK3ntSgUq
	syCZ1Q2lop63CpTVjyLgiJlRZTie6LXTi7jmrcUt2WPaLqSe4z7CZJCeSAn8SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751407990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qS5Bb3kXSu+vbr+RiaFzUX+sZsfL/dX197QXB1TsCBA=;
	b=sa39Jx5s0vHfSqEmp/o4P70qzG/eQCIXcON9uRsd8NEBGaFdEObjS13rmnTyeZMAuz/V4C
	WT1WUOkzDx0jrcBw==
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-rt-devel@lists.linux.dev
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH nf-next 2/3] netfilter: nft_set_pipapo_avx2: Drop the comment regarding protection
Date: Wed,  2 Jul 2025 00:13:03 +0200
Message-ID: <20250701221304.3846333-3-bigeasy@linutronix.de>
In-Reply-To: <20250701221304.3846333-1-bigeasy@linutronix.de>
References: <20250701221304.3846333-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The comment claims that the kernel_fpu_begin_mask() below protects
access to the scratch map. This is not true because the access is only
protected by local_bh_disable() above.

Remove the misleading comment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/netfilter/nft_set_pipapo_avx2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pi=
papo_avx2.c
index 83acfa0c62b91..daf23a996e612 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1170,9 +1170,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, co=
nst struct nft_set *set,
=20
 	m =3D rcu_dereference(priv->match);
=20
-	/* This also protects access to all data related to scratch maps.
-	 *
-	 * Note that we don't need a valid MXCSR state for any of the
+	/* Note that we don't need a valid MXCSR state for any of the
 	 * operations we use here, so pass 0 as mask and spare a LDMXCSR
 	 * instruction.
 	 */
--=20
2.50.0


