Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3A557DC5
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiFWO3A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiFWO27 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:28:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1245518
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5EK+GQt4yTfnBDUW7119IMGZZAK6xaJM4ttic+2grJw=; b=NZoiAQVujFwOMdiysVZ1rDYRQe
        MOreCw9yEyW0Jk280uylKVSkhGFyZXja5uLX3/kETJFhHZWFVNbArS2KjwS/yq0zFjcufV/tIquuN
        mcCyaIrv2zASILa5tdMG4AoAbJRLFHm+8mq8tjE42Y7EwbERizwV3hWXWyfbxGmZK52ShmozZFdxb
        WHtmnKhtdPGfMYwA8oviOjqNm1fPeUyrHxogOBtU8At0GR/XtEBBi/9bh6IglzLPbcQArYT4QH+M2
        fPPQSLjqM02vlwarM9dvr0HLnDZQ5kxycKJXIp02p8Jw7dc5I5S4XEUme/di0pxrhTh+htC+VmbiF
        wzcIovjw==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1o4NpJ-0007QL-CY; Thu, 23 Jun 2022 16:28:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nft PATCH 0/2] Fix for failing 'counter ipsec ...' rule
Date:   Thu, 23 Jun 2022 16:28:41 +0200
Message-Id: <20220623142843.32309-1-phil@nwl.cc>
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

The following rule is rejected by the parser:

| oifname "s_c" counter packets 0 bytes 0 ipsec out ip daddr 192.168.1.2 counter name "ipsec_out"

For unknown reasons, COUNTER scope is not closed before parsing 'daddr'
which is not recognized in that scope.

This series adds a test case in patch 1 and a workaround in patch 2,
namely moving saddr/daddr keywords back to global scope. Eliminating the
whole COUNTER scope would also work, but is neither a real solution.

The fact that a scope closed three words ago still causes trouble proves
the concept is flawed. IMO one should abandon it and instead deploy
quoting of all user-defined strings on output and consequently allow all
user-defined strings to be quoted on input.

Phil Sutter (2):
  tests/py: Add a test for failing ipsec after counter
  Revert "scanner: remove saddr/daddr from initial state"

 src/scanner.l                 |  6 ++----
 tests/py/inet/ipsec.t         |  2 ++
 tests/py/inet/ipsec.t.json    | 21 +++++++++++++++++++++
 tests/py/inet/ipsec.t.payload |  6 ++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.34.1

