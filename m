Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F75124547
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 12:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfLRLF3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 06:05:29 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:35968 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLRLF3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:05:29 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ihX8y-000778-54; Wed, 18 Dec 2019 12:05:28 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 0/9] netfilter: nft_meta: add support for slave device matching
Date:   Wed, 18 Dec 2019 12:05:12 +0100
Message-Id: <20191218110521.14048-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Martin Willi recently proposed addition of new xt_slavedev module to
allow matching the real interface within a VRF domain.

This adds an nft equivalent:

meta sdif "realdev" accept
meta sdifname "realdev" accept

In case packet had no vrf slave, sdif stores 0 or "" name, just
like 'oif/oifname' would on input.

sdif(name) is restricted to the ipv4/ipv6 input and forward hooks,
as it depends on ip(6) stack parsing/storing info in skb->cb[].

Because meta main eval function is now exceeding more than 200 LOC,
the first patches are diet work to debloat the function by using
helpers where appropriate.

Last patch adds the sdif/sdifname functionality.

Function                                     old     new   delta
nft_meta_get_eval_pkttype_lo                   -     588    +588
nft_meta_get_eval_time                         -     404    +404
nft_meta_get_eval_skugid                       -     397    +397
nft_meta_get_eval_cgroup                       -     234    +234
nft_meta_get_eval_sif                          -     148    +148
nft_meta_get_eval_kind                         -     138    +138
nft_meta_get_eval_sifname                      -      91     +91
nft_meta_get_validate                        111     169     +58
nft_prandom_u32                                -      20     +20
nft_meta_get_eval                           2904    1261   -1643
Total: Before=6076, After=6511, chg +7.16%


