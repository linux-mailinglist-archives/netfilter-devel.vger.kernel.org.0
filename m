Return-Path: <netfilter-devel+bounces-3494-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C44A95EC77
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF15C1C2147A
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9713D276;
	Mon, 26 Aug 2024 08:55:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6618027
	for <netfilter-devel@vger.kernel.org>; Mon, 26 Aug 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662504; cv=none; b=Jp+Xp1Ij4WSo/9b4SSDNF2Ci21Tf+9zQF/pTAnmWp2YfsWE71lktdvBwXXC0C9LheW2mxNRiZgCd7GZQVQAXwT3xoH9WEzNC7iskMpZGYkxLnQU1g5FOCLWOK6fG3HMqvrc/7+v2JFGlRsQMkqT/an2NlKF/Gah9iL3ynmYW5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662504; c=relaxed/simple;
	bh=Joq6v6FZH1+QCaDz/EcW3gJodzoPhsEgxcluPKSq8c8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSDWVqru/+c6M0XZSu7aqY6f65wLXuB2waFhsOYp7D4t+c6wniO34Z3NgVs1anq95OzyZRxVdwTjcWarb7z8IEJwnvQ2UefJa61KGUEM0OtXy9nSPNILqbyPH+1x/uMs379nzae0FwP4FeRo0iv1+OuSjZLv8GVWoJTp4Ggg5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 1/7] cache: reset filter for each command
Date: Mon, 26 Aug 2024 10:54:49 +0200
Message-Id: <20240826085455.163392-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826085455.163392-1-pablo@netfilter.org>
References: <20240826085455.163392-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inconditionally reset filter for each command in the batch, this is safer.

Fixes: 3f1d3912c3a6 ("cache: filter out tables that are not requested")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: new in this series

 src/cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index 233147649263..5442da35a129 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -400,6 +400,11 @@ err_name_too_long:
 	return -1;
 }
 
+static void reset_filter(struct nft_cache_filter *filter)
+{
+	memset(&filter->list, 0, sizeof(filter->list));
+}
+
 int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 		       struct list_head *msgs, struct nft_cache_filter *filter,
 		       unsigned int *pflags)
@@ -411,8 +416,7 @@ int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 		if (nft_handle_validate(cmd, msgs) < 0)
 			return -1;
 
-		if (filter->list.table && cmd->op != CMD_LIST)
-			memset(&filter->list, 0, sizeof(filter->list));
+		reset_filter(filter);
 
 		switch (cmd->op) {
 		case CMD_ADD:
-- 
2.30.2


