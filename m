Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE3241C5B
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Aug 2020 16:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgHKO33 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Aug 2020 10:29:29 -0400
Received: from mx1.riseup.net ([198.252.153.129]:59938 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgHKO33 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:29:29 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BQwFj32YbzDsdh;
        Tue, 11 Aug 2020 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1597156169; bh=VADsgtDnd7eXMBl02BXytadUYrePXRXcCAGvd1I80Lw=;
        h=From:To:Cc:Subject:Date:From;
        b=koobMXISGrysM8zvJ1aAomN7g9et8LMovgSGMsDgTW10M6HQVev+VjPy71/3hBaSY
         3PCGexmXK+oYPKS/t/XvoTw+X8LRKatsXy+IkKb8z8AStGBLt6N2/lQUBP45e8EjVl
         dbxk0ei5b0BWe426F6E23uKi3enD458tOIMniqO0=
X-Riseup-User-ID: A8A2890408D6701D020A41C2E52FEAF1B477F3A350A9CF9EF29BA220D3291CC5
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BQwFh3jFFzJnn3;
        Tue, 11 Aug 2020 07:29:28 -0700 (PDT)
From:   "Jose M. Guisado Gomez" <guigom@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org
Subject: [PATCH libnftnl] udata: add NFTNL_UDATA_SET_COMMENT
Date:   Tue, 11 Aug 2020 16:27:19 +0200
Message-Id: <20200811142719.328237-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This field is used to store an optional comment of a set.

Signed-off-by: Jose M. Guisado Gomez <guigom@riseup.net>
---
 include/libnftnl/udata.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnftnl/udata.h b/include/libnftnl/udata.h
index 661493b..efa3f76 100644
--- a/include/libnftnl/udata.h
+++ b/include/libnftnl/udata.h
@@ -26,6 +26,7 @@ enum nftnl_udata_set_types {
 	NFTNL_UDATA_SET_DATA_TYPEOF,
 	NFTNL_UDATA_SET_EXPR,
 	NFTNL_UDATA_SET_DATA_INTERVAL,
+	NFTNL_UDATA_SET_COMMENT,
 	__NFTNL_UDATA_SET_MAX
 };
 #define NFTNL_UDATA_SET_MAX (__NFTNL_UDATA_SET_MAX - 1)
-- 
2.27.0

