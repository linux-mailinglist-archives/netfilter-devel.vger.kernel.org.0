Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B71EAFEC
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfJaMMg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 08:12:36 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:47096 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaMMg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:12:36 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iQ9Ja-0003lv-EE; Thu, 31 Oct 2019 13:12:34 +0100
Date:   Thu, 31 Oct 2019 13:12:34 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [libnftnl PATCH 1/2] libnftnl.map: Export
 nftnl_{obj,flowtable}_set_data()
Message-ID: <20191031121234.GB8531@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20191030174948.12493-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030174948.12493-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Oct 30, 2019 at 06:49:47PM +0100, Phil Sutter wrote:
> In order to deprecate nftnl_{obj,flowtable}_set() functions, these must
> to be made available.

In case you wonder why current nftables sources don't compile, it's
because I had this one applied when pushing 909e297ed430c ("mnl: Replace
use of untyped nftnl data setters") so I didn't notice the missing
dependency.

Quick review of at least this patch is therefore highly appreciated.

Sorry, Phil
