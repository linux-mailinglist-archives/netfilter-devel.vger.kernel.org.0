Return-Path: <netfilter-devel+bounces-12156-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOw3ACwL6mn4sgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12156-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 14:06:04 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96503451BF4
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 14:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7C503006126
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E33E95A9;
	Thu, 23 Apr 2026 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvVM/Zd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eqsjOlK7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvVM/Zd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eqsjOlK7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3D3E92A6
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945956; cv=none; b=Fczfk2fuKmXDYJTJqSq61Y+V62W6fsCyiDSkVzvSINGEcatRnQ/NBkHUZ/T1rT2VcZMPoq+oD0NVmM9zOekD5i2Vv/+391RyqBEAEP/hlLbXsa81EuwiwxaDCmSERjnMPbAtvLvXwkzMBO568+LunIfaCC2ZJplNqZsA64JSa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945956; c=relaxed/simple;
	bh=pCmsWTC+0RpL+OgNt/TAQMIpuTKY3IwVkxJNfvFTRhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/jQFVxnnYT3lIhLTrICDCyrBEBu8pLBckGlRfpYSvUzK9cwoL0kPHjJtZciFS2yLq+rPjESye9YdhrE2x+9/0U9TQBWi1s/0i0Xk3RgmerQdbrL72yZ/j/dNSPDigfydiGVfbAwX1i8GaQAiiftVv2LYTCA1kAg4iJbsCfgKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RvVM/Zd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eqsjOlK7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RvVM/Zd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eqsjOlK7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 790195BD73;
	Thu, 23 Apr 2026 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776945953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y2iBU6iAY+1cqJm0GdfBUtyCpQMeHLN7r9J8bY5zTI0=;
	b=RvVM/Zd5e5m3CfouqoElCTCGOlOUyFi2u5lpjSY3HbLMJJX7LV2KsiMHdsrQJJQxOB2LvQ
	yaqins7J/b6Fl9K2SfsrWRejAQmG/+lD319/cZYJwlEnToLgfet4ShfB4WdnJhZTxWvmHE
	ApZ077YHw/qVJBdEQoTkjvmInW3I6RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776945953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y2iBU6iAY+1cqJm0GdfBUtyCpQMeHLN7r9J8bY5zTI0=;
	b=eqsjOlK7xJijwMwTrzLP7UV82xOYrHMnKlfe8vn3t2DDnkvYvSnraMYY+hXRrOj0SS7naw
	3OtOsv4PEm0ReGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776945953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y2iBU6iAY+1cqJm0GdfBUtyCpQMeHLN7r9J8bY5zTI0=;
	b=RvVM/Zd5e5m3CfouqoElCTCGOlOUyFi2u5lpjSY3HbLMJJX7LV2KsiMHdsrQJJQxOB2LvQ
	yaqins7J/b6Fl9K2SfsrWRejAQmG/+lD319/cZYJwlEnToLgfet4ShfB4WdnJhZTxWvmHE
	ApZ077YHw/qVJBdEQoTkjvmInW3I6RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776945953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y2iBU6iAY+1cqJm0GdfBUtyCpQMeHLN7r9J8bY5zTI0=;
	b=eqsjOlK7xJijwMwTrzLP7UV82xOYrHMnKlfe8vn3t2DDnkvYvSnraMYY+hXRrOj0SS7naw
	3OtOsv4PEm0ReGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D2A8593A3;
	Thu, 23 Apr 2026 12:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fXh1ACEL6mm5VAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 23 Apr 2026 12:05:53 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	jeremy@azazel.net,
	phil@nwl.cc,
	fw@strlen.de,
	pablo@netfilter.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH nf v2] netfilter: nft_bitwise: fix dst corruption in same register shifts
Date: Thu, 23 Apr 2026 14:05:38 +0200
Message-ID: <20260423120538.3704-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12156-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 96503451BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In nft_bitwise_eval_lshift() and nft_bitwise_eval_rshift(), shift
operations are performed in a loop over 32-bit words. The loop
calculates the shifted value, writes it to dst, and calculates the carry
from src for the next iteration.

