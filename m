Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C646F7E6
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Dec 2021 01:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhLJAQM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Dec 2021 19:16:12 -0500
Received: from mail.netfilter.org ([217.70.188.207]:44330 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhLJAQL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:16:11 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id B2DCF60085
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Dec 2021 01:10:12 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5] nf_tables misc updates
Date:   Fri, 10 Dec 2021 01:12:26 +0100
Message-Id: <20211210001231.144098-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This patchset contains misc updates for nf_tables:

1) Remove unnecessary rcu read-size lock when updating chain counters.
   from the nft_do_chain() path.

2) Replace BUG_ON by WARN_ON_ONCE in nft_payload on buggy payload base.

3) Consolidate verdict tracing in nft_do_chain().

4) Replace WARN_ON() by WARN_ON_ONCE() in nft_do_chain() for unknown
   verdicts.

5) Make counters a built-in expression (IIRC, already suggested by Florian).

Pablo Neira Ayuso (5):
  netfilter: nf_tables: remove rcu read-size lock
  netfilter: nft_payload: WARN_ON_ONCE instead of BUG
  netfilter: nf_tables: consolidate rule verdict trace call
  netfilter: nf_tables: replace WARN_ON by WARN_ON_ONCE for unknown verdicts
  netfilter: nf_tables: make counter support built-in

 include/net/netfilter/nf_tables_core.h |  4 ++
 net/netfilter/Kconfig                  |  6 ---
 net/netfilter/Makefile                 |  3 +-
 net/netfilter/nf_tables_core.c         | 46 +++++++++++++++-----
 net/netfilter/nft_counter.c            | 59 +++++++-------------------
 net/netfilter/nft_payload.c            |  6 ++-
 6 files changed, 61 insertions(+), 63 deletions(-)

-- 
2.30.2

