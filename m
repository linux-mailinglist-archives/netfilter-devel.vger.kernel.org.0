Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BEEE0D8E
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Oct 2019 22:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfJVU66 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Oct 2019 16:58:58 -0400
Received: from kadath.azazel.net ([81.187.231.250]:44372 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbfJVU65 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sTPHKz1M6ZEMW440g4g/fnZYXfyMkySr+QBeM1e4ORI=; b=UkIj2NzPBdh7/mADrdVxiy7o+A
        lw+n8lq7hU000xef8aWohHjz2EoItcyhM8INsVNMUsD4mqQ2jr4Nf5jcBSBogPiurRKYrh2xLLQki
        sU1Ka3AdqU1WNAtM4iNkUVx1dOBHHeBJ+QIDTPqNcngJgbDQPM2UteR9arnCC5PmpzqE7o35yb9EZ
        owdPaCPgp5HAcMt0sN80QbIAkMjBi0AYEe/x8kt+yWE/uXEH5PGJvHZWo7kPzL60FRlVm8iyVJrnn
        dvWDPdXYGn0txd3d83lGzQyp9Sk5Kg3ytOdfXc42oMcmFTuMcuI0hlFNqbNOsNMvqCWiD16s5i50c
        +IVwgohw==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iN1F1-0002CC-Gx; Tue, 22 Oct 2019 21:58:55 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 2/4] py: add missing output flags.
Date:   Tue, 22 Oct 2019 21:58:53 +0100
Message-Id: <20191022205855.22507-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022205855.22507-1-jeremy@azazel.net>
References: <20191022205855.22507-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

`terse` and `numeric_time` are missing from the `output_flags` dict.
Add them and getters and setters for them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 py/nftables.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/py/nftables.py b/py/nftables.py
index 81e57567c802..48eb54fe232d 100644
--- a/py/nftables.py
+++ b/py/nftables.py
@@ -58,6 +58,8 @@ class Nftables:
         "numeric_proto":  (1 << 7),
         "numeric_prio":   (1 << 8),
         "numeric_symbol": (1 << 9),
+        "numeric_time":   (1 << 10),
+        "terse":          (1 << 11),
     }
 
     validator = None
@@ -305,6 +307,39 @@ class Nftables:
         """
         return self.__set_output_flag("numeric_symbol", val)
 
+    def get_numeric_time_output(self):
+        """Get current status of numeric times output flag.
+
+        Returns a boolean value indicating the status.
+        """
+        return self.__get_output_flag("numeric_time")
+
+    def set_numeric_time_output(self, val):
+        """Set numeric times output flag.
+
+        Accepts a boolean turning numeric representation of time values
+        in output either on or off.
+
+        Returns the previous value.
+        """
+        return self.__set_output_flag("numeric_time", val)
+
+    def get_terse_output(self):
+        """Get the current state of terse output.
+
+        Returns a boolean indicating whether terse output is active or not.
+        """
+        return self.__get_output_flag("terse")
+
+    def set_terse_output(self, val):
+        """Enable or disable terse output.
+
+        Accepts a boolean turning terse output either on or off.
+
+        Returns the previous value.
+        """
+        return self.__set_output_flag("terse", val)
+
     def get_debug(self):
         """Get currently active debug flags.
 
-- 
2.23.0

