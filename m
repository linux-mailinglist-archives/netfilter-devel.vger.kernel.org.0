Return-Path: <netfilter-devel+bounces-9782-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E314EC6907C
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Nov 2025 12:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B98B74F085F
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Nov 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812A3339B24;
	Tue, 18 Nov 2025 11:17:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541534CFC1
	for <netfilter-devel@vger.kernel.org>; Tue, 18 Nov 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464639; cv=none; b=cwm4pMVtLa5xZsveDwvEnnLSdMZVY162YV622GQbgriKiq+wn+BRXYknMj4sd6fNv+9mOVWNvXHJBPtFrE1vbdD784u/xCC84+svwaGXzzmQCPFrnppyQuyaO9wrvdLGMnIixaSzzT8w/CizcBmejbYqVBaWAIIKPwrjImCwdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464639; c=relaxed/simple;
	bh=uZSIxQNhOCeUIir2VKoCaEroEckiyCbsnOhJQHaLODM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EIqpkoajeQy50IGNOZegK+0J34qlh+3yvXkCTXKjrAS3bzEKlcgYTMYiSZZp1UrSS9qyJpFRXAQlkXtuG208E2+vOmTQdztM4cA5b74mv+oyxSQe+cFIq1QE7cqTLnbyRZIux+N46sB25OrKIxGukY0JNNXckSUynpBAgIlTvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1E5C760345; Tue, 18 Nov 2025 12:17:10 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/3] netfilter: nft_set_rbtree: use cloned tree for insertions and removal
Date: Tue, 18 Nov 2025 12:16:47 +0100
Message-ID: <20251118111657.12003-1-fw@strlen.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes false negative lookup bug in rbtree set backend that
can occur during transaction.

First two patches prepare for actual fix, which is coming in last patch.

All inserts/removals will now occur in a cloned copy, so packetpath can
no longer observe the problematic mixed-bag of old, current and new
elements.

The live tree will only have reachable elements that are active in the
current generation or were active in the previous generation (but are still
valid while packetpath holds rcu read lock).  The latter case is only
temporary, as new lookups already observe the updated tree).

Florian Westphal (3):
  netfilter: nft_set_rbtree: prepare for two rbtrees
  netfilter: nft_set_rbtree: factor out insert helper
  netfilter: nft_set_rbtree: do not modifiy live tree

 net/netfilter/nft_set_rbtree.c | 279 +++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 68 deletions(-)
-- 
2.51.0

