Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520155EF5ED
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Sep 2022 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiI2NB1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Sep 2022 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiI2NBX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:01:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16964145CA1
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Sep 2022 06:01:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1odtAE-00031R-TR; Thu, 29 Sep 2022 15:01:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/3] vlan followup fixes
Date:   Thu, 29 Sep 2022 15:01:10 +0200
Message-Id: <20220929130113.22289-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

vlan header matching in ip/ip6/inet families may not work, because
default behaviour is to remove the vlan header/tag information.

Update documentation to mention this.
Furthermore, dependency generation was broken so that even if the
vlan striping is disabled matching did not work, as the offset was
not computed correctly.

Add test cases for this too.

Florian Westphal (3):
  doc: mention vlan matching in ip/ip6/inet families
  evaluate: add ethernet header size offset for implicit vlan dependency
  tests: py: add vlan test case for ip/inet family

 doc/payload-expression.txt           |  8 +++++++
 src/evaluate.c                       | 20 ++++++++++++++++-
 tests/py/inet/ether.t                |  6 ++++++
 tests/py/inet/ether.t.json           | 32 ++++++++++++++++++++++++++++
 tests/py/inet/ether.t.payload        | 20 +++++++++++++++++
 tests/py/inet/ether.t.payload.bridge | 16 ++++++++++++++
 tests/py/inet/ether.t.payload.ip     | 20 +++++++++++++++++
 7 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.35.1

