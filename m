Return-Path: <netfilter-devel+bounces-10511-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBtGC55pe2lEEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10511-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:07:26 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B94B0B01
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D7CE3013737
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E021D3C5;
	Thu, 29 Jan 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="TRR4jivD"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C03081BE
	for <netfilter-devel@vger.kernel.org>; Thu, 29 Jan 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695639; cv=none; b=DJG5gzgFgywoOjcMlCoVvhmVoFqUFtDF9y3sKEwm4CGpBywDIXSmamAR4jpXWU/f5cVCvmqBDQMXg6v4krpZuQ1jfBRHMI6rhOiVwI0aptjGr5HlmokqBEkdR0pghGiLvWX3EIjJqRQc52X7bA8TB11kvDWY1MSEID5TVUlzXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695639; c=relaxed/simple;
	bh=GLizEXiUbUuvM6H4YL6zW/IdI6SrQH8JQqDh1gJwtmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHj0i3/5PxcWcTB6bXjVU13CkE1N4LVuZeLLfbn58p2ArzteFahhuHnkNjPJ8NXf6EoQDVGQHmkKDhevZkbIr6jUWb8U3DXBZtbGb3LAzto7q8FcPMcrXva+rpC/pAbA2zUg3gJRM2ODYiaiXmvGVhHFKtRzG0ifpCbBMJr07kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=TRR4jivD; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Gi8mQ3u2UA9esLPdWyOqfs8ZYC2cNtBpBvmuDFynTsw=; b=TRR4jivDNWOOfcFd5P1oF3W1Ze
	/F6k4+tUYH4Sv4id/fai2jDV5npHWmeJS3u6WWXG2D563lG3NjPUCiE1raFgPTUyIoXl7yxbqJyKx
	1S0je6FKjw239Ho5dH7iyDV3Pt1Kqax35Vf6LFoSQF68C6MHQmdSk86H9Tz4VQAy/wXVWk1RUJLkg
	k/B1b8qMs+geLhiAS1PQ+TJS7sKmk51cTePgUYGhiWZGDCyeb3I3UzfpPBgKxRQ3AB5yydbj0DTmL
	eXsRoqxQvOWMLQ2Fqp/6gya0qWc+W708Oz3NGTjgN/0MyCLlVEVmOj7zc6TrSkXFCi0fKmj+I1JyS
	CPOs4u1g==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vlSfw-000000001Ly-2PkA;
	Thu, 29 Jan 2026 15:07:12 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [libnftnl PATCH 2/2] src: Do not include userdata content in debug output
Date: Thu, 29 Jan 2026 15:07:07 +0100
Message-ID: <20260129140707.10025-2-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129140707.10025-1-phil@nwl.cc>
References: <20260129140707.10025-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nwl.cc];
	TAGGED_FROM(0.00)[bounces-10511-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:mid,nwl.cc:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1B94B0B01
X-Rspamd-Action: no action

This storage in rules and set elements is opaque by design, neither
libnftnl nor kernel should deal with its content. Yet nftables enters data
in host byte order which will lead to changing output depending on
host's byte order. Avoid this problem for test suites checking the debug
output by merely printing the number and sum of all the bytes in the
buffer. This likely detects changes in userdata but deliberately ignores
data reordering.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/utils.h | 10 ++++++++++
 src/rule.c      | 19 ++++---------------
 src/set_elem.c  | 18 ++++--------------
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index 10492893e3a16..5dcd287f491c4 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -91,4 +91,14 @@ char *nftnl_attr_get_ifname(const struct nlattr *attr);
 int nftnl_parse_str_attr(const struct nlattr *tb, int attr,
 			 const char **field, uint32_t *flags);
 
+static inline uint32_t bytesum(uint8_t *buf, size_t buflen)
+{
+	uint32_t ret = 0;
+
+	while (buflen--)
+		ret += buf[buflen];
+
+	return ret;
+}
+
 #endif
diff --git a/src/rule.c b/src/rule.c
index cd3041e5a399a..f8109969a9183 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -509,8 +509,8 @@ static int nftnl_rule_snprintf_default(char *buf, size_t remain,
 				       uint32_t type, uint32_t flags)
 {
 	struct nftnl_expr *expr;
-	int ret, offset = 0, i;
 	const char *sep = "";
+	int ret, offset = 0;
 
 	if (r->flags & (1 << NFTNL_RULE_FAMILY)) {
 		ret = snprintf(buf + offset, remain, "%s%s", sep,
@@ -573,21 +573,10 @@ static int nftnl_rule_snprintf_default(char *buf, size_t remain,
 	}
 
 	if (r->user.len) {
-		ret = snprintf(buf + offset, remain, "\n  userdata = { ");
-		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-
-		for (i = 0; i < r->user.len; i++) {
-			char *c = r->user.data;
-
-			ret = snprintf(buf + offset, remain,
-				       isprint(c[i]) ? "%c" : "\\x%02hhx",
-				       c[i]);
-			SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-		}
-
-		ret = snprintf(buf + offset, remain, " }");
+		ret = snprintf(buf + offset, remain,
+			       "\n  userdata len %d sum 0x%x",
+			       r->user.len, bytesum(r->user.data, r->user.len));
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-
 	}
 
 	return offset;
diff --git a/src/set_elem.c b/src/set_elem.c
index d22643c44dd71..3e0ab0cf50876 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -705,7 +705,7 @@ int nftnl_set_elem_parse_file(struct nftnl_set_elem *e, enum nftnl_parse_type ty
 int nftnl_set_elem_snprintf_default(char *buf, size_t remain,
 				    const struct nftnl_set_elem *e)
 {
-	int ret, dregtype = DATA_NONE, offset = 0, i;
+	int ret, dregtype = DATA_NONE, offset = 0;
 
 	ret = snprintf(buf, remain, "element ");
 	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
@@ -748,19 +748,9 @@ int nftnl_set_elem_snprintf_default(char *buf, size_t remain,
 	}
 
 	if (e->user.len) {
-		ret = snprintf(buf + offset, remain, "  userdata = { ");
-		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-
-		for (i = 0; i < e->user.len; i++) {
-			char *c = e->user.data;
-
-			ret = snprintf(buf + offset, remain,
-				       isprint(c[i]) ? "%c" : "\\x%02hhx",
-				       c[i]);
-			SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-		}
-
-		ret = snprintf(buf + offset, remain, " }");
+		ret = snprintf(buf + offset, remain,
+			       "  userdata len %d sum 0x%x",
+			       e->user.len, bytesum(e->user.data, e->user.len));
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
-- 
2.51.0


