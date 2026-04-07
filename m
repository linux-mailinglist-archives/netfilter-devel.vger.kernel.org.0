Return-Path: <netfilter-devel+bounces-11678-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKD2Mx8T1Wm30AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11678-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:22:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FF3AFF00
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6E030CA7D0
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DF3B8BD1;
	Tue,  7 Apr 2026 14:15:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45403B8950;
	Tue,  7 Apr 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571357; cv=none; b=ZnziCmLlrPOuRR5iJaB3DPKnFqR1BnYBWKBGTiLP9789RMWoPcsemPcQgej31ZMA2cHvGcQ4dtwm7vEiIeE/XTqQRnYuLQRx60DoesPaYCYyCvigCsf0mlCTE2Sb+Xmg522VkPEYCynJW1T/T03AF+ULerhk8OA0ErkTBwU3VeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571357; c=relaxed/simple;
	bh=AsCQxqV4NsERfy622sleC6imp1YRQ8OLbVvEAOjx9+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/dpZubqauN53T0ynZKyAr/qCyaNM6SyUdsKXlQImDtbWirNekV+uAJH09ylvJcttvWCz49wEs1gHkqGgrGcUZfo3TA+XS++XDuJZZy9u3POI+0nhEEABEJMmgJWZ7uo3MUno10r0Agk+ddJ99PDgckY0iSItJqwxVunxmurw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id ABA5460670; Tue, 07 Apr 2026 16:15:53 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 02/13] netfilter: nf_tables: Fix typo in enum description
Date: Tue,  7 Apr 2026 16:15:29 +0200
Message-ID: <20260407141540.11549-3-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407141540.11549-1-fw@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11678-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid,vdwaa.nl:email]
X-Rspamd-Queue-Id: 300FF3AFF00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jelle van der Waa <jelle@vdwaa.nl>

Fix the spelling of "options".

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 45c71f7d21c2..dca9e72b0558 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -884,7 +884,7 @@ enum nft_exthdr_flags {
  * @NFT_EXTHDR_OP_TCPOPT: match against tcp options
  * @NFT_EXTHDR_OP_IPV4: match against ipv4 options
  * @NFT_EXTHDR_OP_SCTP: match against sctp chunks
- * @NFT_EXTHDR_OP_DCCP: match against dccp otions
+ * @NFT_EXTHDR_OP_DCCP: match against dccp options
  */
 enum nft_exthdr_op {
 	NFT_EXTHDR_OP_IPV6,
-- 
2.52.0


