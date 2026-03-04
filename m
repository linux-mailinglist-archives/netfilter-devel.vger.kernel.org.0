Return-Path: <netfilter-devel+bounces-10959-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD65F6AcqGnyoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10959-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 023051FF4C8
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F3AA304F024
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C688371872;
	Wed,  4 Mar 2026 11:50:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CE3A8729;
	Wed,  4 Mar 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625009; cv=none; b=jEwye2Sb+UlA6OzxntvfIM9Jm0xd4U9M9kWxeF3WF8YcfS146pP1UTp0dMf3v4cfiXztg9iX/7RM/clbQoxCe04gB+iiVDo3gSLIpw7zFjP48Foo+V1vT5zxEvfiSrYEQ70VYT5CsSZPpE2eVUmr53+GS3+QyJ6j8/+Iu2ROgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625009; c=relaxed/simple;
	bh=IESuYyoyRFq5VQD1768CJKIUK5Q1SnpOrdQ13h7CO8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDZ8+63CpKA/h6rPxCZc3UJfdl9fjyEKqfVrS5e1wZ/3hak/6j0/6fIQzi8BxgauqyGguPFuMUoPpzlejPeGeEYp2lbgkEJbKP1AWQ3WPzEvia2T28wE4j7suW/5W1TGlaq+Trv+eTBAsLGugmvmh42ISeX6Q5nY/4rlwDiGINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D489360499; Wed, 04 Mar 2026 12:50:04 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 08/14] netfilter: nfnetlink_queue: no longer acquire sk_callback_lock
Date: Wed,  4 Mar 2026 12:49:15 +0100
Message-ID: <20260304114921.31042-9-fw@strlen.de>
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
X-Rspamd-Queue-Id: 023051FF4C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10959-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in
nfqnl_put_sk_uidgid() to avoid touching sk->sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_queue.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 7f5248b5f1ee..27300d3663da 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -545,14 +545,23 @@ nfqnl_put_packet_info(struct sk_buff *nlskb, struct sk_buff *packet,
 
 static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 {
+	const struct socket *sock;
+	const struct file *file;
 	const struct cred *cred;
 
 	if (!sk_fullsock(sk))
 		return 0;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	if (sk->sk_socket && sk->sk_socket->file) {
-		cred = sk->sk_socket->file->f_cred;
+	/* The sk pointer remains valid as long as the skb is.
+	 * The sk_socket and file pointer may become NULL
+	 * if the socket is closed.
+	 * Both structures (including file->cred) are RCU freed
+	 * which means they can be accessed within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (file) {
+		cred = file->f_cred;
 		if (nla_put_be32(skb, NFQA_UID,
 		    htonl(from_kuid_munged(&init_user_ns, cred->fsuid))))
 			goto nla_put_failure;
@@ -560,11 +569,9 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 		    htonl(from_kgid_munged(&init_user_ns, cred->fsgid))))
 			goto nla_put_failure;
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
 	return 0;
 
 nla_put_failure:
-	read_unlock_bh(&sk->sk_callback_lock);
 	return -1;
 }
 
-- 
2.52.0


