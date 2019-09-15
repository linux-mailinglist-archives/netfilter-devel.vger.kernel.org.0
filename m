Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0716CB2FF2
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Sep 2019 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfIOMkH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Sep 2019 08:40:07 -0400
Received: from mx1.riseup.net ([198.252.153.129]:42964 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfIOMkH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Sep 2019 08:40:07 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 007521A3215
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Sep 2019 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1568551207; bh=VY14p9VEwCetK5qD7jzGDmGVPWYn3Sld58ckse3QG7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Ajliy1j2iP/A66yIwu9Zh7EV4VuZT048vjaJXM93FYcbi0p098uL0t/WnOdtvv55F
         XauPqrFY0yQ2W+Llqq3INwJh1d9CYKvOxuYkmX7HCIsaCYlADZXWUOOnlufRiWaeft
         +Ha4n3QthXljVFQrnwzg89vMx9F1WdEF3BQy5nBc=
X-Riseup-User-ID: 7A021D95372E1169604E5B080C10FBBD4291A845EAFA3DA7373E0CFDCF643C80
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id B84AA120698;
        Sun, 15 Sep 2019 05:40:05 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nft] json: tests: fix typo in ct expectation json test
Date:   Sun, 15 Sep 2019 14:39:55 +0200
Message-Id: <20190915123955.1969-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The correct form is "ct expectation" not "ct expect". That was causing the
tests/py/ip/object.t json test to fail.

Fixes: 1dd08fcfa07a ("src: add ct expectations support")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 tests/py/ip/objects.t.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/py/ip/objects.t.json b/tests/py/ip/objects.t.json
index 634f192..a70dd9e 100644
--- a/tests/py/ip/objects.t.json
+++ b/tests/py/ip/objects.t.json
@@ -196,7 +196,7 @@
 # ct expectation set "ctexpect1"
 [
     {
-        "ct expect": "ctexpect1"
+        "ct expectation": "ctexpect1"
     }
 ]
 
-- 
2.20.1

