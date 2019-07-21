Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC36F28A
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 12:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGUKWd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Jul 2019 06:22:33 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49262 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbfGUKWc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:22:32 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hp8z9-0004aj-9y; Sun, 21 Jul 2019 12:22:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] scanner: don't rely on fseek for input stream repositioning
Date:   Sun, 21 Jul 2019 12:18:31 +0200
Message-Id: <20190721101831.28089-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It doesn't work when reading from a pipe, leading to parser
errors in case of 'cat foo | nft -f -', whereas 'nft -f < foo'
works fine.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1354
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/scanner.l | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/src/scanner.l b/src/scanner.l
index 4ed5f9241381..c1adcbddbd73 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -36,23 +36,28 @@
  */
 #define YY_INPUT(buf,result,max_size)						\
 {										\
-	long n = 0;								\
+	result = 0;								\
 	errno = 0;								\
-	while ((result = fread(buf, 1, max_size, yyin)) == 0 &&			\
-		ferror(yyin)) {							\
-		if (errno != EINTR) {						\
-			YY_FATAL_ERROR("input in flex scanner failed");		\
-			break;							\
+										\
+	while (result < max_size) {						\
+		int chr = fgetc(yyin);						\
+										\
+		if (chr != EOF) {						\
+			buf[result++] = chr;					\
+			if (chr == '\n' || chr == ' ')				\
+				break;						\
+			continue;						\
 		}								\
-		errno = 0;							\
-		clearerr(yyin);							\
-	}									\
-	if (result > 1 && !feof(yyin)) {					\
-		while (result > 1 && 						\
-		       (buf[result - 1] != '\n' &&  buf[result - 1] != ' '))	\
-			result--, n++;						\
-		result--, n++;							\
-		fseek(yyin, -n, SEEK_CUR);					\
+										\
+		if (ferror(yyin)) {						\
+			if (errno != EINTR) {					\
+				YY_FATAL_ERROR("input in flex scanner failed");	\
+				break;						\
+			}							\
+			errno = 0;						\
+			clearerr(yyin);						\
+		}								\
+		break;								\
 	}									\
 }
 
-- 
2.21.0

