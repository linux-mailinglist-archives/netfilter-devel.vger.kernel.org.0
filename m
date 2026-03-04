Return-Path: <netfilter-devel+bounces-10958-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FX+N5UcqGnyoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10958-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:45 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E01FF4B2
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B4EF3018F39
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D139F17B;
	Wed,  4 Mar 2026 11:50:03 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E93914E5;
	Wed,  4 Mar 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625003; cv=none; b=L0gt3sqsR/DMkmu1HxRyc7PoL0mnIA+B+H0nEjpiE9zmA6J+ib1FEsAhlwekBwB5c3lMWI45Vt0vixYyfBznq8vZsd9hPVB4ED0l50OBGHHOkFMHKuDkCATHwvYNIoNbeJf5dlqCLgoyRU7Z72RqzfyC9fWigJYTyNLt5Xvvh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625003; c=relaxed/simple;
	bh=4pe+sHODYeIYo88bnHLEvrJ7GGhn9cC/0AOnuI6XwP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtmfjL4KMwyD2xxWqqU117Yl+anPGbVdwoGOAsIqiWIlusT5buOahUtwU1rM6BKEladO35doJA/SJ2YM2BYJaqIPm56LDg+DHq9/d3EDlsXAEpXiMkv24p4G4ph18bgSE2lZP/gEutn+W+Pl7fVcfJ/Yn98F1EhB8Hmj5Qvy0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7BFBF6026E; Wed, 04 Mar 2026 12:50:00 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 07/14] netfilter: nfnetlink_log: no longer acquire sk_callback_lock
Date: Wed,  4 Mar 2026 12:49:14 +0100
Message-ID: <20260304114921.31042-8-fw@strlen.de>
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
X-Rspamd-Queue-Id: 8F8E01FF4B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10958-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in
__build_packet_message() to avoid touching sk->sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_log.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index b35a90955e2e..730c2541a849 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -611,19 +611,26 @@ __build_packet_message(struct nfnl_log_net *log,
 	/* UID */
 	sk = skb->sk;
 	if (sk && sk_fullsock(sk)) {
-		read_lock_bh(&sk->sk_callback_lock);
-		if (sk->sk_socket && sk->sk_socket->file) {
-			struct file *file = sk->sk_socket->file;
+		const struct socket *sock;
+		const struct file *file;
+
+		/* The sk pointer remains valid as long as the skb is.
+		 * The sk_socket and file pointer may become NULL
+		 * if the socket is closed.
+		 * Both structures (including file->cred) are RCU freed
+		 * which means they can be accessed within a RCU read section.
+		 */
+		sock = READ_ONCE(sk->sk_socket);
+		file = sock ? READ_ONCE(sock->file) : NULL;
+		if (file) {
 			const struct cred *cred = file->f_cred;
 			struct user_namespace *user_ns = inst->peer_user_ns;
 			__be32 uid = htonl(from_kuid_munged(user_ns, cred->fsuid));
 			__be32 gid = htonl(from_kgid_munged(user_ns, cred->fsgid));
-			read_unlock_bh(&sk->sk_callback_lock);
 			if (nla_put_be32(inst->skb, NFULA_UID, uid) ||
 			    nla_put_be32(inst->skb, NFULA_GID, gid))
 				goto nla_put_failure;
-		} else
-			read_unlock_bh(&sk->sk_callback_lock);
+		}
 	}
 
 	/* local sequence number */
-- 
2.52.0


