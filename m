Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04758E1AD
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Aug 2022 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiHIVSh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Aug 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiHIVSR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:18:17 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6207152E7E
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Aug 2022 14:18:16 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/2] --optimize fixes
Date:   Tue,  9 Aug 2022 23:18:10 +0200
Message-Id: <20220809211812.749217-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

Two more fixes for the -o/--optimize infrastructure, reported by users
after the release:

1) do not hit assert() when concatenation already exists in the ruleset.
2) do not merge rules unless they contain at least one mergeable statement.

Both patches come with tests to illustrate the issues.

Pablo Neira Ayuso (2):
  optimize: merging concatenation is unsupported
  optimize: check for mergeable rules

 src/optimize.c                                | 32 ++++++++++++++++++-
 .../dumps/merge_stmts_concat.nft              |  1 +
 .../optimizations/dumps/not_mergeable.nft     | 12 +++++++
 .../optimizations/merge_stmts_concat          |  1 +
 .../testcases/optimizations/not_mergeable     | 16 ++++++++++
 5 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tests/shell/testcases/optimizations/dumps/not_mergeable.nft
 create mode 100755 tests/shell/testcases/optimizations/not_mergeable

-- 
2.30.2

