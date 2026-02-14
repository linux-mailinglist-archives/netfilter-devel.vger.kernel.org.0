Return-Path: <netfilter-devel+bounces-10771-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9kbyKNOPkGlebQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10771-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Feb 2026 16:08:03 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648A13C44C
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Feb 2026 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 026CA3004DDF
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Feb 2026 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA342750ED;
	Sat, 14 Feb 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="RgsbmKTB"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D71C695
	for <netfilter-devel@vger.kernel.org>; Sat, 14 Feb 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081678; cv=none; b=Z9p9/m4eirYl3e9wFh7CxlwGcNq25zTE/PDhdSqPncXX815gNnB2pufZjCKiR0pfdIYpTsEcuNqRsy7VOKoQAdOIMjiPNnom9NL49gpKfJPNTsL/XSEgIn6CVJu2Aw6wwiw0cNc6f1oRIRA1pUYyU7yl2wNalYpazesiq+HCUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081678; c=relaxed/simple;
	bh=qjvhRLP0u2WL5eSecAtAkWDctpXK3Ur7iBUTBtcAw5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcRKOOQwLhPpi8VI9A011xY2s+DgVQBVQ5l8VDzMR55rMVSRXKN2Pf+9fElnq2Xbm1p163npGcCDq300OYhmZZoWf0A3NaFq4qXNbbdGwHe73mkyysy3QfhDjKshb2NTcWvBOkRpG401I9sfjveRAGoiQ5HIaY0X4WtxVcwAm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=RgsbmKTB; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QvBXslcm4SU2m9mrC+oc+x4byiN+H1CtaOnGnICGVtU=; b=RgsbmKTBoeQE+keYSkXMEq4SQy
	qPQvB4K9QMYBWy7JTXl8pis+3ldV4R1XJsSSzeyGLG94IIjLsmDfn2op+vDKjK/SrEtcfynuUxHND
	MGw8aWjmXVtz6P91QyBMq4HZHCUH7te77l0IWfvmeD81UyVEydX+Gmat/4Nh95KGJAvloLYhd5SOu
	OJxGGwsI/1xqqXkSUlr2lxyg/Zvg5SawIlegE6rQ1ORufP3QeukDO7bXShXHkZgoLGU5b0m2LebsV
	ZwNXClvkivbdAFtN6G19oBBv5E/z8YHuGOTOnvp4seQDBC4YcL/JNfrI4APcCcIhOItZtZF3qdZ/s
	PfxSArIw==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vrH2W-000000000P0-1KJC;
	Sat, 14 Feb 2026 15:54:32 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Alyssa Ross <hi@alyssa.is>,
	Florian Westphal <fw@strlen.de>
Subject: [nf PATCH v2] include: uapi: netfilter_bridge.h: Cover for musl libc
Date: Sat, 14 Feb 2026 15:54:06 +0100
Message-ID: <20260214145427.6341-1-phil@nwl.cc>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10771-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:mid,nwl.cc:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alyssa.is:email]
X-Rspamd-Queue-Id: 0648A13C44C
X-Rspamd-Action: no action

Musl defines its own struct ethhdr and thus defines __UAPI_DEF_ETHHDR to
zero. To avoid struct redefinition errors, user space is therefore
supposed to include netinet/if_ether.h before (or instead of)
linux/if_ether.h. To relieve them from this burden, include the libc
header here if not building for kernel space.

Reported-by: Alyssa Ross <hi@alyssa.is>
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Adjust to previously applied 0b3877bec78b ("netfilter: uapi: Use UAPI definition of INT_MAX and INT_MIN")
---
 include/uapi/linux/netfilter_bridge.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/netfilter_bridge.h b/include/uapi/linux/netfilter_bridge.h
index f6e8d1e05c97..758de72b2764 100644
--- a/include/uapi/linux/netfilter_bridge.h
+++ b/include/uapi/linux/netfilter_bridge.h
@@ -5,6 +5,10 @@
 /* bridge-specific defines for netfilter. 
  */
 
+#ifndef __KERNEL__
+#include <netinet/if_ether.h>	/* for __UAPI_DEF_ETHHDR if defined */
+#endif
+
 #include <linux/in.h>
 #include <linux/netfilter.h>
 #include <linux/if_ether.h>
-- 
2.51.0


