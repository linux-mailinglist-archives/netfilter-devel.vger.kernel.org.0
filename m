Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36A2A5DF3
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfIBXGz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 19:06:55 -0400
Received: from kadath.azazel.net ([81.187.231.250]:43572 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfIBXGz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vkPaDJ+vcHYrLElIERRFK6fNfCzlCuV5J23B8YJ6RZk=; b=Pe+jAYi37Jeao2MTbK4xmvkgsl
        zIuhM1LPMC5sInLCVKb73TpfaNy2EBuOcNk2taEFqrzpM623MjSbg8QrSMhUvtXDAc66fS156VkjL
        5D3Lq//YAdCXcYgsUcIJzXOiAedRHWy5ICDKiosA1zAzJhMMD2c5pmJ4lf9JJejS1Ju+vV+RBHJqo
        JHlVVs+75ADy6Uy9lJ454rqEPK7S8xpsG065yc8ylLqLasw04v5GBIHU+bII6lP6kiQBAbttornMB
        F8BsFjCQxlZ0VYiCc3XwirqzZ0+RVEu0y1l0OiPEoLxTRsI9Ujiw2VtKBGsNm8LxnFSwLc3SfNGXB
        vbFcmgyQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4vPO-0004la-PU; Tue, 03 Sep 2019 00:06:50 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 02/30] netfilter: add include guard to nf_conntrack_labels.h.
Date:   Tue,  3 Sep 2019 00:06:22 +0100
Message-Id: <20190902230650.14621-3-jeremy@azazel.net>
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

nf_conntrack_labels.h has no include guard.  Add it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_conntrack_labels.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_labels.h b/include/net/netfilter/nf_conntrack_labels.h
index 4eacce6f3bcc..ba916411c4e1 100644
--- a/include/net/netfilter/nf_conntrack_labels.h
+++ b/include/net/netfilter/nf_conntrack_labels.h
@@ -1,11 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/types.h>
-#include <net/net_namespace.h>
+
+#ifndef _NF_CONNTRACK_LABELS_H
+#define _NF_CONNTRACK_LABELS_H
+
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_conntrack_tuple_common.h>
+#include <linux/types.h>
+#include <net/net_namespace.h>
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_extend.h>
-
 #include <uapi/linux/netfilter/xt_connlabel.h>
 
 #define NF_CT_LABELS_MAX_SIZE ((XT_CONNLABEL_MAXBIT + 1) / BITS_PER_BYTE)
@@ -51,3 +54,5 @@ static inline void nf_conntrack_labels_fini(void) {}
 static inline int nf_connlabels_get(struct net *net, unsigned int bit) { return 0; }
 static inline void nf_connlabels_put(struct net *net) {}
 #endif
+
+#endif /* _NF_CONNTRACK_LABELS_H */
-- 
2.23.0.rc1

