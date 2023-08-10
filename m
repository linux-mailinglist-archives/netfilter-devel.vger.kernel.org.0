Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE35C7776D2
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Aug 2023 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHJLXq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Aug 2023 07:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjHJLXp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:23:45 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5906268A
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Aug 2023 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xctmncFJpYrEaW9bdO94qzbXqF1dszHE5/pt/S8NH4s=; b=SY/xAgbri8LLAeBlZ0bs/lC9t1
        LjrDtrUNEAbI//WZi9s1GQO3U0rE8u2QPrTrvqFJJd9JEqPiCsGeYo7Sif4icOsDfBgJpLf6S/vzr
        hEkC+FMhVPhV3yb5TNvrTCDIUoepFbgVBT/yDNCx/1Zm5Ed91KhzLZCOrPV3WF6V9st97omWfEgzY
        Agg/ht8BN+2moN4iGpPya4+VHzKpg5EP3fk5vqB9rD474bEQh+CdX0qyR3DPjNiBYSEMvV1KnDpMB
        IF6WdUIvlp6iBSf64DeHg51KMbFNQbaZ50MV48gbFLnOgDytyTpjRuCzOhsihHHo6PmkZ5akffMSz
        fxTVvSgA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qU3lT-0004Nw-8m
        for netfilter-devel@vger.kernel.org; Thu, 10 Aug 2023 13:23:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 0/3] Chain counter fixes here and there
Date:   Thu, 10 Aug 2023 13:23:22 +0200
Message-Id: <20230810112325.20630-1-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Resending patch 2 after the test I created for it in patch 3 exposed the
iptables-nft bug fixed in patch 1.

Phil Sutter (3):
  nft: Create builtin chains with counters enabled
  Revert "libiptc: fix wrong maptype of base chain counters on restore"
  tests: shell: Test chain policy counter behaviour

 iptables/nft.c                                | 14 ++--
 .../shell/testcases/chain/0007counters_0      | 78 +++++++++++++++++++
 libiptc/libiptc.c                             |  2 +-
 3 files changed, 87 insertions(+), 7 deletions(-)
 create mode 100755 iptables/tests/shell/testcases/chain/0007counters_0

-- 
2.40.0