If the source and destination registers overlap either exactly (sreg ==
dreg) or partially (e.g., dreg is offset from sreg by 4 bytes) the loop
overwrites src data before it can be read by subsequent iterations. This
causes the carry or the shifted data itself to be incorrectly calculated
using the newly modified dst value instead of the original src payload.

Fix this by separating the calculation and assignment phases. Evaluate
the shift into a temporary local array and then copy the final results
into dst. This completely decouples the memory reads from the memory
writes, safely supporting any register overlap configuration without
corrupting the payload.

This was tested for both partial and exact overlaps with the following
bytecode:

table test_table ip flags 0 use 1 handle 1
ip test_table test_chain use 3 type filter hook input prio 0 policy accept packets 0 bytes 0 flags 1
ip test_table test_chain 2
  [ immediate reg 1 0xaaaaaaaa 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 9 << 0x08000000 ) ]
  [ cmp eq reg 1 0x55008877 0x00887766 ]
  [ counter pkts 0 bytes 0 ]
ip test_table test_chain 3 2
  [ immediate reg 1 0xaaaaaaaa 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 9 << 0x08000000 ) ]
  [ cmp eq reg 1 0x55443322 0x00887766 ]
  [ counter pkts 1511 bytes 133128 ]
ip test_table test_chain 4 3
  [ immediate reg 1 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
  [ cmp eq reg 1 0x55443322 0x00887766 ]
  [ counter pkts 109 bytes 9548 ]
ip test_table test_chain 5 4
  [ immediate reg 1 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
  [ cmp eq reg 1 0x66443322 0x00887766 ]
  [ counter pkts 0 bytes 0 ]

Fixes: 567d746b55bc ("netfilter: bitwise: add support for shifts.")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handle partially register overlap too
---
 net/netfilter/nft_bitwise.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 13808e9cd999..27fc09ec0e11 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -38,27 +38,35 @@ static void nft_bitwise_eval_mask_xor(u32 *dst, const u32 *src,
 static void nft_bitwise_eval_lshift(u32 *dst, const u32 *src,
 				    const struct nft_bitwise *priv)
 {
+	unsigned int i, n = DIV_ROUND_UP(priv->len, sizeof(u32));
 	u32 shift = priv->data.data[0];
-	unsigned int i;
+	u32 res[NFT_REG_SIZE];
 	u32 carry = 0;
 
-	for (i = DIV_ROUND_UP(priv->len, sizeof(u32)); i > 0; i--) {
-		dst[i - 1] = (src[i - 1] << shift) | carry;
+	for (i = n; i > 0; i--) {
+		res[i - 1] = (src[i - 1] << shift) | carry;
 		carry = src[i - 1] >> (BITS_PER_TYPE(u32) - shift);
 	}
+
+	for (i = 0; i < n; i++)
+		dst[i] = res[i];
 }
 
 static void nft_bitwise_eval_rshift(u32 *dst, const u32 *src,
 				    const struct nft_bitwise *priv)
 {
+	unsigned int i, n = DIV_ROUND_UP(priv->len, sizeof(u32));
 	u32 shift = priv->data.data[0];
-	unsigned int i;
+	u32 res[NFT_REG_SIZE];
 	u32 carry = 0;
 
-	for (i = 0; i < DIV_ROUND_UP(priv->len, sizeof(u32)); i++) {
-		dst[i] = carry | (src[i] >> shift);
+	for (i = 0; i < n; i++) {
+		res[i] = carry | (src[i] >> shift);
 		carry = src[i] << (BITS_PER_TYPE(u32) - shift);
 	}
+
+	for (i = 0; i < n; i++)
+		dst[i] = res[i];
 }
 
 static void nft_bitwise_eval_and(u32 *dst, const u32 *src, const u32 *src2,
-- 
2.53.0


