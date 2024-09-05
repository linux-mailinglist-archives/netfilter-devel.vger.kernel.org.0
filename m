Return-Path: <netfilter-devel+bounces-3724-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9396E63A
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2024 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F3C1C2322A
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Sep 2024 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD51BAEFD;
	Thu,  5 Sep 2024 23:29:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C39C1B6523;
	Thu,  5 Sep 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578979; cv=none; b=qTrJg+iL/2HHP8ErGvyO7bCgY9TCkBuc+W4KhdZrxhtrRkM3FydDISwg6o4UokNw3mnC1ipTK2kgwlHZVnwSTsPVoJMI3WpDxL78NahQwlaTXGFqRtVUcHdJfuYeduXzBfU7zwxkqTzpsLsLIYnSDehEEEYzYwgZrieAtBwOG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578979; c=relaxed/simple;
	bh=CibE2LviFyefwx1EHOgQusZkF7cAtFeGSa/++6zyk5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJU4AjaMkhbrkkPZu/BANcEkAf9I2v0n0EFrQ8W431sFTLnRj15fwqTArqQ1231achBLVk70pI+toSEDBh9KDFMrKvy6AWjN3Dnivb5rfyB7DvLuuXPOeA4aA02djjen28VOydZuyBM4VdHYdyEdumGJqSa8A8iD1h/AmCBGz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 04/16] netfilter: conntrack: Convert to use ERR_CAST()
Date: Fri,  6 Sep 2024 01:29:08 +0200
Message-Id: <20240905232920.5481-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905232920.5481-1-pablo@netfilter.org>
References: <20240905232920.5481-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shen Lichuan <shenlichuan@vivo.com>

Use the ERR_CAST macro to clearly indicate that this is a pointer
to an error value and that a type conversion was performed.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 9384426ddc06..d3cb53b008f5 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1722,7 +1722,7 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 	ct = __nf_conntrack_alloc(net, zone, tuple, &repl_tuple, GFP_ATOMIC,
 				  hash);
 	if (IS_ERR(ct))
-		return (struct nf_conntrack_tuple_hash *)ct;
+		return ERR_CAST(ct);
 
 	if (!nf_ct_add_synproxy(ct, tmpl)) {
 		nf_conntrack_free(ct);
-- 
2.30.2


