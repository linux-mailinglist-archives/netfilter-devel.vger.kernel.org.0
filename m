Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C528A5E1E
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIBXcI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 19:32:08 -0400
Received: from kadath.azazel.net ([81.187.231.250]:43938 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfIBXcH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hDHDCgYoOWvYdGIiEvIkg/R709cjZHTGdsMOCZ1IUuU=; b=EXT/T6CnNw39ZRnqU50MI8pdi7
        d/dr6JpRltq/B5iHHFl0y1ZMxrz/56SblyDcfmDdgl5q0QWJG9phmP/yNrY0wUilX7hefTvvj8J6v
        nmRlw4VhAxm7TctC7nmFNuzyMxMZwTxtJQUIbmyBPQx3BIu+mEUrt3WeQMiJp9JjlzY0AZa5kIEKo
        E9LcmjrVhGK79s4lHO2xNRro2/DPmmLsTVIXU9FiQvCv/cMKmGxVCcEbt4a+Zm8wmm8CJObmSpBrs
        DE5iBjJlhh7/xTWGQVGq2UUovyQ+guSLgCp08sgR+lD/vEPHIvSRHuxG3OHqrj0meoCn/BtOOIFeG
        fNNh5q8g==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4vPT-0004la-3j; Tue, 03 Sep 2019 00:06:55 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 28/30] netfilter: add IP_SET_BITMAP config option.
Date:   Tue,  3 Sep 2019 00:06:48 +0100
Message-Id: <20190902230650.14621-29-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190902230650.14621-1-jeremy@azazel.net>
References: <20190902230650.14621-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a hidden tristate option which is selected by all the
IP_SET_BITMAP_* options.  It will be used to wrap ip_set_bitmap.h.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/ipset/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/ipset/Kconfig b/net/netfilter/ipset/Kconfig
index 3c273483df23..8a5498a86df0 100644
--- a/net/netfilter/ipset/Kconfig
+++ b/net/netfilter/ipset/Kconfig
@@ -25,9 +25,13 @@ config IP_SET_MAX
 	  The value can be overridden by the 'max_sets' module
 	  parameter of the 'ip_set' module.
 
+config IP_SET_BITMAP
+	tristate
+
 config IP_SET_BITMAP_IP
 	tristate "bitmap:ip set support"
 	depends on IP_SET
+	select IP_SET_BITMAP
 	help
 	  This option adds the bitmap:ip set type support, by which one
 	  can store IPv4 addresses (or network addresse) from a range.
@@ -37,6 +41,7 @@ config IP_SET_BITMAP_IP
 config IP_SET_BITMAP_IPMAC
 	tristate "bitmap:ip,mac set support"
 	depends on IP_SET
+	select IP_SET_BITMAP
 	help
 	  This option adds the bitmap:ip,mac set type support, by which one
 	  can store IPv4 address and (source) MAC address pairs from a range.
@@ -46,6 +51,7 @@ config IP_SET_BITMAP_IPMAC
 config IP_SET_BITMAP_PORT
 	tristate "bitmap:port set support"
 	depends on IP_SET
+	select IP_SET_BITMAP
 	help
 	  This option adds the bitmap:port set type support, by which one
 	  can store TCP/UDP port numbers from a range.
-- 
2.23.0.rc1

