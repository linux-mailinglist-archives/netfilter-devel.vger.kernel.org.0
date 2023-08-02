Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCC76D36A
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Aug 2023 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjHBQKv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Aug 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHBQKu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:10:50 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124AE1
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Aug 2023 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xU8sNqJgSvJcAdqwfKPbRimnpu6NfYG9t1KcXFMChCQ=; b=CVl/BpJgb8XPa4opMVoKnuLRFV
        J89pNVLzKm+jg+Rjdl2JhqdKQ36vbdW2rpS7RwZfM1UVVMzj+r3JaGv3D4tAqimRI8NqmZ/dh2gn7
        fSMjewKo7N9sveG4q1Ef6eAf+br6FUj30LmDiHtaOd9op8A/oOLVG3+HZNlFEgmzmnfF68mX7W0f1
        /fAzqT1fZObTPyZBfatThMF7OSIUHBN8IyUFkdcuv/hDPeSrPIU7QQNGa/La/DC7NYe2OL0ck7Xif
        JuR5fbXuYWcTqOLp7g9cBge7oMi3ybx3lNCzMpel1xG7HRvJZnDJX9dmbSsVwfgk74e2kBDpIVSS7
        B0qaOQyA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qREQx-0004ym-Vq
        for netfilter-devel@vger.kernel.org; Wed, 02 Aug 2023 18:10:48 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 15/15] man: iptables-save.8: Start paragraphs in upper-case
Date:   Wed,  2 Aug 2023 18:09:23 +0200
Message-Id: <20230802160923.17949-16-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802160923.17949-1-phil@nwl.cc>
References: <20230802160923.17949-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Also add a missing full stop.

Fixes: 117341ada43dd ("Added iptbles-restore and iptables-save manpages")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/iptables-save.8.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/iptables/iptables-save.8.in b/iptables/iptables-save.8.in
index 118dddcdf62d5..65c1f28ccc3c7 100644
--- a/iptables/iptables-save.8.in
+++ b/iptables/iptables-save.8.in
@@ -46,10 +46,10 @@ Specify a filename to log the output to. If not specified, iptables-save
 will log to STDOUT.
 .TP
 \fB\-c\fR, \fB\-\-counters\fR
-include the current values of all packet and byte counters in the output
+Include the current values of all packet and byte counters in the output.
 .TP
 \fB\-t\fR, \fB\-\-table\fR \fItablename\fP
-restrict output to only one table. If the kernel is configured with automatic
+Restrict output to only one table. If the kernel is configured with automatic
 module loading, an attempt will be made to load the appropriate module for
 that table if it is not already there.
 .br
-- 
2.40.0

