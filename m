Return-Path: <netfilter-devel+bounces-11270-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNLQEfOqumn9aQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11270-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 14:38:59 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA52BC315
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 14:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C99A300989A
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D823D88F0;
	Wed, 18 Mar 2026 13:38:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CF31353B
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841137; cv=none; b=iPtKx3wZsxJzJxTM37h4Ud962a/4vXeFgQgh54obkGqB8P8tf3EfyJdlIhStMLfVI/EEwbRS4VnvmMK1GxUqWMLckc5YUU1ZtgouJj4ZbE/5UmtSVQUQlJodApgrPGuKexw+9AJxffKAeV6x5/OEYnQSepavTYlxqYR3ZxJxCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841137; c=relaxed/simple;
	bh=EJuP/OxzZQ5hmNNJ4qM0cHEavix/d8zMB/GPo11ntsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lz2CDKdLiLoOfgPMk1b1VeAcBotdZD2aKTYfRGg50TEhhXz32n3gvOl+y3GzTcy1wsK1wbKgQjJmkbEToM1z4Hdc/3AI7aulIdYKQro2zKlooD6h+mGHquenSW8F284JHLrZdVfQ70igrrZ1s9XeJ2Wa4aOcKyMtgpDF+S24vXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7D54A605C3; Wed, 18 Mar 2026 14:38:53 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nft_set_pipapo: increment data in one step
Date: Wed, 18 Mar 2026 14:38:34 +0100
Message-ID: <20260318133840.1334-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11270-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.922];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: E9DA52BC315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For unkown reason the C version increments the data pointer in two steps.
Switch to a single invocation of NFT_PIPAPO_GROUPS_PADDED_SIZE() helper,
like the avx2 implementation.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7fd24e0cc428..50d4a4f04309 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -452,8 +452,6 @@ static struct nft_pipapo_elem *pipapo_get_slow(const struct nft_pipapo_match *m,
 			pipapo_and_field_buckets_4bit(f, res_map, data);
 		NFT_PIPAPO_GROUP_BITS_ARE_8_OR_4;
 
-		data += f->groups / NFT_PIPAPO_GROUPS_PER_BYTE(f);
-
 		/* Now populate the bitmap for the next field, unless this is
 		 * the last field, in which case return the matched 'ext'
 		 * pointer if any.
@@ -498,7 +496,7 @@ static struct nft_pipapo_elem *pipapo_get_slow(const struct nft_pipapo_match *m,
 		map_index = !map_index;
 		swap(res_map, fill_map);
 
-		data += NFT_PIPAPO_GROUPS_PADDING(f);
+		data += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
 	}
 
 	__local_unlock_nested_bh(&scratch->bh_lock);
-- 
2.52.0


