Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269B4A4C19
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Sep 2019 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfIAVCC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Sep 2019 17:02:02 -0400
Received: from kadath.azazel.net ([81.187.231.250]:53630 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfIAVCB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZbZaMQnoNxxHgm9dHsr8ESnx4TWpMqblRb8xgiEABtE=; b=NlS+M0SpmfViEtNWLMoog2sIaD
        Lj3vPnB5p9xInPLZbPKxfeI3mMuzN+CoeezzKRA5sHcp/VOf78wP7e/BBjKzf7KqGpTOhUOgmywOy
        lgVsBj7GzAYNK8M0ctxfIz6g6g2fCyar+pBBk6vQwpaL7FwGIY4yxnwcbvUBW7SUEa591oaVYOOaD
        mPAVV+6RzxLaxnkxsslC3SLexZU4x9ci1YlkuIREnx6vhtBsIV0yVbv0KMaY+p/4da3R3n19d+UIE
        f/4xY0UXaTd4cjAdG3raZ+VZfH3lNK67sZRezSNR88DZlEZ2SlyF+oTtdBr96I8s3rOroROiZ0WUJ
        ybJPQhrw==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4Wop-0002Uf-J3; Sun, 01 Sep 2019 21:51:27 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 10/29] netfilter: include the right header in nf_conntrack_zones.h.
Date:   Sun,  1 Sep 2019 21:51:06 +0100
Message-Id: <20190901205126.6935-11-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190901205126.6935-1-jeremy@azazel.net>
References: <20190901205126.6935-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_conntrack_zones.h includes nf_conntrack_extend.h, but it doesn't
actually use anything from it.  It does, however, require stuff from
nf_conntrack.h which it includes transitively.  Include nf_conntrack.h
directly instead.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_conntrack_zones.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_conntrack_zones.h b/include/net/netfilter/nf_conntrack_zones.h
index 52950baa3ab5..33b91d19cb7d 100644
--- a/include/net/netfilter/nf_conntrack_zones.h
+++ b/include/net/netfilter/nf_conntrack_zones.h
@@ -5,7 +5,8 @@
 #include <linux/netfilter/nf_conntrack_zones_common.h>
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
-#include <net/netfilter/nf_conntrack_extend.h>
+
+#include <net/netfilter/nf_conntrack.h>
 
 static inline const struct nf_conntrack_zone *
 nf_ct_zone(const struct nf_conn *ct)
-- 
2.23.0.rc1

