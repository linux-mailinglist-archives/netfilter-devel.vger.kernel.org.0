Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A856A490
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfGPJI7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 05:08:59 -0400
Received: from mx1.riseup.net ([198.252.153.129]:50324 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfGPJI7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:08:59 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id D06DA1A01EC
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1563268138; bh=CcJmELnfBvUVJhIX5Cds+HgT1OHNPWeNAnFbC6Fxso8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjt3Dzi1xIF6ItKRcFLck2oKWdrLDhM8o80pjOKaVO7Er47VcXSq/aX1mBngBRKxM
         3x/Mz7r8UTIObJhf4NeNitQIPh+0qRIXbALGgTPrtbr0AYShd90GDzaFaUt0uFVj0L
         1V1v2S8exXE7S7cUEfQLJqHblyvKKxFudRKL4vbM=
X-Riseup-User-ID: 606DF106194DABB7551D3610CB6854A285FE8CFB6A4E72D49381F7D8BCD3D46E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id A8D811204FF;
        Tue, 16 Jul 2019 02:08:56 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH 2/2 nft WIP] src: allow variables in chain priority
Date:   Tue, 16 Jul 2019 11:08:14 +0200
Message-Id: <20190716090812.873-3-ffmancera@riseup.net>
In-Reply-To: <20190716090812.873-1-ffmancera@riseup.net>
References: <20190716090812.873-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 src/parser_bison.y | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index c6a43cf..d55a5fc 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1926,7 +1926,8 @@ extended_prio_name	:	OUT
 			|	STRING
 			;
 
-prio_expr		:	extended_prio_name
+prio_expr		:	variable_expr
+			|	extended_prio_name
 			{
 				$$ = constant_expr_alloc(&@$, &string_type,
 							 BYTEORDER_HOST_ENDIAN,
-- 
2.20.1

