Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665862B4578
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Nov 2020 15:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgKPODE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Nov 2020 09:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPODE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:03:04 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EE5C0613CF
        for <netfilter-devel@vger.kernel.org>; Mon, 16 Nov 2020 06:03:04 -0800 (PST)
Received: from localhost ([::1]:51046 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kef5y-0001Rq-UV; Mon, 16 Nov 2020 15:03:03 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/3] Merge some common code
Date:   Mon, 16 Nov 2020 15:02:35 +0100
Message-Id: <20201116140238.25955-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is basically fallout from an upcoming larger code merge around
arptables:

Patch 1 extends MAC address parsing capabilities of libxtables so the
various implementations in extensions and xtables code may be dropped.

Patch 2 is a requirement for patch 3 but rather large: It changes the
code to not use arptables-specific inv-flags (ARPT_INV_*) anymore as
they clash badly with iptables-ones (IPT_INV_*).

Patch 3 merges the three copies of 'commands_v_options' table along with
generic_opt_check() routine as well as 'optflags' array and opt2char()
routine. Both are extended to work for arptables as well.

Phil Sutter (3):
  libxtables: Extend MAC address printing/parsing support
  xtables-arp: Don't use ARPT_INV_*
  xshared: Merge some command option-related code

 extensions/libarpt_mangle.c                   | 13 +--
 extensions/libebt_arp.c                       | 50 +---------
 extensions/libebt_stp.c                       | 60 ++----------
 extensions/libxt_mac.c                        | 15 +--
 include/xtables.h                             |  3 +
 iptables/ip6tables.c                          | 79 ----------------
 iptables/iptables.c                           | 80 ----------------
 iptables/nft-arp.c                            | 92 +++++++------------
 iptables/nft-arp.h                            |  7 ++
 iptables/nft-bridge.c                         | 37 +-------
 .../ipt-save/dumps/ipt-save-filter.txt        |  4 +-
 iptables/xshared.c                            | 74 +++++++++++++++
 iptables/xshared.h                            | 20 ++--
 iptables/xtables-arp.c                        | 86 +++--------------
 iptables/xtables-eb-translate.c               |  8 +-
 iptables/xtables-eb.c                         | 59 ++----------
 iptables/xtables.c                            | 80 ----------------
 libxtables/xtables.c                          | 73 +++++++++++++++
 18 files changed, 248 insertions(+), 592 deletions(-)

-- 
2.28.0

