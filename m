Return-Path: <netfilter-devel+bounces-11046-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLYtNJ9crWmD1wEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11046-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 08 Mar 2026 12:25:19 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952222F6D5
	for <lists+netfilter-devel@lfdr.de>; Sun, 08 Mar 2026 12:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF1713006693
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Mar 2026 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA9239E9B;
	Sun,  8 Mar 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="LIg21NFG"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AD1B4257
	for <netfilter-devel@vger.kernel.org>; Sun,  8 Mar 2026 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772969116; cv=none; b=SVmZA5Wmvkb5cCoyVgp1b5Jmha7zoNy1iGzzUnoPaE3plgMtzR9kUojMxNzSPQ5P12YuWizj/CTWF8NqeqL5G3F76w7dNZuNGWRnbkSftnkJ8N7PDN0f1jBq7Yq1hJPM8RxtgCp4NQjWt5abMZoWYpzhJiGWZg3GGAUYs5xL7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772969116; c=relaxed/simple;
	bh=jqsXRSSLInU1s8bIvhZulcfUgMuv2X8qVfsYl2SDjb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEmh+SpRhyOS7jZwJRDZQ5aW8MMuHdxSNKTFz5oBuaYC8sGb4unQEp6xyPojTDeLYvrL1xszZl63kYwOJ3n0SFQI1R2/huWy9mpPDTuv59p04vHdDquHnlXMzxN5qs+kmY9g3TWJckoZw8VKVBsHaPEqSlP2hEoS4e7rdhYuxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=LIg21NFG; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E502C60339;
	Sun,  8 Mar 2026 12:25:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772969114;
	bh=yb874iRDPE0WauwkEmhpbG6zKerxVne52nxgEpdEk5E=;
	h=From:To:Cc:Subject:Date:From;
	b=LIg21NFGV6R3W2aKnFOT3NragpL4QrhbMCH8CbDZhFxTesoSJb/I2tln+4798sxrF
	 68PfJE6m+fb56K8tRnU43gxbTGvI4wlE0pLyXi+iJ7j6ppjshkepHirJVOlUiya0VQ
	 PYDuISkdqL9D6kX63v3yu4gLXrWHeXGJ2dI3TVKXjoevwKGAFgygAeqYfU4Tmj+0rD
	 f+Kv5j6LwSPZDb8xAQ2r/cmBoj0M5bdrOTg047xA//idzcfO/of7KzMYKnWms/2q2t
	 EKvtb2WlSUsAP73fCha+5DyOy6IlgTQEloY5kdmNCZyjEtZ+U8v+N2mzSXkFGfzVZZ
	 NAwinD+B8+Z0A==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: moderador@gmail.com,
	fw@strlen.de
Subject: [PATCH] netfilter: xtables: fix possible off-by-one when accessing TCP/DCCP options
Date: Sun,  8 Mar 2026 12:25:10 +0100
Message-ID: <20260308112510.2958551-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6952222F6D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11046-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When iterating over the TCP/DCCP options, there is a possible off-by-one
access to the option area that has been fetched via skb_header_pointer().
Add an extra safety check on i + 1 >= optlen check to fix this.

Reported-by: David Dull <moderador@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/xt_dccp.c   | 11 +++++++----
 net/netfilter/xt_tcpudp.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/xt_dccp.c b/net/netfilter/xt_dccp.c
index e5a13ecbe67a..3332d1801632 100644
--- a/net/netfilter/xt_dccp.c
+++ b/net/netfilter/xt_dccp.c
@@ -61,11 +61,14 @@ dccp_find_option(u_int8_t option,
 			spin_unlock_bh(&dccp_buflock);
 			return true;
 		}
-
-		if (op[i] < 2)
+		if (op[i] < 2) {
 			i++;
-		else
-			i += op[i+1]?:1;
+			continue;
+		}
+		if (i + 1 >= optlen)
+			break;
+
+		i += op[i + 1] ?: 1;
 	}
 
 	spin_unlock_bh(&dccp_buflock);
diff --git a/net/netfilter/xt_tcpudp.c b/net/netfilter/xt_tcpudp.c
index e8991130a3de..e27faf49462f 100644
--- a/net/netfilter/xt_tcpudp.c
+++ b/net/netfilter/xt_tcpudp.c
@@ -58,9 +58,17 @@ tcp_find_option(u_int8_t option,
 	}
 
 	for (i = 0; i < optlen; ) {
-		if (op[i] == option) return !invert;
-		if (op[i] < 2) i++;
-		else i += op[i+1]?:1;
+		if (op[i] == option)
+			return !invert;
+
+		if (op[i] < 2) {
+			i++;
+			continue;
+		}
+		if (i + 1 >= optlen)
+			break;
+
+		i += op[i + 1] ?: 1;
 	}
 
 	return invert;
-- 
2.47.3


