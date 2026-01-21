Return-Path: <netfilter-devel+bounces-10373-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOxeIeApcWniewAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10373-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 20:32:48 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 043795C3BA
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 20:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0EC05701DA
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107213AE709;
	Wed, 21 Jan 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vBilFy7H"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E03BC4F4;
	Wed, 21 Jan 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021280; cv=none; b=OWSz+oX96R7jPqWxY08udjN7wqm8cS4p83Fqgq/cA0V2l+MXQ4Mg71PrNwswiVH6rMTUWRwI/QzOYBZXX8+QURbdALSPTfgxpbbiOfR0vYLei/Y9AWxaRlti/gJ0Uc1R62tA+pmZaptN5hmyGtMMrJQNAqbGJl1OkRLMPeu9QCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021280; c=relaxed/simple;
	bh=2k+xa2OozsViZmJtLAVxnFv77Wx7BDEhcsb9Q5fpVBo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6WS+ljELHeg2b1IBfrCXPcp1ZsXhl11pWjW+/MMQZr4ePLBSXPuVZ/+uVh6Xt5sD3gEIjQdi+u1CDJpbkv4WDUDOpWA3ffYjFPb5ayPPx0quMYzGXlNurXOtq/vPOUPraeA39kM4WcohqUwPUSmo0r4dT2ZwZiCc4LOhtsneoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=vBilFy7H; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1769021268; x=1769280468;
	bh=zgDBaq6W6wW7oGLEeEBePjUmm1IPAdlKRyQy5yeZuM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vBilFy7HtAiBN8AUOVPx803IzoyR2H6WYFp+iBGBuoIf0GGH4ks9gQ0K/hNa/jG84
	 1+A99cfMsmXf0KHVoW1SdDrARJqWTdtFU9F5z9W9OisHBmWkoq13FqcFw3sV2hwvip
	 vsTp5ri6WJlViDPNrZ2ftt3oo2tRqurbr48OIj8Chnexv8n4ANI/SpHi36DWiLkGIo
	 S1QyPLx4ed1PtMD5zNJFWnmTD8xuOnNaT8/JK8WNdjuSCsXN+sO317jec6KTAy1TtO
	 /apfiE8JW/ZvqTLSt4b15bQY1CXTcT5qBQHAORJav2d9Ud3xZqd/NwwgDrHTmGNNpU
	 +RAH0OykYr9tA==
Date: Wed, 21 Jan 2026 18:47:45 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v6 4/6] doc/netlink: nftables: Add sub-messages
Message-ID: <20260121184621.198537-5-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-1-one-d-wide@protonmail.com>
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: b9c9f00de5ac46d002c1ff027efce4cd29885886
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10373-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,vger.kernel.org,protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[protonmail.com:+];
	FREEMAIL_FROM(0.00)[protonmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netfilter-devel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[protonmail.com,quarantine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 043795C3BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

New sub-messsages:
- log
- match
- numgen
- range

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netl=
ink/specs/nftables.yaml
index 826d3441b..4b1f5b107 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -1454,15 +1454,24 @@ sub-messages:
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
@@ -1472,6 +1481,9 @@ sub-messages:
       -
         value: quota
         attribute-set: quota-attrs
+      -
+        value: range
+        attribute-set: range-attrs
       -
         value: reject
         attribute-set: expr-reject-attrs
@@ -1481,6 +1493,9 @@ sub-messages:
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



