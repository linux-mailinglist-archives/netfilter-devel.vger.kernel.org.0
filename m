Return-Path: <netfilter-devel+bounces-13424-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qT1AJPoFO2r6OggAu9opvQ
	(envelope-from <netfilter-devel+bounces-13424-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:17:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E831D6BA60E
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=noUNRZ4n;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13424-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13424-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20B483080E52
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 22:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA843C417F;
	Tue, 23 Jun 2026 22:16:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2B3C3459;
	Tue, 23 Jun 2026 22:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252961; cv=none; b=CTD0rKl/bjf5JWByI9vE2UcddxVo2jDnt6+qaEDCESu3pfmtoprfY57zoG2RK3ckA4mfP1+gi62WX2lWtIUlKXt+5K8tRILKW1C4QhrNYdson2cuPAVpaEJsUm4pE3pZmvRdJ8k4tC5Rl543DXAKKrUwHUUwlIa3R+Y8VDVrRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252961; c=relaxed/simple;
	bh=uzXC7AqqY3gzOC59SvIf9ohV+eAlN7ls6OV7Lqr4Qz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njVlJIbRiT69wnkL/J6NNOLB8U5tI8+9tx/rAFINmx/ZKLmqfRPUUBHo21ozD34G4frFFe9PNbb4G32sY3ADPKZMzlDfRwDXBmt3s5weeKnahL7gyxV3y6QCifxzoMPx6FPW3M6NNCg4ejxZrILjKQpsODyU+XRcWryHRDDY+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=noUNRZ4n; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id EC74B6057A;
	Wed, 24 Jun 2026 00:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782252958;
	bh=vCow7yv9AaEFI0M89DsSYZsuTQ/qjQ6vfyqCFEewwHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=noUNRZ4nKlDns1DflAGWifoMIC8GHH9EjXKW7mSpt5S4pJBVwR6ZR1NTRcdB2bn/+
	 f1FjGEDvUzjw4CNaFYSBf1fSgGVJeuTPPtzet+6k77pJTCk3aUz74IdHJcHbRAQ9Gs
	 bg5CyJJ5gCWadpIlyAVhpb8hr4zZaXksV1N5/CRF2NCIvzP8oTd0x9AL2hJ+8NqSu7
	 9VtW3FyT2ViRszO6UMQRzU+E+UNdcquVnRx/JTS07070aYGEAEXekPuCWJdhPb1vCC
	 Eq2V61f1FQnJahCmv2c09oDY8nl9I4Kfb36u1B8Mo4hDtGBfz+MuivtzekJrEmWZA8
	 OaGpF3E3G9cMA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 04/14] netfilter: x_tables.h: fix all kernel-doc warnings
Date: Wed, 24 Jun 2026 00:15:37 +0200
Message-ID: <20260623221548.701545-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623221548.701545-1-pablo@netfilter.org>
References: <20260623221548.701545-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13424-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E831D6BA60E

From: Randy Dunlap <rdunlap@infradead.org>

- use correct names in kernel-doc comments
- add missing struct members to kernel-doc comments

Warning: include/linux/netfilter/x_tables.h:41 struct member 'targinfo' not described in 'xt_action_param'
Warning: include/linux/netfilter/x_tables.h:41 Excess struct member 'targetinfo' description in 'xt_action_param'
Warning: include/linux/netfilter/x_tables.h:90 struct member 'family' not described in 'xt_mtchk_param'
Warning: include/linux/netfilter/x_tables.h:90 struct member 'nft_compat' not described in 'xt_mtchk_param'
Warning: include/linux/netfilter/x_tables.h:101 expecting prototype for struct xt_mdtor_param. Prototype was for struct xt_mtdtor_param instead

Warning: include/linux/netfilter/x_tables.h:121 struct member 'net' not described in 'xt_tgchk_param'
Warning: include/linux/netfilter/x_tables.h:121 struct member 'table' not described in 'xt_tgchk_param'
Warning: include/linux/netfilter/x_tables.h:121 struct member 'target' not described in 'xt_tgchk_param'
Warning: include/linux/netfilter/x_tables.h:121 struct member 'targinfo' not described in 'xt_tgchk_param'
Warning: include/linux/netfilter/x_tables.h:121 struct member 'hook_mask' not described in 'xt_tgchk_param'
Warning: include/linux/netfilter/x_tables.h:121 struct member 'family' not described in 'xt_tgchk_param'
Warning: include/linux/netfilter/x_tables.h:121 struct member 'nft_compat' not described in 'xt_tgchk_param'

Warning: include/linux/netfilter/x_tables.h:345 expecting prototype for xt_recseq(). Prototype was for DECLARE_PER_CPU() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/x_tables.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index 20d70dddbe50..25062f4a0dd5 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -18,7 +18,7 @@
  * @match:	the match extension
  * @target:	the target extension
  * @matchinfo:	per-match data
- * @targetinfo:	per-target data
+ * @targinfo:	per-target data
  * @state:	pointer to hook state this packet came from
  * @fragoff:	packet is a fragment, this is the data offset
  * @thoff:	position of transport header relative to skb->data
@@ -77,7 +77,9 @@ static inline u_int8_t xt_family(const struct xt_action_param *par)
  * @match:	struct xt_match through which this function was invoked
  * @matchinfo:	per-match data
  * @hook_mask:	via which hooks the new rule is reachable
- * Other fields as above.
+ * @family:	actual NFPROTO_* through which the function is invoked
+ *		(helpful when match->family == NFPROTO_UNSPEC)
+ * @nft_compat:	running from the nft compat layer if true
  */
 struct xt_mtchk_param {
 	struct net *net;
@@ -91,8 +93,13 @@ struct xt_mtchk_param {
 };
 
 /**
- * struct xt_mdtor_param - match destructor parameters
- * Fields as above.
+ * struct xt_mtdtor_param - match destructor parameters
+ *
+ * @net:	network namespace through which the check was invoked
+ * @match:	struct xt_match through which this function was invoked
+ * @matchinfo:	per-match data
+ * @family:	actual NFPROTO_* through which the function is invoked
+ *		(helpful when match->family == NFPROTO_UNSPEC)
  */
 struct xt_mtdtor_param {
 	struct net *net;
@@ -105,10 +112,16 @@ struct xt_mtdtor_param {
  * struct xt_tgchk_param - parameters for target extensions'
  * checkentry functions
  *
+ * @net:	network namespace through which the check was invoked
+ * @table:	table the rule is tried to be inserted into
  * @entryinfo:	the family-specific rule data
  * 		(struct ipt_entry, ip6t_entry, arpt_entry, ebt_entry)
- *
- * Other fields see above.
+ * @target:	the target extension
+ * @targinfo:	per-target data
+ * @hook_mask:	via which hooks the new rule is reachable
+ * @family:	actual NFPROTO_* through which the function is invoked
+ *		(helpful when match->family == NFPROTO_UNSPEC)
+ * @nft_compat:	running from the nft compat layer if true
  */
 struct xt_tgchk_param {
 	struct net *net;
@@ -336,9 +349,9 @@ struct xt_table_info *xt_alloc_table_info(unsigned int size);
 void xt_free_table_info(struct xt_table_info *info);
 
 /**
- * xt_recseq - recursive seqcount for netfilter use
+ * var xt_recseq - recursive seqcount for netfilter use
  *
- * Packet processing changes the seqcount only if no recursion happened
+ * Packet processing changes the seqcount only if no recursion happened.
  * get_counters() can use read_seqcount_begin()/read_seqcount_retry(),
  * because we use the normal seqcount convention :
  * Low order bit set to 1 if a writer is active.
-- 
2.47.3


