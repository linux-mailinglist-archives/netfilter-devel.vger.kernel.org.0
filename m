Return-Path: <netfilter-devel+bounces-12817-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHA7LE6VFGpfOgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12817-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 20:30:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308F5CDA9C
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B3D3027B6D
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531433ADAF;
	Mon, 25 May 2026 18:29:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B636074D;
	Mon, 25 May 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733775; cv=none; b=XOssDQZIdatmpNFM+TY+mYNA2wW51X9eBselaQy0DlMmdnWUR9FbK2stBipTuDswao2+EnoRYLlDQ3Q99STlvlsOWt9Y4Fnje9P4WgRnU/a+2ZB67yMHRmUeyOXrxivBBTOetjc876iozR7XRVqMbnjYWzb/DthUEkamB3y9JQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733775; c=relaxed/simple;
	bh=7uMURCew3Jk+SiEzw4qGvlTxeNHwvso4BA/1ZGF9wx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsVqTQRa3wLMVo/iMpvz0fQ7Vf59pumFzUYZfAPXWVsPq7uIi2nnc6ReLevmqbzDwUiaDHmaQg6Hy9Ez+0kJplTRRszZA+5MTsuIO8MFsJP7Q2a8w6p1cbB6hciuKLY+CO+DnVaO+SDz0eQsXC+kM6MdV2gibiL3le4u1feBzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B09896068A; Mon, 25 May 2026 20:29:32 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 01/11] netfilter: x_tables: disable 32bit compat interface in user namespaces
Date: Mon, 25 May 2026 20:29:14 +0200
Message-ID: <20260525182924.28456-2-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-12817-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5308F5CDA9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This feature is required to use 32bit arp/ip/ip6/ebtables binaries on
64bit kernels.  I don't think there are many users left.

Support has been a compile-time option since 2021 and defaults to off
since 2023.

The XTABLES_COMPAT config option is already off in many distributions
including Debian and Fedora.

Give a few more months before complete removal but disable support in
user namespaces already.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/x_tables.h | 17 +++++++++++++++++
 net/bridge/netfilter/ebtables.c    |  4 ++++
 net/ipv4/netfilter/arp_tables.c    |  4 ++++
 net/ipv4/netfilter/ip_tables.c     |  4 ++++
 net/ipv6/netfilter/ip6_tables.c    |  4 ++++
 5 files changed, 33 insertions(+)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index 5a1c5c336fa4..20d70dddbe50 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -534,4 +534,21 @@ int xt_compat_check_entry_offsets(const void *base, const char *elems,
 				  unsigned int next_offset);
 
 #endif /* CONFIG_NETFILTER_XTABLES_COMPAT */
+
+static inline bool xt_compat_check(void)
+{
+#ifdef CONFIG_NETFILTER_XTABLES_COMPAT
+	if (!in_compat_syscall())
+		return true;
+
+	pr_warn_once("%s %s\n",
+		     "xtables 32bit compat interface no longer supported",
+		     "in namespaces and will be removed soon.");
+
+	if (!capable(CAP_NET_ADMIN))
+		return false;
+#endif
+	return true;
+}
+
 #endif /* _X_TABLES_H */
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index b9f4daac09af..8d8f1a7c9ad5 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2455,6 +2455,8 @@ static int do_ebt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 
 	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 	/* try real handler in case userland supplied needed padding */
@@ -2520,6 +2522,8 @@ static int do_ebt_set_ctl(struct sock *sk, int cmd, sockptr_t arg,
 
 	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case EBT_SO_SET_ENTRIES:
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index ad2259678c78..341ae049e5a2 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -1430,6 +1430,8 @@ static int do_arpt_set_ctl(struct sock *sk, int cmd, sockptr_t arg,
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case ARPT_SO_SET_REPLACE:
@@ -1458,6 +1460,8 @@ static int do_arpt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case ARPT_SO_GET_INFO:
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 5cbdb0815857..f917a9004a01 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1624,6 +1624,8 @@ do_ipt_set_ctl(struct sock *sk, int cmd, sockptr_t arg, unsigned int len)
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case IPT_SO_SET_REPLACE:
@@ -1653,6 +1655,8 @@ do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case IPT_SO_GET_INFO:
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 9d9c3763f2f5..ecf79d05a51b 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1633,6 +1633,8 @@ do_ip6t_set_ctl(struct sock *sk, int cmd, sockptr_t arg, unsigned int len)
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case IP6T_SO_SET_REPLACE:
@@ -1662,6 +1664,8 @@ do_ip6t_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
+	if (!xt_compat_check())
+		return -EPERM;
 
 	switch (cmd) {
 	case IP6T_SO_GET_INFO:
-- 
2.53.0


