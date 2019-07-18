Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FA6CC13
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRJlX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Jul 2019 05:41:23 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55590 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfGRJlX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:41:23 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id B05361A02E0
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1563442882; bh=LZKxW3t/Fr4ylmsyPN9wlDxJDjZh7lonYnTc+S7rySM=;
        h=From:To:Cc:Subject:Date:From;
        b=goaC2PHBNMdzM8Z/GMVGpBudpHlcMQNSBuOmwbk4U80xgFGclPxIQvaXtKbUdJXL8
         4WiWWuVqRv3+fCtLke81ceRpyK/Ty4juXjVMVyTPx7jvRVTibFtyV8OHwhMQbT/Bxi
         A8pJCQ5D5zwzObbu4IX5woqYdS329nEW/BhY/Keg=
X-Riseup-User-ID: ADCD64C7C845223F7BE792FF1F48904B264C7A6FA760EE63880D0DC01A121973
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id DB1372235D6;
        Thu, 18 Jul 2019 02:41:21 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nft] include: json: add missing synproxy stmt print stub
Date:   Thu, 18 Jul 2019 11:41:14 +0200
Message-Id: <20190718094114.28800-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: 1188a69604c3 ("src: introduce SYNPROXY matching")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 include/json.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/json.h b/include/json.h
index ce57c9f..7f2df7c 100644
--- a/include/json.h
+++ b/include/json.h
@@ -180,6 +180,7 @@ STMT_PRINT_STUB(queue)
 STMT_PRINT_STUB(verdict)
 STMT_PRINT_STUB(connlimit)
 STMT_PRINT_STUB(tproxy)
+STMT_PRINT_STUB(synproxy)
 
 #undef STMT_PRINT_STUB
 #undef EXPR_PRINT_STUB
-- 
2.20.1

