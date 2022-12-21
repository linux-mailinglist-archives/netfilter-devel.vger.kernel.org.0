Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4757653452
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Dec 2022 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiLUQsG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Dec 2022 11:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiLUQsF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:48:05 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E77C24BFC
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Dec 2022 08:48:05 -0800 (PST)
Date:   Wed, 21 Dec 2022 17:48:01 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH 0/4] Fix some minor bugs
Message-ID: <Y6M4wXLf+OjKAkq2@salvia>
References: <20221220153847.24152-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220153847.24152-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Dec 20, 2022 at 04:38:43PM +0100, Phil Sutter wrote:
> All these were identified by Covscan.

Series LGTM.
