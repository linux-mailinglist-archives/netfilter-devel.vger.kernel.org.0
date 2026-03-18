Return-Path: <netfilter-devel+bounces-11271-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC2BD8yrumn9aQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11271-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 14:42:36 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E22F42BC3BC
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 14:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C08F300D4D6
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9B3D7D89;
	Wed, 18 Mar 2026 13:42:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB206397688
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841353; cv=none; b=SqIrDPfLQ/UbHtdjlYzCoHEGBpINs8mWDPjOhpBPqHJZqEveMBpwCwUUYfMZ7WgfqYWGLiCtJhF8sCT5/1IF1SL4LZvB+PNAmys3YQvzt/LJHrtETw5c9UkPK3OVC5jxk8SRdt0sD1ORRZNP0xb/tKsEK9hsRWDlh+YBkc/HZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841353; c=relaxed/simple;
	bh=T1XzOgibSpPcuohMT0Yc8MEy4n8MMWGvlALcPE0GOl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rk5l0b1dNoREIKPiFol0IySi9/4tJ8fRS1VzGleiQATFnUU7Vh6+9HqAo4zhWYn4PgsA0tG3WcQnaxwlQi1NPZzb6o17kKAx/ZFeYz7nSoU3lkCX+U+yx+YG53+nXfHZm1L6upKoeGm2wAjhTE7vu37jG4kU/sDWi7iLwr0keD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 510DB605C3; Wed, 18 Mar 2026 14:42:30 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nft_set_pipapo_avx2: remove redundant loop in lookup_slow
Date: Wed, 18 Mar 2026 14:42:12 +0100
Message-ID: <20260318134217.1596-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11271-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: E22F42BC3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nft_pipapo_avx2_lookup_slow will never be used in reality, because the
common sizes are handled by avx2 optimized versions.

However, nft_pipapo_avx2_lookup_slow loops over the data just like the
avx2 functions. BUT _slow doesn't need to do that:
  pipapo_and_field_buckets_() + pipapo_refill() already handle
  everyhing for us.

All other iterations boild down to 'x = x & x': Remove the loop.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo_avx2.c | 30 ++++++++---------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 7ff90325c97f..025f9ebb1ba2 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1041,7 +1041,6 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
  * @map:	Previous match result, used as initial bitmap
  * @fill:	Destination bitmap to be filled with current match result
  * @f:		Field, containing lookup and mapping tables
- * @offset:	Ignore buckets before the given index, no bits are filled there
  * @pkt:	Packet data, pointer to input nftables register
  * @first:	If this is the first field, don't source previous result
  * @last:	Last field: stop at the first match and return bit index
@@ -1056,32 +1055,19 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 static int nft_pipapo_avx2_lookup_slow(const struct nft_pipapo_match *mdata,
 					unsigned long *map, unsigned long *fill,
 					const struct nft_pipapo_field *f,
-					int offset, const u8 *pkt,
+					const u8 *pkt,
 					bool first, bool last)
 {
-	unsigned long bsize = f->bsize;
-	int i, ret = -1, b;
-
 	if (first)
 		pipapo_resmap_init(mdata, map);
 
-	for (i = offset; i < bsize; i++) {
-		if (f->bb == 8)
-			pipapo_and_field_buckets_8bit(f, map, pkt);
-		else
+	if (f->bb == 8)
+		pipapo_and_field_buckets_8bit(f, map, pkt);
+	else
 			pipapo_and_field_buckets_4bit(f, map, pkt);
-		NFT_PIPAPO_GROUP_BITS_ARE_8_OR_4;
-
-		b = pipapo_refill(map, bsize, f->rules, fill, f->mt, last);
-
-		if (last)
-			return b;
-
-		if (ret == -1)
-			ret = b / XSAVE_YMM_SIZE;
-	}
+	NFT_PIPAPO_GROUP_BITS_ARE_8_OR_4;
 
-	return ret;
+	return pipapo_refill(map, f->bsize, f->rules, fill, f->mt, last);
 }
 
 /**
@@ -1201,7 +1187,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 				NFT_SET_PIPAPO_AVX2_LOOKUP(8, 16);
 			} else {
 				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
-								  ret, data,
+								  data,
 								  first, last);
 			}
 		} else {
@@ -1217,7 +1203,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 				NFT_SET_PIPAPO_AVX2_LOOKUP(4, 32);
 			} else {
 				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
-								  ret, data,
+								  data,
 								  first, last);
 			}
 		}
-- 
2.52.0


