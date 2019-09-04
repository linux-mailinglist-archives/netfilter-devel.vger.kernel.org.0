Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284F9A82CC
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2019 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfIDM3M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Sep 2019 08:29:12 -0400
Received: from mx1.riseup.net ([198.252.153.129]:45366 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfIDM3M (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:29:12 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 17B681A0D11
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Sep 2019 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1567600152; bh=tqmZhqB6sfVsx3GrfuaSRsQaWiYdF+ECAuVgfy0Z64s=;
        h=From:To:Cc:Subject:Date:From;
        b=cLiv4r1lMkCMLXE6slDeHQ8PXEeyLoDY2dTWLqqD3Hve54vOd20Zt8AbRkoi+cQv6
         N49ZGW+Whwvvc4HZbwym0kfQHBw3UMGCzmWFMK/rC50Fag1vzG4nUGsuQVFPnfcy37
         GBq+Je63LU6BISzNKk/W2Y9QFS6rOK+EFvL5S1vw=
X-Riseup-User-ID: 405C6DB22057E2F223D3BE841BAF431D8C573D6DD78008CF184EC4CFBDF09B7D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 3AEC022388D;
        Wed,  4 Sep 2019 05:29:11 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nf-next v2] netfilter: nf_tables: fix possible null-pointer dereference in object update
Date:   Wed,  4 Sep 2019 14:29:07 +0200
Message-Id: <20190904122907.967-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Not all objects need an update operation. If the object type doesn't implement
an update operation and the user tries to update it there will be a EOPNOTSUPP
error instead of a null pointer.

Fixes: d62d0ba97b58 ("netfilter: nf_tables: Introduce stateful object update operation")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index cf767bc58e18..013d28899cab 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5140,6 +5140,9 @@ static int nf_tables_updobj(const struct nft_ctx *ctx,
 	struct nft_trans *trans;
 	int err;
 
+	if (!obj->ops->update)
+		return -EOPNOTSUPP;
+
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWOBJ,
 				sizeof(struct nft_trans_obj));
 	if (!trans)
-- 
2.20.1

