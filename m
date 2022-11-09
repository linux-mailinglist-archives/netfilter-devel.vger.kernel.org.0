Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CCB622736
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Nov 2022 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiKIJjF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Nov 2022 04:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKIJiw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:38:52 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9C78FD1A
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Nov 2022 01:38:44 -0800 (PST)
Date:   Wed, 9 Nov 2022 10:38:40 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH] selftests: netfilter: Fix and review rpath.sh
Message-ID: <Y2t1IKo+kof2OrBQ@salvia>
References: <20221109090604.18439-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109090604.18439-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:06:04AM +0100, Phil Sutter wrote:
> Address a few problems with the initial test script version:
> 
> * On systems with ip6tables but no ip6tables-legacy, testing for
>   ip6tables was disabled by accident.
> * Firewall setup phase did not respect possibly unavailable tools.
> * Consistently call nft via '$nft'.

Applied to nf.git, thanks
