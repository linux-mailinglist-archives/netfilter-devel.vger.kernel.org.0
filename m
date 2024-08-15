Return-Path: <netfilter-devel+bounces-3330-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27164953763
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Aug 2024 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C89B26EAF
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Aug 2024 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3D19F49A;
	Thu, 15 Aug 2024 15:35:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EE1AAE07
	for <netfilter-devel@vger.kernel.org>; Thu, 15 Aug 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736129; cv=none; b=NuTvAJ0hlhpz6j5JRGbSnYYpsLsiORBlGJSeQbC2R4TG6EeSB0tYvISTnznQQmVXF/43rHwVQkEH99Lwxp6CEeahBi7O17DrAg52pzj7463VPkF8h+g/Q791YAjGKWvsT5+BrHqPM8vKA7IKEaOrBw8v1fMmh5aOC10KPZNKlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736129; c=relaxed/simple;
	bh=DtU7M7+E8N812wmFkF8vQ+R6fraDjQJ72m3SnOV/fQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ilv3ab6T1qvGZ/OlWavRng+F7TIDyI8JGFAknwcY5DYV56YdojKbRZLOYU4NXQlw6xabFzA+Ggm9420gC4imVEkaB2r360AOPohp6Z7M5bwAnibSvvNKmcEwePXVkz7cPGocukY2I4+o5V9rbLj9eWY9OkzfQBdbndmTzxedaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc
Subject: [PATCH nft] cache: revisit reset command flags
Date: Thu, 15 Aug 2024 17:35:19 +0200
Message-Id: <20240815153519.1589974-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- reset rules => fetch full cache, rules can refer to objects
- reset counter,quota => fetch only table and objects

... otherwise, default to cache full fetch, which is slow but safe.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1763
Fixes: 1694df2de79f ("Implement 'reset rule' and 'reset rules' commands")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
I plan to send v2 to extend tests.

A few more comments:

- nft reset ruleset seems to be missing?
- nft reset rules lists the entire ruleset, i guess this expected
  nft reset counters comes with memleak, ASAN reports

 src/cache.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index 233147649263..d91e4b682e1f 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -278,16 +278,21 @@ static unsigned int evaluate_cache_reset(struct cmd *cmd, unsigned int flags,
 			if (cmd->handle.chain.name)
 				filter->list.chain = cmd->handle.chain.name;
 		}
-		flags |= NFT_CACHE_SET | NFT_CACHE_FLOWTABLE |
-			 NFT_CACHE_OBJECT | NFT_CACHE_CHAIN;
+		flags |= NFT_CACHE_FULL;
+		break;
+	case CMD_OBJ_COUNTER:
+	case CMD_OBJ_COUNTERS:
+	case CMD_OBJ_QUOTA:
+	case CMD_OBJ_QUOTAS:
+		flags |= NFT_CACHE_TABLE | NFT_CACHE_OBJECT;
 		break;
 	case CMD_OBJ_ELEMENTS:
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
-		flags |= NFT_CACHE_SET;
+		flags |= NFT_CACHE_SETELEM | NFT_CACHE_CHAIN | NFT_CACHE_OBJECT;
 		break;
 	default:
-		flags |= NFT_CACHE_TABLE;
+		flags |= NFT_CACHE_FULL;
 		break;
 	}
 	flags |= NFT_CACHE_REFRESH;
-- 
2.30.2


