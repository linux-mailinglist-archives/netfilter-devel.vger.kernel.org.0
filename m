Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2461E120E
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2020 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbgEYPsh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 May 2020 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbgEYPsh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 May 2020 11:48:37 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448EC061A0E
        for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2020 08:48:37 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jdFL8-00061v-Fo; Mon, 25 May 2020 17:48:34 +0200
Date:   Mon, 25 May 2020 17:48:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] tests: shell: Introduce test for concatenated
 ranges in anonymous sets
Message-ID: <20200525154834.GU17795@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <cover.1590324033.git.sbrivio@redhat.com>
 <5735155a0e98738cdc5507385d6225e05c225465.1590324033.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5735155a0e98738cdc5507385d6225e05c225465.1590324033.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, May 24, 2020 at 03:00:27PM +0200, Stefano Brivio wrote:
> Add a simple anonymous set including a concatenated range and check
> it's inserted correctly. This is roughly based on the existing
> 0025_anonymous_set_0 test case.

I think this is pretty much redundant to what tests/py/inet/sets.t tests
if you simply enable the anonymous set rule I added in commit
64b9aa3803dd1 ("tests/py: Add tests involving concatenated ranges").

Cheers, Phil
