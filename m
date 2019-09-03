Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB08DA7647
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfICVdW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 17:33:22 -0400
Received: from mx1.riseup.net ([198.252.153.129]:37440 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfICVdW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:33:22 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 171531B94C6
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1567546402; bh=h9SrqIRirHmNkaUSSaWo/8tkvnZkqlbsosror37nF1E=;
        h=From:To:Cc:Subject:Date:From;
        b=bYa4QfCvJtGiPaVOfDQouYiHPRQ2ftPFFZe67baxTWI4nCliDRJg7eZB/agNUVGqK
         4N3QLwOEYGANwhlL2epSqCfzMVl03oZCS18YLEUC75Ce/zOnwWEd0aN2/4CL5a/zPQ
         aRlX90B1bShsjHtc+xh8Ce08786ETz69IXg7Cj6c=
X-Riseup-User-ID: 5BD92957FA9C2C76D2700FF20F34947F8DC2BA8631B4BD4C85F20B84DAC148D9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 28F04222E37;
        Tue,  3 Sep 2019 14:33:20 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nf] netfilter: nf_tables: fix possible null-pointer dereference in object update
Date:   Tue,  3 Sep 2019 23:33:13 +0200
Message-Id: <20190903213313.1080-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: d62d0ba97b58 ("netfilter: nf_tables: Introduce stateful object update operation")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 net/netfilter/nf_tables_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index cf767bc58e18..6893de9e1389 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6477,7 +6477,8 @@ static void nft_obj_commit_update(struct nft_trans *trans)
 	obj = nft_trans_obj(trans);
 	newobj = nft_trans_obj_newobj(trans);
 
-	obj->ops->update(obj, newobj);
+	if (obj->ops->update)
+		obj->ops->update(obj, newobj);
 
 	kfree(newobj);
 }
-- 
2.20.1

