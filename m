Return-Path: <netfilter-devel+bounces-3269-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF8951A65
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A040128439D
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CA1AED5C;
	Wed, 14 Aug 2024 11:51:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78621AC443
	for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636291; cv=none; b=GFKMLB1XIYacOQNk9M7D6rl7lwh+GN4+nQfdW0MWxvRTMcO6zKEFkldS/jm6mFNPDZ/QYrcl6sCePwNjY+X8yB1hRS+YstVQN0r+BG7rigSzB7YgpfB6xlxr7DeP2uc/w7tHFUV8CKUtpLaAota4dDzWgyKTl7veh5Mx197r/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636291; c=relaxed/simple;
	bh=e8py/eIhYY8Tu2EdmcNEa9U+uCqbPQpX0smqrMySEeM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNhWrPqPzl/YV0qWE1T2Xu1jBQZvJRbqC82kBsRTTs0xrYJ+dWhEpfwf47WuzX8QFxihRcLN6AS3aoIYPEbknR3uZQAapl5EloVAYBcFY6SS+prZ4aUyLB0sE+w+7hneOXcfuHWJnbO2CdzHuJ+BxwHQQzxQJQApKpeqpml9SwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 2/2] datatype: improve error reporting when time unit is not correct
Date: Wed, 14 Aug 2024 13:51:22 +0200
Message-Id: <20240814115122.279041-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240814115122.279041-1-pablo@netfilter.org>
References: <20240814115122.279041-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Display:

  Wrong unit format, expecting bytes or kbytes or mbytes

instead of:

  Wrong rate format

Fixes: 6615676d825e ("src: add per-bytes limit")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/datatype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/datatype.c b/src/datatype.c
index 297c5d0409d5..33fe471048ef 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1477,7 +1477,7 @@ static struct error_record *time_unit_parse(const struct location *loc,
 	else if (strcmp(str, "week") == 0)
 		*unit = 1ULL * 60 * 60 * 24 * 7;
 	else
-		return error(loc, "Wrong rate format");
+		return error(loc, "Wrong time format, expecting second or minute or hour or day or week");
 
 	return NULL;
 }
-- 
2.30.2


