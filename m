Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17A519D01
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 May 2022 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiEDKiS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 May 2022 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiEDKiR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 May 2022 06:38:17 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839BC1402B
        for <netfilter-devel@vger.kernel.org>; Wed,  4 May 2022 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k/5nq5OWrGUUp9MWEnnBIGq6ICHj0WAU3+jY4ALbvik=; b=PZLlczyqTIFCm4U3nPYBLpSq5L
        300P0UP/J+rRBYL05FJ2iurhLM0dJPlZl6Jj1sHfkPzOvf8G9f6zVrqc8W03VqbkNrxIBeGXis6tw
        yAThe1KmJlq9GuX/naqo7NJ3OqLUWu2w5bYiiAQ9CuBw9N50/0qYChyYsaufHnPROVqAWVptpGIsp
        7lqkdgfA80fsUIIPy+xLiDvtuRSIDnomNny5XTpR3PKC9+0SdtZ2UyV451W3cRIfecvm17BXXxZuI
        4Yx5Ocu+qERUSjSfnmbap6KjlDUDk08F3Rd3x+Lqk+RYSPbEEjQJ6pJSuB8lQ0Oh30Wz8mW42gucZ
        7aEm7VCA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nmCLA-0008Pj-VQ; Wed, 04 May 2022 12:34:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/4] Some misc fixes
Date:   Wed,  4 May 2022 12:34:12 +0200
Message-Id: <20220504103416.19712-1-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix and improve DNAT printing routines, add some missing bits to
extension man page and further improve extension loading for
unprivileged users.

Phil Sutter (4):
  extensions: DNAT: Merge core printing functions
  man: *NAT: Review --random* option descriptions
  extensions: LOG: Document --log-macdecode in man page
  nft: Fix EPERM handling for extensions without rev 0

 extensions/libxt_DNAT.c                       | 58 +++++++++----------
 extensions/libxt_DNAT.man                     |  4 +-
 extensions/libxt_LOG.man                      |  3 +
 extensions/libxt_MASQUERADE.man               | 10 +---
 extensions/libxt_REDIRECT.man                 |  4 +-
 extensions/libxt_SNAT.man                     |  8 +--
 iptables/nft.c                                | 14 +++--
 .../testcases/iptables/0008-unprivileged_0    |  6 ++
 8 files changed, 52 insertions(+), 55 deletions(-)

-- 
2.34.1

