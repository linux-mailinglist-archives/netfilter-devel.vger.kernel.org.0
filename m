Return-Path: <netfilter-devel+bounces-13731-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4i2LgZaTmqNLAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13731-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 16:09:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECD7271F6
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 16:09:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13731-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13731-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22147305CDC0
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561941B34C;
	Wed,  8 Jul 2026 14:03:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07E4189C5;
	Wed,  8 Jul 2026 14:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519410; cv=none; b=R/OXTfNxJhpsib94486rPNagOBWFXpXXpZOZp2Bs+DkMMQvK5HP52bOBkWefxBDxjz8BjBCUyu5kaH9cBW65SrNAU4kpIZgi4hTSqM9jT0Ya08Npr+56Y3qKZeD5uJNGZRSfTeLgW5RuEHwQFv2z+byMljvinC1exnYxBRHRvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519410; c=relaxed/simple;
	bh=MztAl7Gua0MZM+Zd/+9jxM6mCLjLDz/BXESwfXFhGQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSOstRugifPOFIA4yfu2NQNZ7K8UjnvLWkmjGQoHOC5/2rzQbJ6M165nXdy80VIVcjXrHj3+e3FgfgxxqQoHRxYqlq8ZihZjHcgpbkyQxyd4s5/6lP5THZyfbp1frhV+C8jO/O4462DvemrTAsAIu0Dig6xFtcyOA4ASwGELwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C6DA36059E; Wed, 08 Jul 2026 16:03:27 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 02/17] netfilter: ebtables: terminate table name before find_table_lock()
Date: Wed,  8 Jul 2026 16:02:54 +0200
Message-ID: <20260708140309.19633-3-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708140309.19633-1-fw@strlen.de>
References: <20260708140309.19633-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13731-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49ECD7271F6

From: Xiang Mei <xmei5@asu.edu>

update_counters() and compat_update_counters() forward a user-supplied
32-byte table name to find_table_lock() without NUL-terminating it. On a
lookup miss, find_inlist_lock() calls try_then_request_module(..., "%s%s",
"ebtable_", name), and vsnprintf() reads past the name field and the
stack object until it hits a zero byte.

  BUG: KASAN: stack-out-of-bounds in string (lib/vsprintf.c:648 lib/vsprintf.c:730)
  Read of size 1 at addr ffff8880119dfb20 by task exploit/147
  Call Trace:
  ...
   string (lib/vsprintf.c:648 lib/vsprintf.c:730)
   vsnprintf (lib/vsprintf.c:2945)
   __request_module (kernel/module/kmod.c:150)
   do_update_counters.isra.0 (net/bridge/netfilter/ebtables.c:371 net/bridge/netfilter/ebtables.c:380)
   update_counters (net/bridge/netfilter/ebtables.c:1440)
   do_ebt_set_ctl (net/bridge/netfilter/ebtables.c:2573)
   nf_setsockopt (net/netfilter/nf_sockopt.c:101)
   ip_setsockopt (net/ipv4/ip_sockglue.c:1424)
   raw_setsockopt (net/ipv4/raw.c:847)
   __sys_setsockopt (net/socket.c:2393)
  ...

compat_do_replace() shares the same unterminated name via
compat_copy_ebt_replace_from_user(); terminate it there too so all
find_table_lock() callers behave alike. The other callers already
terminate the name after the copy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebtables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index f20c039e44c8..5b74ff827493 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1434,6 +1434,8 @@ static int update_counters(struct net *net, sockptr_t arg, unsigned int len)
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return -EINVAL;
 
@@ -2273,6 +2275,8 @@ static int compat_copy_ebt_replace_from_user(struct ebt_replace *repl,
 
 	memcpy(repl, &tmp, offsetof(struct ebt_replace, hook_entry));
 
+	repl->name[sizeof(repl->name) - 1] = '\0';
+
 	/* starting with hook_entry, 32 vs. 64 bit structures are different */
 	for (i = 0; i < NF_BR_NUMHOOKS; i++)
 		repl->hook_entry[i] = compat_ptr(tmp.hook_entry[i]);
@@ -2395,6 +2399,8 @@ static int compat_update_counters(struct net *net, sockptr_t arg,
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	/* try real handler in case userland supplied needed padding */
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return update_counters(net, arg, len);
-- 
2.54.0


