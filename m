Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F8EB160
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 14:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfJaNnX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 09:43:23 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:47254 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJaNnX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:43:23 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iQAjR-0004kp-52; Thu, 31 Oct 2019 14:43:21 +0100
Date:   Thu, 31 Oct 2019 14:43:21 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 2/2] Deprecate untyped data setters
Message-ID: <20191031134321.GC8531@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191030174948.12493-1-phil@nwl.cc>
 <20191030174948.12493-2-phil@nwl.cc>
 <20191031124920.4p2frkvfwgktaxqz@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031124920.4p2frkvfwgktaxqz@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:49:20PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Oct 30, 2019 at 06:49:48PM +0100, Phil Sutter wrote:
> > These functions make assumptions on size of passed data pointer and
> > therefore tend to hide programming mistakes. Instead either one of the
> > type-specific setters or the generic *_set_data() setter should be used.
> 
> Please, confirm that the existing iptables / nft codebase will not hit
> compilation warnings because of deprecated functions.

Yes, current code base does not use those functions.

Cheers, Phil
