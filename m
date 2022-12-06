Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA906448FE
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Dec 2022 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiLFQRR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Dec 2022 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiLFQQw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:16:52 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23691180B
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Dec 2022 08:12:25 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:12:22 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Harald Welte <laforge@osmocom.org>
Cc:     netfilter-devel@vger.kernel.org,
        Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] doc/payload-expression.txt: Mention that 'ih' exists
Message-ID: <Y49p5vYwM0Mn6xmY@salvia>
References: <20221206140333.1213221-1-laforge@osmocom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206140333.1213221-1-laforge@osmocom.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:03:33PM +0100, Harald Welte wrote:
> Back in commit b67abc51ba6f78be79f344dfda9c6d0753d79aea a new
> payload expression 'ih' was added, but the documentation wasn't updated
> accordingly.
> 
> Let's at least mention in the man page that it exists at all.

Applied, thanks
