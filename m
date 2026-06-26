Return-Path: <netfilter-devel+bounces-13480-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2oH+MWhlPmogFQkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13480-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 13:41:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9996CC92B
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 13:41:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="Xzj/x6A7";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13480-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13480-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0D9301F30C
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B23E4C87;
	Fri, 26 Jun 2026 11:40:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78213DBD55
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jun 2026 11:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474048; cv=none; b=BYQhBBVG3tb5+Isu/H1Fs2uRuzhG7FLHyBM/8a/YIqC3ugWHrZRFIXnUGFbLI2v0ZtpebbHDjuAx2ZPouKtumJEwxxrqbsglIWRQYZ1zq4+KgBg9MCNtkDYxBQm5ZE9RCMGDHpznTCwvDbh5xjCkQoNLXmH0B9hvAIovWYbXb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474048; c=relaxed/simple;
	bh=8n/znfvIg9weJ9DTMUBZslAI69/A8W7UE5bRjRqaj40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j+6vejG0/FKkJk5AsGC165JcfjzXsBOM2KMIJelqYJRgsTjlYdvv0eX3uMgXF9Ijce4xsE3OpKb6dU7KPL5c8gIF/1cN9ZT94aZs28Tt5JtEyA26rHNMd9KCUKaXis43+ca0a/QyhLV+9RNQ9KTqa0yCUHsA7Gv/oJvc4fDzhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Xzj/x6A7; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id A34C16058E
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jun 2026 13:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782474045;
	bh=wobwtPb65wrcCSck+ADJCfoY8cx48V37kDXvWxj8/t4=;
	h=From:To:Subject:Date:From;
	b=Xzj/x6A777jaXLHjPGA6rKZeK1TH7MgPzAcCmrYa46JwgrMw3Du+Gg1oLaE/g8+3E
	 o6HHOcSgfVPhNf0Rf1huv3zIj8RsajAzxPUjvjcM/sBSjBlJKXhl/jvT9FvwVIZRFe
	 Ey9HzONYxIdQFuPzYZNV74XBZXL+pjRmwQYihUR7UVs0cYOVcPsi3E3ZturUG0H7FT
	 VugA2jEPyp7Z9DjjD6IOZ6OsaI0hKwpLSFRHpc1Fkn9LMhFSMTN/gN6lPiFdty89Ae
	 Mr3dcaew/fZlO5DaHtzxvQSvNo1sNcvut3CKT/UD0/OoOdljBfaBv02Wpwrkq/eYXo
	 bEnVRZYZrCAAg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master
Date: Fri, 26 Jun 2026 13:40:42 +0200
Message-ID: <20260626114042.849218-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13480-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B9996CC92B

If userspace helper policy updates sets maximum number of expectation to
zero, cap it to NF_CT_EXPECT_MAX_CNT (255) on updates too.

Fixes: 397c8300972f ("netfilter: nf_conntrack_helper: cap maximum number of expectation at helper registration")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
reported by sashiko in the last PR.

 net/netfilter/nfnetlink_cthelper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index f1460b683d7a..2cbcca9110db 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -163,6 +163,8 @@ nfnl_cthelper_expect_policy(struct nf_conntrack_expect_policy *expect_policy,
 		    tb[NFCTH_POLICY_NAME], NF_CT_HELPER_NAME_LEN);
 	expect_policy->max_expected =
 		ntohl(nla_get_be32(tb[NFCTH_POLICY_EXPECT_MAX]));
+	if (!expect_policy->max_expected)
+		expect_policy->max_expected = NF_CT_EXPECT_MAX_CNT;
 	if (expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
-- 
2.47.3


