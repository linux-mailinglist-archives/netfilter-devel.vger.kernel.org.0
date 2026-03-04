Return-Path: <netfilter-devel+bounces-10955-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DUJGbUcqGnyoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10955-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:51:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5FB1FF4ED
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CDE6309417C
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2DD39EF04;
	Wed,  4 Mar 2026 11:49:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE038C2BD;
	Wed,  4 Mar 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624990; cv=none; b=Ka890A5LIki4cxNHJFsVUmK0a0eD2bZYMOitQfV/J8jGm2/4e/R5BfoOGBEbU/v8r3PVBOrY7hzTl0lGDxm1U/9XMlzwqquxovKcvYNl9N9Z6coGZ1oXdJjMXA0MI4w9RPDO7/tkvy7hwDrWdqXTEAEPk4J25PM/pSUK1hlL/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624990; c=relaxed/simple;
	bh=TuCsOZUN1adO9zguBW3T0kou2cWHPkKd9L0iAyqKmq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1P8oAqRGvrajDZd5SiXr13bYBtZbwnKk4rRVfqfGgOf8DMuzeoP3pVxz1JJX7LQpE3ICfSO2C+Iy6xfC9u+Afg3e8HcH/ZWWQQHnR+7B+en8qK+lZOLRdMO9ypl9iSFNI6TaOeOmBaDfD6eOPaFtAgT1AysbOmv6FjKQE5Lt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6A82A6026E; Wed, 04 Mar 2026 12:49:47 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 04/14] netfilter: nf_log_syslog: no longer acquire sk_callback_lock in nf_log_dump_sk_uid_gid()
Date: Wed,  4 Mar 2026 12:49:11 +0100
Message-ID: <20260304114921.31042-5-fw@strlen.de>
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
X-Rspamd-Queue-Id: CC5FB1FF4ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10955-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in nf_log_dump_sk_uid_gid()
to avoid touching sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_log_syslog.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 41503847d9d7..0507d67cad27 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -165,18 +165,26 @@ static struct nf_logger nf_arp_logger __read_mostly = {
 static void nf_log_dump_sk_uid_gid(struct net *net, struct nf_log_buf *m,
 				   struct sock *sk)
 {
+	const struct socket *sock;
+	const struct file *file;
+
 	if (!sk || !sk_fullsock(sk) || !net_eq(net, sock_net(sk)))
 		return;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	if (sk->sk_socket && sk->sk_socket->file) {
-		const struct cred *cred = sk->sk_socket->file->f_cred;
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (file) {
+		const struct cred *cred = file->f_cred;
 
 		nf_log_buf_add(m, "UID=%u GID=%u ",
 			       from_kuid_munged(&init_user_ns, cred->fsuid),
 			       from_kgid_munged(&init_user_ns, cred->fsgid));
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static noinline_for_stack int
-- 
2.52.0


