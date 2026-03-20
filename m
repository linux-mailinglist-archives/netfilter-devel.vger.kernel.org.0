Return-Path: <netfilter-devel+bounces-11344-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PNCJpZnvWnL9gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11344-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 16:28:22 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5D2DCAAC
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 16:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BFDE30E2C1D
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6953C9420;
	Fri, 20 Mar 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="BNY2pR6z"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21853B961D
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019794; cv=none; b=KcAZsFl+zwToldqtVoRRLl1SCZeV8zIWbhhd1PqabBaPzmWqGoDjxDo0rmA/hErgUk5ftplsYaAm/sjDEq9FcmCmSJg+UirQHj49a7f8F7Y406jNn683gvG6YoQjauFAo/DvUgdrUKlM2oMm+GJ+IOeU8bGoAHCfZjdeZZV1aQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019794; c=relaxed/simple;
	bh=ENgvlipYnpFn9hV2Ovth+Kh2YJNIVHqv3UAi3/ns0Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mELp89Yvyz5A6qQ/h/H1/XhUjT/trdhxMauGtqmIHu/BuQqYHP3GsjuMJKVCNb4gC+AmXEtQbh3FZ8rKuLJdf/10H0NaangaYVdJCr6eUvp1i9gXCKDyMD6mixqWPnRlHnkcMw54bmdoWupvdX8S1GzSQBRjtHFIQrWuo6LbPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=BNY2pR6z; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9Tg80sMmSRNkW58VywyMyD06OeOgZE9oAIjkPymOyjs=; b=BNY2pR6zPYsB49hxXbZ/gZVKvP
	GrjO3myB22DEa4+vKIgyWuSwHZs49MJ+/kh0GFdhY4eUKIISmQ5Ncdb+XZqkSiQRtQTqPVKVv2EVN
	fmGB141sqYnYwq+lak0vXyI/3IpoebmIJi4vnqRUj4/Kv2T0njo6odE5xFFd5CHDiB8olCqpMxnO2
	UavjS8T2lVaz5awDmZO3nSXU4ALkU0fRj0hNTKQQmKMc7ctu6KwY8NFw3bbMCGC+SteaToFRql24M
	5OA5vhjNPbqEQvHE8QluYUvz8/ZzACHIzPPXyyEN65dOUhjIRapmEl4kh4eu5ihmwDlpzvO3O4a9Z
	upibGiPg==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w3baQ-000000001wH-1asH;
	Fri, 20 Mar 2026 16:16:30 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nft PATCH] mnl: Fix ordering of hooks in 'list hooks' output
Date: Fri, 20 Mar 2026 16:16:25 +0100
Message-ID: <20260320151625.5318-1-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11344-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-0.063];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nwl.cc:email,nwl.cc:mid]
X-Rspamd-Queue-Id: 21B5D2DCAAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hooks with same family, basehook and priority were inadvertently
inserted into the list in reverse ordering, fix that.

Suggested-by: Florian Westphal <fw@strlen.de>
Fixes: b98fee20bfe23 ("mnl: revisit hook listing")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/mnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mnl.c b/src/mnl.c
index 4893af8322ae6..b9efd3cfd3cea 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -2520,7 +2520,7 @@ static void basehook_list_add_tail(struct basehook *b, struct list_head *head)
 			continue;
 		if (!basehook_eq(hook, b))
 			continue;
-		if (hook->prio < b->prio)
+		if (hook->prio <= b->prio)
 			continue;
 
 		list_add(&b->list, &hook->list);
-- 
2.51.0


