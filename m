Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30506DC60E
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393685AbfJRN1w (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 09:27:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44100 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393118AbfJRN1w (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:27:52 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iLSII-0004uQ-6W; Fri, 18 Oct 2019 15:27:50 +0200
Date:   Fri, 18 Oct 2019 15:27:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH] xtables-restore: Fix --table parameter check
Message-ID: <20191018132750.GF26123@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20190920154920.7927-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920154920.7927-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Fri, Sep 20, 2019 at 05:49:20PM +0200, Phil Sutter wrote:
> Xtables-restore tries to reject rule commands in input which contain a
> --table parameter (since it is adding this itself based on the previous
> table line). Sadly getopt_long's flexibility makes it hard to get this
> check right: Since the last fix, comments starting with a dash and
> containing a 't' character somewhere later were rejected. Simple
> example:
> 
> | *filter
> | -A FORWARD -m comment --comment "- allow this one" -j ACCEPT
> | COMMIT
> 
> To hopefully sort this once and for all, introduce is_table_param()
> which should cover all possible variants of legal and illegal
> parameters. Also add a test to make sure it does what it is supposed to.
> 
> Fixes: f8e5ebc5986bf ("iptables: Fix crash on malformed iptables-restore")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Could anyone please review this one?

Thanks, Phil
