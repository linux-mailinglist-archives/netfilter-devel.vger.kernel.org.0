Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC79F1614
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 13:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfKFMbP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 07:31:15 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:33512 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfKFMbO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:31:14 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iSKSv-0001QP-Hy; Wed, 06 Nov 2019 13:31:13 +0100
Date:   Wed, 6 Nov 2019 13:31:13 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v3 0/7] Improve xtables-restore performance
Message-ID: <20191106123113.GP15063@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191024163712.22405-1-phil@nwl.cc>
 <20191031150234.osfnsa2emuvhocrc@salvia>
 <20191031171947.GF8531@orbyte.nwl.cc>
 <20191106092452.2witubxzularwbn2@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106092452.2witubxzularwbn2@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Wed, Nov 06, 2019 at 10:24:52AM +0100, Pablo Neira Ayuso wrote:
[...]
> One thing: why do you need the conversion from \n to \0. The idea is
> to read once from the file and keep it in a buffer, then pass it to
> the original parsing function after this pre-parsing to calculate the
> cache.

Excellent question! It took me quite a while to figure out why it is
necessary to drop the trailing newlines when buffering input: In
add_param_to_argv() I couldn't find what my comment described, yet when
I removed the newline character dropping code some shell tests started
failing.

The real reason is this: When reading a table or chain definition line,
xtables_restore_parse_line() uses strtok() to eliminate trailing
whitespace or newline characters. This in turn mangles input buffer,
replacing the newline chars by nul chars.

The above turns into a problem when xtables_restore_parse() then updates
the pointer to the next string in buffer by calling:

| ptr += strlen(ptr) + 1;

With double nul chars, 'ptr' will point at the second one and that
matches the loop exit condition so we'll lose the remaining buffered
lines.

I'll fix the comment before pushing the commits out.

> Please, add this to the remaining patches of this series.
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks, Phil
