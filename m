Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB54AC0EB
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Feb 2022 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiBGOSC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Feb 2022 09:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389049AbiBGNvD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:51:03 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A113BC0401C2
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Feb 2022 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=P//dhnCs+l6cHRJtSTc0TQ3xaDmfLJBU3W17lx9sY04=; b=kgZwUaZx7Ms/ldAHOtLyEBuGOz
        2kEJXgh4iDOYcJrezcLjUZqu7/hL37pY/19sB8fC+kiNalwAVctsmnM/z7dyZg06xZuzindqR+/zy
        qJ+Ch7GCK8TxdbnihSR9rkbnJW3PtpiqmqsFj5eFnNkjcIpU1YPVtvc5hZjBMMVdOYOobUni4Tkdp
        V0pvtx2S9eZXEZNHzvbSRH04bal+uST6db9pqZgjm5ghcIbv4+ysum9OYKNYVUKCcivtaRA7krLQ5
        Gd/sdM1Eqf7slK4x7t0KAijAdrJaW2mdL9+hmLpTKSvIgZZnj8vENBYyJJSZ7a//JVfAV5HPtHScf
        fLKHEQvA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nH4Q0-0007fD-Sp; Mon, 07 Feb 2022 14:51:00 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnetfilter_conntrack PATCH 1/2] tests: Fix for missing qa-connlabel.conf in tarball
Date:   Mon,  7 Feb 2022 14:50:47 +0100
Message-Id: <20220207135048.17147-1-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
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

Register the file as extra dist so 'make dist' picks it up.

Fixes: 6510a98f4139f ("api: add connlabel api and attribute")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 20ebaf2e5b851..56c78d9424326 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -3,6 +3,8 @@ include $(top_srcdir)/Make_global.am
 check_PROGRAMS = test_api test_filter test_connlabel ct_stress \
 	ct_events_reliable
 
+EXTRA_DIST = qa-connlabel.conf
+
 test_api_SOURCES = test_api.c
 test_api_LDADD = ../src/libnetfilter_conntrack.la
 
-- 
2.34.1

