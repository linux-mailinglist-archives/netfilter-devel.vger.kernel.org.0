Return-Path: <netfilter-devel+bounces-10510-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BFFEJtpe2lEEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10510-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:07:23 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D0B0AF8
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70F493004DF6
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA637417B;
	Thu, 29 Jan 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="EI4J+Miv"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953721D3C5
	for <netfilter-devel@vger.kernel.org>; Thu, 29 Jan 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695638; cv=none; b=VyGA7pIYq/MtpJmB6Pnsse2H59mvdiW7Md3zYa/QnqEDDFQcm6RQgxjyXGEUJ5krZYweHKWSwxet6PiS4m4vtqz5U7U5o3UNVNstVp0GD7iplad5akaP2g641L4pZml4iBkL4yZ7dNkD3GwWEXApUGIV92dbl9kVyiliYco4nSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695638; c=relaxed/simple;
	bh=KxFmhi3OvX+vFqEjc+4fiMGG7EJOZRtA/Zc/KHkKfOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoFpEbt/eUAxGHhLQMtScujf32FhfPUR8Wa5EyVTd5ePEWNoQYDDr1AyFpY+tiHVbNsqpqpJhWufIpAWZ1OCLYPJVdhjZvIUQWVeuF9cFKjIbMsfY42feQaa5VXBLdyxbRGd3d5rKJUKOkOacnzUKtrJy8qLG8f0EyODWXMQ3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=EI4J+Miv; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p/fXXall3QpLds8Te05nVYNn2aGsPopw6XjuaYg1mFE=; b=EI4J+MivCiojrD3CVpNw5Trt4R
	zsh0LoWK8tClbn+B1A98Hg64gU/xqbc9VHTorUMb/duIzm+ynwOTUzgxq0gwFx9fiFQ7WDyodzTl2
	Tlt9vrkaWH18XzN4aLgOd3ynEeSNy1UBHullVYoxi9EF48tKhGF60L3T9HHXxXoqZpbDl6k7+DWuv
	FhVpC9FOZgLpiDiT0LFb6CFvyjWUVP/ivcEkFyGrCFS6ewbATWDHnw3xrhMAjR9PV7tNknRPMH2N+
	ogo2BRqqAPxLEwH4X+1SbmAmMr22pkPkzHztTdKjoqqvjbVIrkgw5pvaYs1/M+2WapvZ+dLqf+gbe
	+PamUN+w==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vlSfx-000000001M2-0QTR;
	Thu, 29 Jan 2026 15:07:13 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [libnftnl PATCH 1/2] Revert "udata: Store u32 udata values in Big Endian"
Date: Thu, 29 Jan 2026 15:07:06 +0100
Message-ID: <20260129140707.10025-1-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10510-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nwl.cc:mid,nwl.cc:email]
X-Rspamd-Queue-Id: 5E3D0B0AF8
X-Rspamd-Action: no action

This reverts commit f20dfa7824860a9ac14425a3f7ca970a6c981597.

This change to payload (interpretation) is problematic with package
updates at run-time: The new version might trip over userdata in the
running ruleset, avoid this.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/udata.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/udata.c b/src/udata.c
index 8cf4e7ca61e2f..a1956571ef5fd 100644
--- a/src/udata.c
+++ b/src/udata.c
@@ -8,7 +8,6 @@
 #include <udata.h>
 #include <utils.h>
 
-#include <arpa/inet.h>
 #include <stdlib.h>
 #include <stdint.h>
 #include <string.h>
@@ -101,9 +100,7 @@ EXPORT_SYMBOL(nftnl_udata_put_u32);
 bool nftnl_udata_put_u32(struct nftnl_udata_buf *buf, uint8_t type,
 			 uint32_t data)
 {
-	uint32_t data_be = htonl(data);
-
-	return nftnl_udata_put(buf, type, sizeof(data_be), &data_be);
+	return nftnl_udata_put(buf, type, sizeof(data), &data);
 }
 
 EXPORT_SYMBOL(nftnl_udata_type);
@@ -131,7 +128,7 @@ uint32_t nftnl_udata_get_u32(const struct nftnl_udata *attr)
 
 	memcpy(&data, attr->value, sizeof(data));
 
-	return ntohl(data);
+	return data;
 }
 
 EXPORT_SYMBOL(nftnl_udata_next);
-- 
2.51.0


