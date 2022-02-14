Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287624B4FD4
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Feb 2022 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbiBNMQ3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Feb 2022 07:16:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352819AbiBNMQ3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:16:29 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D4E64925B
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Feb 2022 04:16:18 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id A8DF560028
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Feb 2022 13:15:47 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/2] add example folder
Date:   Mon, 14 Feb 2022 13:16:11 +0100
Message-Id: <20220214121613.311530-1-pablo@netfilter.org>
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

Add two initial example files:

- use buffer API to load a ruleset
- load JSON ruleset from file

Pablo Neira Ayuso (2):
  examples: add libnftables example program
  examples: load ruleset from JSON

 configure.ac              |  1 +
 examples/Makefile.am      |  4 ++++
 examples/json-ruleset.nft | 43 +++++++++++++++++++++++++++++++++++++++
 examples/nft-buffer.c     | 34 +++++++++++++++++++++++++++++++
 examples/nft-json-file.c  | 30 +++++++++++++++++++++++++++
 5 files changed, 112 insertions(+)
 create mode 100644 examples/Makefile.am
 create mode 100644 examples/json-ruleset.nft
 create mode 100644 examples/nft-buffer.c
 create mode 100644 examples/nft-json-file.c

-- 
2.30.2

