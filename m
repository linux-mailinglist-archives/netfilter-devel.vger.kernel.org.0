Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3411A0F51
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2020 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgDGOez (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Apr 2020 10:34:55 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:54928 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgDGOez (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:34:55 -0400
Received: from localhost ([::1]:39786 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jLpJW-0007dk-2o; Tue, 07 Apr 2020 16:34:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/3] nft: cache: Minor review
Date:   Tue,  7 Apr 2020 16:34:42 +0200
Message-Id: <20200407143445.26394-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Minor code simplification in patches 1 and 2, a small tweak to set
fetching in patch 3.

Basically these are fall-out from working at rewritten cache logic.

Phil Sutter (3):
  nft: cache: Eliminate init_chain_cache()
  nft: cache: Init per table set list along with chain list
  nft: cache: Fetch sets per table

 iptables/nft-cache.c | 57 ++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

-- 
2.25.1

