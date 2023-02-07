Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42D68D626
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Feb 2023 13:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBGMFo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Feb 2023 07:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBGMFo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:05:44 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 683D027986
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Feb 2023 04:05:43 -0800 (PST)
Date:   Tue, 7 Feb 2023 13:05:38 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Subject: Re: [nft PATCH v4 13/32] evaluate: support shifts larger than the
 width of the left operand
Message-ID: <Y+I+khlMuL+kFoq9@salvia>
References: <20220404121410.188509-1-jeremy@azazel.net>
 <20220404121410.188509-14-jeremy@azazel.net>
 <YovHkOThO0KYRGda@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YovHkOThO0KYRGda@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Long time, no news.

On Mon, May 23, 2022 at 07:42:43PM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> I just tested patches 9 and 14 alone, and meta mark set ip dscp ...
> now works fine.

I have applied 9 and 14, including one testcase for tests/py, so

        meta mark set ip dscp

works, so there is at least some progress on this, sorry about this :(
