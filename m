Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7340CA32
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Sep 2021 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhIOQer (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Sep 2021 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhIOQeq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:46 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6877C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Sep 2021 09:33:27 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1mQXqg-0000s8-3S; Wed, 15 Sep 2021 18:33:26 +0200
Date:   Wed, 15 Sep 2021 18:33:26 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ebtables: Avoid dropping policy when flushing
Message-ID: <20210915163326.GG22465@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210915154413.32598-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915154413.32598-1-phil@nwl.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:44:13PM +0200, Phil Sutter wrote:
> Unlike nftables, ebtables' user-defined chains have policies -
> ebtables-nft implements those internally as invisible last rule. In
> order to recreate them after a flush command, a rule cache is needed.
> 
> https://bugzilla.netfilter.org/show_bug.cgi?id=1558
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Pushed this one after adding a testcase asserting correct behaviour.

Cheers, Phil
