Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366051282EF
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Dec 2019 20:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTTyw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Dec 2019 14:54:52 -0500
Received: from kadath.azazel.net ([81.187.231.250]:53318 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTyw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=a8PmRGoKxkOMZHsDOkXnwhqJlNzq+x+cizRtBOPSg70=; b=b4hJmDmpJT+/8ErWe3Erdy3coi
        4RWrEcy4AWDoIsjldSA7lG6s2Z/0swcaD8wCdet9OMm5smBO3WPmYraRz4OiNxGVPVlPZORbiuibB
        Faen7LDXMZFFcS17FRLr9hP0GDYZff18GUACkoDb17SC/sD7oh0LsqXL+F/5rnpV76HeHOW2XmXKC
        LBsHsiMf/XIdTsOBxPmMut88KCwLeIYVdiDIlxmZzbR+p/KpUIzNse/c/CeuKzmKalueB8+tgk5FE
        Uaky1u6vVr5VEeNJxGiPkYCshpABeHFIyXfn8wS4IB1mAKPe+TV34QRNjI2D8guF5EYwn+iyArWnA
        A2LriI5w==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iiOMM-00080h-GT
        for netfilter-devel@vger.kernel.org; Fri, 20 Dec 2019 19:54:50 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH iptables] extensions: AUDIT: fix man-page typo.
Date:   Fri, 20 Dec 2019 19:54:50 +0000
Message-Id: <20191220195450.1743476-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

A recent commit fixed uses of "allows to" in man-pages.  There was one
instance where the "to" was removed but the "allows" was left behind.
Remove that as well.

Fixes: 3b9b515618c6 ("iptables: cleanup "allows to" usage")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/libxt_AUDIT.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extensions/libxt_AUDIT.man b/extensions/libxt_AUDIT.man
index 57cce8c40e0a..8c513d227b88 100644
--- a/extensions/libxt_AUDIT.man
+++ b/extensions/libxt_AUDIT.man
@@ -1,4 +1,4 @@
-This target allows creates audit records for packets hitting the target.
+This target creates audit records for packets hitting the target.
 It can be used to record accepted, dropped, and rejected packets. See
 auditd(8) for additional details.
 .TP
-- 
2.24.0

