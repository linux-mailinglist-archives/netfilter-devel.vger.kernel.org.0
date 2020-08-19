Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F6249A7A
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Aug 2020 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHSKhb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Aug 2020 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHSKh3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:37:29 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004FFC061757
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Aug 2020 03:37:28 -0700 (PDT)
Received: from localhost ([::1]:38128 helo=minime)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1k8LT8-0000EO-UF; Wed, 19 Aug 2020 12:37:22 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/4] ordered chain listing fallout
Date:   Wed, 19 Aug 2020 12:37:08 +0200
Message-Id: <20200819103712.12974-1-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The following four patches were partially contained within my ordered
chain listing series but unrelated. Submitting them separately to reduce
the actual series' size.

Phil Sutter (4):
  nft: cache: Check consistency with NFT_CL_FAKE, too
  nft: Extend use of nftnl_chain_list_foreach()
  nft: Fold nftnl_rule_list_chain_save() into caller
  nft: Use nft_chain_find() in nft_chain_builtin_init()

 iptables/nft-cache.c |   4 +-
 iptables/nft.c       | 210 ++++++++++++++++++++-----------------------
 2 files changed, 99 insertions(+), 115 deletions(-)

-- 
2.27.0

