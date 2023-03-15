Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04C36BBF5F
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Mar 2023 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjCOVsK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Mar 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCOVsJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:48:09 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181DEF9E
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Mar 2023 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o4KxpymZOsrNIiZ37Cob3j0Kqu8jJw9bE9aeZwX1GtI=; b=NK/lcMeuJ9vh+e3sVjsgXasGJ1
        DZsjz9S3lIyw48LTi/otXr9ZuHDgvOT/Ek5sZkxIODpi6MNXoS/nt5ISynHYcizKRNFC6nwv5qCEf
        0fYRtuhjGAl++reAMcC8NAMgo//BvnVJjjFg4ZBsq9/tg0osJvDw990yP+KinBWk7rAHjliMcre/L
        JP8AUxnaDaWiyqGoRyHYX8lujPIXv9qD4wHHk1xMLIBdnSjb2RffX/TGVBQ4AqQ5Hyv04W0pR4v0V
        SUeG/fmBKDyPei9Tj9rofQq4AbSzeFkSVVsjpK7rxUEC/mvZXoQg5YP+zD1Ku/zGZYkUFsnGGy/qr
        7blHXhoQ==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1pcYyc-009sxd-Hm
        for netfilter-devel@vger.kernel.org; Wed, 15 Mar 2023 21:48:06 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 0/2] NF NAT deduplication refactoring
Date:   Wed, 15 Mar 2023 21:48:00 +0000
Message-Id: <20230315214802.236464-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315214802.236464-1-jeremy@azazel.net>
References: <20230315214802.236464-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These two patches perform refactoring in NF NAT modules to remove
duplicate code.

Changes since v1.

  * The two redirect patches in v1 have been merged.
  * The new `struct nf_nat_range2` instance in nf_nat_redirect.c is
    memset to zero.
  * The two `union nf_inet_addr` instances in nf_nat_redirect.c are
    zero-initialized.
  * The `WARN_ON` call in nf_nat_redirect.c has been removed.

Jeremy Sowden (2):
  netfilter: nft_redir: use `struct nf_nat_range2` throughout and
    deduplicate eval call-backs
  netfilter: nft_masq: deduplicate eval call-backs

 include/net/netfilter/nf_nat_redirect.h |  3 +-
 net/netfilter/nf_nat_redirect.c         | 71 ++++++++++-----------
 net/netfilter/nft_masq.c                | 75 +++++++++-------------
 net/netfilter/nft_redir.c               | 84 +++++++++----------------
 net/netfilter/xt_REDIRECT.c             | 10 ++-
 5 files changed, 101 insertions(+), 142 deletions(-)

-- 
2.39.2

