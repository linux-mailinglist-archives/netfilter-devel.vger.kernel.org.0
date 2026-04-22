Return-Path: <netfilter-devel+bounces-12125-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOtvNJqY6GnVNAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12125-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 11:44:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5004442BF
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 11:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BB3D301E01B
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309E34B67F;
	Wed, 22 Apr 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="shiVZX6y"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2A3BF677
	for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2026 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851094; cv=none; b=CkfldUZToLJQmgWNubFhnmW+VJwQvmcFyZua0O18z5vJGdg3zWPyMiYATOgWwTSO/VlFBRnv8/V8uyaAVVOVpq49c5ZWVwldYwewNtMJVjNf+pSXcOJzU1+qq/z6M4180MJq7d5QgLItrB50VhLccJb1K1LC2ujJCgfjB2vInYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851094; c=relaxed/simple;
	bh=cDuHU2vDd7HJQ/4drs7R7DnQRcwpAsSDE/FdsCyqVIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkU9gmVqtFVMjPkLvnfXd7R9BdlC+ufCzjUP3YSsDYNWKtkLKKez3ReTyvZF9tTfg3jXpxOtQCVIERDLsoCgotlrJ8td62GHilfPfv8zlLwd2vE+HP9XerJ0IvWvrDpKjHiOBP4Npa71GJBEE/hEm0VfNrxGrMPGJZpUWN0oApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=shiVZX6y; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E88656017A
	for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2026 11:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776851091;
	bh=B9uGnF/debDGHWsdBrNly2IQkTnji1ov9aT57vH2s2Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=shiVZX6yn0jRYRnmsbtlURccc4hdM8CXdRxW7dtpPIO6bea52XAeyJs+d6Mrg7rgR
	 j5r3ek+x1wwxsYQOWqRza2ux73Mn91LU8miQmO+HAkEAN1KVISHs7c6xJttKI+qkiH
	 7bGzEwP1y9FKOe599jYw59lsFApNwcl1Rq1vckiM307E3wHdZG8ywEBBll3sKjwiVq
	 7HDXvWPX/CPLEisGkapml/oq/gAYVayg4Bur46MI+AOnHwyhK/iqkzlNQGUtWCMZ+h
	 xVgdyL94Q1G50ZvNkhljsTvmLEAOV3dPUj5PW32x/lo3MaMWp53crRsr6lZp4Kk0Uy
	 PEuJPLDVgJ/Tw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2 2/3] netfilter: nft_fwd_netdev: drop packet if no device found when forwarding via neigh
Date: Wed, 22 Apr 2026 11:44:43 +0200
Message-ID: <20260422094444.198178-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422094444.198178-1-pablo@netfilter.org>
References: <20260422094444.198178-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-12125-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: 7F5004442BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ttl field has been decremented already and evaluate of this rule
would proceed, just drop this packet instead if there is no destination
device to forwards this packet. This is exactly what nf_dup already does
in this case.

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 net/netfilter/nft_fwd_netdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 516287ce7f9b..95b2af3eede4 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -153,8 +153,10 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 	}
 
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
-	if (dev == NULL)
-		return;
+	if (dev == NULL) {
+		verdict = NF_DROP;
+		goto out;
+	}
 
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
-- 
2.47.3


