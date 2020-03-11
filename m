Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F609181B2F
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2020 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgCKOaX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Mar 2020 10:30:23 -0400
Received: from correo.us.es ([193.147.175.20]:41044 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgCKOaX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:30:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D9BA6DA708
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:29:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CB38EDA3AE
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:29:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BFAEDDA3A9; Wed, 11 Mar 2020 15:29:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0AECDA3C2
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:29:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 11 Mar 2020 15:29:57 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id CB60742EF42B
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:29:57 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 0/5 nf-next,v2] enhance stateful expression support
Date:   Wed, 11 Mar 2020 15:30:11 +0100
Message-Id: <20200311143016.4414-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patchset allows users to add and to restore stateful expressions
of set elements, e.g.

 table ip test {
        set test {
                type ipv4_addr
                size 65535
                flags dynamic,timeout
                timeout 30d
                gc-interval 1d
                elements = { 192.168.10.13 expires 19d23h52m27s576ms counter packets 51 bytes 17265 }
        }
        chain output {
                type filter hook output priority 0;
                update @test { ip saddr }
        }
 }

You can also add counters to elements from the control place, ie.

 table ip test {
        set test {
                type ipv4_addr
                size 65535
                elements = { 192.168.2.1 counter packets 75 bytes 19043 }
        }

        chain output {
                type filter hook output priority filter; policy accept;
                ip daddr @test
        }
 }

v2: Missing patch to add nft_set_elem_expr_alloc() helper function.

Pablo Neira Ayuso (5):
  netfilter: nf_tables: add nft_set_elem_expr_alloc()
  netfilter: nf_tables: remove EXPORT_SYMBOL_GPL for nft_expr_init()
  netfilter: nf_tables: add elements with stateful expressions
  netfilter: nf_tables: add nft_set_elem_update_expr() helper function
  netfilter: nft_lookup: update element stateful expression

 include/net/netfilter/nf_tables.h | 18 +++++++++++--
 net/netfilter/nf_tables_api.c     | 55 ++++++++++++++++++++++++++++++++++++---
 net/netfilter/nft_dynset.c        | 23 +++-------------
 net/netfilter/nft_lookup.c        |  1 +
 4 files changed, 72 insertions(+), 25 deletions(-)

--
2.11.0

