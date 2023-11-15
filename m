Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673ED7E3AE5
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Nov 2023 12:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjKGLQJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Nov 2023 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjKGLQG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:16:06 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026A102
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Nov 2023 03:15:56 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r0K3m-0002EA-II; Tue, 07 Nov 2023 12:15:54 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 iptables 0/4] xtables-nft: add arptranslate support
Date:   Tue,  7 Nov 2023 12:15:36 +0100
Message-ID: <20231107111544.17166-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series adds support for arptranslate to xtables-nft.
First patch adds missing value/mask support, second patch
adds arptranslate.

Patch 3 adds test cases.  Finally, patch 4 fixes -j MARK and adds
test cases for it.

Florian Westphal (4):
  nft-arp: add missing mask support
  nft-arp: add arptables-translate
  arptables-txlate: add test cases
  extensions: MARK: fix arptables support

 extensions/generic.txlate        |   6 ++
 extensions/libarpt_mangle.c      |  47 +++++++++
 extensions/libarpt_mangle.txlate |   6 ++
 extensions/libxt_MARK.c          |   2 +
 extensions/libxt_MARK.txlate     |   9 ++
 iptables/nft-arp.c               | 174 ++++++++++++++++++++++++++++++-
 iptables/nft-ruleparse-arp.c     |   8 ++
 iptables/xtables-multi.h         |   1 +
 iptables/xtables-nft-multi.c     |   1 +
 iptables/xtables-translate.c     |  35 ++++++-
 xlate-test.py                    |   4 +-
 11 files changed, 289 insertions(+), 4 deletions(-)
 create mode 100644 extensions/libarpt_mangle.txlate

-- 
2.41.0

