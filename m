Return-Path: <netfilter-devel+bounces-10363-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELmAM3nccGnCaQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10363-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 15:02:33 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFAB58173
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 15:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5CEF702089
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844A3EDAB7;
	Wed, 21 Jan 2026 13:39:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B12D94A1
	for <netfilter-devel@vger.kernel.org>; Wed, 21 Jan 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002772; cv=none; b=EB+lGcuznoPi3bgGlkV09lZbwVuZxL6DmLkk5af+WMvX1ubcRVj34TLq2sfrkyhe4Ss/zU+3LCIX6fqegxtjlVdVewf3B+tkaL0uxHvloiaTMv0ybcSaawx7kANgbt6Qqtvm4nIf0GxhI9AxE4ThUs4/cxvqJMq/sPxrRorhdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002772; c=relaxed/simple;
	bh=+u5CzodRozL5kgOc+i/eh+tDO+ojmeisBzGXOwYGanc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0M5Wn54Aw/7KCYQhsakTzw+TVBT1bZfofEJHijU08zX5rSbkgKcAyKO/Sn0/c4gYlUfSKnxHoQFxBI5aTV2P3a49hf0gvhLjd59c+HFsJCoAHm4sG3SeCQPiM94zQcYRHkgsyCEgMiXgk+Rn4deWKcasrSJcY/XZ9wqhUDBLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 22613604E3; Wed, 21 Jan 2026 14:39:22 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] monitor: fix memleak in setelem cb
Date: Wed, 21 Jan 2026 14:39:08 +0100
Message-ID: <20260121133917.11734-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DMARC_NA(0.00)[strlen.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-10363-lists,netfilter-devel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: 6BFAB58173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

since 4521732ebbf3 ("monitor: missing cache and set handle initialization")
these fields are initied via handle_merge(), so don't clear them in
the json output case.  Fixes:

==31877==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 16 byte(s) in 2 object(s) allocated from:
 #0 0x7f0cb9f29d4b in strdup asan/asan_interceptors.cpp:593
 #1 0x7f0cb9b584fd in xstrdup src/utils.c:80
 #2 0x7f0cb9b355b3 in handle_merge src/rule.c:127
 #3 0x7f0cb9ae12b8 in netlink_events_setelem_cb src/monitor.c:457

Seen when running tests/monitor with asan enabled.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/monitor.c b/src/monitor.c
index fafeeebe914b..6532c9c50f8d 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -496,13 +496,7 @@ static int netlink_events_setelem_cb(const struct nlmsghdr *nlh, int type,
 		nft_mon_print(monh, "\n");
 		break;
 	case NFTNL_OUTPUT_JSON:
-		dummyset->handle.family = family;
-		dummyset->handle.set.name = setname;
-		dummyset->handle.table.name = table;
 		monitor_print_element_json(monh, cmd, dummyset);
-		/* prevent set_free() from trying to free those */
-		dummyset->handle.set.name = NULL;
-		dummyset->handle.table.name = NULL;
 		if (!nft_output_echo(&monh->ctx->nft->output))
 			nft_mon_print(monh, "\n");
 		break;
-- 
2.52.0


