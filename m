Return-Path: <netfilter-devel+bounces-12825-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMsVJHOWFGpfOgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12825-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 20:35:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE85CDB2E
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38550301B91E
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6154336E468;
	Mon, 25 May 2026 18:30:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A033C507;
	Mon, 25 May 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733812; cv=none; b=GeFxECxmaB4qbU20my0FKxh9/2sy6QcIdcSKKQrWaScT9btzYy67zv0FdC+AEh2KchSAJywX43PXy5Qu/qSVg2Ulp7LSQkn8nL4PP+oSCBdX5KKdTN7nbOcDKFitLUnGAVJZFlFw/lVCElt4KBXOsUcgLr2RUmNKwubOO1n43zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733812; c=relaxed/simple;
	bh=QNRY61yISDqTV59OvMgxBaMcwLXXLR+LfMMXp0YSxEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWIllPfrEC3S2kpjbp/4yMqChJ6FXhGlOOG1JskUk9A2OXlzJLSe+c9eoe4egI2TxODfhml0Wf+xPC2BaBukNj09La5jb+K3rrgjFOT2CIHSrLrXlHiasot5tkHZ6MF4G/rtPFkwcD2r89KssZvlXt4RniVXhVFLz25eLn6q8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E92F26070B; Mon, 25 May 2026 20:30:06 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 09/11] netfilter: nf_conntrack_proto_tcp: fix typos in comments
Date: Mon, 25 May 2026 20:29:22 +0200
Message-ID: <20260525182924.28456-10-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525182924.28456-1-fw@strlen.de>
References: <20260525182924.28456-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-12825-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 27BE85CDB2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Duduskar <avinash.duduskar@gmail.com>

Fix three typos in comments:

- "migth"/"Migth" -> "might" (two adjacent occurrences in the
  tcp_conntracks[] state-transition table comment block).
- "agaist" -> "against" (tcp_error() header comment).
- "intrepretated" -> "interpreted" (RFC 5961 challenge-ACK
  marker comment in nf_conntrack_tcp_packet()).

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index b67426c2189b..47dc6edb4431 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -169,14 +169,14 @@ static const u8 tcp_conntracks[2][6][TCP_CONNTRACK_MAX] = {
 /*fin*/    { sIV, sIV, sFW, sFW, sLA, sLA, sLA, sTW, sCL, sIV },
 /*
  *	sNO -> sIV	Too late and no reason to do anything...
- *	sSS -> sIV	Client migth not send FIN in this state:
+ *	sSS -> sIV	Client might not send FIN in this state:
  *			we enforce waiting for a SYN/ACK reply first.
  *	sS2 -> sIV
  *	sSR -> sFW	Close started.
  *	sES -> sFW
  *	sFW -> sLA	FIN seen in both directions, waiting for
  *			the last ACK.
- *			Migth be a retransmitted FIN as well...
+ *			Might be a retransmitted FIN as well...
  *	sCW -> sLA
  *	sLA -> sLA	Retransmitted FIN. Remain in the same state.
  *	sTW -> sTW
@@ -798,7 +798,7 @@ static void tcp_error_log(const struct sk_buff *skb,
 	nf_l4proto_log_invalid(skb, state, IPPROTO_TCP, "%s", msg);
 }
 
-/* Protect conntrack agaist broken packets. Code taken from ipt_unclean.c.  */
+/* Protect conntrack against broken packets. Code taken from ipt_unclean.c.  */
 static bool tcp_error(const struct tcphdr *th,
 		      struct sk_buff *skb,
 		      unsigned int dataoff,
@@ -1098,7 +1098,7 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			}
 			/* Mark the potential for RFC5961 challenge ACK,
 			 * this pose a special problem for LAST_ACK state
-			 * as ACK is intrepretated as ACKing last FIN.
+			 * as ACK is interpreted as ACKing last FIN.
 			 */
 			if (old_state == TCP_CONNTRACK_LAST_ACK)
 				ct->proto.tcp.last_flags |=
-- 
2.53.0


