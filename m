Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47480227B59
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jul 2020 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGUJEu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jul 2020 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGUJEt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:04:49 -0400
X-Greylist: delayed 1990 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jul 2020 02:04:49 PDT
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED67C061794
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vr5BY6x1L2drsWA3P3XrCNE771NsvvB6xZimeUg4lZs=; b=JZPjudKyxmQRdLh556pKlRaWbH
        CVX7RMEwgLQeIfGCGHrj6CvPH/vYT9ZbODQ8MYdGTYJzD2ic1on3AHW7ebMgDTocSpx6YDzwaycWw
        ERhgdhNyeNJ5SbQ8G7lyXi3blHjZ0g4RBUOHRJZI1HfdZ/sDhFq5gq+1wAgL4sUKeu3HKlUcOMdZ4
        8iHtvp4W3Tu5qqptJ8BZXATxFbpR7bLLnj+DTSt/7JmeMENEbXJcuKM85g4kGfqfdkjsYn3AnPvOr
        5wfK0xhNg3c97N5v2Q5fLctfraGYKYJHKERv9hoLOht3hHYojp7sNLgTOay1+JqMzQkWx7zLdtN/u
        Yx+xfFSg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1jxngW-0006Vv-J6; Tue, 21 Jul 2020 09:31:36 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons] doc: fix quoted string in libxt_DNETMAP man-page.
Date:   Tue, 21 Jul 2020 09:31:36 +0100
Message-Id: <20200721083136.710735-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In roff, lines beginning with a single quote are control lines.  In the
libxt_DNETMAP man-page there is a single-quoted string at the beginning
of a line, which troff tries and fails to interpret as a macro:

  troff: <standard input>:49: warning: macro 'S'' not defined

This means that the line is not output.

Adjust the formatting of the paragraph to move the string from the
beginning of the line.

Fixes: 2b38d081a50b ("doc: spelling and grammar corrections to DNETMAP")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/libxt_DNETMAP.man | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/extensions/libxt_DNETMAP.man b/extensions/libxt_DNETMAP.man
index 7a8fe404435b..56cd2a68c6e6 100644
--- a/extensions/libxt_DNETMAP.man
+++ b/extensions/libxt_DNETMAP.man
@@ -45,8 +45,8 @@ The module creates the following entries for each new specified subnet:
 Contains the binding table for the given \fIsubnet/mask\fP. Each line contains
 \fBprenat address\fR, \fBpostnat address\fR, \fBttl\fR (seconds until the entry
 times out), \fBlasthit\fR (last hit to the entry in seconds relative to system
-boot time). Please note that the \fBttl\fR and \fBlasthit\fR entries contain an
-'\fBS\fR' in case of a static binding.
+boot time). Please note that the \fBttl\fR and \fBlasthit\fR entries contain
+an '\fBS\fR' in case of a static binding.
 .TP
 \fB/proc/net/xt_DNETMAP/\fR\fIsubnet\fR\fB_\fR\fImask\fR\fB_stat\fR
 Contains statistics for a given \fIsubnet/mask\fP. The line contains four
-- 
2.27.0

