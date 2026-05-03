Return-Path: <netfilter-devel+bounces-12399-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE11EOUJ92nnbQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12399-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 03 May 2026 10:40:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77474B4EEF
	for <lists+netfilter-devel@lfdr.de>; Sun, 03 May 2026 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D35E300794C
	for <lists+netfilter-devel@lfdr.de>; Sun,  3 May 2026 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A023AD508;
	Sun,  3 May 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="GaqI1600"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-21.smtp.spacemail.com (out-21.smtp.spacemail.com [66.29.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF139264617;
	Sun,  3 May 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.159.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777797601; cv=none; b=VurgI/Zjpb/Xl+364n77zu6R4Rytp9anZzt05wdtV0apZMfqJfJTKuKhXkB+LI/+Gl47EZXvb0b3K7BnDgqsS14Uo5UVSLaJWQ2lB4oFCiUR3IfERztACgeCgr6p6jUEmXkKViW49O5SR3Uq3CcJ6/FJyafoi6pzCWvJpqfwkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777797601; c=relaxed/simple;
	bh=nR2UvrQhwXbHczxiyNhOgWKmudrRc0WInr0MsJ9wdoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDlZ9yffOo8GFQrpMdmQjbsmXvXxqffkRl26T6oWGbgoupoxVS7Y+7VeoQwKoRrQ+XIbnr84DZoyiGN0I4DW4C8xm620i5RTMVkhztJjTOQ71xpTRYWtBxfa/8wP0PO4Hn8I4HtGV1rf1Nic1mvp6Jhc08oVkU5QcdKqSvo1bVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=GaqI1600 reason="key not found in DNS"; arc=none smtp.client-ip=66.29.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.224.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4g7dM16sHVz8sc7;
	Sun, 03 May 2026 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1777797169;
	bh=UWHDX60T6C3pWblSNBnfc+v9Si2dLL5tyuqjr8YWHtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GaqI1600Mw4HShgJETvm96UwJwiqOUcV1FSxhU8bHxLqdE14Vi1IjIHXfVUQjcw8P
	 5Sh1+RaUzR2GTSj3YbfFg6vPOtsAlG8ckMEDKOuxMn71xabRj1QwNFuOKKkKsiHrOC
	 gYWy03DP8KdYtjz3quRMBxUlCQ5qpxmKCx70/7tQWVFxDbjani4HsTke0hbxPVQZ8y
	 HUmrPCq3D9NIQFDoRzqaO1GHX16QucNbRNzFu6paCZUblrMxO5Z8H+TkgA13EA6vEE
	 q1GCWUnZVmrLn3njPOTYixpsQr2TrGpYygBoGHXND5Qh++Pl1rbJ5NLBi+Rx3Ah5Qz
	 +BXNw0nIJSnqw==
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
Subject: [PATCH net-next v3 4/4] netfilter: nf_conntrack_sip: use nf_ct_helper_parse_port()
Date: Sun,  3 May 2026 14:02:20 +0530
Message-ID: <20260503083220.630655-5-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503083220.630655-1-rc@rexion.ai>
References: <afSBzDE-caw3Dsr1@orbyte.nwl.cc>
 <20260503083220.630655-1-rc@rexion.ai>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai
X-Rspamd-Queue-Id: A77474B4EEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12399-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	DKIM_TRACE(0.00)[rexion.ai:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.070];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rexion.ai:mid,rexion.ai:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Replace simple_strtoul() based port parsing in ct_sip_parse_request()
and ct_sip_parse_header_uri() with nf_ct_helper_parse_port(), which
handles the bounded parse without requiring NUL-termination.  The
SIP-specific minimum port check (>= 1024) is retained as before.

Signed-off-by: HACKE-RC <rc@rexion.ai>
---
 net/netfilter/nf_conntrack_sip.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 182cfb119..ac29f0762 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -241,7 +241,7 @@ int ct_sip_parse_request(const struct nf_conn *ct,
 {
 	const char *start = dptr, *limit = dptr + datalen, *end;
 	unsigned int mlen;
-	unsigned int p;
+	u16 p;
 	int shift = 0;
 
 	/* Skip method and following whitespace */
@@ -269,8 +269,9 @@ int ct_sip_parse_request(const struct nf_conn *ct,
 		return -1;
 	if (end < limit && *end == ':') {
 		end++;
-		p = simple_strtoul(end, (char **)&end, 10);
-		if (p < 1024 || p > 65535)
+		if (nf_ct_helper_parse_port(end, limit - end, &p, (char **)&end))
+			return -1;
+		if (p < 1024)
 			return -1;
 		*port = htons(p);
 	} else
@@ -509,7 +510,7 @@ int ct_sip_parse_header_uri(const struct nf_conn *ct, const char *dptr,
 			    union nf_inet_addr *addr, __be16 *port)
 {
 	const char *c, *limit = dptr + datalen;
-	unsigned int p;
+	u16 p;
 	int ret;
 
 	ret = ct_sip_walk_headers(ct, dptr, dataoff ? *dataoff : 0, datalen,
@@ -522,8 +523,9 @@ int ct_sip_parse_header_uri(const struct nf_conn *ct, const char *dptr,
 		return -1;
 	if (*c == ':') {
 		c++;
-		p = simple_strtoul(c, (char **)&c, 10);
-		if (p < 1024 || p > 65535)
+		if (nf_ct_helper_parse_port(c, limit - c, &p, (char **)&c))
+			return -1;
+		if (p < 1024)
 			return -1;
 		*port = htons(p);
 	} else
-- 
2.54.0


