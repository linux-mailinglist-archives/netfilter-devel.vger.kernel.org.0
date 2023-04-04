Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F296D6574
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Apr 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDDOeu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Apr 2023 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjDDOeq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:34:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4149810EA
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Apr 2023 07:34:44 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/4] revisit NAT redirect support
Date:   Tue,  4 Apr 2023 16:34:33 +0200
Message-Id: <20230404143437.133493-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is a batch to revisit NAT redirect support:

Patch #1 add a few assert() to src/optimize.c related to NAT support.

Patch #2 relax check for explicit transport protocol match if NAT
	 expression implicitly refers to transport protocol match.

Patch #3 remove workaround required before patch #2

Patch #4 add -o/--optimize support for NAT redirect (and masquerade).

Pablo Neira Ayuso (4):
  optimize: assert nat type on nat statement helper
  evaluate: bogus missing transport protocol
  netlink_delinearize: do not reset protocol context for nat protocol expression
  optimize: support for redirect and masquerade

 src/evaluate.c                                |  11 +-
 src/netlink_delinearize.c                     |   4 +-
 src/optimize.c                                | 140 +++++++++++++-----
 .../optimizations/dumps/merge_nat.nft         |   4 +
 tests/shell/testcases/optimizations/merge_nat |   7 +
 5 files changed, 127 insertions(+), 39 deletions(-)

-- 
2.30.2

