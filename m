Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFCFF552
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Nov 2019 20:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfKPTnL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 16 Nov 2019 14:43:11 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:58070 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfKPTnL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 16 Nov 2019 14:43:11 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iW3yP-0004oc-LW; Sat, 16 Nov 2019 20:43:09 +0100
Date:   Sat, 16 Nov 2019 20:43:09 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] segtree: Check ranges when deleting elements
Message-ID: <20191116194309.GB17739@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191112191007.9752-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112191007.9752-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, Nov 12, 2019 at 08:10:07PM +0100, Phil Sutter wrote:
> Make sure any intervals to delete actually exist, otherwise reject the
> command. Without this, it is possible to mess up rbtree contents:
> 
> | # nft list ruleset
> | table ip t {
> | 	set s {
> | 		type ipv4_addr
> | 		flags interval
> | 		auto-merge
> | 		elements = { 192.168.1.0-192.168.1.254, 192.168.1.255 }
> | 	}
> | }
> | # nft delete element t s '{ 192.168.1.0/24 }'
> | # nft list ruleset
> | table ip t {
> | 	set s {
> | 		type ipv4_addr
> | 		flags interval
> | 		auto-merge
> | 		elements = { 192.168.1.255-255.255.255.255 }
> | 	}
> | }

Sadly, this breaks tests/monitor/testcases/set-simple.t. The reason is
that 'add element' command does not add the new element to set in cache
and my change requires for 'delete element' command to find the range in
cache. Above test case basically does:

| # nft 'add element ip t s { 10-20 }; delete element ip t s { 10-20 }'

This is not really a common use-case, but still worth fixing IMO.

Sorry, Phil
