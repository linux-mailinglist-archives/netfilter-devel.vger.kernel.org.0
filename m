Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B999723222
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfETLT0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 07:19:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35266 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732362AbfETLT0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 07:19:26 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hSgKB-0007rk-Fu; Mon, 20 May 2019 13:19:23 +0200
Date:   Mon, 20 May 2019 13:19:23 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: iptables: Testsuites in release tarballs?
Message-ID: <20190520111923.GO4851@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190520105219.GN4851@orbyte.nwl.cc>
 <20190520110112.oyju3c2uc5jmxgxg@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520110112.oyju3c2uc5jmxgxg@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 01:01:12PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > IIRC, we have three distinct testsuites in iptables git repo:
> > 
> > * xlate-test.py, cases in extensions/*.txlate
> > * iptables-test.py, cases in extensions/*.t
> > * iptables/tests/shell/run-tests.sh, cases in .../testcases
> > 
> > Of those, only the first and last ones are included in release tarballs.
> > Is there a specific reason why iptables-test.py is left out?
> 
> No idea, I guess its just historic artefact.

Indeed, hitting the history books revealed this one:

4b187eeed49dc ("build: don't include tests in released tarball")

It is from 2013, the other two testsuites are from 2017/2018. :)

Thanks, Phil
