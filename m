Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341FA4D5E8
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Jun 2019 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFTSCI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Jun 2019 14:02:08 -0400
Received: from mx1.riseup.net ([198.252.153.129]:56184 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfFTSCH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:02:07 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 4087F1A0717
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Jun 2019 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1561053727; bh=+/BRf4xpp1QS6CPSz/Zpi1Y+DrfukqaJPO0chKILwWg=;
        h=From:To:Cc:Subject:Date:From;
        b=Cq1m34XnoqodCqq4bmHr0QbE7AoCelR26MpeaJMt77k7pJYSCkIEIXz2F7KhaLz4t
         hTzjHB/ljPg20VkGe9VRZzgMMrPSPT7Szit2yJ58CMZFNm71n/n/2BvlxquUrkJSLg
         IdYBtC9T/7DWBRv56L3/ECM3uoApM9rTp6P1d4aI=
X-Riseup-User-ID: F2AD1D4358F0C5D6672404BB5EA026A534FF22D9BB7CB73AA90697D2FFD4EFFE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 5F11D1203FD;
        Thu, 20 Jun 2019 11:02:06 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nf-next] netfilter: synproxy: fix manual bump of the reference counter
Date:   Thu, 20 Jun 2019 20:01:59 +0200
Message-Id: <20190620180159.1470-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This operation is handled by nf_synproxy_ipv4_init() now.

Fixes: d7f9b2f18eae ("netfilter: synproxy: extract SYNPROXY infrastructure from {ipt, ip6t}_SYNPROXY")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 net/ipv4/netfilter/ipt_SYNPROXY.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/netfilter/ipt_SYNPROXY.c b/net/ipv4/netfilter/ipt_SYNPROXY.c
index 7f7979734fb4..0c80616c00b5 100644
--- a/net/ipv4/netfilter/ipt_SYNPROXY.c
+++ b/net/ipv4/netfilter/ipt_SYNPROXY.c
@@ -82,7 +82,6 @@ static int synproxy_tg4_check(const struct xt_tgchk_param *par)
 		return err;
 	}
 
-	snet->hook_ref4++;
 	return err;
 }
 
-- 
2.20.1

