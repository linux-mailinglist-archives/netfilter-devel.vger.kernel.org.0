Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5822912DF09
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jan 2020 14:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAANld (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jan 2020 08:41:33 -0500
Received: from kadath.azazel.net ([81.187.231.250]:57512 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAANld (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jan 2020 08:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sXBCLl3l3aqSd43TdhA6XnVGVZAXGdRkFdqnN68nFGA=; b=felyPd6LpryiDtebaq8ld/5Je3
        JXScAVoqzyNILVHwlgcZDeGmyQXOGD7ObVaFJsmsNjAoycK76UeJol9O8CxMKd/1z6YjdRaSedDnT
        Eex0MaYb7AqY+Msbncgt2n/jVvK9FgAbxvV7pn6gxlpuID9rrmu8zqFUI3B9SUm5SbmjFakZimImj
        JzyPzEZhiqVhknOW7EPdRQJ9O6EJsqNo0yRJOOtxZPYRLvONpl3xQaL2y3TJZdttjh0/mENoLgEuZ
        35zHV8pupNldm6GsqVbMT2YAFw/G10Zzm2EMcmVR3daqCidanuzuDiZvf3Qi4yISYyt0OO6siCA+Y
        krLyfBYQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1imeFg-0008Q1-De
        for netfilter-devel@vger.kernel.org; Wed, 01 Jan 2020 13:41:32 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next] netfilter: nft_bitwise: correct uapi header comment.
Date:   Wed,  1 Jan 2020 13:41:32 +0000
Message-Id: <20200101134132.169496-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The comment documenting how bitwise expressions work includes a table
which summarizes the mask and xor arguments combined to express the
supported boolean operations.  However, the row for OR:

 mask    xor
 0       x

is incorrect.

  dreg = (sreg & 0) ^ x

is not equivalent to:

  dreg = sreg | x

What the code actually does is:

  dreg = (sreg & ~x) ^ x

Update the documentation to match.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index e237ecbdcd8a..dd4611767933 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -501,7 +501,7 @@ enum nft_immediate_attributes {
  *
  * 		mask	xor
  * NOT:		1	1
- * OR:		0	x
+ * OR:		~x	x
  * XOR:		1	x
  * AND:		x	0
  */
-- 
2.24.1

