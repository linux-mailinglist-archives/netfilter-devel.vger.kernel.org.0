Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F05AEFCA
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Sep 2022 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiIFQB3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Sep 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiIFQAw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:00:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BA98F968
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Sep 2022 08:20:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oVaNX-0004Bx-SO; Tue, 06 Sep 2022 17:20:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: nat: avoid long-running loops
Date:   Tue,  6 Sep 2022 17:20:34 +0200
Message-Id: <20220906152036.27394-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <netfilter-devel>
References: <netfilter-devel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If a majority of ports are in use, trying every available port may
take significant amounts of time.

Add a upper limit and cancel once we've exhausted all available
options.

First patch collapses the repetitive reserve-port loop into a helper,
second patch changes the helper to only make up to 128 attempts.

Florian Westphal (2):
  netfilter: nat: move repetitive nat port reserve loop to a helper
  netfilter: nat: avoid long-running port range loop

 include/net/netfilter/nf_nat_helper.h |  1 +
 net/ipv4/netfilter/nf_nat_h323.c      | 60 ++-------------------------
 net/netfilter/nf_nat_amanda.c         | 14 +------
 net/netfilter/nf_nat_ftp.c            | 17 +-------
 net/netfilter/nf_nat_helper.c         | 31 ++++++++++++++
 net/netfilter/nf_nat_irc.c            | 16 +------
 net/netfilter/nf_nat_sip.c            | 14 +------
 7 files changed, 42 insertions(+), 111 deletions(-)

-- 
2.35.1

