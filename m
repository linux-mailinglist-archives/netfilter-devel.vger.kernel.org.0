Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A213FA75C
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 21:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhH1Tlf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 15:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1Tle (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:41:34 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3365C061756
        for <netfilter-devel@vger.kernel.org>; Sat, 28 Aug 2021 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UHOquu/25BuWhYqgQmEVNS0NDHG+Qz/0TmfPr28tkaM=; b=ZBqNoNU9wB318c97EMYX4a+9dF
        sMznu/fLl6iynupr0rHNBiRa1Zycop3PAUQr6p8UCGt7eT1kn/eRJPXthdf6J60ra1GZtW/1aySu2
        ez3lTkfYo/pKZE6lixkvVd9aQOUq9QavQ59Cim7FmzrTlfTkNUtCukx6rmpjniCMZEp6loU89Iy79
        T6RgmipxOwqOlY/VGG6xlcaiAsVOUn81NV/bjwj+F3uFNBaSvWs9mRADT4ukEEo0LV2kK0nbw+som
        +sKk87w/2zl+uiXvQid16iQNGGs3pzevfg+ExdaE4ZGXZTfZEwu1gVCxGlNluZG6D1iDXWw4Iudhv
        HdJIslKQ==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mK4C1-00FeN7-Bg; Sat, 28 Aug 2021 20:40:41 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH libnetfilter_log 0/6] Implementation of some fields omitted by `ipulog_get_packet`.
Date:   Sat, 28 Aug 2021 20:38:18 +0100
Message-Id: <20210828193824.1288478-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The first four patches contain some miscellaneous improvements, then the
last two add code to retrieve time-stamps and interface names from
packets.

Incidentally, I notice that the last release of libnetfilter_log was in
2012.  Time for 1.0.2, perhaps?

Jeremy Sowden (6):
  Add doxygen directory to .gitignore.
  build: remove references to non-existent man-pages.
  doc: fix typo's in example.
  src: use calloc instead of malloc + memset.
  libipulog: use correct index to find attribute in packet.
  libipulog: fill in missing packet fields.

 .gitignore             |  1 +
 Makefile.am            |  4 +---
 src/libipulog_compat.c | 28 ++++++++++++++++++----------
 src/libnetfilter_log.c | 12 +++++-------
 utils/ulog_test.c      |  7 +++++++
 5 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.33.0

