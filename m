Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24350ABB3D
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2019 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405589AbfIFOme (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Sep 2019 10:42:34 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:59688 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403803AbfIFOme (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:42:34 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i6FRY-0004dH-KA; Fri, 06 Sep 2019 16:42:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: flag fwd and queue statements as terminal
Date:   Fri,  6 Sep 2019 16:43:37 +0200
Message-Id: <20190906144337.25367-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Both queue and fwd statement end evaluation of a rule:

in
... fwd to "eth0" accept
... queue accept

"accept" is redundant and never evaluated in the kernel.
Add the missing "TERMINAL" flag so the evaluation step will catch
any trailing expressions:

nft add rule filter input queue counter
Error: Statement after terminal statement has no effect

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index b8bcf4866d8d..29fe966008b1 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2963,6 +2963,7 @@ static int stmt_evaluate_fwd(struct eval_ctx *ctx, struct stmt *stmt)
 	default:
 		return stmt_error(ctx, stmt, "unsupported family");
 	}
+	stmt->flags |= STMT_F_TERMINAL;
 	return 0;
 }
 
@@ -2982,6 +2983,7 @@ static int stmt_evaluate_queue(struct eval_ctx *ctx, struct stmt *stmt)
 					  "fanout requires a range to be "
 					  "specified");
 	}
+	stmt->flags |= STMT_F_TERMINAL;
 	return 0;
 }
 
-- 
2.21.0

