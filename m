Return-Path: <netfilter-devel+bounces-3632-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF183969065
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2024 01:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C5AB20A7A
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2024 23:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617631885B6;
	Mon,  2 Sep 2024 23:23:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20422032A
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725319432; cv=none; b=WqnAvmxTh5Bu+4IkYWzLuKkjUS/4y8XvUhT05dUbEuMB0X5GPbYIC4mE01ZHJ5c6vPV8oDpuitlIocfAQQItCN/Ra7tKlkFmo8dlyg9uYFaabPo53SAuMhSx8op8o0feaEdbEPFdjVPIFA1qockTViSy6GjquJeylxL3vZWNiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725319432; c=relaxed/simple;
	bh=JCt7jOMX+XLLs+wDUW5iS1KansvYgJyl3Cm2L5JT6+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/UMSjYRwvA8MwnEH3PGbJIDp4lXd02T9QaT4tHIAjH6ZxVYrPmTCycQ5jkEKVsLasQtFFzURgnIUd/q4KsLFouI5w7W35AtBtoDvSxTO7HbC1JTo4WfOgUGWqe14wJ4FcA6QtnCV/H7KrpgqEPCvN5PkofuOEfZR3O1yo5MqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	fw@strlen.de
Subject: [PATCH nf-next,v2 3/9] netfilter: nf_tables: reject expiration higher than timeout
Date: Tue,  3 Sep 2024 01:17:20 +0200
Message-Id: <20240902231726.171964-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240902231726.171964-1-pablo@netfilter.org>
References: <20240902231726.171964-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report ERANGE to userspace if user specifies an expiration larger than
the timeout.

Fixes: 8e1102d5a159 ("netfilter: nf_tables: support timeouts larger than 23 days")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes.

 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1884125ebb28..684dff68b2c3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6924,6 +6924,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 					    &expiration);
 		if (err)
 			return err;
+
+		if (expiration > timeout)
+			return -ERANGE;
 	}
 
 	if (nla[NFTA_SET_ELEM_EXPR]) {
-- 
2.30.2


