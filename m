Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0E20E24A
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2020 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgF2VD7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Jun 2020 17:03:59 -0400
Received: from correo.us.es ([193.147.175.20]:49622 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbgF2VDp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:03:45 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 20CB0E34CA
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2020 23:03:43 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1128CDA78D
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2020 23:03:43 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 06BA7DA78C; Mon, 29 Jun 2020 23:03:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7379BDA722
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2020 23:03:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 29 Jun 2020 23:03:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 5704C42EF9E0
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2020 23:03:40 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5,v2] nftables: support for implicit chains binding
Date:   Mon, 29 Jun 2020 23:03:32 +0200
Message-Id: <20200629210337.30008-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is a second version for the patch series entitled:

	"support for anonymous non-base chains in nftables" [1]

Changes since last patchset are:

* The kernel dynamically allocates the (internal) chain name, unless
  userspace provides an chain name.

* Remove the chain from the lists and decrement the reference counters
  before the commit path (from nft_data_release() path). This
  ensures no ongoing netlink dump over the chain list ends up walking over
  a chain object while being released.

* Add nft_chain_add() in a new patch to re-add the chain into the list
  if the preparation phase fails, given that nft_data_release() now
  zaps the chain from the list.

[1] https://marc.info/?l=netfilter-devel&m=159310902001476&w=2

Pablo Neira Ayuso (5):
  netfilter: nf_tables: add NFTA_RULE_CHAIN_ID attribute
  netfilter: nf_tables: add NFTA_VERDICT_CHAIN_ID attribute
  netfilter: nf_tables: expose enum nft_chain_flags through UAPI
  netfilter: nf_tables: add nft_chain_add()
  netfilter: nf_tables: add NFT_CHAIN_BINDING

 include/net/netfilter/nf_tables.h        |  20 ++-
 include/uapi/linux/netfilter/nf_tables.h |   9 ++
 net/netfilter/nf_tables_api.c            | 158 +++++++++++++++++++----
 net/netfilter/nft_immediate.c            |  51 ++++++++
 4 files changed, 204 insertions(+), 34 deletions(-)

-- 
2.20.1

