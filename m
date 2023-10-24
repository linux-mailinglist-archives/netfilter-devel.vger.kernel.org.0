Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D67D4F15
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 13:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjJXLoH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 07:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJXLoG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:44:06 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0297DD79
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cRhUPpnoo25p5b14FpwnDwXHzmXNztqrXNPuOOTXQ4Y=; b=d5JBv1YKpjXP1C4KhwdhlEdTI4
        SFawjbPOi+b61jkvFOaYvjwi1+GVejJp7E7GLi8UpEe2g4sr5SAkIezl+pSO+AQOI9/AilYZk4zfi
        AZ3pi9Lsa2hsgojX57YMc+BNlVLnFwkt80tvb4vL3l37VYQS3+EAKmB+wmdAvL8mU++gGM2j50Ln3
        lBPbEHV/zo+2PC1RxvHqd16zbvb/u0NMsXEqJXz8xvGHyXVpN9ABFPY1n821lR/57RMlSgwFOcYUf
        PW0fW0ASygHoC2frw03l3ZpAkiTLyMccSMn39BMR54uoRFrbPnfrl8K0OpGfNlc/+23UjBY9nZCqm
        R3vcq2nQ==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qvFpI-000073-Tc; Tue, 24 Oct 2023 13:44:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [iptables PATCH 0/2] Fix up string match man page
Date:   Tue, 24 Oct 2023 13:43:55 +0200
Message-ID: <20231024114357.23271-1-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

My earlier adjustment to describe the actual behaviour is obsolete given
that I adjusted said behaviour upon request. Revert the change in patch
1 and introduce a new copy-edit in patch 2 making the text a bit more
clear and removing a mistake.

I will fold both commits before pushing them out. Keeping them separated
for the sake of easier reviews.

Phil Sutter (2):
  Revert "extensions: string: Clarify description of --to"
  extensions: string: Clarify description of --to

 extensions/libxt_string.man | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.41.0

