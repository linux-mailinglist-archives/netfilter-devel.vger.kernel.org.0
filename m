Return-Path: <netfilter-devel+bounces-10957-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC3HA94cqGnyoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10957-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:51:58 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFAA1FF52B
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6D57309F441
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8ED39B945;
	Wed,  4 Mar 2026 11:49:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C4371872;
	Wed,  4 Mar 2026 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624999; cv=none; b=EFjMlZvvh28tB94d+k/VcPd8opMoSV0oC7Cbk7+GAIFjwzdm00nNUpOgmmPVrPW6kRk5M1DBuOCR32sBbb9HE6i3StjA/9HsgY/clD1GW1i9saKriTmJGf3VBl9QZH/0Pj4yw3uWxtGbNHzY/H05ZairsW09VLqC/FxfzKYWXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624999; c=relaxed/simple;
	bh=KPHQIorftCzmegXaoFBAMjKp1clMjuRrH5PAaPySCRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7uxrqyg/2fEdXpk9sxD/50GSzWvasQsAWn3iszehK9DHwPxvfNnMAvUrk6whiawBXzqdegz9xHPRbTQaJvDV0vmLdodJLtzEm08R1SGkeIEapyMp+AmLQAXCbpyIwykuIUu2/UDEFwwPSdSfhoAp/ntF1QxuACK1PXb8NrOlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2740F6026E; Wed, 04 Mar 2026 12:49:56 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 06/14] netfilter: nft_meta: no longer acquire sk_callback_lock in nft_meta_get_eval_skugid()
Date: Wed,  4 Mar 2026 12:49:13 +0100
Message-ID: <20260304114921.31042-7-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304114921.31042-1-fw@strlen.de>
References: <20260304114921.31042-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CFAA1FF52B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10957-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[91.216.245.30:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in
nft_meta_get_eval_skugid() to avoid touching sk->sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_meta.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 983158274c68..d0df6cf374d1 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -131,33 +131,36 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 			 u32 *dest,
 			 const struct nft_pktinfo *pkt)
 {
-	struct sock *sk = skb_to_full_sk(pkt->skb);
-	struct socket *sock;
+	const struct sock *sk = skb_to_full_sk(pkt->skb);
+	const struct socket *sock;
+	const struct file *file;
 
 	if (!sk || !sk_fullsock(sk) || !net_eq(nft_net(pkt), sock_net(sk)))
 		return false;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	sock = sk->sk_socket;
-	if (!sock || !sock->file) {
-		read_unlock_bh(&sk->sk_callback_lock);
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (!file)
 		return false;
-	}
 
 	switch (key) {
 	case NFT_META_SKUID:
 		*dest = from_kuid_munged(sock_net(sk)->user_ns,
-					 sock->file->f_cred->fsuid);
+					 file->f_cred->fsuid);
 		break;
 	case NFT_META_SKGID:
 		*dest =	from_kgid_munged(sock_net(sk)->user_ns,
-					 sock->file->f_cred->fsgid);
+					 file->f_cred->fsgid);
 		break;
 	default:
 		break;
 	}
 
-	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
-- 
2.52.0


