Return-Path: <netfilter-devel+bounces-13116-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fElQJoCTJmrpYwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13116-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 12:03:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F12654D44
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 12:03:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="icsD6X Z";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13116-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13116-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E77823074C82
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89BC3BCD29;
	Mon,  8 Jun 2026 09:55:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A23B8930;
	Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=iJ9hrhz814iQ9s6fIwK2Hg4L1wBL6PDwChlVAVhf+SMRff2/s0SowlCNQpSzUXRAV9FekQ3ksNJHczTcM+eku0BDIE2UBXxT8APmT/oMRurxYgT6GD7fTHl4+rkgIiOkghbFA3SHYawfcjwTAzqkYI0gNy35NXhhxUTYx6mCoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=g2a+0peurYc++lj+MTJ+qK/QF5LhOp9QgWJzFwBQQ60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZy/PBmZ8IgIUEryjtzVSNM5YORLg+DlCm59Bvb7/56o3EOO5TKF0YNV+fm51nx/z+d+FRrbLeQ6a0thhEq6wKBnLhcnXLpI9HEh1PrKLKp8eCR6mw849GsyHddulBpZBC9ItyEPvxbTZBWBiVAJ0ylRPdlthWeWYZS4iJ2jnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=icsD6XZk; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-00BRyo-Iq; Mon, 08 Jun 2026 11:55:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=hOyVQeN0Zn21ZxnkGr2+7/wIdoUqTpMPv9PBDwl37z8=; b=icsD6X
	ZkBw0g9gkjA2bR0nerz7qipgEDZlx622c1sGNma5VNqMwp8twyiTzSNQN40T/brnpdSc/dZy3sHAl
	ypKCCU0BNqgnJ6Ka7eBqltikYiGzd6LkrGkSpes2MK0ARnItbFL98wY+Mq9nYQQhd57Ay0LxqzgGb
	PROGritLv9BwBXjgQRex+JVm7fGTBpIPB6jpAtJmrvWmj0vS1OOnkWYI1U5W/DUrhEmk3CdeBIBEi
	BltFpMCCL8ATz+zGqNJYjLUDs7j5CCZH0LsptJK4qSacOz3th9Bv0xZ8IAfKR5/kfAOUvZ8h4Rq8p
	Ae39CjVBliW0lGuOw6AtovHnaVHA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-0003ed-HD; Mon, 08 Jun 2026 11:55:41 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhf-00Ag6G-K8;
	Mon, 08 Jun 2026 11:55:31 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/netfilter/nfnetlink_cttimeout: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:59 +0100
Message-Id: <20260608095523.2606-15-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13116-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:arnd@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:fw@strlen.de,m:kuba@kernel.org,m:pablo@netfilter.org,m:pabeni@redhat.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netfilter-devel@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,strlen.de,netfilter.org,redhat.com,gmail.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02F12654D44

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/netfilter/nfnetlink_cttimeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index dca6826af7de..7ed14accff22 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -165,7 +165,7 @@ static int cttimeout_new_timeout(struct sk_buff *skb,
 	if (ret < 0)
 		goto err;
 
-	strcpy(timeout->name, nla_data(cda[CTA_TIMEOUT_NAME]));
+	strscpy(timeout->name, nla_data(cda[CTA_TIMEOUT_NAME]));
 	timeout->timeout.l3num = l3num;
 	timeout->timeout.l4proto = l4proto;
 	refcount_set(&timeout->refcnt, 1);
-- 
2.39.5


