Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DF69EB2A
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 00:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBUXXd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Feb 2023 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBUXXd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:23:33 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C69437D93
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Feb 2023 15:23:32 -0800 (PST)
Date:   Wed, 22 Feb 2023 00:23:29 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>
Subject: Re: [nf PATCH] netfilter: Fix regression in ip6t_rpfilter with VRF
 interfaces
Message-ID: <Y/VScb9gbevbSzNF@salvia>
References: <20230216160536.18506-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230216160536.18506-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:05:36PM +0100, Phil Sutter wrote:
> When calling ip6_route_lookup() for the packet arriving on the VRF
> interface, the result is always the real (slave) interface. Expect this
> when validating the result.

Applied, thanks
