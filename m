Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E9A5DF2
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIBXGz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 19:06:55 -0400
Received: from kadath.azazel.net ([81.187.231.250]:43580 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfIBXGz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H12Ygv/ZWHIPzG5kSXpja+K4C0xnU27gilCQPRe/jTY=; b=Iwhw4MH2VePUyrIPIJad0MLElP
        US61AeSa1lwJzXdXoYLMof7blVeV6tHGMhZiKYn+UOqL4WBJ7RtBPM0lrCmFePYxhCk1bXzc9dyPo
        s+wH3vW9RdUO/YNhs0jthDllp5Gfni5clz0h4QdgcefL98jiiCmzDPJWaPK8ycltJUdZCUgoJzrgg
        mBRbb7pwV7obrlkOVIHr3plzwGC9WJ4ru3MJzjrgsUiDRy7fuFXitbfSfBo8pcgqqqrWYe4CnTy/n
        SwjxHoiEEKEXhmmGb6EkusGO7d9a5nvZJWvFKG7qi4J7opeP5yfA7z+PYtwPzuYaYYsQ1wwA34dFY
        N06Lq7cA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4vPP-0004la-K1; Tue, 03 Sep 2019 00:06:51 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 07/30] netfilter: remove stray semicolons.
Date:   Tue,  3 Sep 2019 00:06:27 +0100
Message-Id: <20190902230650.14621-8-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190902230650.14621-1-jeremy@azazel.net>
References: <20190902230650.14621-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There are a couple of semicolons at the end of function definitions.
Remove them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_conntrack_acct.h   | 2 +-
 include/net/netfilter/nf_conntrack_ecache.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_acct.h b/include/net/netfilter/nf_conntrack_acct.h
index ad9f2172dee1..5b5287bb49db 100644
--- a/include/net/netfilter/nf_conntrack_acct.h
+++ b/include/net/netfilter/nf_conntrack_acct.h
@@ -45,7 +45,7 @@ struct nf_conn_acct *nf_ct_acct_ext_add(struct nf_conn *ct, gfp_t gfp)
 #else
 	return NULL;
 #endif
-};
+}
 
 /* Check if connection tracking accounting is enabled */
 static inline bool nf_ct_acct_enabled(struct net *net)
diff --git a/include/net/netfilter/nf_conntrack_ecache.h b/include/net/netfilter/nf_conntrack_ecache.h
index 52b44192b43f..0815bfadfefe 100644
--- a/include/net/netfilter/nf_conntrack_ecache.h
+++ b/include/net/netfilter/nf_conntrack_ecache.h
@@ -61,7 +61,7 @@ nf_ct_ecache_ext_add(struct nf_conn *ct, u16 ctmask, u16 expmask, gfp_t gfp)
 #else
 	return NULL;
 #endif
-};
+}
 
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
 /* This structure is passed to event handler */
-- 
2.23.0.rc1

