Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA222769516
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Jul 2023 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGaLkn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Jul 2023 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjGaLkm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:40:42 -0400
Received: from taras.nevrast.org (unknown [IPv6:2a05:d01c:431:aa03:b7e1:333d:ea2a:b14e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC01E5F
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Jul 2023 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4J/7WTIW3x7BDHmyp+D2RB+nPfkl5c8cM7VSu7cFnaY=; b=BnjcvbzW2XKa2R+7sMqrFy+AP/
        PW31Of7HQnk2/9iBPxxhQpJtP8KS2Yj8z69Y7dv3xZeUQbiZp6taYro7ncZ+oW0QIFeH6kswto9d+
        uAyGbqJ0welSYl8xC68XTdWdL8QhbHSi6KtgpnSbUduVMWpUNB2h3kcfjV2+43yc3bzcByTIk8Ron
        cfeNB6TX/xKmVY6Fo3yM0rLQd6gKlVxDx4KcZLwmRAR3hhUEgOXb3S3AzyYVsczlBTc+Iy3HToYRD
        Wmxe1zpVRrZM8OMjakIt3ZxdKlZop87sz4biyUBFGjxo2ZB5hAs5R6/A7+I5AsJn+RvufNPLiALKz
        FyS1beEg==;
Received: from [2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608] (helo=ulthar.dreamlands)
        by taras.nevrast.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jeremy@azazel.net>)
        id 1qQRGP-0062Uw-1N
        for netfilter-devel@vger.kernel.org;
        Mon, 31 Jul 2023 12:40:37 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 1/3] py: move package source into src directory
Date:   Mon, 31 Jul 2023 12:40:22 +0100
Message-Id: <20230731114024.2836892-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731114024.2836892-1-jeremy@azazel.net>
References: <20230731114024.2836892-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on taras.nevrast.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Separate the actual package source from the build files.  In addition
to being a bit tidier, this will prevent setup.py being erroneously
installed when we introduce PEP-517 support in a later commit.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 py/Makefile.am           | 2 +-
 py/setup.py              | 2 +-
 py/{ => src}/__init__.py | 0
 py/{ => src}/nftables.py | 0
 py/{ => src}/schema.json | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename py/{ => src}/__init__.py (100%)
 rename py/{ => src}/nftables.py (100%)
 rename py/{ => src}/schema.json (100%)

diff --git a/py/Makefile.am b/py/Makefile.am
index f10ae360599f..4056aa61f820 100644
--- a/py/Makefile.am
+++ b/py/Makefile.am
@@ -1 +1 @@
-EXTRA_DIST = setup.py __init__.py nftables.py schema.json
+EXTRA_DIST = setup.py src
diff --git a/py/setup.py b/py/setup.py
index 8ad73e7b58e5..d08b8b129a81 100755
--- a/py/setup.py
+++ b/py/setup.py
@@ -10,7 +10,7 @@ setup(name='nftables',
       url='https://netfilter.org/projects/nftables/index.html',
       packages=['nftables'],
       provides=['nftables'],
-      package_dir={'nftables':'.'},
+      package_dir={'nftables':'src'},
       package_data={'nftables':['schema.json']},
       classifiers=[
           'Development Status :: 4 - Beta',
diff --git a/py/__init__.py b/py/src/__init__.py
similarity index 100%
rename from py/__init__.py
rename to py/src/__init__.py
diff --git a/py/nftables.py b/py/src/nftables.py
similarity index 100%
rename from py/nftables.py
rename to py/src/nftables.py
diff --git a/py/schema.json b/py/src/schema.json
similarity index 100%
rename from py/schema.json
rename to py/src/schema.json
-- 
2.40.1

