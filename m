Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4593C23A92
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbfETOl1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 10:41:27 -0400
Received: from mail.us.es ([193.147.175.20]:37326 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbfETOlY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 15D3CC1A66
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 16:41:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06ACDDA717
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 16:41:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EF290DA704; Mon, 20 May 2019 16:41:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F1AE7DA704;
        Mon, 20 May 2019 16:41:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 16:41:18 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id BF4AF4265A32;
        Mon, 20 May 2019 16:41:18 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, phil@nwl.cc
Subject: [PATCH iptables RFC 0/4] revisit RESTART log
Date:   Mon, 20 May 2019 16:41:11 +0200
Message-Id: <20190520144115.29732-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This still does not work, still searching for more bugs here.

Patch 1) Remove skip logic from __nft_table_flush(), before we
	 hit ERESTART. Better do not preventively skip table flush.

Patch 2) Keeps the original cache, while we introduce a new cache
         that is used when we hit ERESTART.

Patch 3) Remove NFT_COMPAT_TABLE_ADD case from refresh transaction,
         I don't find a scenario for this.

Patch 4) Reevaluate based on the existing cache, not on the previous
         object state. Original commit doesn't mention, but
	 NFT_COMPAT_CHAIN_USER_ADD only makes sense to me to do
	 the special handling from h->noflush.

I can still see the test still fails most of the time with:

line 5: CHAIN_USER_ADD failed (File exists): chain UC-0

which should not happen if table exists, because a flush should have
happened before.

Pablo Neira Ayuso (4):
  nft: don't check for table existence from __nft_table_flush()
  nft: keep original cache in case of ERESTART
  nft: don't skip table addition from ERESTART
  nft: don't care about previous state in RESTART

 iptables/nft.c | 77 +++++++++++++++++++++++++++++++---------------------------
 iptables/nft.h |  3 ++-
 2 files changed, 43 insertions(+), 37 deletions(-)

-- 
2.11.0

