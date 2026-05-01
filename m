Return-Path: <netfilter-devel+bounces-12367-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDVXEQVJ9GkGAQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12367-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 08:32:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA254AAA02
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 08:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A84ED30091DC
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2026 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166D35C1BC;
	Fri,  1 May 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="Ib+pTAst"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625135E929;
	Fri,  1 May 2026 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617151; cv=none; b=RktgO/fmN48tspzVeDibbE2/wLtqGe3LdHsXBtMhZSsccx2CdZaQpFiNhrRi0pYlrUbyGvOqto9geSZJBThr4KLXIkmDFtwkFsx78/TkgChRSCorAWEQiW2pwtElK093j3aBWvVjc7GfWpRphfzUX9CrdWiwBY+Ut9UcCLUqLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617151; c=relaxed/simple;
	bh=9yyUUs2BXIToAhIyi6W6MlHL2Q0Rkg+H4tfy95uVAzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9zS7QnrXvyAOoKFufg5Uawr7u5q+VwhbCOxbXwajV52DJF/l0Llm6JlH3W6NuWmEt9/f52aqd9nrlpFfCl7sjkALwD0ZhjPMsvEjHIenCma4zttG7GKBDsgjlX3B2iNiYFOKC0N+OEijJQQpgHQ0ZdZJUOUP5Zk/gmXfDwQNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=Ib+pTAst reason="key not found in DNS"; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.224.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4g6Ln43LsBz8sXL;
	Fri, 01 May 2026 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1777617148;
	bh=aCT15It8ZbWGI5T3TU+l8UKx6cl6pDrHxcHnymDFNhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ib+pTAsth7IQOrfFTNDXw30uB8zqgJMkRWvhnSIH90ZWP841Y26W/RmHMcPS5AxhY
	 +W1Um0CSiSsF+rjpzBR8yZ5RE0IU2EDMRP2ryBf+Q77hgYMDXSKcN71dQt8/8lAj6E
	 ov85mcVTwtCmzhnp0v1/UDMHJ0lrzJQaVIDdmPyGzx6/BfnssjBDjTugLjOMHyjGE3
	 gI6xcTC8Pj37+q9XfbcadMwVBg0hbXv9hDcypoReBy3uUFnBmqwgcf/pkCn5o8F+wt
	 HGLaYm1Va8d7ExldKoYoFHSSG/AdsvluczejyxSZJMaKvTfjza3wPr5akCnLNG4b/5
	 8y2cakY7yI3Kw==
From: HACKE-RC <rc@rexion.ai>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HACKE-RC <rc@rexion.ai>
Subject: [PATCH net-next v2 3/3] netfilter: nf_conntrack_amanda: use nf_ct_helper_parse_port()
Date: Fri,  1 May 2026 12:01:56 +0530
Message-ID: <20260501063156.2520780-4-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501063156.2520780-1-rc@rexion.ai>
References: <20260501063156.2520780-1-rc@rexion.ai>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai
X-Rspamd-Queue-Id: 2EA254AAA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12367-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	DKIM_TRACE(0.00)[rexion.ai:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_SPAM(0.00)[0.011];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rexion.ai:mid,rexion.ai:email]

Replace the bare simple_strtoul() call with the shared
nf_ct_helper_parse_port(). This removes reliance on the
nul-terminated pbuf string for parsing and validates the port
range in a single call.

The len > 5 guard and port == 0 check are now handled by the
shared parser, which rejects zero and values above 65535.

Reorder local variable declarations to reverse christmas tree.

Fixes: 16958900578b ("[NETFILTER]: nf_conntrack/nf_nat: add amanda helper port")
Signed-off-by: HACKE-RC <rc@rexion.ai>
---
 net/netfilter/nf_conntrack_amanda.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_conntrack_amanda.c
index d2c09e8dd..30b5c4b84 100644
--- a/net/netfilter/nf_conntrack_amanda.c
+++ b/net/netfilter/nf_conntrack_amanda.c
@@ -88,11 +88,12 @@ static int amanda_help(struct sk_buff *skb,
 	struct nf_conntrack_expect *exp;
 	struct nf_conntrack_tuple *tuple;
 	unsigned int dataoff, start, stop, off, i;
+	nf_nat_amanda_hook_fn *nf_nat_amanda;
 	char pbuf[sizeof("65535")], *tmp;
+	int ret = NF_ACCEPT;
 	u_int16_t len;
+	u16 parsed_port;
 	__be16 port;
-	int ret = NF_ACCEPT;
-	nf_nat_amanda_hook_fn *nf_nat_amanda;
 
 	/* Only look at packets from the Amanda server */
 	if (CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL)
@@ -132,10 +133,10 @@ static int amanda_help(struct sk_buff *skb,
 			break;
 		pbuf[len] = '\0';
 
-		port = htons(simple_strtoul(pbuf, &tmp, 10));
-		len = tmp - pbuf;
-		if (port == 0 || len > 5)
+		if (nf_ct_helper_parse_port(pbuf, len, &parsed_port, &tmp))
 			break;
+		port = htons(parsed_port);
+		len = tmp - pbuf;
 
 		exp = nf_ct_expect_alloc(ct);
 		if (exp == NULL) {
-- 
2.54.0


