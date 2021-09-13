Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91540881E
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Sep 2021 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhIMJ0I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Sep 2021 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbhIMJ0G (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:26:06 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79BC061762
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Sep 2021 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Kyf13SHRHM7ml5xod7x55G9a/8KoO3Bj0y+y+fHTO8k=; b=dzSDB7iCASVlIQDmso15h+//Dl
        GbBHEKRJfDVDLnlSbP1f4cZaUTCNg0CPXMmkU5N+p2xp783iiZp1PZkeoVwCi7U0GSwdN4uYTNfut
        Awp5khjsevAhV57rfhbmV+lXAErT9fOVXwbrk1OkPDbbtymBEm2o4GN2mMKi6bVNQL7wTSmj3bEy/
        HRsy7/kY9orMmQ7uUq9GBJY7x3J4rX0hZ9zZIumEY1D5qD5RfD5+/i337PlF7Brk29ICztTj4/e8i
        R9QCCIArDU7YRVNb+3uPJzUJHs/Uom6LN3Pd9A+l2e1ZahRaeVHRHQdjoWu8LGGNlFmMU4If/gO2Q
        gRmh4i8g==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mPiCm-00GLzi-7T; Mon, 13 Sep 2021 10:24:48 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>, kaskada@email.cz
Subject: [xtables-addons 0/4] IPv6 support for xt_ipp2p
Date:   Mon, 13 Sep 2021 10:20:47 +0100
Message-Id: <20210913092051.79743-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

* The first patch short-circuits searches if the packet is empty.
* The second and third patches refactor the ipv4 code in anticipation of
  adding ipv6 support.
* The fourth patch adds ipv6 support.

Jeremy Sowden (4):
  xt_ipp2p: don't search haystack if it's empty
  xt_ipp2p: move the protocol-specific code out into separate functions
  xt_ipp2p: move result printing code into separate functions
  xt_ipp2p: add ipv6 support

 extensions/libxt_ipp2p.c |   2 +-
 extensions/xt_ipp2p.c    | 293 ++++++++++++++++++++++++++++-----------
 2 files changed, 214 insertions(+), 81 deletions(-)

-- 
2.33.0

