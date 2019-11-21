Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504BD1058D1
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 18:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKURwG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 12:52:06 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:41750 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKURwG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:52:06 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iXqce-0006aQ-6C; Thu, 21 Nov 2019 18:52:04 +0100
Date:   Thu, 21 Nov 2019 18:52:04 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?utf-8?Q?J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>
Subject: Re: [PATCH nft v2 3/3] tests: Introduce test for set with
 concatenated ranges
Message-ID: <20191121175204.GD3074@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?utf-8?Q?J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>
References: <cover.1574353687.git.sbrivio@redhat.com>
 <ecec1c16ea949fa2515a129568972e5ff263bff8.1574353687.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecec1c16ea949fa2515a129568972e5ff263bff8.1574353687.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 21, 2019 at 06:10:06PM +0100, Stefano Brivio wrote:
> This test checks that set elements can be added, deleted, that
> addition and deletion are refused when appropriate, that entries
> time out properly, and that they can be fetched by matching values
> in the given ranges.
> 
> v2:
>  - actually check an IPv6 prefix, instead of specifying everything
>    as explicit ranges in ELEMS_ipv6_addr
>  - renumber test to 0041, 0038 already exists
> 
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

Acked-by: Phil Sutter <phil@nwl.cc>
