Return-Path: <netfilter-devel+bounces-10561-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BWzNfFxgGkw8QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10561-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 10:44:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3CCA3BA
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67613026A87
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Feb 2026 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68822DB797;
	Mon,  2 Feb 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JleHxcWJ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A162D5946
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Feb 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025275; cv=none; b=RthEFasPNHj1Iso9wUO2asj03Qm66Lw+d1Q11lejxuYPGOAI5mpXRRJSezjIGnIuDpnIYk+4+ZIJvL9/kohgEVU9QcSIfSLCi7WzTTvEKn6bKmyt+7bNEYxAJfIajCvHN6puqi6/Gp+Ocy5MQWGTp0LChMD4IxxJLVWoEU4IE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025275; c=relaxed/simple;
	bh=miaYdtRGKFhToxlQMZxl8M5uaO7AZwcYcBDJddTQSqY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+y2ruh/8guUhH9F28uLUkoESGn7V76LB1G4PuXsaskttRDByE1yaneqtcdShdlQ6HWNhenMi4s81+b8dZpO48uy5buwWs3I3LCICEt64S4lX1ztDCU0jTIXYkXlu0COf6l7e+jG46x+Wnyj5bU232Px93geAlF9BH9DRiDxj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=JleHxcWJ; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770025272; x=1770284472;
	bh=tTbGlJGqyS5lVXBDmTtMNg73wcxfzHUm1uK4uzFfDQw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JleHxcWJMjJ1Vfy3dV3m6HGSoNXjslYXbrmRwbA+wV0wdeyia9GT7W6wVRtOkvfTS
	 r0uD4xpFd0pnyapJGYbPkT6YIbEh+oKQghtH1fgcFER/hCrQ7IOQdJDK3KR85eGFIt
	 Sns5p6PwitrjGCpFB7ejvDJUsN3R38zeGEA0rHOVnY/U9xjrN9pCinkqDU4x/wXCf1
	 FSkP02ckrOqZQEdyX3KBg3GUTDi6DFPBFNMYwCAv9zJsx92SLT4tG3rIGrvUL9r4Do
	 R5aONfEtBz9RREYQYUyoih2hiRXEbccKVmMiCGxlwtgWrcSiR7lqw62r195qR8FZqb
	 6WlagH1+p5uRw==
Date: Mon, 02 Feb 2026 09:41:08 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next v7 4/5] doc/netlink: nftables: Add sub-messages
Message-ID: <20260202093928.742879-5-one-d-wide@protonmail.com>
In-Reply-To: <20260202093928.742879-1-one-d-wide@protonmail.com>
References: <20260202093928.742879-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 563bf8fbc3ffd873351a0c78ccca33357b7b2bab
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10561-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,vger.kernel.org,protonmail.com];
	DKIM_TRACE(0.00)[protonmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netfilter-devel@vger.kernel.org];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,protonmail.com:dkim,protonmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66C3CCA3BA
X-Rspamd-Action: no action

New sub-messsages:
- log
- match
- numgen
- range

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netl=
ink/specs/nftables.yaml
index 2ddf89c70..ced567e7a 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -1478,15 +1478,24 @@ sub-messages:
       -
         value: immediate
         attribute-set: expr-immediate-attrs
+      -
+        value: log
+        attribute-set: log-attrs
       -
         value: lookup
         attribute-set: expr-lookup-attrs
+      -
+        value: match
+        attribute-set: compat-match-attrs
       -
         value: meta
         attribute-set: expr-meta-attrs
       -
         value: nat
         attribute-set: expr-nat-attrs
+      -
+        value: numgen
+        attribute-set: numgen-attrs
       -
         value: objref
         attribute-set: expr-objref-attrs
@@ -1496,6 +1505,9 @@ sub-messages:
       -
         value: quota
         attribute-set: quota-attrs
+      -
+        value: range
+        attribute-set: range-attrs
       -
         value: reject
         attribute-set: expr-reject-attrs
@@ -1505,6 +1517,9 @@ sub-messages:
       -
         value: tproxy
         attribute-set: expr-tproxy-attrs
+        # There're more sub-messages to go:
+        #   grep -A10 nft_expr_type
+        # and look for .name\s*=3D\s*"..."
   -
     name: obj-data
     formats:
--=20
2.51.2



