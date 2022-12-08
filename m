Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C8647796
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 21:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHU7G (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 15:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLHU6n (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:58:43 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D248E081
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 12:58:32 -0800 (PST)
Date:   Thu, 8 Dec 2022 21:58:29 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2 0/4] Some bug-fixes
Message-ID: <Y5JP9VwP26/yoRaj@salvia>
References: <20221203190212.346490-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203190212.346490-1-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Dec 03, 2022 at 07:02:08PM +0000, Jeremy Sowden wrote:
> As requested by Pablo, I've broken up the 34-part "Refactor of the DB
> output plug-ins" patch-series I sent out last month into smaller chunks.
> This first set contains four unrelated bug-fixes.

Applied to ulogd2, thanks
