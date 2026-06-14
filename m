Return-Path: <netfilter-devel+bounces-13264-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIZmHwyVLmoe0AQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13264-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jun 2026 13:48:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF444680F3B
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jun 2026 13:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=iPXoX+Ie;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13264-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13264-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AF743014683
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jun 2026 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E02032D;
	Sun, 14 Jun 2026 11:46:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D643A48E4;
	Sun, 14 Jun 2026 11:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437589; cv=none; b=sUbT3coleudCCWv/FxxHiOMQIAicpsESMOrXfriIbX4p0jCziLuZ+ZjbCGu76TpH7vP/USKi8zpcxsIeX2FtNJ4IXrQPL12nAo65606qaKH6W+S4BtHd1JqwaB5GyTaF3JTaS9tFagtul50Ij0/Elbon8otl1VSHybd0Aw+HDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437589; c=relaxed/simple;
	bh=cFYkkIgoJqwbIIMxTaevYPWwMFtn5O2yjPjfmvV+TKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReaUMDIO0s4GvokG3I/4y//8tiowpNgwYtNPtHmfRDqLvvacokCNvWyszGWNCtUbl29NZKSU5cD9EyKcm6YZ9w74UBlUJktfQYngHUkCIuarXIL94vPjBfSS7ufnnbTBiu9dv8hwKXS5Cola9lnR2Lcl4oGuB8x8zTVDAAva3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iPXoX+Ie; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 0C236600B5;
	Sun, 14 Jun 2026 13:46:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781437584;
	bh=nrnghwlJkodSq0H8h//KV2iRzHbcibombOjaGBrtfPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPXoX+IebfD5dd3b6jgU/AGftumrKaNAwTU7/0LOHu/qVSHoKlzj4aCo4xx9RQ7sQ
	 ozipdcARVpU8T3ti1InwFlKRE3XvssyCLqPKNxgS37A47/C8nybzb3EGl7gN2RDiHG
	 mfa824Ofcnj1FPyhYauPhC/ReEq2plF/4fxl3uAciBrtfXfJjSGC4xLuAGme0M640U
	 euqysiBWqxLcjEPice8rvr7KRbTh00ntcxqW97wlvabk5dplfUY5Ni+2rk++p9sWgE
	 0wguOgNxTPRaxdmZly/Cb7Yk2zBbxXgvhK2bS0j2vdP2s95CT51PjQseqfrh7M9ePs
	 caIyeku4ZEMcw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 10/11] ipvs: fix doc syntax for conn_max sysctl
Date: Sun, 14 Jun 2026 13:46:04 +0200
Message-ID: <20260614114605.474783-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260614114605.474783-1-pablo@netfilter.org>
References: <20260614114605.474783-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13264-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ssi.bg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF444680F3B

From: Julian Anastasov <ja@ssi.bg>

Fix the docutils error reported by kernel test robot
for the new conn_max sysctl:

Documentation/networking/ipvs-sysctl.rst:76: WARNING: Block quote ends
without a blank line; unexpected unindent. [docutils]
Documentation/networking/ipvs-sysctl.rst:76: ERROR: Unexpected section
title or transition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606071851.Dc1H7hOO-lkp@intel.com/
Fixes: 4a15044a2b06 ("ipvs: add conn_max sysctl to limit connections")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 Documentation/networking/ipvs-sysctl.rst | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ipvs-sysctl.rst b/Documentation/networking/ipvs-sysctl.rst
index b6bac2612420..fe36f4fcd3a0 100644
--- a/Documentation/networking/ipvs-sysctl.rst
+++ b/Documentation/networking/ipvs-sysctl.rst
@@ -72,20 +72,29 @@ conn_max - INTEGER
 	Netfilter connection tracking) the connections can be
 	limited also by nf_conntrack_max.
 
-				soft limit	hard limit
-	=====================================================
-	init_net:
+	Limits for init_net:
+
+	======================= =============== =============
+	\			soft limit	hard limit
+	======================= =============== =============
 	create netns		platform	platform
 	priv admin		0 .. platform	0 .. platform
-	=====================================================
-	new netns:
+	======================= =============== =============
+
+	Limits for new netns:
+
+	======================= =============== =============
+	\			soft limit	hard limit
+	======================= =============== =============
 	create netns		init_net:soft	init_net:soft
 	priv admin		0 .. platform	0 .. platform
 	unpriv admin		0 .. hard	N/A
+	======================= =============== =============
 
 	Limits per platform:
-	1,073,741,824 (2^30 for 64-bit)
-	   16,777,216 (2^24 for 32-bit)
+
+	- 1,073,741,824 (2^30 for 64-bit)
+	- 16,777,216 (2^24 for 32-bit)
 
 	Possible values: 0 .. platform limit
 
-- 
2.47.3


