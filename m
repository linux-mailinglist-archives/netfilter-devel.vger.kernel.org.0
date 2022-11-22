Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A696348AF
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Nov 2022 21:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiKVUs3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Nov 2022 15:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiKVUsJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:48:09 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE8042734
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Nov 2022 12:45:34 -0800 (PST)
Date:   Tue, 22 Nov 2022 21:45:31 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/1] netfilter: ipset: restore allowing 64 clashing
 elements in hash:net,iface
Message-ID: <Y30064mEhfsX1xQ1@salvia>
References: <20221122191858.1051777-1-kadlec@netfilter.org>
 <20221122191858.1051777-2-kadlec@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122191858.1051777-2-kadlec@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Jozsef,

On Tue, Nov 22, 2022 at 08:18:58PM +0100, Jozsef Kadlecsik wrote:
> The patch "netfilter: ipset: enforce documented limit to prevent allocating
> huge memory" was too strict and prevented to add up to 64 clashing elements
> to a hash:net,iface type of set. This patch fixes the issue and now the type
> behaves as documented.

I have manually applied, this to add the Fixes: tag, upstream
maintainers usually require this and it also helps robots to identify
patches which should go into -stable.
