Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72BCBEE08
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Sep 2019 11:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfIZJHE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Sep 2019 05:07:04 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:44680 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729018AbfIZJHE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:07:04 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iDPjq-00021u-W6; Thu, 26 Sep 2019 11:07:03 +0200
Date:   Thu, 26 Sep 2019 11:07:02 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 02/24] tests/shell: Speed up
 ipt-restore/0004-restore-race_0
Message-ID: <20190926090702.GC12491@breakpoint.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925212605.1005-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> This test tended to cause quite excessive load on my system, sometimes
> taking longer than all other tests combined. Even with the reduced
> numbers, it still fails reliably after reverting commit 58d7de0181f61
> ("xtables: handle concurrent ruleset modifications").

Acked-by: Florian Westphal <fw@strlen.de>

