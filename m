Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC0347985
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Mar 2021 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhCXNX3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Mar 2021 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhCXNW4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:22:56 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227CEC061763
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Mar 2021 06:22:55 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 91B9262BDE;
        Wed, 24 Mar 2021 14:22:44 +0100 (CET)
Date:   Wed, 24 Mar 2021 14:22:50 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] doc: use symbolic names for chain priorities
Message-ID: <20210324132250.GA14971@salvia>
References: <568a5508e53d6e710c06f5a726fac0357e35a9bb.1615287064.git.simon@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <568a5508e53d6e710c06f5a726fac0357e35a9bb.1615287064.git.simon@ruderich.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 09, 2021 at 11:53:30AM +0100, Simon Ruderich wrote:
> This replaces the numbers with the matching symbolic names with one
> exception: The NAT example used "priority 0" for the prerouting
> priority. This is replaced by "dstnat" which has priority -100 which is
> the new recommended priority.
> 
> Also use spaces instead of tabs for consistency in lines which require
> updates.

Applied, thanks.
