Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCF347705
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Mar 2021 12:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhCXLWw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Mar 2021 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhCXLWg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:22:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A8CBC061763
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Mar 2021 04:22:36 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 26CFE62BDE;
        Wed, 24 Mar 2021 12:22:25 +0100 (CET)
Date:   Wed, 24 Mar 2021 12:22:30 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] conntrack: reset optind in do_parse
Message-ID: <20210324112230.GA7694@salvia>
References: <20210129212452.45352-1-mikhail.sennikovskii@cloud.ionos.com>
 <20210129212452.45352-2-mikhail.sennikovskii@cloud.ionos.com>
 <20210315171819.GA25083@salvia>
 <CALHVEJbqbPLMUJN5H6Q-8sUFxTWtmCN+qWNCBETPEjBhtZc_Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALHVEJbqbPLMUJN5H6Q-8sUFxTWtmCN+qWNCBETPEjBhtZc_Jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:31:18PM +0100, Mikhail Sennikovsky wrote:
> Hi Pablo,
> 
> Sure, so taking into account your comments to 3/8 and 4/8 I collapse
> 1-5/8 in a single commit, correct?

Yes please. My understanding is that they belong to the same logical
changes, that is, add batch support.

So this new "batch support" for conntrack is all new code that can be
added at once IMO.

Thanks.
