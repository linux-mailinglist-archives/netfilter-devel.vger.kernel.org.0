Return-Path: <netfilter-devel+bounces-10477-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PC5GOkwemlq3wEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10477-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 16:53:13 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA42A4A2D
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7993831B57F8
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88670304BC6;
	Wed, 28 Jan 2026 15:42:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8152F3C1D;
	Wed, 28 Jan 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614949; cv=none; b=Z+CqKi9qLJaRoKLRi43FEdNV40EcrCHvwECXne10Ws3uvFREPNMeXeWda4ZnXBDFLsQo9N+qhCmxJPaemR7Sfj867IbWBAcKeum5o8QTRVEcVkn9M6Pth9NVIpC0GAzddKvpxKsRE5wWGaDoooWKPHFclAJIoRkyw2PQMXAz9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614949; c=relaxed/simple;
	bh=1K5IqJRvatmxZmxrvyMTfmzqoKKlWjYoUj9r1bFB72E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJXYFwFm/CpPQ7NUROxYqbzTQGcprNCi+Ta0vK6M5Vi9oqFdhdDuItGs8Wb9ZJUDNl7I/9HO4sTKFThcxUcZ86qAuTgyFssq0DHXCSwUiWL6tIC55kqjOLIAxF+V2neXy5wsmJq+cu5vnfTpNZHCQx7Ws6qrcfkbDFtulqkJkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 80C0560520; Wed, 28 Jan 2026 16:42:24 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 6/9] netfilter: xt_time: use is_leap_year() helper
Date: Wed, 28 Jan 2026 16:41:52 +0100
Message-ID: <20260128154155.32143-7-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128154155.32143-1-fw@strlen.de>
References: <20260128154155.32143-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10477-lists,netfilter-devel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: BBA42A4A2D
X-Rspamd-Action: no action

From: Jinjie Ruan <ruanjinjie@huawei.com>

Use the is_leap_year() helper from rtc.h instead of
writing it by hand

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_time.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/xt_time.c b/net/netfilter/xt_time.c
index 6aa12d0f54e2..00319d2a54da 100644
--- a/net/netfilter/xt_time.c
+++ b/net/netfilter/xt_time.c
@@ -14,6 +14,7 @@
 
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/rtc.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
 #include <linux/netfilter/x_tables.h>
@@ -64,11 +65,6 @@ static const u_int16_t days_since_epoch[] = {
 	3287, 2922, 2557, 2191, 1826, 1461, 1096, 730, 365, 0,
 };
 
-static inline bool is_leap(unsigned int y)
-{
-	return y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);
-}
-
 /*
  * Each network packet has a (nano)seconds-since-the-epoch (SSTE) timestamp.
  * Since we match against days and daytime, the SSTE value needs to be
@@ -138,7 +134,7 @@ static void localtime_3(struct xtm *r, time64_t time)
 	 * (A different approach to use would be to subtract a monthlength
 	 * from w repeatedly while counting.)
 	 */
-	if (is_leap(year)) {
+	if (is_leap_year(year)) {
 		/* use days_since_leapyear[] in a leap year */
 		for (i = ARRAY_SIZE(days_since_leapyear) - 1;
 		    i > 0 && days_since_leapyear[i] > w; --i)
-- 
2.52.0


