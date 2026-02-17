Return-Path: <netfilter-devel+bounces-10790-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CVBHr5XlGkXDAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10790-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Feb 2026 12:57:50 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F714BACE
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Feb 2026 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E06EE3045E1F
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Feb 2026 11:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6102337105;
	Tue, 17 Feb 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="SexMZLO8"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19C335562
	for <netfilter-devel@vger.kernel.org>; Tue, 17 Feb 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329406; cv=none; b=uy4FpCX2PvzdFLQB2zcZ+C/uPafE2A3aHVHLX4C+KSnRK2+jybMoxUFM7Giso4JE6eM2/D+pIhyA0duQg+wjCbPhKiFMPjbagvL5ZSD1LlFhcbQ6798kBjtsWI7SyEk2By7vR+UY/boOr+SzWXK39VICjwJS6rTgUov0gLpJTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329406; c=relaxed/simple;
	bh=X4U5y36REp1rnlqIvFZdqx+2I6jkwub8+8tRaYx0Eq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZavRREuZq08SPbD41qFRnWIp7EPCyaUwZTg3ZobYf+keRcfd2SRcHG2etAmyYsXuXkTbx1FU/RDLw5uXAnFqYdbQ3Nm/4IA/0gPzO0Fe8H3hK1qHkh//qfNMQycGhTVpwoV3FtNV4bq+da4+qTATCIXHZsQsJ1L10h8/nsaWqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=SexMZLO8; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 74A1760253;
	Tue, 17 Feb 2026 12:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1771329402;
	bh=O2KMcwLtbgkUMp153f8TYhMCJ7dlCpYdyRGyoZYZ/A4=;
	h=From:To:Cc:Subject:Date:From;
	b=SexMZLO8U4LnP0TVykrC7aVXrgSzNwdXZGGxhiXnPf9n9n4iHOao5Ci6/78YPA2qx
	 0Bt2J2VkI3bLcgeIVoYAkEqEABQzZO8jKYWHCsZxa1f83xd92zrX0K1BEenDpoOJHM
	 tFDWQu4YoG8xOjIRhz5vD0yv4Fr6mauRHpv5jbmCtBDq93+oa8pc/LXpR0dzVceJXT
	 gJH1Cvoc/GW78EKv81X/oukntBJPgHyRn647L5R4XkKcw8uHbDGA806V95xSmckgSf
	 ydex+grlwsJa52AVP4zgOlnQn7ZLN4Kk1JN5eLtUH5KW2OI+8oXJKHRqzf3A0ciZor
	 JBNbdCVmUKNRQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf] net: remove WARN_ON_ONCE when accessing forward path array
Date: Tue, 17 Feb 2026 12:56:39 +0100
Message-ID: <20260217115639.1863946-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10790-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:mid,netfilter.org:dkim,netfilter.org:email]
X-Rspamd-Queue-Id: 0D4F714BACE
X-Rspamd-Action: no action

Although unlikely, recent support for IPIP tunnels increases chances of
reaching this WARN_ON_ONCE if userspace manages to build a sufficiently
long forward path.

Remove it.

Fixes: ddb94eafab8b ("net: resolve forwarding path from virtual netdevice and HW destination address")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
This infrastructure is only used by netfilter's flowtable at this stage,
so I suggest the nf.git tree for this fix.

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ac6bcb2a0784..a8d5b0b1adc8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -737,7 +737,7 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
 {
 	int k = stack->num_paths++;
 
-	if (WARN_ON_ONCE(k >= NET_DEVICE_PATH_STACK_MAX))
+	if (k >= NET_DEVICE_PATH_STACK_MAX)
 		return NULL;
 
 	return &stack->path[k];
-- 
2.47.3


