Return-Path: <netfilter-devel+bounces-4581-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D979A5410
	for <lists+netfilter-devel@lfdr.de>; Sun, 20 Oct 2024 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C511F22376
	for <lists+netfilter-devel@lfdr.de>; Sun, 20 Oct 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39118FDA3;
	Sun, 20 Oct 2024 12:50:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D91137E;
	Sun, 20 Oct 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729428605; cv=none; b=FCOdCtIjyPnt1+b35uL5xCNmQzgMAZlmeU48ibUexj6EBsUxA8GZ1914TXFeHq3M+yvuBT6LeRHbJ7swuClZnuN4i35gerH29k+FIEjDMnKd4UkdWP1dCLKm6kM3Y5eMfAhHKhU94rWMXKTXVJtDZEJ5otbIOOmXyrkFGs8iA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729428605; c=relaxed/simple;
	bh=3kTB1R9/xn3p8fpcF0/beCjNpRcV6uJ+m8FB1X/R5QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XEkUevBzezeMcA3t7KXLMJawKzoOKUv1D0YdK2HfUv2gYQCV5O3UDLL4oMd1FyjeQc/jFoO7o3Gz5L0n/9dwtcxCFaGA0I8ZZxtp785W9vL3f14DCyu6gia7oUzt0HRygakEmzlasZwV+zM3KLqkjqV6VbcZPVh/jN+oab/Y/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH nf] netfilter: xtables: fix typo causing some targets to not load on IPv6
Date: Sun, 20 Oct 2024 14:49:51 +0200
Message-Id: <20241020124951.180350-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- There is no NFPROTO_IPV6 family for mark and NFLOG.
- TRACE is also missing module autoload with NFPROTO_IPV6.

This results in ip6tables failing to restore a ruleset. This issue has been
reported by several users providing incomplete patches.

Fixes: 0bfcb7b71e73 ("netfilter: xtables: avoid NFPROTO_UNSPEC where needed")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/xt_NFLOG.c | 2 +-
 net/netfilter/xt_TRACE.c | 1 +
 net/netfilter/xt_mark.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index d80abd6ccaf8..6dcf4bc7e30b 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -79,7 +79,7 @@ static struct xt_target nflog_tg_reg[] __read_mostly = {
 	{
 		.name       = "NFLOG",
 		.revision   = 0,
-		.family     = NFPROTO_IPV4,
+		.family     = NFPROTO_IPV6,
 		.checkentry = nflog_tg_check,
 		.destroy    = nflog_tg_destroy,
 		.target     = nflog_tg,
diff --git a/net/netfilter/xt_TRACE.c b/net/netfilter/xt_TRACE.c
index f3fa4f11348c..a642ff09fc8e 100644
--- a/net/netfilter/xt_TRACE.c
+++ b/net/netfilter/xt_TRACE.c
@@ -49,6 +49,7 @@ static struct xt_target trace_tg_reg[] __read_mostly = {
 		.target		= trace_tg,
 		.checkentry	= trace_tg_check,
 		.destroy	= trace_tg_destroy,
+		.me		= THIS_MODULE,
 	},
 #endif
 };
diff --git a/net/netfilter/xt_mark.c b/net/netfilter/xt_mark.c
index f76fe04fc9a4..65b965ca40ea 100644
--- a/net/netfilter/xt_mark.c
+++ b/net/netfilter/xt_mark.c
@@ -62,7 +62,7 @@ static struct xt_target mark_tg_reg[] __read_mostly = {
 	{
 		.name           = "MARK",
 		.revision       = 2,
-		.family         = NFPROTO_IPV4,
+		.family         = NFPROTO_IPV6,
 		.target         = mark_tg,
 		.targetsize     = sizeof(struct xt_mark_tginfo2),
 		.me             = THIS_MODULE,
-- 
2.30.2


