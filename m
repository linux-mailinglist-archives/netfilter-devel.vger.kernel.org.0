Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ECD73DCD3
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jun 2023 13:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFZLFT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jun 2023 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFZLFR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:05:17 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFAD8F;
        Mon, 26 Jun 2023 04:05:14 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     stable@vger.kernel.org, carnil@debian.org
Subject: [PATCH -stable,5.10 0/3] stable fixes for 5.10
Date:   Mon, 26 Jun 2023 13:05:03 +0200
Message-Id: <20230626110506.76630-1-pablo@netfilter.org>
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

Hi Greg, Sasha,

The following batch contains Netfilter fixes for 5.10.

Patches 1 and 2 you can manually cherry-pick them:

1) 08a01c11a5bb ("netfilter: nftables: statify nft_parse_register()")
2) 98494660a286 ("netfilter: nf_tables: validate registers coming from userspace.")

Patch 3 is a backport:

3) 99e73e80d3df ("netfilter: nf_tables: hold mutex on netns pre_exit path")

Thanks.

Pablo Neira Ayuso (3):
  netfilter: nftables: statify nft_parse_register()
  netfilter: nf_tables: validate registers coming from userspace.
  netfilter: nf_tables: hold mutex on netns pre_exit path

 include/net/netfilter/nf_tables.h |  1 -
 net/netfilter/nf_tables_api.c     | 34 +++++++++++++++++--------------
 2 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.30.2

