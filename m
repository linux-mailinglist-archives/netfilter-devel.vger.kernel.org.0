Return-Path: <netfilter-devel+bounces-181-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FB805906
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB64B20F47
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8B5F1F3;
	Tue,  5 Dec 2023 15:43:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E8A483
	for <netfilter-devel@vger.kernel.org>; Tue,  5 Dec 2023 07:43:14 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: flush ruleset with -U after feature probing
Date: Tue,  5 Dec 2023 16:43:06 +0100
Message-Id: <20231205154306.154220-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

feature probe script leave a ruleset in place, flush it once probing is
complete.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/run-tests.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index e54f8bf3e3ee..86c8312683cc 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -602,6 +602,9 @@ for feat in "${_HAVE_OPTS[@]}" ; do
 		val="$(bool_n "${!var}")"
 	fi
 	eval "export $var=$val"
+	if [ "$NFT_TEST_HAS_UNSHARED" != y ] ; then
+		$NFT flush ruleset
+	fi
 done
 
 if [ "$NFT_TEST_JOBS" -eq 0 ] ; then
-- 
2.30.2


