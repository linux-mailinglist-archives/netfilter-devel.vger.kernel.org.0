Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA2D9129
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Oct 2019 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393157AbfJPMkl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 08:40:41 -0400
Received: from correo.us.es ([193.147.175.20]:55114 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391329AbfJPMkl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:40:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 369041BFA84
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:37 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2869A123946
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1DF63123944; Wed, 16 Oct 2019 14:40:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3E477DA72F
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 16 Oct 2019 14:40:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 290EE42EE393
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:35 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5] Hook multiple netdevices to basechain
Date:   Wed, 16 Oct 2019 14:40:29 +0200
Message-Id: <20191016124034.9847-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This patchset extends the netdev family to allow for hooking multiple
devices to basechains, eg.

nft add table netdev x
nft add chain netdev x y { \
	type filter hook ingress devices = { eth0, eth1 } priority 0\; }

Hence you can apply the same policy to packet coming in from eth0 and
eth1 netdevices.

1) Add nft_flow_block_chain() helper function.

2) Pass callback list to nft_setup_cb_call().

3) Add nft_flow_cls_offload_setup() helper function.

4) Iterate over list of callbacks that belongs to the netdevices that
   is being unregister to remove the rules from the netdevice.

This patches comes in preparation for:

5) Allow for hooking multiple devices to the same netdev basechain.

Pablo Neira Ayuso (5):
  netfilter: nf_tables_offload: add nft_flow_block_chain()
  netfilter: nf_tables_offload: Pass callback list to nft_setup_cb_call()
  netfilter: nf_tables_offload: add nft_flow_cls_offload_setup()
  netfilter: nf_tables_offload: remove rules on unregistered device only
  netfilter: nf_tables: support for multiple devices per netdev hook

 include/net/netfilter/nf_tables.h        |   4 +-
 include/uapi/linux/netfilter/nf_tables.h |   2 +
 net/netfilter/nf_tables_api.c            | 296 ++++++++++++++++++++++++-------
 net/netfilter/nf_tables_offload.c        |  98 ++++++----
 net/netfilter/nft_chain_filter.c         |  45 +++--
 5 files changed, 325 insertions(+), 120 deletions(-)

-- 
2.11.0

