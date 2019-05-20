Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33C7231E3
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfETLBO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 07:01:14 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56386 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731332AbfETLBO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 07:01:14 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hSg2a-0008Pd-9i; Mon, 20 May 2019 13:01:12 +0200
Date:   Mon, 20 May 2019 13:01:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: iptables: Testsuites in release tarballs?
Message-ID: <20190520110112.oyju3c2uc5jmxgxg@breakpoint.cc>
References: <20190520105219.GN4851@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520105219.GN4851@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> IIRC, we have three distinct testsuites in iptables git repo:
> 
> * xlate-test.py, cases in extensions/*.txlate
> * iptables-test.py, cases in extensions/*.t
> * iptables/tests/shell/run-tests.sh, cases in .../testcases
> 
> Of those, only the first and last ones are included in release tarballs.
> Is there a specific reason why iptables-test.py is left out?

No idea, I guess its just historic artefact.
