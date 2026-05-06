Return-Path: <netfilter-devel+bounces-12452-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMAPJPUS+2lLWQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12452-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 12:07:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868D4D91AE
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B28E0300820B
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2026 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9B63F9F44;
	Wed,  6 May 2026 10:07:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55F3F788A
	for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062064; cv=none; b=TZhAg2o2AGuwSukKs1Z8+UMZpIvYQUqbjGKZRu4k2sf8odt59zlgJxLVElRQyADY5Zdx6+KHuBW0m2Nls+XSyG/iT1kwAsALTpS5xdfkxtUGgPjjvNjppFoYnRbacZHExt7xIc2qTpYn8PdrMIe2lu3XIjzh+ZRCyJS3SRwPtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062064; c=relaxed/simple;
	bh=36ADkzYhuM4JVEFp4Z19/aMaJQVPGYih6FQhK/o7jf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoJTKgHBARDsjfe5DaVGpkAWYsuht6IhHlXpSrarDYHdbGzWdpNYKu+dHhajZU5vh/VaIQzByF/4TQ+NnB5K3CVaD0pSC7ofWfsTz21+9LasA91mIeh3WJL7Whr4SdyaKgT001Rzvi0MX9KbnrWUk68XWwzcb2yvoYUGP/KgY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7A34C60AED; Wed, 06 May 2026 12:07:38 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: tristan@talencesecurity.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 nf 1/8] netfilter: x_tables: allow initial table replace without emitting audit log message
Date: Wed,  6 May 2026 12:07:13 +0200
Message-ID: <20260506100728.2664-2-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506100728.2664-1-fw@strlen.de>
References: <20260506100728.2664-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0868D4D91AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12452-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

At the moment we emit the audit log a bit too early, which makes it
necessary to also emit an unregister log in case we have to unwind
errors after possible hook register failure.

Followup patch will be slightly simpler if we can delay the
register message until after the hooks have been wired up.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v3: no changes.
 net/netfilter/x_tables.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 2c67c2e6b132..bb0cb3959551 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1472,11 +1472,9 @@ struct xt_counters *xt_counters_alloc(unsigned int counters)
 }
 EXPORT_SYMBOL(xt_counters_alloc);
 
-struct xt_table_info *
-xt_replace_table(struct xt_table *table,
-	      unsigned int num_counters,
-	      struct xt_table_info *newinfo,
-	      int *error)
+static struct xt_table_info *
+do_replace_table(struct xt_table *table, unsigned int num_counters,
+		 struct xt_table_info *newinfo, int *error)
 {
 	struct xt_table_info *private;
 	unsigned int cpu;
@@ -1531,10 +1529,23 @@ xt_replace_table(struct xt_table *table,
 		}
 	}
 
-	audit_log_nfcfg(table->name, table->af, private->number,
-			!private->number ? AUDIT_XT_OP_REGISTER :
-					   AUDIT_XT_OP_REPLACE,
-			GFP_KERNEL);
+	return private;
+}
+
+struct xt_table_info *
+xt_replace_table(struct xt_table *table, unsigned int num_counters,
+		 struct xt_table_info *newinfo,
+		 int *error)
+{
+	struct xt_table_info *private;
+
+	private = do_replace_table(table, num_counters, newinfo, error);
+	if (private)
+		audit_log_nfcfg(table->name, table->af, private->number,
+				!private->number ? AUDIT_XT_OP_REGISTER :
+				AUDIT_XT_OP_REPLACE,
+				GFP_KERNEL);
+
 	return private;
 }
 EXPORT_SYMBOL_GPL(xt_replace_table);
-- 
2.53.0


