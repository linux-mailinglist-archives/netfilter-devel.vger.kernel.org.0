Return-Path: <netfilter-devel+bounces-11805-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ig0Kgfg2GkkjggAu9opvQ
	(envelope-from <netfilter-devel+bounces-11805-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 13:33:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A33D63AF
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F8E30A4ABD
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2A39E177;
	Fri, 10 Apr 2026 11:24:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C31448E0;
	Fri, 10 Apr 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820277; cv=none; b=ee6+aWGaIPKifbkVxhYodaPTnArfFVucFIiPcthPrBwa22nO3KRGZUCKgukKf6/D3M0SWkiypc5EA3kezPDI7DxRNUFMDIoY3JoxC1B5JxEqRjNgcQpRmErbQ8wD9FSG4wDDUnWRBHlwhH92Ja2l75Wo8jMKk8yKwQZ7p5mUIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820277; c=relaxed/simple;
	bh=Lm65GdJipstK3YsSiTY/kO3dH1aRYmxNNsBqeGwvuF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0zM54r/QHg/FrluLKyjpuBEWaBO9+AqOaoaY7fy65hwFwlLXh22L1pFTrRzViLxIbo19ASbQkVXMdwus3MpEmVj+wWVHvWNoTpKAzim4IC4jiJ/zYK6UGJwHNZvLFBIvzaIeV4fArnzaMCuvC8LygI2T73wYY+AO5NZWByNohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3423760B78; Fri, 10 Apr 2026 13:24:35 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 09/11] netfilter: x_tables: Avoid a couple -Wflex-array-member-not-at-end warnings
Date: Fri, 10 Apr 2026 13:23:50 +0200
Message-ID: <20260410112352.23599-10-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410112352.23599-1-fw@strlen.de>
References: <20260410112352.23599-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11805-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D5A33D63AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the TRAILING_OVERLAP() helper to fix the following warnings:

1 net/netfilter/x_tables.c:816:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
1 net/netfilter/x_tables.c:811:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/x_tables.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index b39017c80548..9f837fb5ceb4 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -819,13 +819,17 @@ EXPORT_SYMBOL_GPL(xt_compat_match_to_user);
 
 /* non-compat version may have padding after verdict */
 struct compat_xt_standard_target {
-	struct compat_xt_entry_target t;
-	compat_uint_t verdict;
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct compat_xt_entry_target, t, data,
+		compat_uint_t verdict;
+	);
 };
 
 struct compat_xt_error_target {
-	struct compat_xt_entry_target t;
-	char errorname[XT_FUNCTION_MAXNAMELEN];
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct compat_xt_entry_target, t, data,
+		char errorname[XT_FUNCTION_MAXNAMELEN];
+	);
 };
 
 int xt_compat_check_entry_offsets(const void *base, const char *elems,
-- 
2.52.0


