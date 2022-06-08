Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2661E543904
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jun 2022 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiFHQ1i (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Jun 2022 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiFHQ1f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:27:35 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F3B4F447
        for <netfilter-devel@vger.kernel.org>; Wed,  8 Jun 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XpeMXjJY/9d2RZNUaVPx8guK85MjAz9D8aLcntSsrM0=; b=Q5wqCsKfUbaD1Ll8BeXGpPtpbV
        kBO4WtGmP+ds4oY4fENspfF0P9k2La8J4jxsF9RiKDjDRHIpKaDNpjEiqiZmwl++U4L0xybAjpC4p
        fdJmGwEYFK0hzFTSqiVX9zbKSP3ehgfD5KDeFLrNDvdaGNtth+BVqSjTaTdgnMM333r7fLmlkxt6V
        r5WWG0Wrx8AVVJdHldiCmCNsho8WCl1fvW+HNlsz9eVItWhRq0CN+tKrXHB4QBkZHLB2PAAon96gL
        HjwzKvE+phXX71DR+IkUcmnqM4/HYcn8lvEo9S+i9L5eXcXeb/80PzyYaO7KUFFpTo68/TOg3J2yW
        I5313vcg==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nyyWq-00084y-6V
        for netfilter-devel@vger.kernel.org; Wed, 08 Jun 2022 18:27:32 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 5/9] extensions: libebt_standard.t: Test logical-{in,out} as well
Date:   Wed,  8 Jun 2022 18:27:08 +0200
Message-Id: <20220608162712.31202-6-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220608162712.31202-1-phil@nwl.cc>
References: <20220608162712.31202-1-phil@nwl.cc>
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

These weren't used anywhere before. At least ensure they are only
allowed where claimed.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libebt_standard.t | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/extensions/libebt_standard.t b/extensions/libebt_standard.t
index c6c3172748d7b..97cb3baaf6d21 100644
--- a/extensions/libebt_standard.t
+++ b/extensions/libebt_standard.t
@@ -12,12 +12,17 @@
 :INPUT
 -i foobar;=;OK
 -o foobar;=;FAIL
+--logical-in br0;=;OK
+--logical-out br1;=;FAIL
 :FORWARD
 -i foobar;=;OK
 -o foobar;=;OK
+--logical-in br0 --logical-out br1;=;OK
 :OUTPUT
 -i foobar;=;FAIL
 -o foobar;=;OK
+--logical-in br0;=;FAIL
+--logical-out br1;=;OK
 :PREROUTING
 *nat
 -i foobar;=;OK
-- 
2.34.1

