Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D840A13B44D
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2020 22:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgANV3T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jan 2020 16:29:19 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55058 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgANV3T (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=feWnfsEA/Vu+OQME/kJTobs/aEedw8xcgH4agz8gr+8=; b=NQJURP2WN+9MLhH29A8cGaoDat
        Y0bH8cunlGiadWE7f+Jtt+qi+gUSe7P3wxrshKHzOrIwRmaaCoJ212KUF8/uVxDVNJY3z55XOxvVd
        umjG1HrcYiTpafyUnY3P2vneZySJ/YevrWDPtbuovjGnCB1oGT/4VZyVaf7vJYmdc2ZI2p9Nc/h5A
        PGbfleX6qmBDafahphIikmuWiPosa0IkQKRf3y+MSQsFW9a47PxqVFMmIThsJHWQbGe4Iwla7fmbY
        qwF6QoNg806QE7o3hFyKBi1fuHf6Smo+CXNeusaRMMBH2NXv94JzlgByeGYw0N6W8ckdtUoBYL1pB
        R8mq6NNQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1irTkU-0001Dh-KR; Tue, 14 Jan 2020 21:29:18 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 00/10] netfilter: nft_bitwise: shift support
Date:   Tue, 14 Jan 2020 21:29:08 +0000
Message-Id: <20200114212918.134062-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The connmark xtables extension supports bit-shifts.  Add support for
shifts to nft_bitwise in order to allow nftables to do likewise, e.g.:

  nft add rule t c oif lo ct mark set meta mark << 8 | 0xab
  nft add rule t c iif lo meta mark & 0xff 0xab ct mark set meta mark >> 8

Changes since v1:

  * more white-space fixes;
  * move bitwise op enum to UAPI;
  * add NFTA_BITWISE_OP and NFTA_BITWISE_DATA;
  * remove NFTA_BITWISE_LSHIFT and NFTA_BITWISE_RSHIFT;
  * add helpers for initializaing, evaluating and dumping different
    types of operation.

Jeremy Sowden (10):
  netfilter: nf_tables: white-space fixes.
  netfilter: bitwise: remove NULL comparisons from attribute checks.
  netfilter: bitwise: replace gotos with returns.
  netfilter: bitwise: add NFTA_BITWISE_OP netlink attribute.
  netfilter: bitwise: add helper for initializing boolean operations.
  netfilter: bitwise: add helper for evaluating boolean operations.
  netfilter: bitwise: add helper for dumping boolean operations.
  netfilter: bitwise: only offload boolean operations.
  netfilter: bitwise: add NFTA_BITWISE_DATA attribute.
  netfilter: bitwise: add support for shifts.

 include/uapi/linux/netfilter/nf_tables.h |  23 ++-
 net/netfilter/nft_bitwise.c              | 210 ++++++++++++++++++-----
 net/netfilter/nft_set_bitmap.c           |   4 +-
 net/netfilter/nft_set_hash.c             |   2 +-
 4 files changed, 192 insertions(+), 47 deletions(-)

-- 
2.24.1

