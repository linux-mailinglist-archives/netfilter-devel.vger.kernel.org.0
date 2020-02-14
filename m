Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED115EDA1
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Feb 2020 18:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbgBNRey (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Feb 2020 12:34:54 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:40784 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390318AbgBNRev (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:34:51 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j2era-0004f0-45; Fri, 14 Feb 2020 18:34:50 +0100
Date:   Fri, 14 Feb 2020 18:34:50 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH] src: Fix nftnl_assert() on data_len
Message-ID: <20200214173450.GR20005@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200214172417.11217-1-phil@nwl.cc>
 <20200214173247.2wbrvcqilqfmcqq5@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214173247.2wbrvcqilqfmcqq5@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 14, 2020 at 06:32:47PM +0100, Pablo Neira Ayuso wrote:
> On Fri, Feb 14, 2020 at 06:24:17PM +0100, Phil Sutter wrote:
> > Typical idiom for *_get_u*() getters is to call *_get_data() and make
> > sure data_len matches what each of them is returning. Yet they shouldn't
> > trust *_get_data() to write into passed pointer to data_len since for
> > chains and NFTNL_CHAIN_DEVICES attribute, it does not. Make sure these
> > assert() calls trigger in those cases.
> 
> The intention to catch for unset attributes through the assertion,
> right?

No, this is about making sure that no wrong getter is called, e.g.
nftnl_chain_get_u64() with e.g. NFTNL_CHAIN_HOOKNUM attribute which is
only 32bits.

Cheers, Phil
