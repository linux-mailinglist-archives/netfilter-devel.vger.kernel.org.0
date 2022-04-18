Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E582D504EA9
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Apr 2022 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiDRKMT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Apr 2022 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiDRKMN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:12:13 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520F12AA3
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Apr 2022 03:09:32 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ngOK1-0008QU-Sj; Mon, 18 Apr 2022 12:09:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/2] allow base integer type in concatenation
Date:   Mon, 18 Apr 2022 12:09:22 +0200
Message-Id: <20220418100924.5669-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
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

Now that we have typeof support for set keys there is no longer a
technical reason to reject use of datatypes with a zero size provided
that the set key concatenation can be used to retrieve a size instead.

This allows to use e.g. "ipsec in reqid" in a concatenated set key.

Florian Westphal (2):
  src: allow use of base integer types as set keys in concatenations
  tests: add concat test case with integer base type subkey

 src/evaluate.c                                | 24 +++++++++++++------
 .../testcases/maps/dumps/typeof_maps_0.nft    |  6 +++++
 tests/shell/testcases/maps/typeof_maps_0      |  6 +++++
 .../testcases/sets/dumps/typeof_sets_0.nft    |  9 +++++++
 tests/shell/testcases/sets/typeof_sets_0      |  9 +++++++
 5 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.35.1

