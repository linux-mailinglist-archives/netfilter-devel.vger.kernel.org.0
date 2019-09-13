Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83BB1974
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbfIMIRt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 04:17:49 -0400
Received: from kadath.azazel.net ([81.187.231.250]:60816 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbfIMIRt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8Pp7xcboLErigtOPHsXmWPs2jG113kfyjjSox2ODr9I=; b=EtGkvOp+mN1z1z2imjJv5BeLnx
        oa1tAecnrBueCm7XAjHcpIYSpSQI5E1cp0oSXktgQpxz/34S8Eas22bwn+pdNY8xHnDHA5X42Us+R
        0CbU+gYFvHOX6PSOScsKb4QnxnqdrCIiIaCaHM9JEtKnC7lGuBHft3Ipf5/LjRjesJL7jR4FB0Oyt
        GjdVSeqveOulqGLnv0xIEzPE/ea8fHtlMmqTpqIcl9xnkxiwjuA1hVK0g39HBHIWaDXADDawjJxeF
        AkMzWZnBRt906Wei7Sh3HZLFHedVu19udi9QHnhSP8YEJHvoHij3N/Gs9krUFgzkr1q/xxmTSjmSW
        8BSbmDcA==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i8ghm-0005yL-Oy; Fri, 13 Sep 2019 09:13:22 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v3 17/18] netfilter: remove CONFIG_NF_CONNTRACK checks from nf_conntrack_zones.h.
Date:   Fri, 13 Sep 2019 09:13:17 +0100
Message-Id: <20190913081318.16071-18-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913081318.16071-1-jeremy@azazel.net>
References: <20190913081318.16071-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_conntrack_zones.h was wrapped in a CONFIG_NF_CONNTRACK check in order
to fix compilation failures:

  37ee3d5b3e97 ("netfilter: nf_defrag_ipv4: fix compilation error with NF_CONNTRACK=n")

Subsequent changes mean that these failures will no longer occur and the
check is unnecessary.  Remove it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_conntrack_zones.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_zones.h b/include/net/netfilter/nf_conntrack_zones.h
index 33b91d19cb7d..48dbadb96fb3 100644
--- a/include/net/netfilter/nf_conntrack_zones.h
+++ b/include/net/netfilter/nf_conntrack_zones.h
@@ -3,9 +3,6 @@
 #define _NF_CONNTRACK_ZONES_H
 
 #include <linux/netfilter/nf_conntrack_zones_common.h>
-
-#if IS_ENABLED(CONFIG_NF_CONNTRACK)
-
 #include <net/netfilter/nf_conntrack.h>
 
 static inline const struct nf_conntrack_zone *
@@ -88,5 +85,5 @@ static inline bool nf_ct_zone_equal_any(const struct nf_conn *a,
 	return true;
 #endif
 }
-#endif /* IS_ENABLED(CONFIG_NF_CONNTRACK) */
+
 #endif /* _NF_CONNTRACK_ZONES_H */
-- 
2.23.0

