Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28242458657
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Nov 2021 21:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhKUUo4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Nov 2021 15:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhKUUo4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Nov 2021 15:44:56 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7888C061748
        for <netfilter-devel@vger.kernel.org>; Sun, 21 Nov 2021 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q3slwVu3XrbRto7Rb6M0vPTZ6Tmvn5kaLUuDA5wi1es=; b=e+MwIDglX6u3+/K5a5kBwFxnJJ
        wFmWzrKBjGsMP9VKfxC3xF6525vxCMpc/KtMrRviodjGxpRQfJQu1/NJXTCw41E5vIUhhLoO+BsmR
        hbNe7h5dK6ORTLQ+6H7lZISsLxCKOOWYM7nGkQq86m63x+Zib1fLsELeLyPye0eOoubl/TClBXMeg
        ojmAGsU4/maFUQhPkNgQjTjGYZLhHxp/3VTY8PvzjOcpvVxzOkyP0cMwb/U0ZrnME6AnM7HMKg/Ja
        j7YU9bGBPexmeNeekfpECvwJNhAqrg8YC09YpTHWOKo7N+v5kKqvpAphtjrzI+odcxBWLdFBIx+oe
        4u9UfHDA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1motel-0025lK-AM
        for netfilter-devel@vger.kernel.org; Sun, 21 Nov 2021 20:41:47 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH 3/5] ulogd: fix order of log arguments
Date:   Sun, 21 Nov 2021 20:41:37 +0000
Message-Id: <20211121204139.2218387-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211121204139.2218387-1-jeremy@azazel.net>
References: <20211121204139.2218387-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If `daemon` fails during start-up, ulogd attempts to print `errno` and
`strerror(errno)` to the log.  However, the arguments are the wrong way
round.  Swap them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/ulogd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ulogd.c b/src/ulogd.c
index a31b35592a87..97da4fc0018f 100644
--- a/src/ulogd.c
+++ b/src/ulogd.c
@@ -1569,7 +1569,7 @@ int main(int argc, char* argv[])
 	if (daemonize){
 		if (daemon(0, 0) < 0) {
 			ulogd_log(ULOGD_FATAL, "can't daemonize: %s (%d)\n",
-				  errno, strerror(errno));
+				  strerror(errno), errno);
 			warn_and_exit(daemonize);
 		}
 	}
-- 
2.33.0

