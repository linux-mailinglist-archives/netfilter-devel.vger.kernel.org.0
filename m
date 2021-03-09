Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269AA332776
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCINph (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCINpI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:45:08 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F0C06174A
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 05:45:08 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lJcfa-0008EI-FG; Tue, 09 Mar 2021 14:45:06 +0100
Date:   Tue, 9 Mar 2021 14:45:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 5/5] expr: data_reg: Reduce indenting level a bit
Message-ID: <20210309134506.GA15611@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210308141119.17809-1-phil@nwl.cc>
 <20210308141119.17809-6-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308141119.17809-6-phil@nwl.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 08, 2021 at 03:11:19PM +0100, Phil Sutter wrote:
> Given there's only a single valid output_format left, catch other values
> early to help a bit with those calls to overlong function names.

Please disregard this one, I'll combine it with a larger one dealing
with the same matter.

Thanks, Phil
