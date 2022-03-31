Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156B4ED7A1
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Mar 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiCaKOf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Mar 2022 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiCaKOe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:14:34 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CE2B251
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Mar 2022 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/prMOZLyFvdUZFub4dQQbNSvk34gfrUfnBnxqHsG+3s=; b=KW6GXDvGe2cz/jRtnc4wRSQG0i
        E8RhN0d6N5iaHCaUgrPaFuIXeDsG77DUEHBfnjlEWVqxJqmJpRvftwH1ffCyx7ApNSeYh2eQaHOb7
        JLHLLDwgRH1sErNwsDISq/BrN9lW2+6YAo6CCbMuEMLAbNtkwhatmnsZj7rN2QxPKbxkw5fpA+/Nd
        mXvmvRV2Q/Y/mcBO38bJc9hkseR9OS9jEoqWT76k09uj7vb8GgSjHoF//HAJUYMbqxMllKw9J9MQk
        SayP2An9M+SyDpPc3gnmlHdnSPXYT0fv0lOLVIMvejPYAe4g9cgRONb2D/4UlrdssyZAm2hMBjVBg
        K2L0DzdA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nZrnJ-00068O-M7; Thu, 31 Mar 2022 12:12:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
Subject: [iptables PATCH v2 1/9] man: DNAT: Describe shifted port range feature
Date:   Thu, 31 Mar 2022 12:12:03 +0200
Message-Id: <20220331101211.10099-2-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331101211.10099-1-phil@nwl.cc>
References: <20220331101211.10099-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This wasn't mentioned anywhere.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libxt_DNAT.man | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/extensions/libxt_DNAT.man b/extensions/libxt_DNAT.man
index c3daea9a40394..e044c8216fc09 100644
--- a/extensions/libxt_DNAT.man
+++ b/extensions/libxt_DNAT.man
@@ -10,7 +10,7 @@ should be modified (and all future packets in this connection will
 also be mangled), and rules should cease being examined.  It takes the
 following options:
 .TP
-\fB\-\-to\-destination\fP [\fIipaddr\fP[\fB\-\fP\fIipaddr\fP]][\fB:\fP\fIport\fP[\fB\-\fP\fIport\fP]]
+\fB\-\-to\-destination\fP [\fIipaddr\fP[\fB\-\fP\fIipaddr\fP]][\fB:\fP\fIport\fP[\fB\-\fP\fIport\fP[\fB/\fIbaseport\fP]]]
 which can specify a single new destination IP address, an inclusive
 range of IP addresses. Optionally a port range,
 if the rule also specifies one of the following protocols:
@@ -18,6 +18,9 @@ if the rule also specifies one of the following protocols:
 If no port range is specified, then the destination port will never be
 modified. If no IP address is specified then only the destination port
 will be modified.
+If \fBbaseport\fP is given, the difference of the original destination port and
+its value is used as offset into the mapping port range. This allows to create
+shifted portmap ranges and is available since kernel version 4.18.
 .TP
 \fB\-\-random\fP
 If option
-- 
2.34.1

