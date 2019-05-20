Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4BE240E2
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfETTIb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 15:08:31 -0400
Received: from mail.us.es ([193.147.175.20]:38338 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfETTIb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 15:08:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 12FDCBAEE7
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:29 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06E6DDA706
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F0DF8DA704; Mon, 20 May 2019 21:08:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DA7B5DA701;
        Mon, 20 May 2019 21:08:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 21:08:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A71324265A31;
        Mon, 20 May 2019 21:08:26 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH iptables 0/6] ERESTART fixes
Date:   Mon, 20 May 2019 21:08:16 +0200
Message-Id: <20190520190822.18873-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

A batch of patches to fix concurrent updates via iptables-restore that
result in ERESTART errors in iptables.

Pablo Neira Ayuso (5):
  nft: keep original cache in case of ERESTART
  nft: don't skip table addition from ERESTART
  nft: don't care about previous state in ERESTART
  nft: do not retry on EINTR
  nft: reset netlink sender buffer size of socket restart

Phil Sutter (1):
  xtables: Fix for explicit rule flushes

 iptables/nft.c | 79 ++++++++++++++++++++++++++++------------------------------
 iptables/nft.h |  3 ++-
 2 files changed, 40 insertions(+), 42 deletions(-)

-- 
2.11.0

