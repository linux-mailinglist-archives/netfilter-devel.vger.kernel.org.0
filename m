Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC41412E
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 May 2019 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEEQrl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 May 2019 12:47:41 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56648 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfEEQrl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 May 2019 12:47:41 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hNKIb-00077d-Qp; Sun, 05 May 2019 18:47:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH nf] netfilter: ebtables: CONFIG_COMPAT: reject trailing data after last rule
Date:   Sun,  5 May 2019 18:47:33 +0200
Message-Id: <20190505164733.31905-1-fw@strlen.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If userspace provides a rule blob with trailing data after last target,
we trigger a splat, then convert ruleset to 64bit format (with trailing
data), then pass that to do_replace_finish() which then returns -EINVAL.

Erroring out right away avoids the splat plus unneeded translation and
error unwind,

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 3cad01ac64e4..3a1b94b5c0e5 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2158,7 +2158,9 @@ static int compat_copy_entries(unsigned char *data, unsigned int size_user,
 	if (ret < 0)
 		return ret;
 
-	WARN_ON(size_remaining);
+	if (size_remaining)
+		return -EINVAL;
+
 	return state->buf_kern_offset;
 }
 
-- 
2.20.1

