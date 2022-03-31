Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72744ED79C
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Mar 2022 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiCaKOJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Mar 2022 06:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiCaKOH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:14:07 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909A1EECC
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Mar 2022 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WAaEfp1BdZkp4E6xjSKRIfIA0AnPtB1TSuslBJqwMSs=; b=nR6a/2qCgzl1BMsfXWmwQUPrFv
        v256eMmXIZfT2+3cUjdCGw0Sx3JexIftv/PSpx372DQn9Bl14a+k8DDxRgfpt24Myaen8dDp5pUD8
        FeRZDoPSOla1rerB/sfDc5ZuKxOHwel7M5Q3ZdTZclandesrgB2yBpU4nR+P1mi8F0A1IqaRJFmJk
        d7OYLJmE/EBgPtKa0fD2fywUYHMP8g2XjiOx3Sj1eVLkwQXPJzeMOtsg+Qnin9DHF2wuz41xy/V8C
        kFQ1bSvPVbDJ2TbCUwSj+KTPJX1ztNEBCpiZmViK+WkWCaEpWdkT1MAuk4s9+GERDLSwoRjIgxfaH
        iOHg9kUA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nZrmt-00066A-2X; Thu, 31 Mar 2022 12:12:19 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
Subject: [iptables PATCH v2 6/9] extensions: DNAT: Rename from libipt to libxt
Date:   Thu, 31 Mar 2022 12:12:08 +0200
Message-Id: <20220331101211.10099-7-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331101211.10099-1-phil@nwl.cc>
References: <20220331101211.10099-1-phil@nwl.cc>
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

Prepare for merge of libipt and libip6t DNAT extensions, allow for
better code review.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/{libipt_DNAT.c => libxt_DNAT.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename extensions/{libipt_DNAT.c => libxt_DNAT.c} (100%)

diff --git a/extensions/libipt_DNAT.c b/extensions/libxt_DNAT.c
similarity index 100%
rename from extensions/libipt_DNAT.c
rename to extensions/libxt_DNAT.c
-- 
2.34.1

