Return-Path: <netfilter-devel+bounces-134-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417FB801BED
	for <lists+netfilter-devel@lfdr.de>; Sat,  2 Dec 2023 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC971F211BD
	for <lists+netfilter-devel@lfdr.de>; Sat,  2 Dec 2023 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E831428B;
	Sat,  2 Dec 2023 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="qNttnJp4"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE7D67
	for <netfilter-devel@vger.kernel.org>; Sat,  2 Dec 2023 01:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/72qCkvbD8UznFOK3sNOTehL1puYsDMQUIQ3FrzWcfY=; b=qNttnJp4Xp6BpPYAybMFHAK3i7
	rcG1ilJiHU5S2KUmup3wQi6TTEy78CFxNtXV7WxejiPEo3iun6vdFnpE3mrMrLkHFnXaYPFhBbwJm
	Mp5XGl5Yc9V4feWZY6XeB3WUDkklqLfXn+Y+HRd6Mh1BWpmyjY5f0OtMX2z9OMT50Gy8kyd2pTdlY
	uJX43ktwNqVGkTZ1NQDeUIc0LBklLzZfY/avXrl2Eu/fJVL5kZpTTcGqfiWdophK1LlXhAaMHOAy9
	zuGS9Ftf0HzBa7zHVXBiZOtHeWdo5t3rkzixGROuaZ9VnsvSBttspljky9fNsFhjKttzrI2W3quo1
	eiTTYsdg==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1r9Miq-0000Og-Q1; Sat, 02 Dec 2023 10:55:40 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nft PATCH 1/2] main: Reduce indenting in nft_options_check()
Date: Sat,  2 Dec 2023 11:10:33 +0100
Message-ID: <20231202101034.31571-2-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231202101034.31571-1-phil@nwl.cc>
References: <20231202101034.31571-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change intended.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/src/main.c b/src/main.c
index 9485b193cd34d..c3c7fe23baa37 100644
--- a/src/main.c
+++ b/src/main.c
@@ -333,23 +333,24 @@ static bool nft_options_check(int argc, char * const argv[])
 		} else if (skip) {
 			skip = false;
 			continue;
-		} else if (argv[i][0] == '-') {
-			if (nonoption) {
-				nft_options_error(argc, argv, pos);
-				return false;
-			} else if (argv[i][1] == 'd' ||
-				   argv[i][1] == 'I' ||
-				   argv[i][1] == 'f' ||
-				   argv[i][1] == 'D' ||
-				   !strcmp(argv[i], "--debug") ||
-				   !strcmp(argv[i], "--includepath") ||
-				   !strcmp(argv[i], "--define") ||
-				   !strcmp(argv[i], "--file")) {
-				skip = true;
-				continue;
-			}
 		} else if (argv[i][0] != '-') {
 			nonoption = true;
+			continue;
+		}
+		if (nonoption) {
+			nft_options_error(argc, argv, pos);
+			return false;
+		}
+		if (argv[i][1] == 'd' ||
+		    argv[i][1] == 'I' ||
+		    argv[i][1] == 'f' ||
+		    argv[i][1] == 'D' ||
+		    !strcmp(argv[i], "--debug") ||
+		    !strcmp(argv[i], "--includepath") ||
+		    !strcmp(argv[i], "--define") ||
+		    !strcmp(argv[i], "--file")) {
+			skip = true;
+			continue;
 		}
 	}
 
-- 
2.41.0


