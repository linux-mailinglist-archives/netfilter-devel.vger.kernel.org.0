Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D386DBC72
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Apr 2023 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDHSdx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Apr 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHSdx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Apr 2023 14:33:53 -0400
Received: from libel.victim.com (libel.victim.com [5.200.21.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76D9ECB
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Apr 2023 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pifke.org;
         s=sept2013; h=Content-Type:MIME-Version:Message-ID:Date:References:
        In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BB3G9LnsRBOPDLWVbsMBS7YMQLUcybhZLfdFiu2vMGA=; b=qS8AY+vqQMhT32PKQpcfRtitKI
        76zZ57dwZixK8E6HEwum36D08xBRyJ6uwmpRpzRfAG6gxoqn8MgP969mCedSO8VaTpYLrC9F7GAGa
        9qPwQSBFm+QTHfk0WpLJQtY7f1SBRxgvslBX2sdCQi1no2aXxKhhVsXO1S4A55pIcTo/Gl8FQZ/r4
        zIjgtEPQhkxlabci9vvtKJnZWchg+yZB4ppytnsr+/BLsYHkocIq/N5Fylt3a6ID3yXVFugdnLZt0
        Z074+RlkBWjODm02ezEOdDSgCWU3KUBdI3vKHYmISjkaByNRBD2+8CvqLHZ9IHaezgJpKSmPqN0N8
        taeOOThw==;
Received: from [2620:b0:2000:da00::2] (helo=stabbing.victim.com)
        by libel.victim.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim)
        (envelope-from <dave@pifke.org>)
        id 1plDNm-0004p2-4z; Sat, 08 Apr 2023 18:33:50 +0000
From:   Dave Pifke <dave@pifke.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] src: try SO_SNDBUF before SO_SNDBUFFORCE
In-Reply-To: <ZDGxGJL7+5+CYu4H@calendula>
References: <87wn2n8ghs.fsf@stabbing.victim.com> <ZDGxGJL7+5+CYu4H@calendula>
Date:   Sat, 08 Apr 2023 12:34:13 -0600
Message-ID: <87ttxq8bq2.fsf@stabbing.victim.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> writes:

> May I add your Signed-off-by: tag to this patch before applying it?

Yes.  Thank you!


-- 
Dave Pifke, dave@pifke.org
