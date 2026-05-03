Return-Path: <netfilter-devel+bounces-12396-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCdNMT0I92mfbQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12396-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 03 May 2026 10:33:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1774B4E56
	for <lists+netfilter-devel@lfdr.de>; Sun, 03 May 2026 10:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34C1E30071DC
	for <lists+netfilter-devel@lfdr.de>; Sun,  3 May 2026 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164C3AD510;
	Sun,  3 May 2026 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="RxLF9KJQ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680403AE6EB;
	Sun,  3 May 2026 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777797164; cv=none; b=hBeMJjOwjpIyaUvAAyLmKzvV3FhTjUb4ADdz623Oo3E8ulRPm966RBEighd2WOcO+3YhuOmnFAPTTu52qmmgQLxYi+A64FMf+6WjuuT7NMS8ze6fnhoi11QRtRjXJ9pZ1pmCWH9YwhmqGVUxI3eBN1EZs+QkqOzgqDjWNr4DSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777797164; c=relaxed/simple;
	bh=eyPhzYcrMzmxsVNdoq0bw3cqjHHIYUCAuGDdTQ8vbOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cftgL/ZLiJL+qbOmJhaRhPsVy+meort8MnYZG+AwVgXr5Kyn12sp9GJuMazhlmUFHeet3eW17zGpVRtiJ4Ql21bnLImvk2p++VtSpmveOOh0JEdKLaNmgrJ8vVt2A78DipRLRizuDt2nCwIIG6gJNr7kR+fPj8ymx/pAqS90iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=RxLF9KJQ reason="key not found in DNS"; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.224.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4g7dLm6Kg9z8sc7;
	Sun, 03 May 2026 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1777797156;
	bh=H1UwZxXtA1OhepmdQC3uiluz+P1XCqaIsWNP6kKMuIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxLF9KJQ+pyB/GqRnJ00lXqXcgrwyTYLrpRZhWoYaogVNesHhkyu6KgsAzUbnoo18
	 lIxClUZsp0ojroLhrUixyYQrcbHNSB/wfAxO3s3SqcFtSlYUM/OaCXoWibT6AKaLci
	 xa+nhAj91NvpuMHvduDN0p2HU1Y3d3EtKwtYEqyKanKMW+iHnJOjaPfAcnL6/rx1dr
	 oJIynVzvO1d98shL1RC7irHdDLkQvmaIQAlpEwanZukVM6Kof8Nm9EiU+7dSjJSSzy
	 OrK1LWXy1NBRm/GHSdu0+wFqmtILF8m+WfNiZH8Gl2PQJaTTq+QJ0gRRBy32tOlrEw
	 ixWfuxQrs8Dxg==
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
Subject: [PATCH net-next v3 1/4] netfilter: conntrack: add shared port and uint parsers for helpers
Date: Sun,  3 May 2026 14:02:17 +0530
Message-ID: <20260503083220.630655-2-rc@rexion.ai>
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
X-Rspamd-Queue-Id: 6B1774B4E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12396-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	DKIM_TRACE(0.00)[rexion.ai:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_SPAM(0.00)[0.002];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add nf_ct_helper_parse_uint() for bounded unsigned integer parsing
from an unterminated buffer, and nf_ct_helper_parse_port() which calls
it with max=65535 and rejects port zero.  Both helpers are exported so
conntrack protocol helpers can replace ad-hoc simple_strtoul() usage.

Signed-off-by: HACKE-RC <rc@rexion.ai>
---
 include/net/netfilter/nf_conntrack_helper.h |  5 +++
 net/netfilter/nf_conntrack_helper.c         | 39 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
index de2f956ab..ab145fcd9 100644
--- a/include/net/netfilter/nf_conntrack_helper.h
+++ b/include/net/netfilter/nf_conntrack_helper.h
@@ -160,6 +160,11 @@ nf_ct_helper_expectfn_find_by_name(const char *name);
 struct nf_ct_helper_expectfn *
 nf_ct_helper_expectfn_find_by_symbol(const void *symbol);
 
+int nf_ct_helper_parse_uint(const char *cp, unsigned int len,
+			    unsigned long max, unsigned long *val, char **endp);
+int nf_ct_helper_parse_port(const char *cp, unsigned int len,
+			    u16 *port, char **endp);
+
 extern struct hlist_head *nf_ct_helper_hash;
 extern unsigned int nf_ct_helper_hsize;
 
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index a715304a5..f6229957c 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -499,6 +499,45 @@ void nf_nat_helper_unregister(struct nf_conntrack_nat_helper *nat)
 }
 EXPORT_SYMBOL_GPL(nf_nat_helper_unregister);
 
+int nf_ct_helper_parse_uint(const char *cp, unsigned int len,
+			    unsigned long max, unsigned long *val, char **endp)
+{
+	unsigned long result = 0;
+
+	if (!len || *cp < '0' || *cp > '9')
+		return -1;
+
+	while (len > 0 && *cp >= '0' && *cp <= '9') {
+		result = result * 10 + (*cp - '0');
+		if (result > max)
+			return -1;
+		cp++;
+		len--;
+	}
+
+	*val = result;
+	if (endp)
+		*endp = (char *)cp;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nf_ct_helper_parse_uint);
+
+int nf_ct_helper_parse_port(const char *cp, unsigned int len,
+			    u16 *port, char **endp)
+{
+	unsigned long val;
+
+	if (nf_ct_helper_parse_uint(cp, len, 65535, &val, endp))
+		return -1;
+	if (val == 0)
+		return -1;
+
+	*port = val;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nf_ct_helper_parse_port);
+
 int nf_conntrack_helper_init(void)
 {
 	nf_ct_helper_hsize = 1; /* gets rounded up to use one page */
-- 
2.54.0


